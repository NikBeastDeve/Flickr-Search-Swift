//
//  SearchPresenter.swift
//  PhotoMOB
//

import Foundation

protocol SearchViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol SearchViewPresenterProtocol {
    init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func searchFor(_ literal: String)
    func getNextPage()
    var photoResponce: [Photo]? { get set }
    func tapOnPhoto(photo: Photo?)
}

class SearchPresenter: SearchViewPresenterProtocol{
    var photoResponce: [Photo]?
    weak var view: SearchViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol){
        self.networkService = networkService
        self.view = view
        self.router = router
    }
    
    func tapOnPhoto(photo: Photo?) {
        router?.showDetail(image: photo)
    }
    
    func searchFor(_ literal: String) {
        networkService.searchFor(literal){ [weak self] result in
            guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result{
                    case .success(let photosResponce):
                        self.photoResponce = photosResponce?.photos.photo
                        self.view?.succes()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
    
    func getNextPage(){
        networkService.getNextPage(){ [weak self] result in
            guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result{
                    case .success(let photosResponce):
                        //print("loaded items: \n)")
                        //print(photosResponce)
                        self.photoResponce = self.photoResponce! + photosResponce!.photos.photo
                        //print("new items: \n \(String(describing: self.photoResponce))")
                        self.view?.succes()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
    
}
