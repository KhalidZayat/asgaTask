//
//  AppConstans.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

class AppConstans {

    // Initialization
    private init() {
        
    }
    
    // MARK: - Properties
    static let shared = AppConstans()
    static var baseURL = URL(string: "https://newsapi.org/v2/")!
    static var apiKey = "ddc91641332c46d186d06884f7dfd8ac"
    static var pageSize = 20
    
    enum URLPath: String {
        case news = "everything"
    }
    
    enum newsSortingType: String {
        case relevancy   = "relevancy"
        case popularity  = "popularity"
        case publishedAt = "publishedAt"
    }
}
