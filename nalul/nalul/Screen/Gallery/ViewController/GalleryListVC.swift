//
//  GalleryListVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/17.
//

import UIKit

class GalleryListVC: UIViewController {
    
    // MARK: Variable Part
    
    var titleName: String?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var galleryListCollectionView:
        UICollectionView!
    
    // MARK: IBAction
    
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setView()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        setButton()
        
    }
    
}

// MARK: Extension

extension GalleryListVC {
    
    // MARK: Function
    
    func setView() {
        
        view.backgroundColor = .black
        galleryListCollectionView.backgroundColor = .none
        
        titleLabel.font = UIFont.threeLight(size: 17)
        titleLabel.textColor = .white
        
        if let titleName = titleName {
            titleLabel.text = titleName
        } else {
            titleLabel.text = "왼쪽 눈"
        }
        
        galleryListCollectionView.dataSource = self
        galleryListCollectionView.delegate = self
        
    }
    
    
    func setButton() {
        
        writeButton.setTitle("추가", for: .normal)
        writeButton.titleLabel?.font = UIFont.threeLight(size: 14)
        writeButton.tintColor = .white
        writeButton.setBorder(borderColor: .white, borderWidth: 1)
        writeButton.makeRounded(cornerRadius: nil)
        
    }
    
    
}

extension GalleryListVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 110/375*collectionView.frame.width, height: 110/375*collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 위아래 간격
        
        return 13
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 오른쪽 간격
        
        return 72
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.view.frame.width - (110/375*collectionView.frame.width*2 + 72))
        
    }
    
}

extension GalleryListVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 최소 단위 12개로 설정
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryListCell.identifier, for: indexPath) as? GalleryListCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}
