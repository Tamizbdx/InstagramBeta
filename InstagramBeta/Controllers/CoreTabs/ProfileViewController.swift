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

   @objc func Editprofilebtntapped(){
    let editvc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
    present(editvc, animated: true, completion: nil)
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

extension ProfileViewController:  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PostCollections.dequeueReusableCell(withReuseIdentifier: "ColCell", for: indexPath)
        return cell
    }
    
    
}

