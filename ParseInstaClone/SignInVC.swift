//
//  ViewController.swift
//  ParseInstaClone
//
//  Created by Melih Yuvacı on 30.05.2022.
//

import UIKit
import Parse

class SignInVC: UIViewController {
    

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
         /** Parse Veri Kayıt Etme **/
        
        /*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in
            if error != nil{
                print(error?.localizedDescription)
            }else {
                print("saved")
            }
        }
         */
        
        
        /** Parse Veri Çekme**/
        /*
        let query = PFQuery(className: "Fruits")
        //query.whereKey("calories", greaterThan: 120)
        query.whereKey("name", equalTo: "Apple")
        query.findObjectsInBackground { objects, error in
            if error != nil{
                print(error?.localizedDescription)
            }else {
                print(objects)
            }
        }
        */
        
    }

    
    @IBAction func signInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
                    
                    PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                        
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                                                    
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                        
                        }
                        
                    }
                   
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: "username/password needed", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    present(alert, animated: true, completion: nil)
                }

            }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        
        } else {
            let alert = UIAlertController(title: "Error", message: "username/password needed", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }

  }
}

