//
//  ViewController.swift
//  Prototype
//
//  Created by Kevin Tan on 5/11/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

class ICHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ICHomeTableViewCellDelegate {
    var flavorComboData = [(image: UIImage?, name: String, isFavorited: Bool)]()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let customizeView = UIView()
    let iconImageView = UIImageView()
    let customizeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .pink
	flavorComboData = [
            (UIImage(named: "icecream_1"), "Avocado Smash", false),
            (UIImage(named: "icecream_2"), "Matcha-colate Chip", false),
            (UIImage(named: "icecream_3"), "Fried Ice Cream", false),
            (UIImage(named: "icecream_4"), "Vanilla Bean", false),
            (UIImage(named: "icecream_5"), "Strawberry Sunset", false),
            (UIImage(named: "icecream_6"), "White Rainbow", false),
            (UIImage(named: "icecream_7"), "Kids Vanilla", false)
        ]
        
        tableView.register(ICHomeTableViewCell.self, forCellReuseIdentifier: "ICHomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        customizeLabel.text = "customize your own"
        customizeLabel.preferredMaxLayoutWidth = view.bounds.width / 3
        
        view.addSubview(tableView)
        view.addSubview(customizeView)
        customizeView.addSubview(iconImageView)
        customizeView.addSubview(customizeLabel)
        
        let logoContainerView = UIView()
        logoContainerView.frame.size = CGSize(width: 32, height: 32)
        
        let logoImageView = UIImageView()
        logoImageView.frame = logoContainerView.bounds
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "icecream_logo")
        logoContainerView.addSubview(logoImageView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoContainerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let customizeViewHeight = view.bounds.height / 6
        var tableViewFrame = CGRect.zero
        tableViewFrame.size.width = view.bounds.width
        tableViewFrame.size.height = view.bounds.height - customizeViewHeight
        
        var customizeViewFrame = CGRect.zero
        customizeViewFrame.origin.y = tableViewFrame.maxY
        customizeViewFrame.size.width = view.bounds.width
        customizeViewFrame.size.height = customizeViewHeight
        
        let padding: CGFloat = 20
        var iconImageViewFrame = CGRect.zero
        iconImageViewFrame.origin.x = padding
        iconImageViewFrame.origin.y = padding
        iconImageViewFrame.size.height = customizeViewHeight - padding * 2
        iconImageViewFrame.size.width = iconImageViewFrame.size.height
        
        var customizeLabelFrame = CGRect.zero
        customizeLabelFrame.size = customizeLabel.intrinsicContentSize
        customizeLabelFrame.origin.x = iconImageViewFrame.maxX + padding
        customizeLabelFrame.origin.y = (customizeViewHeight - customizeLabelFrame.height) / 2
        
        tableView.frame = tableViewFrame
        customizeView.frame = customizeViewFrame
        iconImageView.frame = iconImageViewFrame
        customizeLabel.frame = customizeLabelFrame
    }

    func didTapFavorite(id: Int, isOn: Bool) {
        flavorComboData[id].isFavorited = isOn
    }
    
    // MARK: - UITableViewDelegate/DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flavorComboData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ICHomeTableViewCell") as? ICHomeTableViewCell else { fatalError() }
        
        let cellData = flavorComboData[indexPath.row]
        cell.configure(with: indexPath.row,
                       image: cellData.image,
                       comboName: cellData.name,
                       isFavorited: cellData.isFavorited)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ICHomeTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

