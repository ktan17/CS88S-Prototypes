//
//  VGHomeTableViewCell.swift
//  Prototype
//
//  Created by Kevin Tan on 5/12/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

protocol VGHomeTableViewCellDelegate: class {
    func didTapLike(id: Int, isOn: Bool)
}

enum VGCellContent {
    case image(UIImage?)
    case post(String)
}

class VGHomeTableViewCell: UITableViewCell {
    static let height: CGFloat = 240
    let offColor = UIColor(white: 0.847, alpha: 1.0)
    
    let onColor = UIColor(red: 0.78, green: 0.38, blue: 0.31, alpha: 1)
    
    let postContentView = UIView()
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let postImageView = UIImageView()
    let postLabel = UILabel()
    let likeButton = UIButton()
    let commentButton = UIButton(type: .system)
    
    var id = 0
    var content = VGCellContent.post("")
    weak var delegate: VGHomeTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        postContentView.backgroundColor = UIColor(red: 232/255, green: 96/255, blue: 62/255, alpha: 1.0)
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        postLabel.textAlignment = .center
        postLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        postLabel.backgroundColor = UIColor(red: 237/255, green: 199/255, blue: 85/255, alpha: 1.0)
        postLabel.numberOfLines = 0
        
        likeButton.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate),
                            for: .normal)
        likeButton.tintColor = offColor
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        
        commentButton.setTitle("Comment", for: .normal)
        
        addSubview(postContentView)
        postContentView.addSubview(profileImageView)
        postContentView.addSubview(usernameLabel)
        postContentView.addSubview(postImageView)
        postContentView.addSubview(postLabel)
        postContentView.addSubview(likeButton)
        postContentView.addSubview(commentButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentInset: CGFloat = 20
        let postHorizontalPadding: CGFloat = 15
        let postVerticalPadding: CGFloat = 5
        
        let radius: CGFloat = 30
        let postContentViewFrame = bounds.insetBy(dx: contentInset, dy: contentInset)
        postContentView.layer.cornerRadius = radius
        postContentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        let profileImageSide: CGFloat = 30
        var profileImageViewFrame = CGRect.zero
        profileImageViewFrame.origin.x = postHorizontalPadding
        profileImageViewFrame.origin.y = postVerticalPadding
        profileImageViewFrame.size = CGSize(width: profileImageSide, height: profileImageSide)
        profileImageView.layer.cornerRadius = profileImageSide / 2
        
        var usernameLabelFrame = CGRect.zero
        usernameLabelFrame.size = usernameLabel.intrinsicContentSize
        usernameLabelFrame.origin.x = profileImageViewFrame.maxX + postHorizontalPadding
        usernameLabelFrame.origin.y = profileImageViewFrame.midY - usernameLabelFrame.height / 2
        
        let likeButtonSide: CGFloat = 30
        var likeButtonFrame = CGRect.zero
        likeButtonFrame.size = CGSize(width: likeButtonSide, height: likeButtonSide)
        likeButtonFrame.origin.x = postHorizontalPadding
        likeButtonFrame.origin.y = postContentViewFrame.height - likeButtonSide - postVerticalPadding
        
        var commentButtonFrame = CGRect.zero
        commentButtonFrame.size = commentButton.intrinsicContentSize
        commentButtonFrame.origin.x = (postContentViewFrame.width - commentButtonFrame.width) / 2
        commentButtonFrame.origin.y = likeButtonFrame.midY - commentButtonFrame.height / 2
        
        let topHeight = profileImageViewFrame.maxY + postVerticalPadding
        let bottomHeight = postContentViewFrame.height - likeButtonFrame.minY + postVerticalPadding
        var postFrame = CGRect.zero
        postFrame.origin.y = topHeight
        postFrame.size.width = postContentViewFrame.width
        postFrame.size.height = postContentViewFrame.height - topHeight - bottomHeight
        
        postContentView.frame = postContentViewFrame
        profileImageView.frame = profileImageViewFrame
        usernameLabel.frame = usernameLabelFrame
        likeButton.frame = likeButtonFrame
        commentButton.frame = commentButtonFrame
        switch content {
        case .image:
            postImageView.frame = postFrame
            postLabel.frame = .zero
        case .post:
            postImageView.frame = .zero
            postLabel.frame = postFrame
        }
    }
    
    func configure(with id: Int,
                   profilePicture: UIImage?,
                   username: String,
                   content: VGCellContent,
                   isLiked: Bool) {
        self.id = id
        profileImageView.image = profilePicture
        usernameLabel.text = username
        
        self.content = content
        switch content {
        case .image(let image):
            postImageView.image = image
        case .post(let text):
            postLabel.text = text
        }
        
        likeButton.isSelected = isLiked
        likeButton.tintColor = isLiked ? onColor : offColor
        
        setNeedsLayout()
    }
    
    @objc func didTapLike(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        UIView.transition(with: sender, duration: 0.1, options: .curveEaseOut, animations: {
            sender.tintColor = sender.isSelected ? self.onColor : self.offColor
        }, completion: nil)
        
        delegate?.didTapLike(id: id, isOn: sender.isSelected)
    }
}
