//
//  RepositoriesListViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit

class RepositoriesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    
    let repos = [Repo(id: 1,owner:"aa",name:"repo",htmlUrl:"aaa"), Repo(id: 1,owner:"aa",name:"repo2",htmlUrl:"aaa")]
    let cellIdentifier = "RepositoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        title = NSLocalizedString("REPOSITORIES_TITLE", comment: "")
    }
    
    // MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepositoryTableViewCell
        cell.setData(repo: repos[indexPath.row])
        return cell
    }
    //
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(repos[indexPath.row].name)
    }
    
}
