//
//  Models.swift
//  RXSwiftChainedRequests
//
//  Created by Saulo Garcia on 9/22/20.
//

import Foundation

struct Repo: Decodable {
    let name: String
    let owner: Owner
}

struct Owner: Decodable {
    let login: String
}

struct Branch: Decodable {
    let name: String
}
