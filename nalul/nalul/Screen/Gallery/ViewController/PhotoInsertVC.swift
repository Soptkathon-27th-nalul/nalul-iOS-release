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
    
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var photoChoseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        
//        if let questionIndex = questionData?.QuestionIdx,
//           let image = photoChoseButton.imageView?.image,
//           let contents = answerTextView.text,
//           let jwt = UserDefaults.standard.string(forKey: "accessToken") {
//            APIService.shared.postFeed(questionIndex, image, contents, jwt) { [self] result in
//                switch result {
//                case .success(let data):
//
//                    guard let loadData = data as? SimpleData else {
//                        return
//                    }
//
//                    self.simpleData = loadData
//                    if self.simpleData?.status == 200 {
//                        // 성공 alter 띄우기
//                    }
//
//
//
//                case .failure(let error):
//                    if error == 400 {
//                        // 토큰 값 만료 -> 다시 로그인 하세요
//
//                    } else {
//                        print("데이터 연결을 확인해주세요")
//                    }
//
//                }
//
//            }
//        }
        
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
        
    }
    
    func setView() {
        
        answerTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(touchTextView), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드가 화면에 띄어질 때 소환
        NotificationCenter.default.addObserver(self, selector: #selector(touchDownView), name: UIResponder.keyboardWillHideNotification, object: nil)
        // 키보드가 화면에서 내려가면 소환
    }
    
    func setButton() {
        
        insertButton.setTitle("등록", for: .normal)
        insertButton.titleLabel?.font = UIFont.threeLight(size: 14)
        insertButton.tintColor = .white
        insertButton.setBorder(borderColor: .white, borderWidth: 1)
        insertButton.makeRounded(cornerRadius: nil)
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
    }
    
    @objc func myTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textViewPlaceHolder(textView: UITextView) {
        // textView에 PlaceHolder 설정하기
        
        if textView.text == "대답을 입력해주세요." {
            textView.text = ""
            insertButton.isEnabled = true
        } else if textView.text == "" {
            textView.text = "대답을 입력해주세요."
            insertButton.isEnabled = false
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
    
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension PhotoInsertVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            // 수정된 이미지가 있을 경우
            postImage = image
            
        } else if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            
            // 오리지널 이미지가 있을 경우
            postImage = image
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}
