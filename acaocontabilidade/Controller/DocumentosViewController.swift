//
//  DocumentosViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 22/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import WebKit

class DocumentosViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Hides navigation controlle to maximize web view
        navigationController?.navigationBar.isHidden = true
        
        //Access to Acao website
        let url = URL(string: "http://acaocont.app.questorpublico.com.br/entrar")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}
