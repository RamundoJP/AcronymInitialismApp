//
//  AcronymModulePresenterTests.swift
//  AcronymAppTests
//
//  Created by Ramundo, Juan Pablo on 13/09/2021.
//

import XCTest
@testable import AcronymApp

class AcronymModulePresenterTests: XCTestCase {
    
    var presenter: AcronymModulePresenter!
    var view = ViewControllerMock()
    var interactor = AcronymModuleInteractorMock()
    
    override func setUp() {
        presenter = AcronymModulePresenter(interface: view, interactor: interactor, router: nil)
        interactor.presenter = presenter
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testFetchSuccess() throws {
        presenter.fetch(type: .ACRONYM, query: "www")
        
        XCTAssert(view.results.count == 1)
    }
    
    func testFetchError() throws {
        presenter.fetchWithError()
        
        XCTAssert(view.results.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class AcronymModuleInteractorMock: AcronymModuleInteractorInputProtocol {
    var presenter: AcronymModuleInteractorOutputProtocol?
    
    func fetch(type: Type, query: String) {
        let result = [LF(lf: "World Wide Web", freq: 304, since: 1994)]
        presenter?.fetchSucceed(result)
    }
}

class ViewControllerMock: UIViewController, AcronymModuleViewProtocol {
    var presenter: AcronymModulePresenterProtocol?
    
    var results: [LF] = []
    
    func show(_ results: [LF]) {
        self.results = results
    }
    
    func showError() {
        self.results = []
    }
    
    func showLoader(isActive: Bool) {
    }
}
