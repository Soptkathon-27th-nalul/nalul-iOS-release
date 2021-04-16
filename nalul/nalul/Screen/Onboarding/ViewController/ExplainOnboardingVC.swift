//
//  ExplainOnboardingVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class ExplainOnboardingVC: UIViewController {
    
    // MARK: Variable Part
    
    var partNameArray: [String] = ["left\neye","left\nhand","mole","right\nhand","ear","lips","cheek","right\neye","nose"]
    
    // MARK: IBOutlet
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondeLabel: UILabel!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    

}

// MARK: Extension

extension ExplainOnboardingVC {
    
    // MARK: Function
    
    func setView() {
        
        firstLabel.text = "매일 nalul 찍습니다."
        firstLabel.textColor = .white
        firstLabel.font = .threeLight(size: 18)
        
        secondeLabel.text = "날마다 조금씩 달라지는\n당신의 외면을 찍어보세요."
        secondeLabel.textColor = .init(white: 1.0, alpha: 0.6)
        secondeLabel.font = .threeLight(size: 14)
        secondeLabel.numberOfLines = 0
        secondeLabel.textAlignment = .center
        
        galleryCollectionView.backgroundColor = .none
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
    }
}

// MARK: UICollectionViewDataSource

extension ExplainOnboardingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingGalleryCell.identifier, for: indexPath) as? OnboardingGalleryCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(name: partNameArray[indexPath.row])
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ExplainOnboardingVC: UICollectionViewDelegateFlowLayout {
    
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
