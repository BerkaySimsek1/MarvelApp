//
//  Network.swift
//  MarvelApp
//
//  Created by Berkay on 22.03.2024.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {

    static private let basePath = "https://gateway.marvel.com/v1/public/characters"
    static private let privateKey = ""
    static private let publicKey = ""
    static let limit = 50

    class func loadHeroes(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))"
        } else {
            startsWith = ""
        }

        let url = basePath + "?offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        AF.request(url).response { (response) in
            guard let data = response.data,
                let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
                marvelInfo.code == 200 else {
                    onComplete(nil)
                    return
            }
            onComplete(marvelInfo)
        }
    }

    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    class func loadComicsbyID(id: Int, page: Int = 0, onComplete: @escaping (ComicInfo?) -> Void) {
        let offset = page * limit

        let url = basePath + "/\(id)/comics" + "?offset=\(offset)&limit=\(limit)&" + getCredentials()
        AF.request(url).response { (response) in
            guard let data = response.data,
                let marvelInfo = try? JSONDecoder().decode(ComicInfo.self, from: data),
                marvelInfo.code == 200 else {
                    onComplete(nil)
                    return
            }
            onComplete(marvelInfo)
        }
    }
    
    
    class func loadSeriesbyID(id: Int, page: Int = 0, onComplete: @escaping (SeriesInfo?) -> Void) {
        let offset = page * limit
        let url = basePath + "/\(id)/series" + "?offset=\(offset)&limit=\(limit)&" + getCredentials()
        AF.request(url).response { (response) in
            guard let data = response.data,
                let seriesInfo = try? JSONDecoder().decode(SeriesInfo.self, from: data),
                  seriesInfo.code == 200 else {
                    onComplete(nil)
                    return
            }
            
            onComplete(seriesInfo)
        }
    }


}
