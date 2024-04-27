//
//  APIError.swift
//  Task
//
//  Created by Suraj Bhujbal on 26/04/24.
//

import Foundation


enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case invalidData
    case unknownError(String)
}
