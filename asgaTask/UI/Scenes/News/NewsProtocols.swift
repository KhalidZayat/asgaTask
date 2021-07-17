//
//  NewsProtocols.swift.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import Foundation

protocol NewsInteractor: AnyObject {
    func fetchData(params: NewsApiParameter)
}

protocol NewsPresenter: AnyObject {
    func viewLoaded()
    func getNews()
    func handleFetchingMoreNews()
    func handleGetNewsSuccess(with response: NewsResponse)
    func handleGetDataFail(with error: String)
    func configCell(with cell: NewsCell ,and index: Int)
    func getNewsCount() -> Int
    func searchBarTextInput(with text: String)
    func searchBarCanncelButtonTapped()
    func newsCellTapped(with index: Int)
}

protocol NewsView: AnyObject {
    func setupTableView()
    func setupSearchbar()
    func reloadTableView()
    func showIndicator()
    func hideIndicator()
    func showEmptyStateView(with text: String)
    func hideEmptyStateView()
    func showAlert(with message: String)
    func endSearchBarEditing()
    func navigateToDetails(with article: Article)
}

protocol NewsViewCell: AnyObject {
    func setArticleData(with item: NewsCellVM)
}
