//
//  SettingListVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/18.
//

import UIKit
import MessageUI

class SettingListVC: UIViewController {
    
    // MARK: Variable Part
    
    var titleList: [String] = ["nalue 소개", "배경 재설정", "문의하기", "서비스 이용약관", "팀 nalue", "오픈소스"]
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingListTableView: UITableView!
    @IBOutlet weak var explainLabel: UILabel!
    
    // MARK: IBAction
    
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    @objc func backView(_ notification: Notification) {
        // 뒤로 가는 함수
        
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.removeObserver(self, name: .popNavi, object: nil)
        // 옵저버 제거
    }
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "아이폰 - Mail 설정을 확인해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
}

extension SettingListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            guard let nextView = self.storyboard?.instantiateViewController(identifier: "NalulIntroVC") as? NalulIntroVC else {
                return
            }
            
            self.navigationController?.pushViewController(nextView, animated: true)
            
        } else if indexPath.row == 1 {
            //BackgroundSettingVC
            
            let storyboard = UIStoryboard.init(name: "Onboarding", bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(identifier: "BackgroundSettingVC") as? BackgroundSettingVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
            NotificationCenter.default.addObserver(self, selector: #selector(backView(_:)), name: .popNavi, object: nil)

        } else if indexPath.row == 2 {
            // 문의 메일 보내기
            
            if MFMailComposeViewController.canSendMail() {
                // 메일 보내기가 가능한지 확인
                        
                        let compseVC = MFMailComposeViewController()
                        compseVC.mailComposeDelegate = self
                        
                        compseVC.setToRecipients(["shorryshu@gmail.com"])
                        compseVC.setSubject("'나를' 팀에게 문의하기")
//                        compseVC.setMessageBody("사용자의 나를 팀에게 문의사", isHTML: false)
                        
                        self.present(compseVC, animated: true, completion: nil)
                        
                    }
                    else {
                        // 불가능 시 alter으로 보여주기
                        
                        self.showSendMailErrorAlert()
                    }
            
        } else if indexPath.row == 3 {
            // 이용약관 페이지로 이동
            
            if let url = URL(string: "https://www.notion.so/suzieep/4037f79130984665ad56bdfa58db10c8") {
                UIApplication.shared.open(url, options: [:])
            }
            
        } else if indexPath.row == 4 {
            
            guard let nextView = self.storyboard?.instantiateViewController(identifier: "TeamNarulVC") as? TeamNarulVC else {
                return
            }
            
            self.navigationController?.pushViewController(nextView, animated: true)
        } else if indexPath.row == 5 {
            // 오픈소스 보여주기
            
            if let url = URL(string: "https://www.notion.so/suzieep/eace98fb0bb440cab3c6c5bb965c6ee5") {
                UIApplication.shared.open(url, options: [:])
            }
        }
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

extension SettingListVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
}
