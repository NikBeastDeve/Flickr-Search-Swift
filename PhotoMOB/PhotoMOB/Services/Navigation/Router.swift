//
//  Router.swift
//  PhotoMOB
//

import UIKit

protocol RouterMain: class {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselderBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func intialViewController()
    func showDetail(image: Photo?)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AsselderBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AsselderBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func intialViewController() {
        if let navigationController = navigationController{
            guard let searchVC = assemblyBuilder?.createSearchModule(router: self) else { return }
            navigationController.viewControllers = [searchVC]
        }
    }
    
    func showDetail(image: Photo?) {
        if let navigationController = navigationController{
            guard let detailVC = assemblyBuilder?.createDetailModule(photo: image, router: self) else { return }
            navigationController.present(detailVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController{
            navigationController.popToRootViewController(animated: true)
        }
    }
}
