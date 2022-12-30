//
//  ProfileViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var ProfilePicImagView: UIImageView!
    
    @IBOutlet weak var EditProfileBtn: UIButton!
    @IBOutlet weak var PostCollections: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        EditProfileBtn.layer.cornerRadius = Constants.cornerRadius
        EditProfileBtn.addTarget(self, action: #selector(Editprofilebtntapped), for: .touchUpInside)
    }
    @IBAction func ProfilePicModifyBtn(_ sender: Any) {
        let alert = UIAlertController()
        let gal = UIAlertAction(title: "Choose Photo", style: .default, handler: { UIAlertAction in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)
        })
        let cam = UIAlertAction(title: "Open camera", style: .default) { UIAlertAction in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .camera
            image.allowsEditing = true
            self.present(image, animated: true)
        }
        let cancel = UIAlertAction(title: "cancel", style: .destructive)
        alert.addAction(gal); alert.addAction(cam); alert.addAction(cancel)
       present(alert, animated: true, completion: nil)
    }
    
    @objc func Editprofilebtntapped(){
        let Editvc = EditProfileViewController()
        Editvc.title = "Edit Profile"
        let vc = UINavigationController(rootViewController: Editvc)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func LogoutBttn(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            Authmanage.shared.Logout { logot in
                DispatchQueue.main.async {
                    if logot{
                        let logvc = LoginViewController()
                        logvc.modalPresentationStyle = .fullScreen
                        self.present(logvc, animated: true)
                    }else{
                        print("error")
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectimg:UIImage?
        if let editimg = info[.editedImage] as? UIImage{
            selectimg = editimg
            self.ProfilePicImagView.image = editimg
            picker.dismiss(animated: true)
        }else if let orgimg = info[.originalImage] as? UIImage{
            selectimg = orgimg
            self.ProfilePicImagView.image = orgimg
            picker.dismiss(animated: true)
        }else{
            print("error")
        }
        self.ProfilePicImagView.image=selectimg
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
    }
}
extension ProfileViewController:  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PostCollections.dequeueReusableCell(withReuseIdentifier: "ColCell", for: indexPath)
        
        return cell
    }
    
    
}
