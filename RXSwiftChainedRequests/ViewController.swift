//
//  ViewController.swift
//  RXSwiftChainedRequests
//
//  Created by Saulo Garcia on 9/22/20.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let githubRepository = GithubRepository()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chainNetworkCalls()
    }
    
    func chainNetworkCalls() {
        let reposObservable = githubRepository.getRepos().share()
        
        // Share same observable to avoid repeating network calls
        
        let randomNumber = Int.random(in: 0...50)
        reposObservable.map { repos -> String in
            let repo = repos[randomNumber]
            return "\(repo.owner.login) - \(repo.name)"
        }
        .bind(to: navigationItem.rx.title)
        .disposed(by: disposeBag)
        
        reposObservable
            .flatMap { repos -> Observable<[Branch]> in
                let repo = repos[randomNumber]
                return self.githubRepository.getBranches(owner: repo.owner.login, repoName: repo.name)
            }
            .bind(to: tableView.rx.items(cellIdentifier: "branchCell", cellType: BranchTableViewCell.self)) {
                index, branch, cell in
                cell.branchNameLabel.text = branch.name
            }.disposed(by: disposeBag)
    }
}
