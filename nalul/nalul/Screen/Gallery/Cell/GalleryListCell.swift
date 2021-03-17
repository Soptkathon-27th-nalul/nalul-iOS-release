//
//  GalleryListCollectionViewCell.swift
//  nalul
//
//  Created by 김민희 on 2021/03/17.
//

import UIKit

class GalleryListCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "GalleryListCell"
    
    // MARK: IBOutlet
    
    // MARK: Life Cycle Part
    
    override func awakeFromNib() {
//        self.contentView.backgroundColor = .white
        self.contentView.setBorder(borderColor: .white, borderWidth: 1)
    }
    
    // MARK: Function
    
}
