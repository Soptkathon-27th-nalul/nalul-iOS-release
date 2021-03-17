//
//  MainStartVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/13.
//

import UIKit

class MainStartVC: UIViewController {

    // MARK: Variable Part
    
    // MARK: IBOutlet
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var padView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var buttonExplainLabel: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var useExplainLabel: UILabel!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setView()
//        setLabel()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
//        setButton()
//        if view.safeAreaInsets.bottom == 0.0 {
//            startButtonConstraint.constant = 20
//        }
    }

}

// MARK: Extension

extension MainStartVC {
    
    // MARK: View Style Function
    
    func setView() {
        // 뷰 관련 Style 설정
        
        backgroundImageView.image = UIImage(named: "testImage")
        
        padView.setRounded(radius: 18)
    
    }
    
    // MARK: Button Style Function
    
    func setButton() {
        // 버튼 관련 Style 설정

        yesButton.setTitle("그래", for: .normal)
        yesButton.titleLabel?.font = UIFont.threeLight(size: 14)
        yesButton.tintColor = .white
        yesButton.setBorder(borderColor: .white, borderWidth: 1)
        yesButton.makeRounded(cornerRadius: nil)
    }
    
    // MARK: Label Style Function
    
    func setLabel() {
        // 라벨 관련 Style 설정
        
        welcomeLabel.text = "narul\n안녕하세요, 반가워요"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.threeLight(size: 14)
        
        if let text = welcomeLabel.text {
            // "좋은 아침입니다!" 부분에만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: welcomeLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 12), range: (text as NSString).range(of: "narul"))

            welcomeLabel.attributedText = attributedStr
        }
        
        welcomeLabel.lineSetting(kernValue: 0, lineSpacing: 14)
        
        subLabel.text = "시작은 달콤하게"
        subLabel.textColor = .white
        subLabel.font = UIFont.twoExLight(size: 11)
        
        buttonExplainLabel.text = "touch!"
        buttonExplainLabel.textColor = .white
        buttonExplainLabel.font = UIFont.fourRegular(size: 11)
        
        useExplainLabel.text = "메모장을 눌러보세요\n나에게 중독되어 가는거에요, narul"
        useExplainLabel.textColor = .white
        useExplainLabel.font = UIFont.twoExLight(size:  11)
        useExplainLabel.numberOfLines = 0
        
        if let text = useExplainLabel.text {
            // "좋은 아침입니다!" 부분에만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: useExplainLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 14), range: (text as NSString).range(of: "메모장을 눌러보세요"))

            useExplainLabel.attributedText = attributedStr
        }
        
        useExplainLabel.lineSetting(kernValue: 0, lineSpacing: 12)
        
    }
}
