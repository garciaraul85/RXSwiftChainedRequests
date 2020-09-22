//
//  GithubRepository.swift
//  RXSwiftChainedRequests
//
//  Created by Saulo Garcia on 9/22/20.
//

import Foundation
import RxSwift

class GithubRepository {
    private let networkService = NetworkService()
    private let BASE_URL = "https://api.github.com"
    
    func getRepos() -> Observable<[Repo]> {
        return networkService.execute(url: URL(string: BASE_URL + "/repositories")!)
    }
    
    func getBranches(owner: String, repoName: String) -> Observable<[Branch]> {
        return networkService.execute(url: URL(string: BASE_URL + "/repos/\(owner)/\(repoName)/branches")!)
    }
    
}
