//
//  AcronymModuleRouter.swift
//  AcronymApp
//
//  Created by Ramundo, Juan Pablo on 12/09/2021.
//

import UIKit

class AcronymModuleRouter: AcronymModuleWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = AcronymModuleViewController(nibName: nil, bundle: nil)
        let interactor = AcronymModuleInteractor()
        let router = AcronymModuleRouter()
        let presenter = AcronymModulePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
