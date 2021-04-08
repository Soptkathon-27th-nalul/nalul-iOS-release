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
    @IBOutlet weak var answerTextField: UITextField!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
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
        
        answerTextField.textColor = .white
        answerTextField.font = UIFont.oneThin(size: 14)
        answerTextField.textAlignment = .left
        
    }
    
    func setButton() {
        
        insertButton.setTitle("등록", for: .normal)
        insertButton.titleLabel?.font = UIFont.threeLight(size: 14)
        insertButton.tintColor = .white
        insertButton.setBorder(borderColor: .white, borderWidth: 1)
        insertButton.makeRounded(cornerRadius: nil)
    }
    
    
}
