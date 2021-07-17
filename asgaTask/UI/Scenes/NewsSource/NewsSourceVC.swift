//
//  NewsSourceVC.swift
//  asgaTask
//
//  Created by Khalid on 16/07/2021.
//


import UIKit
import WebKit

class NewsSourceVC: UIViewController {
    
    private var webView: WKWebView!
    private var source: String
    
    init(source: String) {
        self.source = source
        super.init(nibName: "NewsSourceVC", bundle: nil)
        self.title = "News Source"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: self.source)!
        webView.load(URLRequest(url: url))
    }
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        view = webView
    }
}
