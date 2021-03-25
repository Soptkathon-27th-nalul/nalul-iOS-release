//
//  MainViewController.swift
//  nalul
//
//  Created by 김민희 on 2021/03/24.
//

import UIKit

class MainVC: UIViewController {

    // MARK: Variable Part
    
    var partNameArray: [String] = ["left\neye","left\nhand","eye\nbrow","right\nhand","ear","lips","cheek","right\neye","nose"]
    
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

        homeAlbumCollectionView.delegate = self
        homeAlbumCollectionView.dataSource = self
        homeAlbumCollectionView.backgroundColor = .none
        
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
        
        explainLabel.numberOfLines = 0
        explainLabel.text = "+ 버튼을 눌러 사진을 추가하세요\n사진 순서는 랜덤입니다"
        explainLabel.font = UIFont.threeLight(size: 14)
        explainLabel.textColor = .white
        
        if let text = explainLabel.text {
            // 두번째줄만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.twoExLight(size: 11), range: (text as NSString).range(of: "사진 순서는 랜덤입니다"))

            explainLabel.attributedText = attributedStr
        }
        
        explainLabel.lineSetting(kernValue: 0, lineSpacing: 12)
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

extension MainVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: (collectionView.frame.width-10)/3, height: (collectionView.frame.width-10)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 위아래 간격
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 오른쪽 간격
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

extension MainVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAlbumCell.identifier, for: indexPath) as? MainAlbumCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(name: partNameArray[indexPath.row])
        
        return cell
    }
    
    
}
