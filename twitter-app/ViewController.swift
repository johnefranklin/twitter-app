//
//  ViewController.swift
//  twitter-app
//
//  Created by John Franklin on 9/25/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: UIButton) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user : User?, error : NSError?) in
            if user != nil {
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                print("login error")
            }
        }
        
    }

}

