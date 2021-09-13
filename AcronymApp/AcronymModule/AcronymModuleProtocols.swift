//
//  AcronymModuleProtocols.swift
//  AcronymApp
//
//  Created Ramundo, Juan Pablo on 12/09/2021.
//

import Foundation

//MARK: Wireframe -
protocol AcronymModuleWireframeProtocol: AnyObject {

}
//MARK: Presenter -
protocol AcronymModulePresenterProtocol: AnyObject {

    var interactor: AcronymModuleInteractorInputProtocol? { get set }
    func fetch(type: Type, query: String)
}

//MARK: Interactor -
protocol AcronymModuleInteractorOutputProtocol: AnyObject {

    func fetchSucceed(_ results: [LF])
    func fetchWithError()
}

protocol AcronymModuleInteractorInputProtocol: AnyObject {

    var presenter: AcronymModuleInteractorOutputProtocol?  { get set }
    func fetch(type: Type, query: String)
}

//MARK: View -
protocol AcronymModuleViewProtocol: AnyObject {

    var presenter: AcronymModulePresenterProtocol?  { get set }
    func show(_ results: [LF])
    func showError()
    func showLoader(isActive: Bool)
}
