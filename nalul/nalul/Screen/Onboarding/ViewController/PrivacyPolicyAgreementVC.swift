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
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    // MARK: IBAction
    
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
        
        self.boxView.backgroundColor = .clear
        self.boxView.setBorder(borderColor: .white, borderWidth: 0.5)
        
        agreementButton.setTitle("(필수) 개인정보 수집 및 이용 방침", for: .normal)
        agreementButton.titleLabel?.font = UIFont.threeLight(size: 16)
        agreementButton.tintColor = .white
        
    }
    
}
