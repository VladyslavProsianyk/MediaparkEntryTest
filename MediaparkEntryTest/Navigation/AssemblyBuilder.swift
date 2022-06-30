//
//  AssemblyBuilder.swift
//  MediaparkEntryTest
//
//  Created by Vladyslav Prosianyk on 30.06.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    
    func createHome(router: RouterProtocol, text: String) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createHome(router: RouterProtocol, text: String) -> UIViewController {
        let view = HomeView()
        return view
    }
}
