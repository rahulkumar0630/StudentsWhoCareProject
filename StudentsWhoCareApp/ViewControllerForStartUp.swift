//
//  ViewControllerForStartUp.swift
//  StudentsWhoCareApp
//
//  Created by Rahul Kumar on 11/24/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit

class ViewControllerForStartUp: UIViewController {

    @IBOutlet var SWCImage: UIImageView!
    @IBOutlet var hieghtConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(ViewController.modelName == "iPhone SE" || ViewController.modelName == "iPad 2" || ViewController.modelName == "iPad 3" || ViewController.modelName == "iPad 4" || ViewController.modelName == "iPad Air" || ViewController.modelName == "iPad Air 2" || ViewController.modelName == "iPad 5" || ViewController.modelName == "iPad Mini" || ViewController.modelName == "iPad Mini 2" || ViewController.modelName == "iPad Mini 3" || ViewController.modelName == "iPad Mini 4" || ViewController.modelName == "iPad Pro 9.7 Inch" || ViewController.modelName == "iPad Pro 12.9 Inch" || ViewController.modelName == "iPad Pro 12.9 Inch 2. Generation" || ViewController.modelName == "iPad Pro 10.5 Inch")
        {
            SWCImage.removeConstraint(hieghtConstraint)
            SWCImage.frame = CGRect.init(x: 64, y: 98, width: 639, height: 246)
        }
        hideToolBar()
        hideNavigationBar()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideToolBar()
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
        showToolBar()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
