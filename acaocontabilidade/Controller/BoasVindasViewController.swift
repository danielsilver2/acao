//
//  BoasVindasViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 23/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class BoasVindasViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordTextfield.delegate = self
        self.emailTextfield.delegate = self
    }

    //MARK: Email / Password authentication
    @IBAction func entrarButtonPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            SVProgressHUD.dismiss()
            if error != nil{
                print(error!)
                self.showIncorrectLoginAlert()
            }else{
                print("Login successful!")
                self.performSegue(withIdentifier: "goToMainScreen", sender: self)
            }
        }
    }
    
    private func showIncorrectLoginAlert() {
        let alert = UIAlertController(title: "Login incorreto", message: "Usuário ou senha incorretos", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { (action) in
            self.emailTextfield.becomeFirstResponder()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: iOS Methods
    //Dismiss keyboard after touching screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.passwordTextfield {
            self.entrarButtonPressed(textField)
        }
        
        return true
    }
}
