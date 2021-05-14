//
//  APITarget.swift
//  nalul
//
//  Created by 김민희 on 2021/04/14.
//

import Foundation
import Moya

enum APITarget {
    // case 별로 api 나누기
    case login(uuid: String) // 로그인
    case signup(uuid: String) // 회원가입
    case shuffleMain(jwt: String) // 9개 부위 사진 셔플받기
    case categoryFeed(category: Int, jwt: String) // 부위 카테고리 모든 게시물 받아오기
    case todayQuestion(category: Int, jwt: String) // 질문 가져오기
    case postFeed(questionIndex: Int, image: UIImage, contents: String, jwt: String) // 게시물 올리기
    case deleteFeed(postIndex: Int, jwt: String) // 게시물 삭제하기
    
}

// MARK: TargetType Protocol 구현

extension APITarget: TargetType {
    
    var baseURL: URL {
        // baseURL - 서버의 도메인
        return URL(string: "http://13.124.224.41:3000")!
    }
    
    var path: String {
        // path - 서버의 도메인 뒤에 추가 될 경로
        switch self {
        case .login:
            return "/user/signin"
        case .signup:
            return "/user/signup"
        case .shuffleMain:
            return "/main"
        case .categoryFeed(let category, _):
            return "/album/\(category)"
        case .todayQuestion(let category, _):
            return "/post/\(category)"
        case .postFeed(let questionIndex, _, _, _):
            return "/post/\(questionIndex)"
        case .deleteFeed(let postIndex, _):
            return "/album/\(postIndex)"
        }
    }
    
    var method: Moya.Method {
        // method - 통신 method (get, post, put, delete ...)
        switch self {
        case .login, .signup, .postFeed:
            return .post
        case .shuffleMain, .categoryFeed, .todayQuestion:
            return .get
        case .deleteFeed:
            return .delete
        }
    }
    
    var sampleData: Data {
        // sampleDAta - 테스트용 Mock Data
        return Data()
    }
    
    var task: Task {
        // task - 리퀘스트에 사용되는 파라미터 설정
        // 파라미터가 없을 때는 - .requestPlain
        // 파라미터 존재시에는 - .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        
        switch self {
        case .login(let uuid), .signup(let uuid):
            return .requestParameters(parameters: ["uuid" : uuid], encoding: JSONEncoding.default)
            
        case .shuffleMain, .categoryFeed, .todayQuestion, .deleteFeed:
            return .requestPlain
        
        case .postFeed(_, let image, let contents, _):
            let postString = MultipartFormData(provider: .data(contents.data(using: .utf8)!), name: "postString")
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0)!), name: "image", fileName: "jpeg", mimeType: "image/jpeg")
            let multipartData = [imageData, postString]
            return .uploadMultipart(multipartData)
            
        }
    }
    
    var validationType: Moya.ValidationType {
        // validationType - 허용할 response의 타입
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        // headers - HTTP header
        switch self {
        case .login, .signup:
            return ["Content-Type" : "application/json"]
        case .shuffleMain(let jwt), .categoryFeed(_, let jwt), .todayQuestion(_, let jwt), .postFeed(_, _, _, let jwt), .deleteFeed(_, let jwt):
            return ["Content-Type" : "application/json", "jwt" : jwt]
        }
    }
    
    
    
}
