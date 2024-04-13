//
//  MainViewModel.swift
//  Melody
//
//  Created by Mike Ulanov on 13.04.2024.
//

import Foundation
import UIKit

struct MainViewModel {
    let title: String
    let contentType: String
    var contentImage = UIImage()
    
    init(title: String, contentType: String, contentImage: UIImage = UIImage()) {
        self.title = title
        self.contentType = contentType
        self.contentImage = contentImage
    }
}

//struct DetailViewModel {
//    let title: String
//    let authorName: String
//    let contentType: String
//    let trackViewUrl: String
//    let description: String
//    let artictLinkUrl: URL
//    var contentImage = UIImage()
//    
//    init(title: String, authorName: String, contentType: String, trackViewUrl: String, description: String, artictLinkUrl: URL,
//         contentImage: UIImage = UIImage()) {
//        self.title = title
//        self.authorName = authorName
//        self.contentType = contentType
//        self.trackViewUrl = trackViewUrl
//        self.description = description
//        self.artictLinkUrl = artictLinkUrl
//        self.contentImage = contentImage
//    }
//}
