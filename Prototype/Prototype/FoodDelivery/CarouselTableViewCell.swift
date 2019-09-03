//
//  CarouselTableViewCell.swift
//  Prototype
//
//  Created by Kevin Tan on 5/13/19.
//  Copyright © 2019 Kevin Tan. All rights reserved.
//

import UIKit

enum PriceLevel: String {
    case cheap = "$"
    case medium = "$$"
    case expensive = "$$$"
}

struct Restaurant {
    let image: UIImage?
    let priceLevel: PriceLevel
    let minutes: Int
    let isPopular: Bool
}

class CarouselTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let height: CGFloat = 200
    let titleLabel = UILabel()
    let carousel: UICollectionView
    
    private let sectionInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    private let itemsInRow: CGFloat = 2.5
    var restaurantData = [Restaurant]() {
        didSet {
            carousel.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        carousel = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        carousel.backgroundColor = .white
        carousel.delegate = self
        carousel.dataSource = self
        carousel.register(CarouselCollectionViewCell.self,
                          forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        
        addSubview(titleLabel)
        addSubview(carousel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let horizontalPadding = sectionInsets.left
        let verticalPadding: CGFloat = 10
        
        var titleLabelFrame = CGRect.zero
        titleLabelFrame.size = titleLabel.intrinsicContentSize
        titleLabelFrame.origin.x = horizontalPadding
        titleLabelFrame.origin.y = verticalPadding
        
        var carouselFrame = CGRect.zero
        carouselFrame.origin.y = titleLabelFrame.maxY
        carouselFrame.size.width = bounds.width
        carouselFrame.size.height = bounds.height - titleLabelFrame.maxY
        
        titleLabel.frame = titleLabelFrame
        carousel.frame = carouselFrame
    }
    
    func configure(with title: String, restaurants: [Restaurant]) {
        titleLabel.text = title
        restaurantData = restaurants
        
        setNeedsLayout()
    }
    
    // MARK: - UICollectionViewDelegate/DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell else { fatalError() }
        
        let cellData = restaurantData[indexPath.row]
        cell.configure(with: cellData.image,
                       price: cellData.priceLevel,
                       minutes: cellData.minutes,
                       isPopular: cellData.isPopular)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - sectionInsets.left * (floor(itemsInRow) + 1)
        let side = width / itemsInRow
        
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
