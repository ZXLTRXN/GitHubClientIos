//
//  ErrorView.swift
//  GitHubClient
//
//  Created by Ilya Shevtsov on 23.06.2022.
//

import UIKit

class ErrorView: UIView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var suggestionLabel: UILabel!
    @IBOutlet private weak var reloadButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    func setUI(image: UIImage, description: String, suggestion: String, color: UIColor, buttonTitle: String, onButtonTap: @escaping() -> ()) {
        imageView.image = image
        descriptionLabel.text = description
        descriptionLabel.textColor = color
        suggestionLabel.text = suggestion
        
        reloadButton.layer.cornerRadius = 8
        reloadButton.clipsToBounds = true
        reloadButton.setTitle(buttonTitle, for: .normal)
        
        reloadButton.addAction(onButtonTap)
    }
}
