//
//  GalleryDetailVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/18.
//

import UIKit

class GalleryDetailVC: UIViewController {
    
    // MARK: Variable Part
    
    var titleName: String?
    var postDate: String?
    var userPhoto: String?
    var question: String?
    var answer: String?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setView()
    }
    
    override func viewDidLayoutSubviews() {
        setButton()
    }
    
}

// MARK: Extension

extension GalleryDetailVC {
    
    // MARK: Function
    
    func setView() {
        
        if let userPhoto = userPhoto {
            userImageView.setImage(from: userPhoto)
        } else {
            userImageView.image = UIImage(named: "miniTest")
        }
    }
    
    func setLabel() {
        
        if let titleName = titleName {
            titleLabel.text = titleName
        } else {
            titleLabel.text = "왼쪽 눈"
        }
        
        titleLabel.font = UIFont.threeLight(size: 17)
        titleLabel.textColor = .white
        
        if let postDate = postDate {
            dateLabel.text = postDate
        } else {
            dateLabel.text = "20210424"
        }
        
        dateLabel.font = UIFont.momFont(size: 16)
        dateLabel.textColor = .white
        
        if let question = question {
            questionLabel.text = question
        } else {
            questionLabel.text = "오늘 당신의 눈은 어떤 색인가요?"
        }
        
        questionLabel.font = UIFont.threeLight(size: 15)
        questionLabel.textColor = .white

        answerLabel.numberOfLines = 0
        if let answer = answer {
            answerLabel.text = answer
        } else {
            answerLabel.text = "내 오른쪽 눈은 적색일지도 모른다.\n밤샘이 잦은 탓에,\n눈에 돋은 핏줄을 숨길 수가 없다.\n\n조만간 푹 쉬고\n흰색의 눈에 갈색의 동공이 빛나는\n건강한 하루를 보내고 싶다."
        }
        answerLabel.textColor = .white
        answerLabel.font = UIFont.oneThin(size: 14)
        answerLabel
            .lineSetting(kernValue: 0.0, lineSpacing: 8.0)
        answerLabel.textAlignment = .left
    }
    
    func setButton() {
        
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.titleLabel?.font = UIFont.threeLight(size: 14)
        deleteButton.tintColor = .white
        deleteButton.setBorder(borderColor: .white, borderWidth: 1)
        deleteButton.makeRounded(cornerRadius: nil)
    }
    
}
