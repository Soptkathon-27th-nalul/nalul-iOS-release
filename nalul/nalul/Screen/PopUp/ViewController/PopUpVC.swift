//
//  PopUpVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/27.
//

import UIKit

class PopUpVC: UIViewController {

    // MARK: Variable Part
    
    var questionMent: String?
    var explainMent: String?
    let yesButton = UIButton()
    let noButton = UIButton()
    
    
    // MARK: IBOutlet
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var mentLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setView()
        setLabel()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        
        // 버튼 둥글게
        yesButton.layer.cornerRadius = self.buttonView.frame.height/2
        noButton.layer.cornerRadius = self.buttonView.frame.height/2
    }

}

// MARK: Extension

extension PopUpVC {
    
    // MARK: View Style Function
    
    func setView() {
        
        self.view.backgroundColor = .nalulBlack
        self.view.backgroundColor?.withAlphaComponent(0.6)
        
        self.popUpView.backgroundColor = .nalulBlack
        self.popUpView.backgroundColor?.withAlphaComponent(0.8)
        self.popUpView.setRounded(radius: 32.5)
        self.popUpView.setBorder(borderColor: .nalulLightGray, borderWidth: 1)
        
        buttonView.backgroundColor = .clear
        
    }
    
    // MARK: Label Style Function
    
    func setLabel() {
        
        questionMent = "기록을 삭제하시겠어요?"
        explainMent = "삭제된 기록은 복구할 수 없습니다."
        // Test 코드
        
        if let question = questionMent,
           let explain = explainMent {
            mentLabel.numberOfLines = 0
            mentLabel.text = "\(question)\n\(explain)"
            mentLabel.textColor = .white
            mentLabel.font = .threeLight(size: 14)
            
            if let text = mentLabel.text {
                // 두번째줄만 style을 다르게 설정하기
                
                let attributedStr = NSMutableAttributedString(string: text)
                attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.twoExLight(size: 11), range: (text as NSString).range(of: explain))
                // 폰트 수정
                attributedStr.addAttribute(.foregroundColor, value: UIColor(white: 1.0, alpha: 0.6), range: (text as NSString).range(of: explain))
                // label 컬러에 불투명도 값 주기
                
                mentLabel.attributedText = attributedStr
            }
            
            mentLabel.lineSetting(kernValue: 0, lineSpacing: 12)
        }
        
        
    }
    
    // MARK: Make One Button Function
    
    func setOneButton() {
        
        yesButton.setTitle("그래", for: .normal)
        yesButton.titleLabel?.font = .threeLight(size: 12)
        yesButton.setTitleColor(.white, for: .normal)
        yesButton.backgroundColor = .gray
        
        self.buttonView.addSubview(yesButton)
        
        // 레이아웃을 수동으로 주고싶을 때 호출하는 인스턴스
        // true 일 때는 자동으로 레이아웃을 주는데 false로 지정하면서 내가 원하는대로 레이아웃을 줄 수 있게 함
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        yesButton.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor).isActive = true
        // 가운데 정렬
        yesButton.widthAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        // Button의 넓이와 높이 주기
        
    }
    
    // MARK: Make Two Button Function
    
    func setTwoButton() {
        
        // 첫번재 버튼
        noButton.setTitle("아니", for: .normal)
        noButton.titleLabel?.font = .threeLight(size: 12)
        noButton.setTitleColor(.white, for: .normal)
        noButton.backgroundColor = .gray
        
        self.buttonView.addSubview(noButton)
        
        noButton.translatesAutoresizingMaskIntoConstraints = false
        
        noButton.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor, constant: -48).isActive = true
        noButton.widthAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        noButton.heightAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        
        // 두번째 버튼
        yesButton.setTitle("응", for: .normal)
        yesButton.titleLabel?.font = .threeLight(size: 12)
        yesButton.setTitleColor(.white, for: .normal)
        yesButton.backgroundColor = .clear
        yesButton.setBorder(borderColor: .gray, borderWidth: 1)
        
        self.buttonView.addSubview(yesButton)
        
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        yesButton.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor, constant: 48).isActive = true
        // 가운데 정렬
        yesButton.widthAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        
    }
}
