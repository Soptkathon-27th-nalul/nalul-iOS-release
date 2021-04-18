//
//  ShuffleData.swift
//  nalul
//
//  Created by 김민희 on 2021/04/15.
//

import Foundation

struct ShuffleData: Codable {
    let random1, random2, random3, random4, random5, random6, random7, random8, random9: String
    
    func toArray() -> [String] {
        return [random1, random2, random3, random4, random5, random6, random7, random8, random9]
    }
}
