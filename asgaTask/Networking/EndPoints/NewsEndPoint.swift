//
//  NewsEndPoint.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Alamofire

struct NewsEndPoint: URLBuilder {
    
    private let path = AppConstans.URLPath.news.rawValue
    private var params: NewsApiParameter
    
    var url: URL {
        return AppConstans.baseURL.appendingPathComponent(path)
    }
    
    var paramaters: [String : Any]? {
        return ["q": params.query,
                "from": params.fromDate,
                "sortBy": params.sort,
                "apiKey": params.apiKey,
                "pageSize": params.pageSize,
                "page": params.page]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    init(params: NewsApiParameter) {
        self.params = params
    }
}
