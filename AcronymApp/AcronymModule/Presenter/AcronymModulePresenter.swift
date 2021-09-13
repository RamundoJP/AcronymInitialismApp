//
//  AcronymModulePresenter.swift
//  AcronymApp
//
//  Created by Ramundo, Juan Pablo on 12/09/2021.
//

import UIKit

class AcronymModulePresenter: AcronymModulePresenterProtocol, AcronymModuleInteractorOutputProtocol {
    weak private var view: AcronymModuleViewProtocol?
    var interactor: AcronymModuleInteractorInputProtocol?
    private let router: AcronymModuleWireframeProtocol?

    init(interface: AcronymModuleViewProtocol, interactor: AcronymModuleInteractorInputProtocol?, router: AcronymModuleWireframeProtocol?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func fetch(type: Type, query: String) {
        interactor?.fetch(type: type, query: query)
    }
    
    func fetchSucceed(_ results: [LF]) {
        view?.show(results)
    }
    
    func fetchWithError() {
        view?.showError()
    }
}
