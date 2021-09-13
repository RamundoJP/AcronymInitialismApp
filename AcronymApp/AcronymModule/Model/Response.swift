//
//  Response.swift
//  AcronymApp
//
//  Created by Ramundo, Juan Pablo on 13/09/2021.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let sf: String
    let lfs: [LF]
}

// MARK: - LF
struct LF: Codable {
    let lf: String
    let freq, since: Int
}
