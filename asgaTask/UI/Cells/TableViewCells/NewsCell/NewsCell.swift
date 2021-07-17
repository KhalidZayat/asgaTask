//
//  NewsCell.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 8
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cellView.layer.shadowOpacity = 0.4
        cellView.layer.shadowRadius = 4.0
    }
    
}

extension NewsCell: NewsViewCell {
    func setArticleData(with item: NewsCellVM) {
        self.titleLabel.text = item.title
        self.sourceLabel.text = item.source
        self.newsImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.newsImageView.sd_setImage(with: URL(string: item.imgUrl ?? ""), placeholderImage: nil)
    }
}
