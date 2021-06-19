//
//  PhotoInsertVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/02.
//

import UIKit

class PhotoInsertVC: UIViewController {
    
    // MARK: Variable Part
    
    var titleName: String?
    var categoryIndex: Int?
    var questionData: QuestionData?
    var simpleData: SimpleData?
    var postImage: UIImage?
    
    // MARK: IBOutlet
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var photoChoseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var answerBoxImage: UIImageView!
    
    // MARK: IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func photoChoseButtonDidTap(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: "게시물 사진 등록하기", preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "카메라 촬영", style: .default, handler: {
            // 카메라 선택 시 action
            
            (alert: UIAlertAction!) -> Void in
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.cameraDevice = .front
            vc.delegate = self
            vc.mediaTypes = ["public.image"]
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
            
        })
        
        let saveAction = UIAlertAction(title: "앨범에서 사진 선택하기", style: .default, handler: {
            // 갤러시 선택 시 action
            
            (alert: UIAlertAction!) -> Void in
            
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.mediaTypes = ["public.image"]
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
        })
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
        })
        
        //action sheet에 옵션 추가.
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func postButtonDidTap(_ sender: Any) {
        // 글 올리기 서버 연결
        
        if let questionIndex = questionData?.QuestionIdx,
           let image = photoChoseButton.imageView?.image,
           let contents = answerTextView.text,
           let jwt = UserDefaults.standard.string(forKey: "accessToken") {
            
            postButton.isEnabled = false
            
            APIService.shared.postFeed(questionIndex, image, contents, jwt) { [self] result in
                switch result {
                
                case .success(let data):

                    guard let loadData = data as? SimpleData else {
                        return
                    }

                    self.simpleData = loadData
                    if self.simpleData?.status == 200 {
                        // 성공 alter 띄우기
                        
                        let nextStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
                        guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "PopUpVC") as? PopUpVC else { return }
                        
                        popUpVC.questionMent = "오늘의 나를 기록했어요."
                        popUpVC.explainMent = "나의 또 다른 부분을 기록해볼까요?"
                        popUpVC.modalPresentationStyle = .overCurrentContext
                        popUpVC.modalTransitionStyle = .crossDissolve
                        
                        self.present(popUpVC, animated: true, completion: nil)
                        popUpVC.setOneButton()
                        // 팝업 띄우기
                        NotificationCenter.default.addObserver(self, selector: #selector(backView(_:)), name: .popNavi, object: nil)
                        // Observer 살리기
                        
                    }
                    
                    postButton.isEnabled = true
                    
                case .failure(let error):
                    if error == 400 {
                        // 토큰 값 만료 -> 다시 로그인 하세요

                    } else {
                        print("데이터 연결을 확인해주세요")
                    }
                    postButton.isEnabled = true

                }

            }
        } else {
            // 토큰이 만료되었거나 없는 것
            
            print("앱 다시 실행해주세요 하고 다시 켜기")
            postButton.isEnabled = true
        }
        
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setView()
        scrollViewTap()
        textViewPlaceHolder(textView: answerTextView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setButton()
    }
    
}

// MARK: Extension

extension PhotoInsertVC {
    
    // MARK: Function
    
    func setLabel() {
        
        if let titleName = titleName {
            titleLabel.text = titleName
        } else {
            titleLabel.text = "왼쪽 눈"
        }
        
        titleLabel.font = UIFont.threeLight(size: 17)
        titleLabel.textColor = .white
        
        postDateLabel.text = Date().datePickerToString()
        // 글 쓰는 현재 날짜로 설정
        postDateLabel.font = UIFont.momFont(size: 16)
        postDateLabel.textColor = .white
        
        getQuestion()
        // 질문 받아오기
        
        questionLabel.font = UIFont.threeLight(size: 15)
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        
        answerTextView.textColor = .white
        answerTextView.font = UIFont.oneThin(size: 14)
        answerTextView.textAlignment = .left
        answerTextView.backgroundColor = .none
        
        scrollView.delegate = self
        
    }
    
    func setView() {
        
        answerTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(touchTextView), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드가 화면에 띄어질 때 소환
        NotificationCenter.default.addObserver(self, selector: #selector(touchDownView), name: UIResponder.keyboardWillHideNotification, object: nil)
        // 키보드가 화면에서 내려가면 소환
    }
    
    func setButton() {
        
        postButton.setTitle("등록", for: .normal)
        postButton.titleLabel?.font = UIFont.threeLight(size: 14)
        postButton.tintColor = .white
        postButton.setBorder(borderColor: .white, borderWidth: 1)
        postButton.makeRounded(cornerRadius: nil)
    }
    
    @objc func touchTextView(notification: NSNotification) {
        // 스크롤 위로 올리기
        
        scrollView.setContentOffset(CGPoint(x: 0, y: self.answerTextView.frame.height+100), animated: true)
        
    }
    
    @objc func touchDownView() {
        // 스크롤 다시 내리기
        
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        
    }
    
    func scrollViewTap() {
        //스크롤뷰 위에서 탭하면 키보드 내리기
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapMethod))
        
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        headerView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func myTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textViewPlaceHolder(textView: UITextView) {
        // textView에 PlaceHolder 설정하기
        
        if textView.text == "대답을 입력해주세요." {
            textView.text = ""
        } else if textView.text == "" {
            textView.text = "대답을 입력해주세요."
            postButton.isEnabled = false
        } else {
            if postImage != nil {
                postButton.isEnabled = true
            }
        }
    }
    
    func getQuestion() {
        
        if let categoryIndex = categoryIndex,
           let jwt = UserDefaults.standard.string(forKey: "accessToken") {
            
            APIService.shared.todayQuestion(categoryIndex, jwt) { [self] result in
                switch result {
                case .success(let data):
                    // 질문 받아오기 완료
    
                    self.questionData = data
                    if let question = questionData?.text {
                        questionLabel.text = question
                    }

                case .failure(_):
                    
                    questionLabel.text = "오늘 당신의 눈은 어떤 색인가요?"
                    print("데이터 연결을 확인해주세요")
                }
                
            }
        }
        
    }
    
    @objc func backView(_ notification: Notification) {
        // 뒤로 가는 함수
        
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.removeObserver(self, name: .popNavi, object: nil)
        // 옵저버 제거
    }
    
}

// MARK: UITextFieldDelegate

extension PhotoInsertVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceHolder(textView: textView)
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewPlaceHolder(textView: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count > 0 {
            // textView에 값이 있을 때
            
            if postImage != nil {
                // 이미지가 존재한다면
                
                postButton.isEnabled = true
                // 등록 버튼 활성화
            } else {
                // 아직 이미지가 존재하지 않는다면
                
                postButton.isEnabled = false
                // 등록 버튼 비활성화
            }
        } else {
            // textView에 값이 없다면
            
            postButton.isEnabled = false
            // 등록 버튼 비활성화
        }
    }
    
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension PhotoInsertVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            // 수정된 이미지가 있을 경우
            postImage = image.convertToGrayScale()
            
        } else if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            
            // 오리지널 이미지가 있을 경우
            postImage = image.convertToGrayScale()
        }
        
        photoChoseButton.setImage(postImage, for: .normal)
        
        if let text = answerTextView.text {
            if text != "대답을 입력해주세요." {
                // 이미 대답이 들어있다면
                
                postButton.isEnabled = true
                // 등록 버튼 활성화
            }
        }
        answerBoxImage.image = UIImage(named: "imgInsertAsset")
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension Notification.Name {
    // Observer 이름 등록
    static let popNavi = Notification.Name("popNavi")
}

extension PhotoInsertVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
