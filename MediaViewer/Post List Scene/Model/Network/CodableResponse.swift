//
//  CodableResponse.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/21/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

// MARK: - DataList
struct DataList: Codable, Equatable {
    let entries: [Entry]
    
    enum CodingKeys: String, CodingKey {
        case entries = "entry"
    }
}

// MARK: - Entry
struct Entry: Codable, Equatable {
    let type: EntryType
    let title, summary: String
    
    let link: Link
    let mediaGroup: [MediaGroup]

    enum CodingKeys: String, CodingKey {
        case type
        case title, summary
        
        case link
        case mediaGroup = "media_group"
    }
}

// MARK: - Link
struct Link: Codable, Equatable {
    let href: String
}

// MARK: - MediaGroup
struct MediaGroup: Codable, Equatable {
    let type: MediaItemType
    let mediaItem: [MediaItem]

    enum CodingKeys: String, CodingKey {
        case type
        case mediaItem = "media_item"
    }
}

// MARK: - MediaItem
struct MediaItem: Codable, Equatable {
    let type: MediaItemType
    let scale: Scale

    let src: String
}

enum Scale: String, Codable {
    case large = "large"
    case small = "small"
}

enum MediaItemType: String, Codable {
    case image = "image"
}

// MARK: - EntryType
struct EntryType: Codable, Equatable {
    let value: Value
}

enum Value: String, Codable {
    case link
    case video
}
