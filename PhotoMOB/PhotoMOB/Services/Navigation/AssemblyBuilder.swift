//
//  AssemblyBuilder.swift
//  PhotoMOB
//

import Foundation
import UIKit

protocol AsselderBuilderProtocol{
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(photo: Photo?, router: RouterProtocol) -> UIViewController
}

final class AsselderModelBuilder: AsselderBuilderProtocol {
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let networkServ = NetworkService()
        let presenter = SearchPresenter(view: view, networkService: networkServ, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(photo: Photo?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkServ = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkServ, router: router, photo: photo)
        view.presenter = presenter
        return view
    }
}
