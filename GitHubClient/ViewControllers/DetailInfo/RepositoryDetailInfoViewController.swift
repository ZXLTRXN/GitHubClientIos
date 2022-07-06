//
//  RepositoryDetailInfoViewController.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit
import SafariServices
import MaterialComponents.MaterialActivityIndicator
import SwiftyMarkdown


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
    @IBOutlet private weak var readmeErrorView: ErrorView!
    
    @IBOutlet private weak var activityIndicator: MDCActivityIndicator!
    @IBOutlet private weak var readmeActivityIndicator: MDCActivityIndicator!
    
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
        getRepoInfo()
        getReadme()
    }
    
    private func getRepoInfo() {
        loadingStart(content: content, errorView: errorView, indicator: activityIndicator)
        appRepo.getRepository(owner: repo.owner, repoName: repo.name) { [weak self] repo, error in
            self?.activityIndicator.hide()
            if let error = error {
                self?.content.isHidden = true
                self?.showErrorView(self?.errorView, error: error) { self?.getRepoInfo() }
                return
            }
            self?.hideErrorView(self?.errorView)
            if let repo = repo {
                self?.repo = repo
                self?.updateRepoUI()
            }
            self?.content.isHidden = false
        }
    }
    
    private func getReadme() {
        loadingStart(content: readme, errorView: readmeErrorView, indicator: readmeActivityIndicator)
        appRepo.getRepositoryReadme(owner: repo.owner, repoName: repo.name, branch: repo.branch){ [weak self] (readme, error) in
            self?.readmeActivityIndicator.hide()
            if let error = error {
                if case .readmeNotFound = error {
                    self?.readme.text = error.errorDescription
                    self?.readme.isHidden = false
                    return
                }
                self?.showErrorView(self?.readmeErrorView, error: error) { self?.getReadme() }
                return
            }
            self?.hideErrorView(self?.readmeErrorView)
            self?.readme.isHidden = false
            guard let readme = readme else {
                self?.readme.text = NSLocalizedString("repoDetails.readmeLabel.emptyReadme.title", comment: "")
                return
            }
            let md = SwiftyMarkdown(string: readme)
            self?.readme.attributedText = md.attributedString()
        }
    }
    
    private func updateRepoUI(){
        title = repo.name
        link.text = repo.htmlUrl
        license.text = repo.license ?? NSLocalizedString("repoDetails.licenseLabelWithValue.noLicense.title", comment: "")
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
        
        readmeActivityIndicator.setColor()
        readmeActivityIndicator.radius = 12
        
        licenseLabel.text = NSLocalizedString("repoDetails.licenseLabel.title", comment: "")
        starsLabel.text = NSLocalizedString("repoDetails.starsLabel.title", comment: "")
        forksLabel.text = NSLocalizedString("repoDetails.forksLabel.title", comment: "")
        watchersLabel.text = NSLocalizedString("repoDetails.watchersLabel.title", comment: "")
    }
    
    private func loadingStart(content: UIView, errorView: ErrorView, indicator: MDCActivityIndicator) {
        content.isHidden = true
        hideErrorView(errorView)
        indicator.show()
    }
    
    @IBAction private func linkPressed() {
        if let url = URL(string: link.text!) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true,
                    completion: nil)
        }
    }
}
