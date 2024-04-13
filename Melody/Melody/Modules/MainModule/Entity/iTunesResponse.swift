//
//  iTunesResponse.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//

import Foundation

struct iTunesResponse: Decodable {
    let resultCount: Int
    let results: [iTunesItem]
}

struct iTunesItem: Decodable {
    let artworkUrl100: URL
    let trackName: String?
    let artistName: String
    let wrapperType: String
    let trackViewUrl: String?
    let longDescription: String?
    let collectionName: String?
    let artistId: Int
}
