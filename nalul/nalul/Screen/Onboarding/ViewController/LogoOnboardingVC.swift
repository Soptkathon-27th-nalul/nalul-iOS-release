//
//  LogoOnboardingVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class LogoOnboardingVC: UIViewController {

    // MARK: IBOutlet
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var explainLabel: UILabel!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }


}

// MARK: Extension

extension LogoOnboardingVC {
    
    // MARK: Function
    
    func setView() {

        
        explainLabel.text = "nalul 나와 가장 가까이에\n매일 기록하는 당신의 외면과 내면"
        explainLabel.font = .threeLight(size: 18)
        explainLabel.textColor = .white
        explainLabel.numberOfLines = 0
        
        if let text = explainLabel.text {
            // 두번째줄만 폰트와 컬러를 다르게 설정
            
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 14), range: (text as NSString).range(of: "매일 기록하는 당신의 외면과 내면"))
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6035621087), range: (text as NSString).range(of: "매일 기록하는 당신의 외면과 내면"))

            explainLabel.attributedText = attributedStr
        }
        
        explainLabel.lineSetting(kernValue: 0, lineSpacing: 12)
    }
}
