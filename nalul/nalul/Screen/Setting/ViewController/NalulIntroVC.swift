//
//  NalulIntroVC.swift
//  nalul
//
//  Created by 김민희 on 2021/05/04.
//

import UIKit

class NalulIntroVC: UIViewController {

    // MARK: IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        // 뒤로 가기
        
        self.navigationController?.popViewController(animated: true)
        
    }
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
