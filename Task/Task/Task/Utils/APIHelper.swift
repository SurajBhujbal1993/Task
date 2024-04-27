//
//  APIHelper.swift
//  Task
//
//  Created by Suraj Bhujbal on 26/04/24.
//

import Foundation


class APIHelper {
    static let shared = APIHelper()
    
    typealias Handler<T> = (Result<T, APIError>) -> Void
    
    private init() {}
    
    func request<T:Codable>(
        form modelType:T.Type,
        type:EndpointType,
        completion:@escaping Handler<T>){
            
            guard let url = type.URl else {
                completion(.failure(.invalidURL))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = type.method.rawValue
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.unknownError(error.localizedDescription)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidStatusCode))
                    return
                }
                
                guard let responseData = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(modelType, from: responseData)
                        completion(.success(decodedData))
                } catch {
                    completion(.failure(.unknownError(error.localizedDescription)))
                }
            }.resume()
        }
}
