//
//  Networking.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation
import Alamofire

public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}



class NetworkService {

    static var instance = NetworkService()
    private init() {}

    func requestFunction<T: Decodable>(urlString: String, method: HTTPMethod, model: [String: Any] = [:], completion: @escaping (Result<T, Error>) -> Void) {

           var headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Accept": "application/json"
           ]

           var request: DataRequest
           switch method {
           case .get:
               request = Alamofire.request(urlString, method: .get, parameters: model, encoding: URLEncoding.default, headers: headers)
           case .post:
               request = Alamofire.request(urlString, method: .post, parameters: model, encoding: JSONEncoding.default, headers: headers)
           case .delete:
               request = Alamofire.request(urlString, method: .delete, parameters: model, encoding: URLEncoding.default, headers: headers)
           case .put:
               request = Alamofire.request(urlString, method: .put, parameters: model, encoding: JSONEncoding.default, headers: headers)
           }

           request.validate().responseData { response in
               switch response.result {
               case .success(let data):
                   do {
                       let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                       completion(.success(decodedResponse))
                   } catch {
                       completion(.failure(error))
                   }
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
}