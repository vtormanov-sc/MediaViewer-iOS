//
//  ArticleRepository.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/25/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

class ArticleRepository {
    var dataEntries: [Entry] = []
    var filteredDataEntries: [Entry] = []
    
    var totalEntries: Int { filteredDataEntries.count }
    
    func getData(at indexPath: IndexPath) -> Entry {
        filteredDataEntries[indexPath.row]
    }
    
    func writeData(_ dataList: DataList) {
        dataEntries = dataList.entries
        filteredDataEntries = dataEntries
    }
    
    @discardableResult
    func filter(by text: String) -> [Entry] {
        if !text.isEmpty {
            let lowercasedSearchText = text.lowercased()
            filteredDataEntries = dataEntries.filter { $0.title.lowercased().contains(lowercasedSearchText) }
        } else {
            filteredDataEntries = dataEntries
        }
        
        return filteredDataEntries
    }
}
