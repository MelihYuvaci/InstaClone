//
//  UploadVC.swift
//  ParseInstaClone
//
//  Created by Melih Yuvacı on 31.05.2022.
//

import UIKit
import Parse

class UploadVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboadRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(keyboadRecognizer)
        
        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        postImage.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
        postButton.isEnabled = false
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func choosePhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        postButton.isEnabled = true
    }
    
    @IBAction func postClicked(_ sender: Any) {
        postButton.isEnabled = false
        
        let object = PFObject(className: "Posts")
        
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image", data: data!)
        
        let uuid = UUID().uuidString
        let uuidpost = "\(uuid) \(PFUser.current()!.username!)"
        
        object["postimage"] = pfImage
        object["postcomment"] = commentText.text
        object["postowner"] = PFUser.current()!.username!
        object["postuuid"] = uuidpost
        
        object.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.commentText.text = ""
                self.postImage.image = UIImage(named: "image.png")
                self.tabBarController?.selectedIndex = 0
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
            }
        }
        
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
