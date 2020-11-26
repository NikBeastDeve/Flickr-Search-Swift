//
//  SearchViewController.swift
//  PhotoMOB
//

import UIKit
import TinyConstraints

class SearchViewController: UIViewController {
    
    // MARK: - Vars
    let searchController = UISearchController(searchResultsController: nil)
    let dataSource: [Photos] = []
    var isLoaded: Bool = false
    var presenter: SearchViewPresenterProtocol!
    var searchLiteral = ""
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pictures"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        setUpViews()
        showLoading()
        presenter.searchFor("dogs")
    }
    
    // MARK: - views
    var collectionView: UICollectionView = {
        let layoutGuide = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutGuide)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var loadingIndicator: UIActivityIndicatorView = {
        let loadingInd = UIActivityIndicatorView()
        loadingInd.hidesWhenStopped = true
        return loadingInd
    }()
    
    var loadingText: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error Occurred While Loading"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.numberOfLines = 2
        return label
    }()
    
    var errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.height(40)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(actionWithParam), for: .touchUpInside)
        return button
    }()
    
    func setUpViews(){
        addViews()
        constrainViews()
    }
    
    func addViews(){
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        self.view.addSubview(loadingIndicator)
        self.view.addSubview(loadingText)
        
        self.view.addSubview(errorLabel)
        self.view.addSubview(errorButton)
        errorButton.layer.borderColor = view.tintColor.cgColor
        errorButton.setTitleColor(view.tintColor, for: .normal)
    }
    
    func constrainViews(){
        collectionView.edgesToSuperview()
        
        loadingIndicator.centerInSuperview()
        loadingText.topToBottom(of: loadingIndicator, offset: 10)
        loadingText.centerXToSuperview()
        
        errorLabel.centerInSuperview()
        errorButton.topToBottom(of: errorLabel, offset: 20)
        errorButton.width(self.view.bounds.width - 40)
        errorButton.centerXToSuperview()
    }
    
    @objc func actionWithParam(sender: UIButton){
        presenter.searchFor(searchLiteral)
        showLoading()
    }
}
