//
//  Model.swift
//  MarvelApp
//
//  Created by Berkay on 22.03.2024.
//

import Foundation
import UIKit

struct ComicInfo: Codable {
    let code: Int
    let status: String
    let data: ComicData
}

struct ComicData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Comic]
}

struct Comic: Codable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: ComicThumbnail

}

struct ComicThumbnail: Codable {
    let path: String
    let ext: String

    var url: String {
        return path + "." + ext
    }

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }

}

struct ComicURL: Codable {
    let type: String
    let url: String
}
