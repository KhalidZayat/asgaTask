//
//  URLBuilder.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Alamofire

protocol URLBuilder: URLRequestConvertible {
    var url: URL {get}
    var method: HTTPMethod {get}
    var paramaters: [String: Any]? {get}
    var images: [String:Data]? {get}
    var videos: [String:Data]? {get}
    var files: [String:Data]? {get}
    var encoding: ParameterEncoding {get}
    var header: HTTPHeaders {get}
    var urlRequest: URLRequest { get }
}
                        
extension URLBuilder {
    var header: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Accept"] = "application/json; charset=utf-8"
        return headers
    }
    
    var images: [String:Data]? {
        return nil
    }
    
    var videos: [String:Data]? {
        return nil
    }
    
    var files: [String:Data]? {
        return nil
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header.dictionary
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: paramaters)
    }
}
