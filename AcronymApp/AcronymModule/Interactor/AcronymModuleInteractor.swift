//
//  AcronymModuleInteractor.swift
//  AcronymApp
//
//  Created by Ramundo, Juan Pablo on 12/09/2021.
//

import Foundation
import Alamofire

class AcronymModuleInteractor: AcronymModuleInteractorInputProtocol {
    
   weak var presenter: AcronymModuleInteractorOutputProtocol?
    
    func fetch(type: Type, query: String) {
        let uri = getUrl(type: type, query: query)
        
        guard let url = URL(string: uri) else {
            return
        }
    
        debugPrint("DEBUG: making fetch with uri \(uri)")
        AF.request(url).responseData(completionHandler: { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([Response].self, from: data)
                    guard let lfs = result.first?.lfs else {
                        self?.presenter?.fetchWithError()
                        return
                    }
                    debugPrint("DEBUG: response returned \(lfs)")
                    self?.presenter?.fetchSucceed(lfs)
                }
                catch {
                    self?.presenter?.fetchWithError()
                    print("DEBUG: there was an error trying to decode response")
               }
            case .failure(let error):
                self?.presenter?.fetchWithError()
                print("DEBUG: there was an error trying to fetch with description \(error.localizedDescription)")
            }
        })
    }
    
    private func getUrl(type: Type, query: String) -> String {
        var uri = BASE_URL
        let queryWithoutSpaces = query.replacingOccurrences(of: " ", with: "%20")
        
        switch type {
        case .ACRONYM:
            uri += acronymQuery
        default:
            uri += initialismQuery
        }
        
        uri += queryWithoutSpaces
        
        return uri
    }
}
