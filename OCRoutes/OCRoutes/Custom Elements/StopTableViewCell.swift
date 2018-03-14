//
//  StopTableViewCell.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-12.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class StopTableViewCell : UITableViewCell {
    
    fileprivate let CUBE_SIZE : CGFloat = 30.0
    fileprivate let CUBE_PADDING : CGFloat = 2.0
    
    private var trackStyle : TrackStyle = .Normal
    
    private var redLineView : RedLineView!
    
    private var stop : BusStop? {
        didSet {
            SetupStopInfo()
        }
    }
    
    fileprivate var routes : [BusRoute]? {
        didSet {
            routeCubeCollection.reloadData()
        }
    }
    
    let mainStack : UIStackView = {
        return UIStackView()
    }()
    
    //1st column
    let busStopNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "6783"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let spacerView : UIView = {
        let view = UIView()
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    //3rd column label
    let busStopNameLabel : UILabel = {
        let label = UILabel()
        label.text = "King Edward / Tempelton"
        label.font = UIFont(name: "AvenirNext", size: 15)
        label.textColor = .black
        return label
    }()
    
    let routeCubeCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        
        return collection
    }()
    
    convenience init(stop: BusStop, routes: [BusRoute], style: TrackStyle) {
        self.init(style: .default, reuseIdentifier: "favStopCell", trackStyle: style)
        self.trackStyle = style
        defer { self.stop = stop }
        defer { self.routes = routes }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, trackStyle: TrackStyle) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        redLineView = RedLineView(style: trackStyle)
        
        routeCubeCollection.delegate = self
        routeCubeCollection.dataSource = self
        routeCubeCollection.register(RouteInfoCubeView.self, forCellWithReuseIdentifier: "cell")
        
        //Adding elements to contentView
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(busStopNumberLabel)
        mainStack.addArrangedSubview(redLineView)
        mainStack.addArrangedSubview(spacerView)
        
        spacerView.addSubview(busStopNameLabel)
        spacerView.addSubview(routeCubeCollection)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func SetupStopInfo() {
        guard let stopInfo = stop else { return }
        busStopNumberLabel.text = stopInfo.stopCode
        busStopNameLabel.text = stopInfo.stopName
    }

    private func ApplyConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])

        busStopNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busStopNumberLabel.widthAnchor.constraint(equalToConstant: busStopNumberLabel.frame.width)
        ])
        
        redLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redLineView.widthAnchor.constraint(equalToConstant: 30)
        ])

        busStopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busStopNameLabel.topAnchor.constraint(equalTo: spacerView.topAnchor, constant: 5),
            busStopNameLabel.leadingAnchor.constraint(equalTo: spacerView.leadingAnchor),
            busStopNameLabel.trailingAnchor.constraint(equalTo: spacerView.trailingAnchor)
        ])

        routeCubeCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeCubeCollection.topAnchor.constraint(equalTo: busStopNameLabel.bottomAnchor),
            routeCubeCollection.leadingAnchor.constraint(equalTo: spacerView.leadingAnchor),
            routeCubeCollection.trailingAnchor.constraint(equalTo: spacerView.trailingAnchor),
            routeCubeCollection.bottomAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: -5),
            routeCubeCollection.heightAnchor.constraint(equalToConstant: 65)
        ])
    }

}

extension StopTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = routes?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RouteInfoCubeView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CUBE_SIZE, height: CUBE_SIZE)
    }
    
    // cell bottom padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CUBE_PADDING
    }
    
    // cell side padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CUBE_PADDING
    }
}
