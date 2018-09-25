//
//  SiteViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 22/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SiteViewController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Hides navigation controlle to maximize web view
        navigationController?.navigationBar.isHidden = true
        
        //Access to Acao website
        let url = URL(string: "https://acaocontabilidadejoinville.com.br/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }

}
