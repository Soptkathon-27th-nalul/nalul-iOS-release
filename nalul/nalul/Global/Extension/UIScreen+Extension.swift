//
//  UIScreen+Extension.swift
//  nalul
//
//  Created by 김민희 on 2021/03/25.
//

import UIKit

extension UIScreen {
    
    // 기기에 노치가 있는지 없는지 판단
    public var hasNotch: Bool {
        
        let deviceRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        
        if deviceRatio > 0.5 {
            return false
        } else {
            return true
        }
    }
}
