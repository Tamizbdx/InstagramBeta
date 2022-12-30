//
//  ViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlenotauthorised()
       
    }
    private func handlenotauthorised(){
        if Auth.auth().currentUser == nil{
            let logvc = LoginViewController()
            logvc.modalPresentationStyle = .fullScreen
            present(logvc, animated: false)
        }
    }
}

