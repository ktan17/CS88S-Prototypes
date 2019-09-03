//
//  ICHomeTableViewCell.swift
//  Prototype
//
//  Created by Kevin Tan on 5/11/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

protocol ICHomeTableViewCellDelegate: class {
    func didTapFavorite(id: Int, isOn: Bool)
}

class ICHomeTableViewCell: UITableViewCell {
    static let height: CGFloat = 100
    let offColor = UIColor(white: 0.847, alpha: 1.0)
    let onColor = UIColor(red: 0.78, green: 0.38, blue: 0.31, alpha: 1)
    
    let iconImageView = UIImageView()
    let comboLabel = UILabel()
    let favoriteButton = UIButton()
    
    var id = 0
    weak var delegate: ICHomeTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        favoriteButton.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate),
                                for: .normal)
        favoriteButton.tintColor = offColor
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
        addSubview(iconImageView)
        addSubview(comboLabel)
        addSubview(favoriteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let verticalPadding: CGFloat = 15
        let horizontalPadding: CGFloat = 30
        
        let iconSize = bounds.height - verticalPadding * 2
        var iconImageViewFrame = CGRect.zero
        iconImageViewFrame.origin.x = horizontalPadding
        iconImageViewFrame.origin.y = verticalPadding
        iconImageViewFrame.size.width = iconSize
        iconImageViewFrame.size.height = iconSize
        
        var comboLabelFrame = CGRect.zero
        comboLabelFrame.size = comboLabel.intrinsicContentSize
        comboLabelFrame.origin.x = (bounds.width - comboLabelFrame.width) / 2
        comboLabelFrame.origin.y = (bounds.height - comboLabelFrame.height) / 2
        
        let buttonSide: CGFloat = 25
        var favoriteButtonFrame = CGRect.zero
        favoriteButtonFrame.size = CGSize(width: buttonSide, height: buttonSide)
        favoriteButtonFrame.origin.x = bounds.width - horizontalPadding - favoriteButtonFrame.width
        favoriteButtonFrame.origin.y = (bounds.height - favoriteButtonFrame.height) / 2
        
        iconImageView.frame = iconImageViewFrame
        comboLabel.frame = comboLabelFrame
        favoriteButton.frame = favoriteButtonFrame
        
        iconImageView.layer.cornerRadius = iconImageViewFrame.width / 2
    }
    
    func configure(with id: Int, image: UIImage?, comboName: String, isFavorited: Bool) {
        self.id = id
        iconImageView.image = image
        comboLabel.text = comboName
        favoriteButton.isSelected = isFavorited
        favoriteButton.tintColor = isFavorited ? onColor : offColor
        
        setNeedsLayout()
    }
    
    @objc func didTapFavorite(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        UIView.transition(with: sender, duration: 0.1, options: .curveEaseOut, animations: {
            sender.tintColor = sender.isSelected ? self.onColor : self.offColor
        }, completion: nil)
        
        delegate?.didTapFavorite(id: id, isOn: sender.isSelected)
    }
}
