//
//  ViewController.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDelegate {
    private let output: MainViewOutput
    private var viewModel: [MainViewModel] = []
    private var detailModel: [DetailViewModel] = []
    
    private let searchBar = UISearchBar()
    private let searchHistoryTable = UITableView()
    private var searchHistory = UserDefaults.standard.stringArray(forKey: "searchHistory") ?? [String]()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private var isFirstSearch: Bool = true
    
    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output.didLoadView()
    }
}

private extension MainViewController {
    func setupUI(){
        view.backgroundColor = Constants.backgroundColorForMainView

        setupSearchBar()
        setupSearchHistoryTable()
        setupCollectionView()
        setupNavigationController()
    }
    
    func setupNavigationController(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Constants.textColor
        navigationItem.backBarButtonItem = backButton
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search your Melody..."
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(systemName: "30.square"), for: .bookmark, state: .normal)
        
        searchBar.barTintColor = Constants.searchBarTintColor
        searchBar.tintColor = Constants.searchBarTintColor
        searchBar.searchTextField.textColor = Constants.textColor
        searchBar.searchTextField.backgroundColor = Constants.backgroundColorForSearchBar
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func setupSearchHistoryTable() {
        view.addSubview(searchHistoryTable)
        searchHistoryTable.translatesAutoresizingMaskIntoConstraints = false
        searchHistoryTable.dataSource = self
        searchHistoryTable.showsVerticalScrollIndicator = false
        searchHistoryTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchHistoryTable.backgroundColor = Constants.backgroundColorForMainCell
        searchHistoryTable.layer.cornerRadius = 16
        searchHistoryTable.isHidden = true
        
        NSLayoutConstraint.activate([
            searchHistoryTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchHistoryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchHistoryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchHistoryTable.heightAnchor.constraint(equalToConstant: 40*5.5)
        ])
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: CollectionView
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width / 2
        let cellWidth = (collectionViewWidth - 20)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didTapOnCell(model: detailModel[indexPath.row])
    }
}

// MARK: SearchBar
extension MainViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.didChangeSearchText(searchText: searchText)
        
        searchHistory = searchHistory.filter {
            $0.localizedCaseInsensitiveContains(searchText.lowercased())
        }
        if searchHistory == [] {
            searchHistoryTable.isHidden = true
            isFirstSearch = false
        }
        if isFirstSearch == true {
            searchHistoryTable.isHidden = false
        }
        isFirstSearch = false
        searchHistoryTable.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let isUsingDefaultIcon = searchBar.image(for: .bookmark, state: .normal) == UIImage(systemName: "30.square")
        let newIcon = isUsingDefaultIcon ? UIImage(systemName: "a.square.fill") : UIImage(systemName: "30.square")
        searchBar.setImage(newIcon, for: .bookmark, state: .normal)
        output.didSearchBarBookmarkButtonClicked(isUsingDefaultLimit: !isUsingDefaultIcon)
    }
}

// MARK: TableView
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchHistory[indexPath.row]
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: ViewInput
extension MainViewController: MainViewInput {
    func configure(with model: [MainViewModel], with detailModel: [DetailViewModel]) {
        self.viewModel = model
        self.detailModel = detailModel
        searchHistoryTable.isHidden = true
        collectionView.reloadData()
        searchHistory = UserDefaults.standard.stringArray(forKey: "searchHistory") ?? [String]()
    }
}
