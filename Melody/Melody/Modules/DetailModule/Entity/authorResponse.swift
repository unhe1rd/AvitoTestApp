//
//  authorResponse.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation

struct authorResponse: Decodable {
    let results: [authorItem]
}

struct authorItem: Decodable {
    let artistLinkUrl: String
}
