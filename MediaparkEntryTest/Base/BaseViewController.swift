//
//  BaseViewController.swift
//  MediaparkEntryTest
//
//  Created by Vladyslav Prosianyk on 30.06.2022.
//

import RxSwift
import UIKit
import AuthenticationServices

protocol BaseViewControllerProtocol: AnyObject {
    func onFailure(error: Error)
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
}

public let globalErrorSubject = PublishSubject<Error>()

class BaseViewController<T: BaseViewModelProtocol>: UIViewController, BaseViewControllerProtocol, ASAuthorizationControllerPresentationContextProviding {
    
    public func onFailure(error: Error) {
        self.showToast(error.localizedDescription)
    }
    
    public var viewModel: T!
    
    public typealias ViewModelType = T
    
    public fileprivate(set) lazy var disposeBags: [String: DisposeBag] = ["default": self.defaultDisposeBag]
    
    public var defaultDisposeBag: DisposeBag! = DisposeBag()
    
    public var performOnViewDidLoad: (BaseViewController)->Void = { _ in }
    
    public var performOnViewWillAppear: (BaseViewController)->Void = { _ in }
    
    public var performOnViewDidAppear: (BaseViewController)->Void = { _ in }
    
    public var performOnViewWillDisappear: (BaseViewController)->Void = { _ in }
    
    public var performOnViewDidDissappear: (BaseViewController)->Void = { _ in }
    
    deinit {
        self.viewModel = nil
        self.disposeBags.removeAll()
        self.defaultDisposeBag = nil
        print("\(#function) -- line[\(#line)] -- \((#file as NSString).lastPathComponent)  -- \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preSetup()
        self.performPreSetup()
        self.perform(#selector(self.performSetup),
                     with: nil,
                     afterDelay: 0.1,
                     inModes: [RunLoop.Mode.default])
        
        
    }
    
    private func preSetup() {
        self.view.backgroundColor = UIColor.white
    
        globalErrorSubject.subscribe(onNext: { error in
            self.onFailure(error: error)
            self.removeLoading()
            print(error)
//            self.stopButtonLoadingIndicators()
        }).disposed(by: self.defaultDisposeBag)
        
    }

    open func performPreSetup() {
        
    }

    @objc open func performSetup() {
        self.performOnViewDidLoad(self)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.performOnViewWillAppear(self)
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performOnViewDidAppear(self)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.performOnViewWillDisappear(self)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.performOnViewDidDissappear(self)
        self.hideLoading()
//        stopButtonLoadingIndicators()
    }

    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func stopButtonLoadingIndicators() {
        self.view.subviews.forEach({ view in
            if let btn = view as? BaseButton {
                btn.loadingIndicator(false)
            }
        })
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else {
            return UIWindow(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        }
        return window
    }
    
}
