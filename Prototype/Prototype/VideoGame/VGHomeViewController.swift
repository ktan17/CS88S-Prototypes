//
//  VGHomeViewController.swift
//  Prototype
//
//  Created by Kevin Tan on 5/12/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

class VGHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VGHomeTableViewCellDelegate {
    let tableView = UITableView(frame: .zero, style: .plain)
    var postData = [(profilePicture: UIImage?, content: VGCellContent, username: String, isLiked: Bool)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postData = [
            (UIImage(named: "profile_1"), .image(UIImage(named: "gtav_1")), "Xx_Jonny_xX", false),
            (UIImage(named: "blank_profile"), .post("i am 10 years old lol"), "wizardpoo420", false),
            (UIImage(named: "profile_2"), .post("I can't beat the shoot-out part of the Mr. Philips mission, any tips?"), "Joker", false),
            (UIImage(named: "profile_3"), .image(UIImage(named: "gtav_2")), "gamergirl21", false),
            (UIImage(named: "blank_profile"), .post("selling brand new GTA V copy $60"), "durrrr", false)
        ]
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VGHomeTableViewCell.self, forCellReuseIdentifier: "VGHomeTableViewCell")
        
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func didTapLike(id: Int, isOn: Bool) {
        postData[id].isLiked = isOn
    }
    
    // MARK: - UITableViewDelegate/DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VGHomeTableViewCell") as? VGHomeTableViewCell else { fatalError() }
        
        let cellData = postData[indexPath.row]
        cell.configure(with: indexPath.row,
                       profilePicture: cellData.profilePicture,
                       username: cellData.username,
                       content: cellData.content,
                       isLiked: cellData.isLiked)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VGHomeTableViewCell.height
    }
}
