//
//  PostListPresenter.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/21/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import Moya

class PostListPresenter {
    unowned var view: PostListView?
    var networkManager: NetworkManager
    var articleRepository: ArticleRepository
    
    var totalEntries: Int { articleRepository.totalEntries }
    
    init(view: PostListView? = nil) {
        self.view = view
        self.networkManager = NetworkManager()
        self.articleRepository = ArticleRepository()
        
        networkManager.delegate = self
    }
    
    func getData(forCellAt indexPath: IndexPath) -> Entry {
        articleRepository.getData(at: indexPath)
    }
    
    // MARK: - Image
    func updateImage(forCell cell: PostListTableViewCell, at indexPath: IndexPath) {
        guard let imageUrl = getImageUrl(forCellAt: indexPath) else { return }
        
        cell.updateImage(withUrl: imageUrl)
    }
    
    private func getImageUrl(forCellAt indexPath: IndexPath) -> URL? {
        let cellData = getData(forCellAt: indexPath)
        
        let firstImageGroup = cellData.mediaGroup.first(where: { $0.type == .image })
        if let firstImageItem = firstImageGroup?.mediaItem.first(where: { $0.type == .image }) {
            return URL(string: firstImageItem.src)
        } else {
            return nil
        }
    }
    
    // MARK: - Filtering
    func filter(by searchText: String) {
        articleRepository.filter(by: searchText)
        view?.reloadData()
    }
    
    // MARK: - Transfer to other views
    func didSelectCell(at indexPath: IndexPath) {
        let selectedArticle = getData(forCellAt: indexPath)
        
        SelectedArticleCache.cache(selectedArticle)
        
        let selectedCellType = selectedArticle.type.value
        switch selectedCellType {
        case .link:
            view?.goToWebView()
        case .video:
            view?.goToVideoView()
        }
    }
    
    // MARK: - Refreshing
    func refreshContent() {
        networkManager.getArticles()
    }
}

extension PostListPresenter: NetworkManagerDelegate {
    func downloadFinished(receivedData: DataList?) {
        guard let list = receivedData else { return }
        
        articleRepository.writeData(list)
        
        view?.didReceiveData()
    }
    
    func downloadFinishedWithError(error: MoyaError) {
        view?.networkErrorOccured(description: error.localizedDescription)
    }
}
