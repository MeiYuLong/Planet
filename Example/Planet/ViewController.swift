//
//  ViewController.swift
//  Planet
//
//  Created by longjiao914@126.com on 02/05/2021.
//  Copyright (c) 2021 longjiao914@126.com. All rights reserved.
//

import UIKit
import MPlanet

class LoginModel: MBaseModel{
    public var code: Int?

    public var message: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let earth = Planet.Earth
        print(earth.name, earth.diameter, earth.age)
        
        MProvider.request(protocol: MBaseClass<LoginModel>(), target: .login) { (result) in
            switch result {
            case let .success(response):
                print("response.code:",response.code, "response.message:", response.message)
                guard let data = response.data else {
                    return
                }
                print(data.baseMessage ?? "")
            case let .failure(response):
                print(response.message)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

