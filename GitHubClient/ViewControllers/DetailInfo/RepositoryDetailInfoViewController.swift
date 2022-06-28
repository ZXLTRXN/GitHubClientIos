//
//  RepositoryDetailInfoViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit

class RepositoryDetailInfoViewController: UIViewController {
    @IBOutlet private weak var link: UILabel!
    @IBOutlet private weak var license: UILabel!
    @IBOutlet private weak var watchers: UILabel!
    @IBOutlet private weak var forks: UILabel!
    @IBOutlet private weak var stars: UILabel!
    
    @IBOutlet private weak var licenseLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var errorView: ErrorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        title = "Repo Name"

//        showErrorView(errorView, error: RequestError.noRepositories){
//            print("tapped")
//        }
//        hideErrorView(errorView)
    }
    
    
    private func setUI(){
        licenseLabel.text = NSLocalizedString("LICENSE_LABEL", comment: "")
        starsLabel.text = NSLocalizedString("STARS_LABEL", comment: "")
        forksLabel.text = NSLocalizedString("FORKS_LABEL", comment: "")
        watchersLabel.text = NSLocalizedString("WATCHERS_LABEL", comment: "")
    }
}
