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
    private let contentTypeLabel = UILabel()
    private let titleLabel = UILabel()
    private let authorNameLabel = UILabel()
    private let trackViewButton = UIButton()
    private let descriptionLabel = UILabel()
    private let lookupButton = UIButton()
    
    private var trackViewUrl: String?
    private var lookupUrl: String?
    
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
        setupTrackViewButton()
        setupContentTypeLabel()
        setupTitleLabel()
        setupAuthorNameLabel()
        setupDescriptionLabel()
        setupLookupButton()
    }
    
    func setupDetailImageView(){
        view.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.layer.cornerRadius = 8
        detailImageView.layer.masksToBounds = true
        
        let imageSize: CGFloat = 120
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            detailImageView.heightAnchor.constraint(equalToConstant: imageSize),
            detailImageView.widthAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    func setupTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .natural
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentTypeLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentTypeLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentTypeLabel.trailingAnchor)
        ])
    }
    
    func setupContentTypeLabel(){
        view.addSubview(contentTypeLabel)
        contentTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTypeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentTypeLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            contentTypeLabel.topAnchor.constraint(equalTo: detailImageView.topAnchor),
            contentTypeLabel.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: 8),
            contentTypeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setupAuthorNameLabel(){
        view.addSubview(authorNameLabel)
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.font = UIFont.systemFont(ofSize: 18)
        authorNameLabel.textAlignment = .natural
        authorNameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentTypeLabel.leadingAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentTypeLabel.trailingAnchor)
        ])
    }
    
    func setupDescriptionLabel(){
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: trackViewButton.topAnchor, constant: -8)
        ])
    }
    //MARK: TrackViewButton
    func setupTrackViewButton(){
        view.addSubview(trackViewButton)
        trackViewButton.translatesAutoresizingMaskIntoConstraints = false
        trackViewButton.addTarget(self, action: #selector(didPressTrackViewButton), for: .touchUpInside)
        if let originalImage = UIImage(systemName: "apple.logo") {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16)
            let symbolImage = originalImage.withConfiguration(symbolConfiguration)
            trackViewButton.setImage(symbolImage, for: .normal)
            trackViewButton.tintColor = UIColor.white
            trackViewButton.setTitle(" iTunes", for: .normal)
            trackViewButton.setTitleColor(UIColor.white, for: .normal)
            trackViewButton.layer.cornerRadius = 16
            trackViewButton.backgroundColor = UIColor.black
        }
        
        let buttonHeight:CGFloat = 32
        let buttonWidth:CGFloat = (view.frame.width / 2) - 16
        NSLayoutConstraint.activate([
         trackViewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            trackViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            trackViewButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            trackViewButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
    }
    
    @objc func didPressTrackViewButton(){
        guard let url = trackViewUrl else {
            return
        }
        output.didPressTrackViewButton(trackViewUrl: url)
    }
    
    //MARK: LookupButton
    func setupLookupButton(){
        view.addSubview(lookupButton)
        lookupButton.translatesAutoresizingMaskIntoConstraints = false
        lookupButton.addTarget(self, action: #selector(didPressLookupButton), for: .touchUpInside)
        if let originalImage = UIImage(systemName: "person.crop.circle") {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16)
            let symbolImage = originalImage.withConfiguration(symbolConfiguration)
            lookupButton.setImage(symbolImage, for: .normal)
            lookupButton.tintColor = UIColor.white
            lookupButton.setTitle(" Author", for: .normal)
            lookupButton.setTitleColor(UIColor.white, for: .normal)
            lookupButton.layer.cornerRadius = 16
            lookupButton.backgroundColor = UIColor.black
        }
        
        let buttonHeight:CGFloat = 32
        let buttonWidth:CGFloat = (view.frame.width / 2) - 16
        NSLayoutConstraint.activate([
            lookupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            lookupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            lookupButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            lookupButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
    }
    
    @objc func didPressLookupButton(){
        guard let url = lookupUrl else {
            return
        }
        output.didPressLookupButton(url: url)
    }
}

extension DetailViewController: DetailViewInput {
}

extension DetailViewController: DetailModuleInput {
    func configure(with detailViewModel: DetailViewModel) {
        detailImageView.image = detailViewModel.contentImage
        titleLabel.text = detailViewModel.title
        contentTypeLabel.text = detailViewModel.contentType
        authorNameLabel.text = detailViewModel.authorName
        trackViewUrl = detailViewModel.trackViewUrl
        lookupUrl = detailViewModel.artictLinkUrl
        
        if TextManager
            .convertHtmlToPlainText(detailViewModel.description)
            == "Description: Description N/F" {
            descriptionLabel.isHidden = true
        }
        descriptionLabel.text = TextManager.convertHtmlToPlainText(detailViewModel.description)
    }
}
