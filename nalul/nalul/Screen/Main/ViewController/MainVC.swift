//
//  MainViewController.swift
//  nalul
//
//  Created by 김민희 on 2021/03/24.
//

import UIKit

class MainVC: UIViewController {

    // MARK: Variable Part
    
    // MARK: IBOutlet
    
    @IBOutlet weak var userBackImageView: UIImageView!
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var todayQuestionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var homeAlbumCollectionView: UICollectionView!
    
    @IBOutlet weak var shakeButton: UIButton!
    
    @IBOutlet weak var middleSubView: UIView!
    
    @IBOutlet weak var subPopUpView: UIView!
    @IBOutlet weak var clipImage: UIImageView!
    @IBOutlet weak var explainLabel: UILabel!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLabel()
        setButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        shakeButton.makeRounded(cornerRadius: nil)
    }
    

}

// MARK: Extension

extension MainVC {
    
    // MARK: View Style Function
    
    func setView() {
        // 뷰 관련 Style 설정
        
        // 사용자 배경화면 설정
        if let backImage = UserDefaults.standard.string(forKey: "backgroundImg") {
            userBackImageView.image = UIImage(named: backImage)
        } else {
            userBackImageView.image = UIImage(named: "testBlackImage")
        }
        
        subPopUpView.backgroundColor = .nalulDarkGray
        subPopUpView.alpha = 0.6
        subPopUpView.setRounded(radius: 32.5)

            
        
    }
    
    // MARK: Label Style Function
    
    func setLabel() {
        // Label 관련 Style 설정
        
        todayQuestionLabel.numberOfLines = 0
        todayQuestionLabel.text = "당신의 나를에게\n점점 나에게 빠져들어가고 있나요?"
        todayQuestionLabel.font = UIFont.threeLight(size: 14)
        todayQuestionLabel.textColor = .white
        
        if let text = todayQuestionLabel.text {
            // 첫째줄만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 12), range: (text as NSString).range(of: "당신의 나를에게"))

            todayQuestionLabel.attributedText = attributedStr
        }
        
        todayQuestionLabel.lineSetting(kernValue: 0, lineSpacing: 14)
        
        dateLabel.text = "그렇게 중독되어 가는거에요"
        dateLabel.font = UIFont.twoExLight(size: 11)
        dateLabel.textColor = .white
        
    }
    
    // MARK: Button Style Function
    
    func setButton() {
        // Button 관련 Style 설정
        
        settingButton.setImage(UIImage(named: "btnSettings"), for: .normal)
        settingButton.tintColor = .white
        
        shakeButton.setBorder(borderColor: .white, borderWidth: 1)
        shakeButton.backgroundColor = .none
        shakeButton.setTitle("섞어", for: .normal)
        shakeButton.tintColor = .white
        
    }
}

