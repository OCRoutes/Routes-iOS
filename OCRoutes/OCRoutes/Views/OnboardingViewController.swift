//
//  OnboardingViewController.swift
//  OCRoutes
//
//  Created by sana on 2018-04-06.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit
import PaperOnboarding

class OnboardingViewController : UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    fileprivate var onboardingView = PaperOnboarding()
    
    let getStartedButton : UILabel = {
        let label = UILabel()
        label.text = "CLICK TO START"
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)!
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.alpha = 0;
        label.isUserInteractionEnabled = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
        view.addSubview(onboardingView)
        view.addSubview(getStartedButton)
        
        ApplyConstraint()
    }
    
    // How many screens do we want
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 125/255, green: 223/255, blue: 100/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 46/255, green: 134/255, blue: 171/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 76/255, green: 44/255, blue: 114/255, alpha: 1)
        let backgroundColorFour = Style.mainColor
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 25)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        
        return [
                OnboardingItemInfo(
                        informationImage: #imageLiteral(resourceName: "wave"),
                        title: "HEY THERE!",
                        description: "Thank you for downloading Routes! We hope to make your daily commute a bit simpler! Here are a few tips for using our app.",
                        pageIcon: UIImage(),
                        color: backgroundColorOne,
                        titleColor: .white,
                        descriptionColor: .white,
                        titleFont: titleFont,
                        descriptionFont: descriptionFont
                ),
                OnboardingItemInfo(
                        informationImage: #imageLiteral(resourceName: "long-press"),
                        title: "SAVE ROUTES OR STOPS!",
                        description: "If you want to save a route or a stop, just press and hold on them and we'll do the rest for you!",
                        pageIcon: UIImage(),
                        color: backgroundColorTwo,
                        titleColor: UIColor.white,
                        descriptionColor: UIColor.white,
                        titleFont: titleFont,
                        descriptionFont: descriptionFont
                ),
                OnboardingItemInfo(
                        informationImage: #imageLiteral(resourceName: "bus-run"),
                        title: "TRACK YOUR BUSSES!",
                        description: "Use the map to know the exact location of your busses, so you never end up in a dead sprint behind them!",
                        pageIcon: UIImage(),
                        color: backgroundColorThree,
                        titleColor: UIColor.white,
                        descriptionColor: UIColor.white,
                        titleFont: titleFont,
                        descriptionFont: descriptionFont
                ),
                OnboardingItemInfo(
                    informationImage: #imageLiteral(resourceName: "smile"),
                    title: "AND THAT'S IT!",
                    description: "Our app thrives on being a 'simple to use' companion, the less work you have to do, the better!",
                    pageIcon: UIImage(),
                    color: backgroundColorFour,
                    titleColor: UIColor.white,
                    descriptionColor: UIColor.white,
                    titleFont: titleFont,
                    descriptionFont: descriptionFont
                )][index]
    }
    
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index _: Int) {
    
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 3 {
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedButton.alpha = 1
                self.getStartedButton.isUserInteractionEnabled = true
            })
        } else {
            self.getStartedButton.alpha = 0
            self.getStartedButton.isUserInteractionEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func ApplyConstraint() {
        // Favs table view constraints
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
}
