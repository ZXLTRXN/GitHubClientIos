//
//  RepositoryDetailInfoViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit
import SafariServices

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
    
    var repo: Repo
    
    init(repo: Repo, nibName: String?, bundle: Bundle?) {
            self.repo = repo
            super.init(nibName: nibName, bundle: bundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        title = "Repo Name"
        setExitButton()
        
        link.isUserInteractionEnabled = true
        link.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.linkPressed)))

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
        
        link.text = repo.htmlUrl
        license.text = repo.license ?? NSLocalizedString("EMPTY_LICENSE", comment: "")
        stars.text = "\(repo.stars)"
        forks.text = "\(repo.forks)"
        watchers.text = "\(repo.watchers)"
    }
    
    
    @IBAction func linkPressed() {
        if let url = URL(string: link.text!) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true,
                   completion: nil)
            }
    }
}
