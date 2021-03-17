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
        
    }
    
    
    func setButton() {
        
        writeButton.setTitle("추가", for: .normal)
        writeButton.titleLabel?.font = UIFont.threeLight(size: 14)
        writeButton.tintColor = .white
        writeButton.setBorder(borderColor: .white, borderWidth: 1)
        writeButton.makeRounded(cornerRadius: nil)

    }
    
    
}
