//
//  MainCell.swift
//  Melody
//
//  Created by Mike Ulanov on 13.04.2024.
//

import UIKit
    
final class MainCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let contentTypeLabel = UILabel()
    private let contentImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MainViewModel) {
        titleLabel.text = model.title
        contentTypeLabel.text = model.contentType
        contentImageView.image = model.contentImage
    }
}

private extension MainCell {
    func setupUI(){
        backgroundColor = Constants.backgroundColorForMainCell 
        layer.cornerRadius = 8
        
        setupContentImageLabel()
        setupContentTypeLabel()
        setupTitleLabel()
    }
    
    func setupContentImageLabel(){
        addSubview(contentImageView)
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.layer.cornerRadius = 8
        contentImageView.layer.masksToBounds = true
        
        let imageSize: CGFloat = 100
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            contentImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentImageView.heightAnchor.constraint(equalToConstant: imageSize),
            contentImageView.widthAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    func setupTitleLabel(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentTypeLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupContentTypeLabel(){
        addSubview(contentTypeLabel)
        contentTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTypeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentTypeLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            contentTypeLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor),
            contentTypeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentTypeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
