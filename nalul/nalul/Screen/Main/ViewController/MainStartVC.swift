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
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var blockCollectionView: UICollectionView!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var useExplainLabel: UILabel!
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLabel()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setButton()
        if view.safeAreaInsets.bottom == 0.0 {
            topLayoutConstraint.constant = 30
            bottomLayoutConstraint.constant = 20
        }
    }

}

// MARK: Extension

extension MainStartVC {
    
    // MARK: View Style Function
    
    func setView() {
        // 뷰 관련 Style 설정
        
        self.view.backgroundColor = .black
        
        backgroundImageView.image = UIImage(named: "mainStartBoder")
        
        blockCollectionView.backgroundColor = .none
        blockCollectionView.dataSource = self
        blockCollectionView.delegate = self
    
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
            // 첫째줄만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: welcomeLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 12), range: (text as NSString).range(of: "narul"))

            welcomeLabel.attributedText = attributedStr
        }
        
        welcomeLabel.lineSetting(kernValue: 0, lineSpacing: 14)
        
        subLabel.text = "시작은 달콤하게"
        subLabel.textColor = .white
        subLabel.font = UIFont.twoExLight(size: 11)
        
        useExplainLabel.text = "이제 시작. 나를에서 나를 찾아봐요\n나에게 중독되어 가는거에요, narul"
        useExplainLabel.textColor = .white
        useExplainLabel.font = UIFont.twoExLight(size:  11)
        useExplainLabel.numberOfLines = 0
        
        if let text = useExplainLabel.text {
            // 첫째줄 부분에만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: useExplainLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 14), range: (text as NSString).range(of: "이제 시작. 나를에서 나를 찾아봐요"))

            useExplainLabel.attributedText = attributedStr
        }
        
        useExplainLabel.lineSetting(kernValue: 0, lineSpacing: 12)
        
    }
}

extension MainStartVC: UICollectionViewDelegateFlowLayout {
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

extension MainStartVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainStartBlockCell.identifier, for: indexPath) as? MainStartBlockCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}
