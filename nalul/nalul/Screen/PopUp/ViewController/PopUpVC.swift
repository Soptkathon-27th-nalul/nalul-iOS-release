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

}

// MARK: Extension

extension PopUpVC {
    
    // MARK: View Style Function
    
    func setView() {
        self.view.backgroundColor = .nalulBlack
        self.view.backgroundColor?.withAlphaComponent(0.3)
        
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
}
