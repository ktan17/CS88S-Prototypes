//
//  CarouselCollectionViewCell.swift
//  Prototype
//
//  Created by Kevin Tan on 5/13/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    private let hiddenLength: CGFloat = 5
    private let borderColor = UIColor.black
    
    let backgroundImageView = UIImageView()
    let infoView = UIView()
    let priceLabel = UILabel()
    let timeLabel = UILabel()
    let lineView = UIView()
    let popularLabel = UILabel()
    let gradientView = GradientView()
    
    private let showGradients = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 5
        
        backgroundImageView.contentMode = .scaleAspectFill
        
        infoView.backgroundColor = .white
        infoView.layer.borderColor = borderColor.cgColor
        infoView.layer.borderWidth = 2
        
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        timeLabel.numberOfLines = 2
        timeLabel.textAlignment = .center
        
        lineView.backgroundColor = borderColor
        
        popularLabel.text = "🔥"
        popularLabel.textAlignment = .center
        
        if showGradients {
            gradientView.isHidden = false
            infoView.layer.borderWidth = 0
            infoView.backgroundColor = .clear
            lineView.isHidden = true
            
            priceLabel.textColor = .white
            timeLabel.textColor = .white
        }
        
        gradientView.colors = (.black, .clear)
        
        addSubview(backgroundImageView)
        addSubview(gradientView)
        addSubview(infoView)
        infoView.addSubview(priceLabel)
        infoView.addSubview(timeLabel)
        infoView.addSubview(lineView)
        addSubview(popularLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let backgroundImageViewFrame = bounds
        
        let infoPadding: CGFloat = 4

        var infoViewFrame = CGRect.zero
        infoViewFrame.size.width = bounds.width * 0.8 - hiddenLength
        
        timeLabel.preferredMaxLayoutWidth = ((infoViewFrame.width - hiddenLength) - 2) / 2
        let infoViewHeight = max(priceLabel.intrinsicContentSize.height,
                                 timeLabel.intrinsicContentSize.height) + infoPadding * 2 + hiddenLength
        
        infoViewFrame.origin.x = -hiddenLength
        infoViewFrame.origin.y = bounds.height - infoViewHeight + hiddenLength
        
        infoViewFrame.size.height = infoViewHeight
        
        var gradientViewFrame = CGRect.zero
        gradientViewFrame.origin.y = infoViewFrame.minY - 10
        gradientViewFrame.size.width = bounds.width
        gradientViewFrame.size.height = infoViewHeight - hiddenLength + 10
        
        var priceLabelFrame = CGRect.zero
        priceLabelFrame.size = priceLabel.intrinsicContentSize
        priceLabelFrame.origin.x = ((infoViewFrame.width - hiddenLength) / 2 - priceLabelFrame.width) / 2 + hiddenLength
        priceLabelFrame.origin.y = (infoViewHeight - hiddenLength - priceLabelFrame.height) / 2
        
        var timeLabelFrame = CGRect.zero
        timeLabel.preferredMaxLayoutWidth = ((infoViewFrame.width - hiddenLength) - 2) / 2
        timeLabelFrame.size = timeLabel.intrinsicContentSize
        timeLabelFrame.origin.x = ((infoViewFrame.width - hiddenLength) * 1.5 - timeLabelFrame.width) / 2 + hiddenLength
        timeLabelFrame.origin.y = (infoViewHeight - hiddenLength - timeLabelFrame.height) / 2
        
        let lineWidth: CGFloat = 2
        var lineViewFrame = CGRect.zero
        lineViewFrame.origin.x = (infoViewFrame.width - hiddenLength - lineWidth) / 2 + hiddenLength
        lineViewFrame.size.width = lineWidth
        lineViewFrame.size.height = infoViewHeight
        
        var popularLabelFrame = CGRect.zero
        popularLabelFrame.origin.x = infoViewFrame.maxX
        popularLabelFrame.origin.y = infoViewFrame.minY
        popularLabelFrame.size.width = bounds.width - infoViewFrame.width
        popularLabelFrame.size.height = infoViewHeight - hiddenLength
        
        backgroundImageView.frame = backgroundImageViewFrame
        gradientView.frame = gradientViewFrame
        infoView.frame = infoViewFrame
        priceLabel.frame = priceLabelFrame
        timeLabel.frame = timeLabelFrame
        lineView.frame = lineViewFrame
        popularLabel.frame = popularLabelFrame
    }
    
    func configure(with image: UIImage?, price: PriceLevel, minutes: Int, isPopular: Bool) {
        backgroundImageView.image = image
        priceLabel.text = price.rawValue
        timeLabel.text = "\(minutes) mins"
        popularLabel.isHidden = !isPopular
        
        setNeedsLayout()
    }
}
