//
//  RegisterViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import UIKit

class RegisterViewController: UIViewController {
    

    private let UsernameTxtfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let EmailTxtfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let PasswordTxtfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.isSecureTextEntry = true
        return field
    }()
    
    private let ConformPasswordTxtfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Conform Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()

    private let SubmitBttn: UIButton = {
        let Submit = UIButton()
        Submit.setTitle("Submit", for: .normal)
        Submit.layer.masksToBounds = true
        Submit.layer.cornerRadius = Constants.cornerRadius
        Submit.backgroundColor = .systemGreen
        Submit.setTitleColor(.white, for: .normal)
        return Submit
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubmitBttn.addTarget(self, action: #selector(DidtapSubmitBtn), for: .touchUpInside)
        UsernameTxtfield.delegate = self
        EmailTxtfield.delegate = self
        PasswordTxtfield.delegate = self
        ConformPasswordTxtfield.delegate = self
        view.addSubview(UsernameTxtfield)
        view.addSubview(EmailTxtfield)
        view.addSubview(PasswordTxtfield)
        view.addSubview(ConformPasswordTxtfield)
        view.addSubview(SubmitBttn)
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UsernameTxtfield.frame = CGRect(x: 20, y: view.safeAreaInsets.top+50, width: view.width-40, height: 52)
        EmailTxtfield.frame = CGRect(x: 20, y: UsernameTxtfield.bottom+20, width: view.width-40, height: 52)
        PasswordTxtfield.frame = CGRect(x: 20, y: EmailTxtfield.bottom+20, width: view.width-40, height: 52)
        ConformPasswordTxtfield.frame = CGRect(x: 20, y: PasswordTxtfield.bottom+20, width: view.width-40, height: 52)
        SubmitBttn.frame = CGRect(x: 50, y: ConformPasswordTxtfield.bottom+50, width: view.width-100, height: 52)
    }
    @objc private func DidtapSubmitBtn(){
        UsernameTxtfield.resignFirstResponder()
        EmailTxtfield.resignFirstResponder()
        PasswordTxtfield.resignFirstResponder()
        ConformPasswordTxtfield.resignFirstResponder()
        
        
        guard  let username = UsernameTxtfield.text,
            let email = EmailTxtfield.text,
              let password = PasswordTxtfield.text,
              let conformpassword = ConformPasswordTxtfield.text else {
            return
        }
        Authmanage.shared.RegisterNewUser(username: username, email: email, password: password) { register in
            DispatchQueue.main.async {
                if register{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    if username.isEmpty, email.isEmpty, password.isEmpty, conformpassword.isEmpty {
                        let alerts = UIAlertController(title: "Sign In", message: "please enter all the details", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                    }
                    else if username.count<=5 {
                        let alerts = UIAlertController(title: "Signin Error", message: "entered username is wrong", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                    }else if email.count<=5 {
                        let alerts = UIAlertController(title: "Signin Error", message: "entered email is wrong", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                    }else if password.count<8 {
                        let alerts = UIAlertController(title: "Signin Error", message: "entered passwod is wrong", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                    }else if conformpassword != password{
                        let alerts = UIAlertController(title: "Signin Error", message: "entered conformpassword did not match ", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                    }
                }
            }
        }
        
    }

 
}
extension RegisterViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UsernameTxtfield{
            EmailTxtfield.becomeFirstResponder()
        }
        else if textField == EmailTxtfield{
            PasswordTxtfield.becomeFirstResponder()
        }else if textField == PasswordTxtfield{
            ConformPasswordTxtfield.becomeFirstResponder()
        }else{
            DidtapSubmitBtn()
        }
        return true
    }
}
