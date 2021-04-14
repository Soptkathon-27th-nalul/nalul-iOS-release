//
//  TeamNarulCell.swift
//  nalul
//
//  Created by 김민희 on 2021/04/14.
//

import UIKit

class TeamNarulCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "TeamNarulCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        
        self.contentView.backgroundColor = .clear
        self.backView.backgroundColor = .clear
        
        self.nameLabel.numberOfLines = 0
        self.nameLabel.font = UIFont.fourRegular(size: 9)
        self.nameLabel.textAlignment = .center
        
    }
    
    func configure(name: String, image: String, click: Bool) {
        
        self.nameLabel.text = name
        memberImage.image = UIImage(named: image)
        
        if click {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.backView.backgroundColor = .black
                self.backView.alpha = 0.5
                self.nameLabel.textColor = .white
            })
            
        } else {
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
                self.backView.backgroundColor = .clear
                self.nameLabel.textColor = .clear
            })
        }
    }
    
}
