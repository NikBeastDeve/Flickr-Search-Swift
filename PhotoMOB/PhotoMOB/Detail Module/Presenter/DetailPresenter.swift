//
//  DetailPresenter.swift
//  PhotoMOB
//

import Foundation

protocol DetailViewProtocol: class {
    func setPhoto(photo: Photo?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol ,router: RouterProtocol ,photo: Photo?)
    func setPhoto()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var photo: Photo?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, photo: Photo?) {
        self.view = view
        self.networkService = networkService
        self.photo = photo
        self.router = router
    }
    
    func setPhoto() {
        self.view?.setPhoto(photo: photo)
    }
}
