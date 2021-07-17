//
//  NewsApiParameter.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

struct NewsApiParameter {
    var query: String = ""
    var fromDate: String = Date().dayBefore.toUrlDate()
    var sort: String = AppConstans.newsSortingType.publishedAt.rawValue
    var page: Int = 1
    var pageSize: Int = AppConstans.pageSize
    var apiKey: String = AppConstans.apiKey
}
