//
//  CadastroViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 21/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CadastroViewController: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Firebase Methods
    @IBAction func registerPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
        
            if error != nil{
                print(error!)
                SVProgressHUD.dismiss()
            }else{
                //Success
                print("Usuário criado com sucesso!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToMainScreen", sender: self)
            }
        }
    }
    
    //MARK: iOS Methods
    //Dismiss keyboard after touching screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //TODO: Diferenciar cliente novo e cativo
    
}
