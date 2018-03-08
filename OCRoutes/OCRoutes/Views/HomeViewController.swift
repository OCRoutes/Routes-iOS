//
//  HomeViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-07.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import Parchment

class HomeViewController : UIViewController, PagingViewControllerDataSource, PagingViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let pagingViewController = PagingViewController<PagingIndexItem>()
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
        
        self.navigationController?.navigationBar.topItem?.title = "FAVOURITE ROUTES"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        
        pagingViewController.borderColor = Style.darkGrey_lowalpha
        pagingViewController.selectedTextColor = .black
        pagingViewController.indicatorColor = Style.mainColor
        pagingViewController.textColor = Style.darkGrey
        pagingViewController.font = UIFont(name: "AvenirNext-DemiBold", size: 15)!
        
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            pagingViewController.view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            pagingViewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        if index == 0 {
            return PagingIndexItem(index: index, title: "Stops") as! T
        } else {
            return PagingIndexItem(index: index, title: "Routes") as! T
        }
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        if index == 0 {
            return FavoriteRoutesViewController()
        } else {
            return FavoriteRoutesViewController()
        }
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return 2
    }
    
}
