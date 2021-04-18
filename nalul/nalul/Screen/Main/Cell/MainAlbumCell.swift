//
//  MainAlbumCell.swift
//  nalul
//
//  Created by 김민희 on 2021/03/25.
//

import UIKit

class MainAlbumCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "MainAlbumCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var partNameLabel: UILabel!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = .clear
        self.contentView.setBorder(borderColor: .white, borderWidth: 1)
        
        partNameLabel.numberOfLines = 0
        partNameLabel.font = UIFont.threeLight(size: 12)
        partNameLabel.textColor = .white
    }
    
    func configure(name: String) {
        self.partNameLabel.text = name
        self.contentView.setBorder(borderColor: .white, borderWidth: 1)
        
    }
    
    func setimage(imageURL: String) {
        self.partNameLabel.text = ""
        userImage.setImage(from: imageURL)
        self.contentView.setBorder(borderColor: .white, borderWidth: 0)
    }
}
