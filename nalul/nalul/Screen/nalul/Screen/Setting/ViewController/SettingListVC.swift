//
//  SettingListVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/18.
//

import UIKit

class SettingListVC: UIViewController {
    
    // MARK: Variable Part
    
    var titleList: [String] = ["nalue 소개", "배경 재설정", "문의하기", "서비스 이용약관", "팀 nalue", "오픈소스"]
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingListTableView: UITableView!
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

extension SettingListVC {
    
    // MARK: Function
    
    func setView() {
        
        titleLabel.text = "설정"
        titleLabel.font = .fourRegular(size: 25)
        titleLabel.textColor = .white
        
        settingListTableView.backgroundColor = .none
        
        explainLabel.numberOfLines = 0
        explainLabel.text = "nalul에서는 회원가입을 진행하지 않습니다\n기기 변경 시 정보가 유실될 수 있으니 유의해주세요"
        explainLabel.font = .twoExLight(size: 14)
        explainLabel.textColor = .white
        explainLabel.alpha = 0.7
        
        if let text = explainLabel.text {
            // 첫째줄 부분에만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.fourRegular(size: 14), range: (text as NSString).range(of: "회원가입을 진행하지 않습니다"))
            
            explainLabel.attributedText = attributedStr
        }
        
        settingListTableView.delegate = self
        settingListTableView.dataSource = self
        settingListTableView.isScrollEnabled = false
        
    }
    
}

extension SettingListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
        
    }
}

extension SettingListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else {
            
            return UITableViewCell()
        }
        
        settingCell.setTitle(name: titleList[indexPath.row])
        
        if indexPath.row == 5 {
            settingCell.underlineView.isHidden = true
            settingCell.buttonImage.isHidden = true
        }
        
        return settingCell
    }
    
    
    
}
