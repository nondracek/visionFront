//
//  menuClass.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/25/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import Foundation
import ExpandingMenu

class menuNavigator {
    
    var menuButton: ExpandingMenuButton
    
    init(currVC: UIViewController) {
        let menuButtonSize: CGSize = CGSize(width: 64, height: 64)
        menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "blueMenu")!, rotatedImage: UIImage(named: "blueMenu")!)
        
        menuButton.center = CGPoint(x: currVC.view.bounds.width * 7 / 8, y: currVC.view.bounds.height * 7 / 8)
        currVC.view.addSubview(menuButton)
        
        createMenuItem(currVC: currVC, size: menuButtonSize, menu: menuButton, title: "Home", img: "homeIcon", hlImg: "homeIcon", bkImg: "homeIcon", hlBkImg: "homeIcon", sbDestination: "sbHome")
        
        createMenuItem(currVC: currVC, size: menuButtonSize, menu: menuButton, title: "Single Bet", img: "betIcon", hlImg: "betIcon", bkImg: "betIcon", hlBkImg: "betIcon", sbDestination: "sbSingleBet")
        
        createMenuItem(currVC: currVC, size: menuButtonSize, menu: menuButton, title: "Profile", img: "profileIcon", hlImg: "profileIcon", bkImg: "profileIcon", hlBkImg: "profileIcon", sbDestination: "sbProfile")
        
    }
    
    
    func getMenu() -> ExpandingMenuButton {
        return menuButton
    }
    
    
    func createMenuItem(currVC: UIViewController, size: CGSize, menu: ExpandingMenuButton,
                        title: String, img: String, hlImg: String, bkImg: String,
                        hlBkImg: String, sbDestination: String) {
        
        let size = CGSize(width: 100.0, height: 100.0)
        
        let menuItem = ExpandingMenuItem(size: size, title: title,
                                         image: UIImage(named: img)!,
                                         highlightedImage: UIImage(named: hlImg)!,
                                         backgroundImage: UIImage(named: bkImg),
                                         backgroundHighlightedImage: UIImage(named: hlBkImg))
        { () -> Void in
            switch title {
            case "Home":
                if let newVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: sbDestination) as? homeController {
                    currVC.present(newVC, animated: true, completion: nil)
                }
                break;
            case "Single Bet":
                if let newVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: sbDestination) as? SingleBetController {
                    currVC.present(newVC, animated: true, completion: nil)
                }
                break;
            case "Profile":
                if let newVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: sbDestination) as? profileController {
                    currVC.present(newVC, animated: true, completion: nil)
                }
                break;
            default:
                break;
            }
        }
        
        menuButton.addMenuItems([menuItem])
        
    }
}
