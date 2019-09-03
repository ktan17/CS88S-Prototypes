//
//  FDHomeViewController.swift
//  Prototype
//
//  Created by Kevin Tan on 5/13/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

class FDHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var cellData = [(title: String, restaurants: [Restaurant])]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellData = [
            ("Speed ⚡️", [
                Restaurant(image: UIImage(named: "restaurant_3"),
                           priceLevel: .cheap,
                           minutes: 15,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_2"),
                           priceLevel: .medium,
                           minutes: 15,
                           isPopular: false),
                Restaurant(image: UIImage(named: "restaurant_8"),
                           priceLevel: .expensive,
                           minutes: 20,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_4"),
                           priceLevel: .medium,
                           minutes: 20,
                           isPopular: false)
            ]),
            ("Price 💲", [
                Restaurant(image: UIImage(named: "restaurant_1"),
                           priceLevel: .cheap,
                           minutes: 30,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_7"),
                           priceLevel: .cheap,
                           minutes: 25,
                           isPopular: false),
                Restaurant(image: UIImage(named: "restaurant_3"),
                           priceLevel: .cheap,
                           minutes: 20,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_6"),
                           priceLevel: .medium,
                           minutes: 50,
                           isPopular: false)
            ]),
            ("Popular 🔥", [
                Restaurant(image: UIImage(named: "restaurant_5"),
                           priceLevel: .medium,
                           minutes: 35,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_8"),
                           priceLevel: .expensive,
                           minutes: 20,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_3"),
                           priceLevel: .cheap,
                           minutes: 15,
                           isPopular: true),
                Restaurant(image: UIImage(named: "restaurant_1"),
                           priceLevel: .cheap,
                           minutes: 30,
                           isPopular: true)
            ]),
        ]
        
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: "CarouselTableViewCell")
        
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.width,
                                 height: view.bounds.height - view.safeAreaInsets.top)
    }
    
    // MARK: - UITableViewDelegate/DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarouselTableViewCell") as? CarouselTableViewCell else { fatalError() }
        
        let data = cellData[indexPath.row]
        cell.configure(with: data.title,
                       restaurants: data.restaurants)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CarouselTableViewCell.height
    }
}
