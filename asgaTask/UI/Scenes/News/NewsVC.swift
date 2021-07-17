//
//  NewsVC.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var emptyStateView: UIStackView!
    
    private lazy var presenter: NewsPresenter = {
        return NewsVCPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        self.presenter.viewLoaded()
    }
    
    init() {
        super.init(nibName: "NewsVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsVC: NewsView {
    
    func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
    func setupSearchbar() {
        self.searchBar.delegate = self
    }
    
    func reloadTableView() {
        self.newsTableView.reloadData()
    }
    
    func showIndicator() {
        self.loadingIndicator.startAnimating()
    }
    
    func hideIndicator() {
        self.loadingIndicator.stopAnimating()
    }
    
    func showEmptyStateView(with text: String) {
        self.emptyStateView.isHidden = false
        self.emptyStateLabel.text = text
    }
    
    func hideEmptyStateView() {
        self.emptyStateView.isHidden = true
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert,animated: true)
    }
    
    func navigateToDetails(with article: Article) {
        let vc = NewsDetailsVC(article: article)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func endSearchBarEditing() {
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }
}

extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        self.presenter.configCell(with: cell, and: indexPath.row )
        return cell
    }
}

extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.newsCellTapped(with: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (self.newsTableView.contentSize.height-100-scrollView.frame.size.height) {
            self.presenter.handleFetchingMoreNews()
        }
    }
}


extension NewsVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchBarCanncelButtonTapped()
    }
    
    // Search bar search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        if let searchKeyword = searchBar.text {
            self.presenter.searchBarTextInput(with: searchKeyword)
        }
    }

}
