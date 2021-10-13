//
//  NetworkLogic.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import Combine
import UIKit
import Network

// MARK: - NetworkingManager
class NetworkingManager {
    static let BASE_URL = "https://darkroastedbeans.coffeeit.nl/"
    static let shared = NetworkingManager()
    
    private init(){
    }
}

// MARK: - Helpers
extension NetworkingManager {
    /// call "GET" API for the endpoint urlString and publish the result that conform to decodable protocol
     func getData<T: Decodable>(urlString: String) -> AnyPublisher<T?, NetworkingError> {
        // verify connection
        guard isConnectedToNetwork() else {
            return Fail(error: NetworkingError.networkUnreachable).eraseToAnyPublisher()
        }
        
        // verify URL
        guard let url = URL(string: NetworkingManager.BASE_URL + urlString) else {return Fail(error: NetworkingError.unableToParseRequest)
            .eraseToAnyPublisher() }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = HttpMethod.get.rawValue
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let urlSession = URLSession(configuration: config)
        
        NVActivityIndicatorManager.showLoader(shouldShow: true, loaderMessage: "", loaderType: .ballBeat)
        return urlSession.dataTaskPublisher(for: urlRequest).tryMap( { (data: Data, response: URLResponse) -> Data in
            defer {
                NVActivityIndicatorManager.hideLoader()
            }
            guard let response = response as? HTTPURLResponse else {
                throw NetworkingError.unableToParseResponse }
            guard response.statusCode == 200 else {
                throw NetworkingError.unknownError
            }
            return data
        })
        .decode(type: T?.self, decoder: JSONDecoder())
        .mapError({ error in
            NetworkingError(error: error)
        })
        .eraseToAnyPublisher()

    }
}
// MARK: - HttpMethod
enum HttpMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
