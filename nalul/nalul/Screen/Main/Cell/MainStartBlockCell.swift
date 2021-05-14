//
//  MainStartBlockCollectionViewCell.swift
//  nalul
//
//  Created by 김민희 on 2021/03/18.
//

import UIKit

class MainStartBlockCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "MainStartBlockCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var plusImageView: UIImageView!

    
    override func awakeFromNib() {
        self.contentView.backgroundColor = .white
    }
}
