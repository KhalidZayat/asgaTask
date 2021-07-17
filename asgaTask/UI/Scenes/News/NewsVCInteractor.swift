//
//  NewsVCInteractor.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

class NewsVCInteractor {
    private weak var presenter: NewsPresenter?
    init(presenter: NewsPresenter) {
        self.presenter = presenter
    }
}

extension NewsVCInteractor: NewsInteractor {
    func fetchData(params: NewsApiParameter) {
        NetworkManager.shared.getData(request: NewsEndPoint(params: params), objType: NewsResponse.self) {
            (results) in
            switch results {
            case .failure(let error):
                self.presenter?.handleGetDataFail(with: error)
            case .success(let NewsResponse):
                guard NewsResponse.articles != nil else { return }
                self.presenter?.handleGetNewsSuccess(with: NewsResponse)
            }
        }
    }
}
