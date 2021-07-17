//
//  NewsDetailsProtocols.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

protocol NewsDetailsPresenter: AnyObject {
    func viewLoaded()
    func handleSourceBtnTap()
}

protocol NewsDetailsView: AnyObject {
    func setupViews(article: Article)
    func navigateToSource(url: String)
}
