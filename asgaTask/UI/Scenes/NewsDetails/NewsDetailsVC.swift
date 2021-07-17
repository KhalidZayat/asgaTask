//
//  NewsDetails.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import UIKit
import SDWebImage

class NewsDetailsVC: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    private var article: Article
    
    private lazy var presenter: NewsDetailsPresenter = {
        return NewsDetailsVCPresenter(view: self, article: self.article)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewLoaded()
    }
    
    init(article: Article) {
        self.article = article
        super.init(nibName: "NewsDetailsVC", bundle: nil)
        self.title = "News Details"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didTapSourceButton(_ sender: UIButton) {
        self.presenter.handleSourceBtnTap()
    }
}

extension NewsDetailsVC: NewsDetailsView {
    func setupViews(article: Article) {
        self.dateLabel.text = article.publishedAt?.ToDate()
        self.authorLabel.text = article.author
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.articleDescription
        self.contentLabel.text = article.content
        self.articleImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.articleImageView.sd_setImage(with: URL(string: article.urlToImage ?? ""), placeholderImage: nil)
    }
    
    func navigateToSource(url: String) {
        self.navigationController?.pushViewController(NewsSourceVC(source: url), animated: true)
    }
}
