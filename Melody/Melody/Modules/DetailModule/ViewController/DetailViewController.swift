//
//  DetailViewController.swift
//  Melody
//
//  Created by Mike Ulanov on 14.04.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    private let output: DetailViewOutput
    
    private let detailImageView = UIImageView()
    
    init(output: DetailViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension DetailViewController{
    func setupUI(){
        view.backgroundColor = Constants.backgroundColorForDetailView
        
        setupDetailImageView()
    }
    
    func setupDetailImageView(){
        view.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.layer.cornerRadius = 8
        detailImageView.layer.masksToBounds = true
        
        let imageSize: CGFloat = 100
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: imageSize),
            detailImageView.widthAnchor.constraint(equalToConstant: imageSize)
        ])
    }
}

extension DetailViewController: DetailViewInput {
}

extension DetailViewController: DetailModuleInput {
    func configure(with detailViewModel: DetailViewModel) {
        detailImageView.image = detailViewModel.contentImage
    }
}
