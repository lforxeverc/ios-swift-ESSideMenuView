//
//  ViewController.swift
//  ios_swift_ESSideMenuView
//
//  Created by LiuYongyuan on 16/4/7.
//  Copyright © 2016年 LiuYongyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      let swipe = ESSideMenuView(frame: self.view.frame)
        let container = UIView(frame: self.view.frame)
        container.backgroundColor = UIColor.yellowColor()
        swipe.containerView = container
        let menu = UIView(frame: self.view.frame)
        menu.backgroundColor = UIColor.greenColor()
        swipe.menuView = menu
        self.view.addSubview(swipe)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

