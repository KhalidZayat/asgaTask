//
//  NewsVCPresenter.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

class NewsVCPresenter {
    private weak var view: NewsView?
    private var searchResults: [Article] = []
    private var selectedArticleIndex = 0
    private var pageIndex = 1
    private var isLoading = false
    private var hasMore = false
    private var params: NewsApiParameter
    private lazy var interactor: NewsInteractor = {
        return NewsVCInteractor(presenter: self)
    }()
    
    init(view: NewsView) {
        self.view = view
        self.params = NewsApiParameter()
    }
}

extension NewsVCPresenter: NewsPresenter {
    
    func viewLoaded() {
        self.view?.setupTableView()
        self.view?.setupSearchbar()
    }
    
    func getNews() {
        self.view?.hideEmptyStateView()
        self.view?.showIndicator()
        self.interactor.fetchData(params: self.params)
    }
    
    func handleFetchingMoreNews() {
        guard !self.isLoading else {return}
        if self.hasMore {
            self.isLoading = true
            self.pageIndex += 1
            self.params.page = self.pageIndex
            self.getNews()
        }
    }
    
    func handleGetNewsSuccess(with response: NewsResponse) {
        self.isLoading = false
        self.view?.hideIndicator()
        self.searchResults.append(contentsOf: response.articles ?? [])
        self.view?.reloadTableView()
        self.hasMore = searchResults.count < response.totalResults! ? true:false
        if response.articles?.count == 0 {
            self.view?.showEmptyStateView(with: "Empty results!, Try another query")
        }else {
            self.view?.hideEmptyStateView()
        }
    }
    
    func handleGetDataFail(with error: String) {
        self.view?.hideIndicator()
        self.view?.showAlert(with: error)
    }
    
    func configCell(with cell: NewsViewCell, and index: Int) {
        let article = self.searchResults[index]
        cell.setArticleData(with: NewsCellVM(title: article.title, source: article.source?.name, imgUrl: article.urlToImage))
    }

    func configCell(with cell: NewsCell, and index: Int) {
        let article = self.searchResults[index]
        cell.setArticleData(with: NewsCellVM(title: article.title, source: article.source?.name, imgUrl: article.urlToImage))
    }
    func newsCellTapped(with index: Int) {
        self.view?.navigateToDetails(with: self.searchResults[index])
    }
    
    func getNewsCount() -> Int {
        return self.searchResults.count
    }
    
    func searchBarTextInput(with text: String) {
        self.pageIndex = 1
        self.searchResults.removeAll()
        self.params.page = self.pageIndex
        self.params.query = text
        self.getNews()
    }
    
    func searchBarCanncelButtonTapped() {
        self.view?.endSearchBarEditing()
    }
}
