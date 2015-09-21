//
//  NavBarViewController.swift
//  RottenTomatoes
//
//  Created by Emily M Yang on 9/19/15.
//  Copyright © 2015 Experiences Evolved. All rights reserved.
//

import UIKit

class NavBarViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        // Sets the default color of the background of the UITabBar
        UINavigationBar.appearance().barTintColor =  UIColor(red: 85/255, green: 15/255, blue: 138/255, alpha: 1.0)

        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleDict as! [String : AnyObject]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
