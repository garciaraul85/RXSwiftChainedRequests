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
        githubRepository
            .getRepos()
            .flatMap { repos -> Observable<[Branch]> in
                let randomNumber = Int.random(in: 0...50)
                let repo = repos[randomNumber]
                return self.githubRepository.getBranches(owner: repo.owner.login, repoName: repo.name)
            }
            .bind(to: tableView.rx.items(cellIdentifier: "branchCell", cellType: BranchTableViewCell.self)) {
                index, branch, cell in
                cell.branchNameLabel.text = branch.name
            }.disposed(by: disposeBag)
    }
}
