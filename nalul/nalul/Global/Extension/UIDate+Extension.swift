//
//  UIDate+Extension.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import Foundation

extension Date {
    
    func datePickerToString() -> String {
        // date 타입을 string으로 바꾸기
        
        let formatter = DateFormatter()
        let format = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        
        return dateString
    }

}
