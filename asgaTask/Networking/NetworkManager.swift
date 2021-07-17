//
//  NetworkManager.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Alamofire

enum Result <T:Codable> {
    case success(T)
    case failure(String    )
}

class NetworkManager {
    // Initialization
    private init() {}
    
    // MARK: - Properties
    static let shared = NetworkManager.init()
    
    func getData<T: Decodable>(request: URLBuilder, objType: T.Type, completionHandler:  @escaping (_ result: Result<T>)->Void) {
        AF.request(request).responseData {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler(Result.failure( error.localizedDescription ))
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(objType.self, from: value)
                    completionHandler(Result.success(result))
                }catch let error {
                    completionHandler(Result.failure(error.localizedDescription))
                }
            }
        }
    }
    
    func uploadFile<T: Decodable>(request: URLBuilder, objType: T.Type, completionHandler:  @escaping (_ result: Result<T>)->Void) {
        AF.upload(multipartFormData: {
            (multipartFormData) in
            for (key, value) in request.paramaters ?? [:] {
                if let val = value as? String {
                    multipartFormData.append(val.data(using: .utf8)!, withName: key)
                }
            }
            
            for (key, value) in request.images ?? [:] {
                multipartFormData.append(value, withName: key, fileName: "\(key).jpg", mimeType: "image/jpeg")
            }
            
            for (key, value) in request.videos ?? [:] {
                multipartFormData.append(value, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
            }
            
            for (key, value) in request.files ?? [:] {
                multipartFormData.append(value, withName: key, fileName: "\(key)", mimeType: "text/plain")
            }
        }, to: request.url, method: request.method, headers: request.header)
        .responseData { (response) in
            switch response.result {
            case .failure(let error):
                completionHandler(Result.failure( error.localizedDescription ))
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(objType.self, from: value)
                    completionHandler(Result.success(result))
                }catch let error {
                    completionHandler(Result.failure(error.localizedDescription))
                }
            }
        }
    }
}
