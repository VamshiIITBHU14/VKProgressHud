//
//  ViewController.swift
//  VKProgressHud
//
//  Created by Vamshi Krishna on 25/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var hudView : VKProgressHud?
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showHudClicked(_ sender: Any) {
        hudView = VKProgressHud(crocImageName: "croc")
        hudView?.showHUD(onView: self.view)
        Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(endAnime), userInfo: nil, repeats: false)
    }
    
    @objc func endAnime(){
        hudView?.hideHUD()
    }
    
}


