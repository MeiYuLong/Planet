//
//  ViewController.swift
//  Planet
//
//  Created by longjiao914@126.com on 02/05/2021.
//  Copyright (c) 2021 longjiao914@126.com. All rights reserved.
//

import UIKit
import Planet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let earth = Planet.Earth
        print(earth.name, earth.diameter, earth.age)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

