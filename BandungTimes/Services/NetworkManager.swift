//
//  NetworkManager.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation
import Alamofire

class NetworkManager {

    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return Session(configuration: configuration)
    }()

    func connect<T: Decodable>(endpoint: String, method: HTTPMethod, parameter: Parameters? = nil,
                               encoding: ParameterEncoding = JSONEncoding.default,
                               completion: @escaping(Result<T, Error>) -> Void) {
        let url = api_url + endpoint
        session.request(url, method: method, parameters: parameter, encoding: encoding, headers: nil)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
