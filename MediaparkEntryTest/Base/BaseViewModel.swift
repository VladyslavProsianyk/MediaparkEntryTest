//
//  BaseViewModel.swift
//  MediaparkEntryTest
//
//  Created by Vladyslav Prosianyk on 30.06.2022.
//

import Foundation

protocol BaseViewModelProtocol: AnyObject {
    
    associatedtype ModelType
    
    var model: ModelType! { get set }
    
    var router: RouterProtocol? { get set }
    
}

public protocol Initializable {
    init()
}

open class BaseViewModel<Model: Initializable>: BaseViewModelProtocol {
    
    public typealias ModelType = Model
    
    public var model: ModelType! = Model()
    
    var router: RouterProtocol?
}
