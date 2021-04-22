//
//  PrivacyPolicyAgreementVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/21.
//

import UIKit

class PrivacyPolicyAgreementVC: UIViewController {
    
    // MARK: Variable Part
    
    // MARK: IBOutlet
    
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func agreementButtonDidTap(_ sender: Any) {
        // 개인정보 수집 및 이용 페이지로 이동
        
        if let url = URL(string: "https://www.notion.so/suzieep/4037f79130984665ad56bdfa58db10c8") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    

}

// MARK: Extension

extension PrivacyPolicyAgreementVC {
    
    // MARK: Function
    
    func setView() {
        
        agreementButton.setBorder(borderColor: .white, borderWidth: 0.5)
        agreementButton.setTitle("(필수) 개인정보 수집 및 이용 방침", for: .normal)
        agreementButton.titleLabel?.font = UIFont.threeLight(size: 16)
        agreementButton.tintColor = .white
        agreementButton.alpha = 0.8

        
        if let text = agreementButton.titleLabel?.text {
            // 버튼에 밑줄 추가
            
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: (text as NSString).range(of: "(필수) 개인정보 수집 및 이용 방침"))

            agreementButton.setAttributedTitle(attributedStr, for: .normal)
        }
        
        agreementLabel.text = "다음 화면으로 넘기시면 개인 정보 수집 및 처리 방침에 동의하시는 것으로 간주됩니다."
        agreementLabel.numberOfLines = 0
        agreementLabel.font = UIFont.threeLight(size: 12)
        agreementLabel.textColor = .white
        agreementLabel.alpha = 0.6
        agreementLabel.textAlignment = .center
        agreementLabel.lineSetting(kernValue: 0, lineSpacing: 5)
        
        beforeLabel.text = "nalul을 시작하기 전에,"
        beforeLabel.font = UIFont.fiveMedium(size: 18)
        beforeLabel.textColor = .white
        
        explainLabel.text = "나를에서 당신의 기록에 필요한\n이용약관을 확인해보세요."
        explainLabel.numberOfLines = 0
        explainLabel.font = UIFont.threeLight(size: 14)
        explainLabel.textColor = .white
        explainLabel.alpha = 0.6
        explainLabel.textAlignment = .center
        explainLabel.lineSetting(kernValue: 0, lineSpacing: 5)
        
    }
    
}
