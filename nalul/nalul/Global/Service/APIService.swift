//
//  APIService.swift
//  nalul
//
//  Created by 김민희 on 2021/04/14.
//

import Foundation
import Moya

struct APIService {
    
    static let shared = APIService()
    // 싱글톤객체로 생성
    let provider = MoyaProvider<APITarget>()
    // MoyaProvider(->요청 보내는 클래스) 인스턴스 생성
    
    func login(_ uuid: String, completion: @escaping (NetworkResult<LoginData>)->(Void)) {
        
        let target: APITarget = .login(uuid: uuid)
        judgeObject(target, completion: completion)

    }
    
    func signup(_ uuid: String, completion: @escaping (NetworkResult<LoginData>)->(Void)) {
        
        let target: APITarget = .signup(uuid: uuid)
        judgeObject(target, completion: completion)

    }

}

extension APIService {
    
    func judgeObject<T: Codable>(_ target: APITarget, completion: @escaping (NetworkResult<T>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(GenericResponse<T>.self, from: result.data)
                    if let data = body.data {
                        completion(.success(data))
                    }
                } catch {
                    print("구조체를 확인해보세요")
                }
            case .failure(let error):
                completion(.failure(error.response!.statusCode))
            }
        }
    }
    
    func judgeSimpleObject(_ target: APITarget, completion: @escaping (NetworkResult<Any>) -> Void) {
        // data를 받아오지 않을때 사용하기!
        provider.request(target) { response in
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(SimpleData.self, from: result.data)
                    completion(.success(body))
                } catch {
                    print("구조체를 확인해보세요")
                }
            case .failure(let error):
                completion(.failure(error.response!.statusCode))
            }
        }
    }
}
