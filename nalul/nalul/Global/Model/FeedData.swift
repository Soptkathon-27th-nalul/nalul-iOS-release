//
//  FeedData.swift
//  nalul
//
//  Created by 김민희 on 2021/04/18.
//

import Foundation

struct FeedData: Codable {
    let PostIdx: Int
    let photo, text, createdAt, Question: String
}
