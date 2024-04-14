//
//  TextManager.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation
import UIKit

final class TextManager {
    
    static func convertHtmlToPlainText(_ html: String) -> String {
        guard let data = html.data(using: .utf8) else { return "" }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString.string
        } else {
            return ""
        }
    }
    
}
