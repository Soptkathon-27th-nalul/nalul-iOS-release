//
//  GalleryListVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/17.
//

import UIKit

class GalleryListVC: UIViewController {

    // MARK: Variable Part
    
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

        // Do any additional setup after loading the view.
    }
    

}

// MARK: Extension

extension GalleryListVC {
    
    // MARK: Function
    func setButton() {
        
        writeButton.makeRounded(cornerRadius: nil)

    }
    
}
