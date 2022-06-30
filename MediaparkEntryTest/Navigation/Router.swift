//
//  Router.swift
//  MediaparkEntryTest
//
//  Created by Vladyslav Prosianyk on 30.06.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func popViewController()
    func dismissVC()
    
    func initial()
    
}

class Router: RouterProtocol {
    
    
     var navigationController: UINavigationController?
     var assemblyBuilder: AssemblyBuilderProtocol?
        
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
        self.setupNavBar()
    }
    
    private func setupNavBar() {
        let nb = navigationController?.navigationBar
        nb?.setBackgroundImage(UIImage(), for: .default)
        nb?.shadowImage = UIImage()
        nb?.isHidden = false
        nb?.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    func popViewController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func dismissVC() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }

    func initial() {
        if let navigationController = navigationController {
            guard let welcome = assemblyBuilder?.createWelcomePage(router: self) else { return }
            navigationController.viewControllers = [welcome]
        }
    }
}
