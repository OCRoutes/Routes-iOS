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
            SetupStopInfo()
        }
    }
    
    let mainStack : UIStackView = {
        return UIStackView()
    }()
    
    private let routeNumberView = RouteInfoDistanceView()
    
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
    
    convenience init(stop: BusStop, routes: [BusRoute]?, style: TrackStyle) {
        self.init(style: .default, reuseIdentifier: "favStopCell", trackStyle: style)
        self.trackStyle = style
        defer { self.stop = stop }
        defer { self.routes = routes }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, trackStyle: TrackStyle) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        redLineView = RedLineView(style: trackStyle)
        
        routeCubeCollection.delegate = self
        routeCubeCollection.dataSource = self
        routeCubeCollection.register(RouteInfoCubeView.self, forCellWithReuseIdentifier: "routecube")
        
        //Adding elements to contentView
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(routeNumberView)
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
        
        if stopInfo.stop_code != nil {
            routeNumberView.busStopNumberLabel.text = stopInfo.stop_code
        } else {
            routeNumberView.busStopNumberLabel.text = String(stopInfo.stop_id.prefix(4))
        }
        
        if let d = stopInfo.distance {
            routeNumberView.routeDistanceLabel.text = "\(d)km"
        } else {
            routeNumberView.routeDistanceLabel.text = ""
        }
        
        busStopNameLabel.text = stopInfo.stop_name
    }

    private func ApplyConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        routeNumberView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeNumberView.widthAnchor.constraint(equalToConstant: routeNumberView.busStopNumberLabel.frame.width)
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
            routeCubeCollection.heightAnchor.constraint(equalToConstant: 45)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routecube", for: indexPath) as! RouteInfoCubeView
        
        if let route = routes?[indexPath.row] {
            if route.routeNumber == "SNOW" {
                cell.routeNumberLabel.text = String(route.routeId.prefix(3))
            } else {
                cell.routeNumberLabel.text = route.routeNumber
            }
        }
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

class RouteInfoDistanceView: UIView {
    
    let busStopNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "SNOW"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    let routeDistanceLabel : UILabel = {
        let label = UILabel()
        label.text = "0.00km"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        addSubview(busStopNumberLabel)
        addSubview(routeDistanceLabel)
        
        ApplyConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        busStopNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busStopNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            busStopNumberLabel.leftAnchor.constraint(equalTo: leftAnchor),
            busStopNumberLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        routeDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeDistanceLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            routeDistanceLabel.leftAnchor.constraint(equalTo: leftAnchor),
            routeDistanceLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
}
