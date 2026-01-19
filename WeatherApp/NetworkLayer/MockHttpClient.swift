//
//  MockHttpClient.swift
//  WeatherApp
//
//  Created by Raghu on 1/19/26.
//

import Foundation

class MockHttpClient: HTTPClient {
    var shouldReturnError = false
    var mockWeatherModel: WeatherModel?

    override func request<T>(modelType: T.Type, url: URL?, httpMethod: HttpMethodType, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        if shouldReturnError {
            completion(.failure(.network(NSError(domain: "", code: 404, userInfo: nil))))
        } else {
            if let mockWeatherModel = mockWeatherModel as? T {
                completion(.success(mockWeatherModel))
            } else {
                completion(.failure(.invalidData))
            }
        }
    }
}
