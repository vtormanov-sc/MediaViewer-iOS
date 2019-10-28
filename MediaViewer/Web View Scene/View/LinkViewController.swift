//
//  LinkViewController.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/22/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import UIKit
import WebKit

class LinkViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var customNavigationItem: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    
    private var errorLabel: UILabel?
    
    var state: ProgressState = .ready {
        willSet {
            switch newValue {
            case .loading:
                customNavigationItem.title = "Loading..."
                
                webView.isHidden = true
                errorLabel?.isHidden = true
                indicatorView.startAnimating()
            case .ready:
                let currentHost = presenter.selectedArticleUrl?.host
                customNavigationItem.title = currentHost
                
                errorLabel?.removeFromSuperview()
                errorLabel = nil
                
                indicatorView.stopAnimating()
                webView.isHidden = false
            case .error:
                customNavigationItem.title = "Network error"
                
                indicatorView.stopAnimating()
                errorLabel?.isHidden = false
            }
        }
    }
    
    var indicatorView: UIActivityIndicatorView!
    
    var presenter: LinkViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LinkViewPresenter(view: self)
        webView.navigationDelegate = self

        setupIndicator()
        
        presenter.loadArticle()
    }
    
    func setupIndicator() {
        indicatorView = UIActivityIndicatorView.setupIndicator(onto: view)
    }

    @IBAction func didPressDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressRefresh(_ sender: UIBarButtonItem) {
        state = .loading
        
        if webView.url != nil {
            webView.reload()
        } else {
            webView.load(URLRequest(url: presenter.selectedArticleUrl))
        }
    }
    
    func displayErrorLabel(text: String) {
        if let errorLabel = errorLabel {
            errorLabel.text = text
            errorLabel.isHidden = false
        } else {
            errorLabel = UILabel.setupErrorLabel(onto: view, text: text)
        }
    }
}

extension LinkViewController: LinkView {
    func loadArticle(_ request: URLRequest) {
        webView.load(request)
        state = .loading
    }
}

extension LinkViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        state = .ready
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        displayErrorLabel(text: error.localizedDescription)
        state = .error
    }
    
}
