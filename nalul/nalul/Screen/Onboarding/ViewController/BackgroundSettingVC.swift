//
//  BackgroundSettingVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class BackgroundSettingVC: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    

}

extension BackgroundSettingVC {
    
    func setView() {
        titleLabel.text = "이제 nalul 찍어볼까요?"
        titleLabel.font = .threeLight(size: 18)
        titleLabel.textColor = .white
        
        explainLabel.text = "나를의 배경은 당신입니다.\n화면에 꽉 찰 수 있는 정면 사진을 올려주세요.\n등록하는 모든 사진은 흑백처리 됩니다."
        explainLabel.font = .threeLight(size: 14)
        explainLabel.textColor = .init(white: 1.0, alpha: 0.6)
        explainLabel.numberOfLines = 0
        explainLabel.textAlignment = .center
    }
}
