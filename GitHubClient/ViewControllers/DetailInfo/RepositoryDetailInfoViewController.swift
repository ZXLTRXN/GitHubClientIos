//
//  RepositoryDetailInfoViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit
import SafariServices
import MaterialComponents.MaterialActivityIndicator


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
    @IBOutlet private weak var readme: UILabel!
    @IBOutlet private weak var content: UIStackView!
    
    @IBOutlet private weak var errorView: ErrorView!
    @IBOutlet private weak var activityIndicator: MDCActivityIndicator!
    
    private var repo: Repo
    private let appRepo = AppRepository.shared
    
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
        getInfo()
        getReadme()
    }
    
    private func getInfo() {
        onLoading(started: true)
        appRepo.getRepository(owner: repo.owner, repoName: repo.name) { [weak self] repo, error in
            if let repo = repo {
                self?.repo = repo
                self?.updateRepoUI()
            }
            if let error = error as? RequestError {
                self?.showErrorView(self?.errorView, error: error) {
                    self?.getInfo()
                }
            } else {
                self?.hideErrorView(self?.errorView)
            }
            self?.onLoading(started: false)
        }
    }
    
    private func getReadme() {
        appRepo.getRepositoryReadme(owner: repo.owner, repoName: repo.name, branch: repo.branch){ [weak self] (readme, error) in
            self?.readme.text = readme ?? NSLocalizedString("EMPTY_README", comment: "")
            
            
//            if let error = error {
//                self?.showErrorView(self?.errorView, error: error as! RequestError) {
//                    self?.getInfo()
//                }
//            } else {
//                self?.hideErrorView(self?.errorView)
//            }
        }
    }
    
    private func updateRepoUI(){
        title = repo.name
        link.text = repo.htmlUrl
        license.text = repo.license ?? NSLocalizedString("EMPTY_LICENSE", comment: "")
        stars.text = "\(repo.stars)"
        forks.text = "\(repo.forks)"
        watchers.text = "\(repo.watchers)"
    }
    
    private func setUI(){
        setExitButton()
        
        link.isUserInteractionEnabled = true
        link.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.linkPressed)))
        
        activityIndicator.setColor()
        activityIndicator.radius = 28
        
        licenseLabel.text = NSLocalizedString("LICENSE_LABEL", comment: "")
        starsLabel.text = NSLocalizedString("STARS_LABEL", comment: "")
        forksLabel.text = NSLocalizedString("FORKS_LABEL", comment: "")
        watchersLabel.text = NSLocalizedString("WATCHERS_LABEL", comment: "")
    }
    
    private func onLoading(started flag: Bool) {
        content.isHidden = flag
        if flag {
            activityIndicator.show()
            errorView.isHidden = true
        } else {
            activityIndicator.hide()
        }
    }
    
    @IBAction private func linkPressed() {
        if let url = URL(string: link.text!) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true,
                    completion: nil)
        }
    }
}
