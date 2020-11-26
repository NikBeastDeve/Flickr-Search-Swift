//
//  SearchVC+SearchViewProtocol.swift
//  PhotoMOB
//

import UIKit

extension SearchViewController: SearchViewProtocol {
    func succes() {
        collectionView.reloadData()
        showResults()
    }
    
    func failure(error: Error) {
        showError()
    }
    
    func showLoading(){
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        loadingText.isHidden = false
        
        hideError()
        hideResults()
    }
    
    func hideLoading(){
        loadingIndicator.isHidden = true
        loadingText.isHidden = true
    }
    
    func showError(){
        errorLabel.isHidden = false
        errorButton.isHidden = false
        
        hideResults()
        hideLoading()
    }
    
    func hideError(){
        errorLabel.isHidden = true
        errorButton.isHidden = true
    }
    
    func showResults(){
        collectionView.isHidden = false
        
        hideLoading()
        hideError()
    }
    
    func hideResults(){
        collectionView.isHidden = true
    }
}
