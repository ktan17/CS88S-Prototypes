//
//  SBProfileViewController.swift
//  Prototype
//
//  Created by Kevin Tan on 5/12/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

class SBProfileViewController: UIViewController {
    let profileImageView = UIImageView()
    let inboxButton = UIButton(type: .system)
    let nameLabel = UILabel()
    let yearLayer = CAShapeLayer()
    let majorLayer = CAShapeLayer()
    let yearLabel = UILabel()
    let majorLabel = UILabel()
    let fromTimeLabel = UILabel()
    let toTimeLabel = UILabel()
    let lineView = UIView()
    let bioLabel = UILabel()
    let bioTextView = UITextView()
    let gradientView = GradientView()
    let cardView = UIView()
    
    let includeBioLabel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        //gradientView.colors = (.blue, .yellow)
        
        profileImageView.image = UIImage(named: "shawn")
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        inboxButton.setImage(UIImage(named: "envelope"), for: .normal)
        
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        nameLabel.text = "Shawn"
        
        yearLayer.fillColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        majorLayer.fillColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        
        yearLabel.text = "1"
        yearLabel.textAlignment = .center
        majorLabel.text = "💰"
        majorLabel.textAlignment = .center
        
        fromTimeLabel.text = "9:30 AM"
        toTimeLabel.text = "10:30 AM"
        lineView.backgroundColor = .black
        
        bioLabel.text = "Bio"
        
        bioTextView.text = "I put the \"stud\" in \"study\" 😏😏\n\nJust kidding, I'm failing math 31B... can anyone help me out? 💎"
        bioTextView.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        bioTextView.isEditable = false
        
        //bioTextView.layer.borderWidth = 2
        //bioTextView.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        //bioTextView.layer.cornerRadius = 15
        cardView.backgroundColor = .white
        
        view.addSubview(cardView)
        view.addSubview(profileImageView)
        view.addSubview(inboxButton)
        view.addSubview(nameLabel)
        view.layer.addSublayer(yearLayer)
        view.layer.addSublayer(majorLayer)
        view.addSubview(yearLabel)
        view.addSubview(majorLabel)
        view.addSubview(fromTimeLabel)
        view.addSubview(toTimeLabel)
        view.addSubview(lineView)
        view.addSubview(bioLabel)
        view.addSubview(bioTextView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let inset: CGFloat = 20
        let interitemSpacing: CGFloat = 25
        
        let inboxButtonSide: CGFloat = 50
        var inboxButtonFrame = CGRect.zero
        inboxButtonFrame.size = CGSize(width: inboxButtonSide,
                                       height: inboxButtonSide)
        inboxButtonFrame.origin.x = view.bounds.width - inboxButtonSide - inset
        inboxButtonFrame.origin.y = inset
        
        let profileSide = view.bounds.width / 2
        var profileImageViewFrame = CGRect.zero
        profileImageViewFrame.size = CGSize(width: profileSide,
                                            height: profileSide)
        profileImageViewFrame.origin.x = (view.bounds.width - profileSide) / 2
        profileImageViewFrame.origin.y = inboxButtonFrame.maxY + interitemSpacing
        profileImageView.layer.cornerRadius = profileSide / 2
        
        var nameLabelFrame = CGRect.zero
        nameLabelFrame.size = nameLabel.intrinsicContentSize
        nameLabelFrame.origin.x = (view.bounds.width - nameLabelFrame.width) / 2
        nameLabelFrame.origin.y = profileImageViewFrame.maxY + interitemSpacing
        
        let layerSide = nameLabelFrame.height
        var yearLayerFrame = CGRect.zero
        yearLayerFrame.size = CGSize(width: layerSide, height: layerSide)
        yearLayerFrame.origin.x = nameLabelFrame.minX - layerSide - interitemSpacing
        yearLayerFrame.origin.y = nameLabelFrame.midY - layerSide / 2
        
        var majorLayerFrame = CGRect.zero
        majorLayerFrame.size = CGSize(width: layerSide, height: layerSide)
        majorLayerFrame.origin.x = nameLabelFrame.maxX + interitemSpacing
        majorLayerFrame.origin.y = nameLabelFrame.midY - layerSide / 2
        
        inboxButton.frame = inboxButtonFrame
        profileImageView.frame = profileImageViewFrame
        nameLabel.frame = nameLabelFrame
        yearLayer.path = UIBezierPath(ovalIn: yearLayerFrame).cgPath
        majorLayer.path = UIBezierPath(ovalIn: majorLayerFrame).cgPath
        yearLabel.frame = yearLayerFrame
        majorLabel.frame = majorLayerFrame
        updateTimeLabelLayout(interitemSpacing: interitemSpacing)
        
        let bioTextViewWidth = view.bounds.width * 0.75
        var bioLabelFrame = CGRect.zero
        bioLabelFrame.origin.x = (view.bounds.width - bioTextViewWidth) / 2
        bioLabelFrame.origin.y = fromTimeLabel.frame.maxY + interitemSpacing
        if includeBioLabel {
            bioLabelFrame.size = bioLabel.intrinsicContentSize
        }
        
        var bioTextViewFrame = CGRect.zero
        bioTextViewFrame.origin.x = (view.bounds.width - bioTextViewWidth) / 2
        bioTextViewFrame.origin.y = bioLabelFrame.maxY
        bioTextViewFrame.size.width = bioTextViewWidth
        bioTextViewFrame.size.height = view.bounds.height - (tabBarController?.tabBar.bounds.height ?? 0) - bioTextViewFrame.origin.y - interitemSpacing
        
        bioLabel.frame = bioLabelFrame
        bioTextView.frame = bioTextViewFrame
        
        var cardViewFrame = CGRect.zero
        cardViewFrame.origin.y = profileImageViewFrame.minY - 20
        cardViewFrame.size.width = view.bounds.width
        cardViewFrame.size.height = bioTextViewFrame.maxY + 50
        
        cardView.layer.cornerRadius = 15
        cardView.frame = cardViewFrame
    }
    
    private func updateTimeLabelLayout(interitemSpacing: CGFloat = 25) {
        let lineViewWidth: CGFloat = 20
        let lineViewHeight: CGFloat = 2
        let padding: CGFloat = 10
        
        var fromTimeLabelFrame = CGRect.zero
        var toTimeLabelFrame = CGRect.zero
        var lineViewFrame = CGRect.zero
        
        fromTimeLabelFrame.size = fromTimeLabel.intrinsicContentSize
        toTimeLabelFrame.size = toTimeLabel.intrinsicContentSize
        lineViewFrame.size = CGSize(width: lineViewWidth, height: lineViewHeight)
        
        fromTimeLabelFrame.origin.y = nameLabel.frame.maxY + interitemSpacing / 2
        toTimeLabelFrame.origin.y = nameLabel.frame.maxY + interitemSpacing / 2
        lineViewFrame.origin.y = fromTimeLabelFrame.midY - lineViewHeight / 2
        
        lineViewFrame.origin.x = (view.bounds.width - lineViewWidth) / 2
        fromTimeLabelFrame.origin.x = lineViewFrame.minX - fromTimeLabelFrame.width - padding
        toTimeLabelFrame.origin.x = lineViewFrame.maxX + padding
        
        fromTimeLabel.frame = fromTimeLabelFrame
        toTimeLabel.frame = toTimeLabelFrame
        lineView.frame = lineViewFrame
    }
}
