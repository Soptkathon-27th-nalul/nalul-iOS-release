//
//  SettingCell.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class SettingCell: UITableViewCell {
    
    // MARK: Variable Part
    
    static let identifier: String = "SettingCell"

    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
        // Initialization code
    }
    
    func setCell() {
        
        titleLabel.font = .twoExLight(size: 16)
        titleLabel.textColor = .white
        underlineView.backgroundColor = .white
        underlineView.alpha = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
