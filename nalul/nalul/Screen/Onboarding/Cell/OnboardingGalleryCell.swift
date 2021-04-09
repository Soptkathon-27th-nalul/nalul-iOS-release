//
//  OnboardingGalleryCell.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class OnboardingGalleryCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "OnboardingGalleryCell"
    
    // MARK: IBOutlet
    
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
    }

}
