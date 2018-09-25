//
//  CustomNavigationViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 21/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar set to transparent
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }

    

}
