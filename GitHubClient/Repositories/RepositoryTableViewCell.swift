//
//  RepositoryTableViewCell.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(repo: Repo) {
        nameLabel.text = repo.name
        languageLabel.text = repo.language
        descriptionLabel.text = repo.description
        if let hex = repo.languageColor, let color = UIColor(hex: hex) {
            languageLabel.textColor = color
        }
    }
    
}
