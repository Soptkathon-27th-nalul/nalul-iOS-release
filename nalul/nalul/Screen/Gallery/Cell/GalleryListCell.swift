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
    
    @IBOutlet weak var galleryImageView: UIImageView!
    
    // MARK: Life Cycle Part
    
    override func awakeFromNib() {
        self.contentView.setBorder(borderColor: .nalulLightGray, borderWidth: 1)
    }
    
    // MARK: Function
    
    func setimage(imageURL: String) {
        galleryImageView.setImage(from: imageURL)
    }
    
}
