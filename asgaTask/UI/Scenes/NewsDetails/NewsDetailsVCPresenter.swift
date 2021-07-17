//
//  NewsDetailsPresenter.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

class NewsDetailsVCPresenter {
    private weak var view: NewsDetailsView?
    private var article: Article
    
    init(view: NewsDetailsView, article: Article) {
        self.view = view
        self.article = article
    }
}

extension NewsDetailsVCPresenter: NewsDetailsPresenter {
    func viewLoaded() {
        self.view?.setupViews(article: self.article)
    }
    
    func handleSourceBtnTap() {
        self.view?.navigateToSource(url: article.url ?? "")
    }
}
