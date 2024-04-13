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
