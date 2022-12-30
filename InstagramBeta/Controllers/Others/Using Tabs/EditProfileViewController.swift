//
//  EditProfileViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 29/12/22.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private let ProfilePictureImage:UIImageView = {
        let ProfilePicImage = UIImageView()
        ProfilePicImage.clipsToBounds = true
        let backgroundImageview = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        ProfilePicImage.addSubview(backgroundImageview)
        ProfilePicImage.contentMode = .scaleAspectFit
        return ProfilePicImage
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ProfilePictureImage)
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
}
