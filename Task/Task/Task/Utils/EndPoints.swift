//
//  EndPoints.swift
//  Task
//
//  Created by Suraj Bhujbal on 26/04/24.
//

import Foundation


enum HttpMethods:String{
    case get = "GET"
    case post = "POST"
}


protocol EndpointType{
    var path:String{get}
    var baseUrl:String{get}
    var URl:URL?{get}
    var method:HttpMethods{get}
}


enum EndpointItem{
    case posts(page:Int)
}

extension EndpointItem:EndpointType{
    var path: String {
        switch self {
        case .posts(let page):
            "posts?_page=\(page)"
        }
    }
    
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    var URl: URL? {
        return URL(string: baseUrl+path)
    }
    
    var method: HttpMethods {
        switch self {
        case .posts:
            return .get
        }
    }
}

