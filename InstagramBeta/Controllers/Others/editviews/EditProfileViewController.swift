//
//  EditProfileViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 04/01/23.
//

import UIKit
import Firebase
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var Websitetxt: UITextField!
    @IBOutlet weak var Biotxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var Phonetxt: UITextField!
    @IBOutlet weak var gendertxt: UITextField!
    @IBOutlet weak var ProfilePicImageView: UIImageView!
    private var data = DatabaseReference.init()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = Database.database().reference()
    }

    @IBAction func SaveDatabtn(_ sender: Any) {
        Savedata()
        self.dismiss(animated: true, completion: nil)
    }
    func Savedata(){
        let datas = ["Name":nametxt.text!,"website":Websitetxt.text!,"Bio":Biotxt.text!,"email":emailtxt.text!,"phone":Phonetxt.text!,"Gender":gendertxt.text!]
        self.data.child("Personal Information").childByAutoId().setValue(datas)
    }
    @IBAction func CancelEditBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func UploadPIcBtn(_ sender: Any) {
        let actionsheet = UIAlertController(title: "Profile picture", message: "Choose the Profile Picture", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (_) in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .camera
            image.allowsEditing = true
            self.present(image, animated: true)
        }))
        actionsheet.addAction(UIAlertAction(title: "Use Gallary", style: .default, handler: { (_) in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)
        }))
        let cancel = UIAlertAction(title: "cancel", style: .destructive)
        actionsheet.addAction(cancel)
        actionsheet.popoverPresentationController?.sourceView = view
        actionsheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionsheet, animated: true)
    }
}

extension EditProfileViewController{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectimg:UIImage?
            if let editimg = info[.editedImage] as? UIImage{
                selectimg = editimg
                self.ProfilePicImageView.image = editimg
                picker.dismiss(animated: true)
            }else if let orgimg = info[.originalImage] as? UIImage{
                selectimg = orgimg
                self.ProfilePicImageView.image = orgimg
                picker.dismiss(animated: true)
            }else{
                print("error")
            }
            self.ProfilePicImageView.image=selectimg
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("cancel")
        }
}

