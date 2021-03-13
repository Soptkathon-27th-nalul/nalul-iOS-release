//
//  UIButton+Extension.swift
//  nalul
//
//  Created by 김민희 on 2021/03/13.
//

import UIKit

extension UIButton {
    func makeRounded(cornerRadius : CGFloat?){
            // UIView 의 모서리가 둥근 정도를 설정
        
            if let cornerRadius_ = cornerRadius {
                self.layer.cornerRadius = cornerRadius_
            }  else {
                self.layer.cornerRadius = self.layer.frame.height / 2
            }
            
            self.layer.masksToBounds = true
        }
}
