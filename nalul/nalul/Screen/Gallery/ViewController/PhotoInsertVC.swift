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
    var question: String?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var photoChoseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: IBAction
    
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
        
        if let question = question {
            questionLabel.text = question
        } else {
            questionLabel.text = "오늘 당신의 눈은 어떤 색인가요?"
        }
        
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
