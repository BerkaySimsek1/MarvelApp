
//
//  Model.swift
//  MarvelApp
//
//  Created by Berkay on 22.03.2024.
//

import Foundation
import UIKit

struct SeriesInfo: Codable {
    let code: Int
    let status: String
    let data: SeriesData
}

struct SeriesData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Series]
}

struct Series: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: SeriesThumbnail

}

struct SeriesThumbnail: Codable {
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

struct SeriesURL: Codable {
    let type: String
    let url: String
}
