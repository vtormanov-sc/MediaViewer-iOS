//
//  PostListTableViewController.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/21/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    var presenter: PostListPresenter!
    
    private var indicator: UIActivityIndicatorView!
    private var searchController: UISearchController!
    
    private var errorLabel: UILabel?
    
    private var offsetToScreenCenter: CGPoint {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let searchBarHeight = searchController?.searchBar.frame.height ?? 0
        
        return CGPoint(x: 0, y: -(navBarHeight + searchBarHeight))
    }
    
    var state: ProgressState = .ready {
        willSet {
            switch newValue {
            case .loading:
                if presenter.totalEntries == 0 && !(refreshControl?.isRefreshing ?? false) {
                    indicator.startAnimating()
                }
                
                errorLabel?.isHidden = true
            case .ready:
                errorLabel?.removeFromSuperview()
                errorLabel = nil
                
                indicator.stopAnimating()
                refreshControl?.endRefreshing()
                
                reloadData()
            case .error:
                indicator.stopAnimating()
                refreshControl?.endRefreshing()
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PostListPresenter(view: self)
        
        tableView.separatorStyle = .none
        refreshControl?.addTarget(self,
                                  action: #selector(didPullRefresh),
                                  for: UIControl.Event.valueChanged)

        setupSearchController()
        setupIndicator()
        
        refreshContent()
    }

    func setupIndicator() {
        indicator = UIActivityIndicatorView.setupIndicator(onto: view, offset: offsetToScreenCenter)
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Titles"
        searchController.searchBar.searchBarStyle = .minimal
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        definesPresentationContext = true
    }
    
    func displayError(text: String) {
        if presenter.totalEntries == 0 {
            if let errorLabel = errorLabel {
                errorLabel.text = text
                errorLabel.isHidden = false
            } else {
                errorLabel = UILabel.setupErrorLabel(onto: view, text: text, offset: offsetToScreenCenter)
            }
        } else {
            presentNetworkErrorAlert(withDescription: text)
        }
    }
    
    @objc func didPullRefresh() {
        guard state != .loading else {
            refreshControl?.endRefreshing()
            return
        }
        
        refreshContent()
    }
    
    func refreshContent() {
        state = .loading
        presenter.refreshContent()
    }
    
}

// MARK: - Table view data source
extension PostListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.totalEntries
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedEntry = presenter.getData(forCellAt: indexPath)
        let cellType = selectedEntry.type.value
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue, for: indexPath) as! PostListTableViewCell
        
        presenter.updateImage(forCell: cell, at: indexPath)
        
        cell.titleLabel.text = selectedEntry.title
        cell.summaryLabel.text = selectedEntry.summary
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCell(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Protocol extension
extension PostListTableViewController: PostListView {
    func didReceiveData() {
        state = .ready
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func goToWebView() {
        performSegue(withIdentifier: "listToLink", sender: self)
    }
    
    func goToVideoView() {
        performSegue(withIdentifier: "listToVideo", sender: self)
    }
    
    func networkErrorOccured(description: String) {
        displayError(text: description)
        state = .error
    }
}

// MARK: - Search controller
extension PostListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        presenter.filter(by: searchText)
    }
}
