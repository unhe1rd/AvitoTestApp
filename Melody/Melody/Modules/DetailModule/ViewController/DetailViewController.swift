//
//  DetailViewController.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    var detailModel: DetailViewModel
    
    init(detailModel: DetailViewModel) {
        self.detailModel = detailModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        print(detailModel.title)
    }
}
