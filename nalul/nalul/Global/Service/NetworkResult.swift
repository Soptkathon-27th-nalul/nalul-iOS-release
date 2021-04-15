//
//  NetworkResult.swift
//  nalul
//
//  Created by 김민희 on 2021/04/14.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(Int)
}
