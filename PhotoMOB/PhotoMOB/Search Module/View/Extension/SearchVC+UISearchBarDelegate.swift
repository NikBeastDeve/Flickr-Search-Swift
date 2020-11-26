//
//  SearchVC+UISearchBarDelegate.swift
//  PhotoMOB
//

import UIKit

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text.isEmpty { return }
        searchLiteral = text
        showLoading()
        presenter.searchFor(searchLiteral)
    }
}

