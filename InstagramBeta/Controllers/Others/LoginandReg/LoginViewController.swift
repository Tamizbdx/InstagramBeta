//
//  LoginViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let UsernameEmailTxtfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
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
    
    private let LoginBttn: UIButton = {
        let LogBtn = UIButton()
        LogBtn.setTitle("Log In", for: .normal)
        LogBtn.layer.masksToBounds = true
        LogBtn.layer.cornerRadius = Constants.cornerRadius
        LogBtn.backgroundColor = .systemBlue
        LogBtn.setTitleColor(.white, for: .normal)
        return LogBtn
    }()
    
    private let CreateAccountBttn: UIButton = {
        let CreateAccBtn = UIButton()
        CreateAccBtn.setTitleColor(.label, for: .normal)
        CreateAccBtn.setTitle("New User? Create an Account", for: .normal)
        return CreateAccBtn
    }()
    
    private let TermsAndConditinonBttn: UIButton = {
        let TCbtn = UIButton()
        TCbtn.setTitle("Terms and Conditions", for: .normal)
        TCbtn.setTitleColor(.secondaryLabel, for: .normal)
        return TCbtn
    }()
    
    private let PrivacyPolicyBttn: UIButton = {
        let PPbtn = UIButton()
        PPbtn.setTitle("Privacy Policy", for: .normal)
        PPbtn.setTitleColor(.secondaryLabel, for: .normal)
        return PPbtn
    }()
    
    private let HeaderView: UIView = {
        let Head = UIView()
        Head.clipsToBounds = true
        let backgroundImageview = UIImageView(image: UIImage(named: "InstaGradient"))
        Head.addSubview(backgroundImageview)
        return Head
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginBttn.addTarget(self, action: #selector(didTapLoginBttn), for: .touchUpInside)
        CreateAccountBttn.addTarget(self, action: #selector(didTapCreateAccountBttn), for: .touchUpInside)
        TermsAndConditinonBttn.addTarget(self, action: #selector(didTapTermsAndConditionBttn), for: .touchUpInside)
        PrivacyPolicyBttn.addTarget(self, action: #selector(didTapPrivacyPolicyBttn), for: .touchUpInside)
        
        UsernameEmailTxtfield.delegate = self
        PasswordTxtfield.delegate = self
        
        AddSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        HeaderView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height/3.0)
        UsernameEmailTxtfield.frame = CGRect(x: 25, y: HeaderView.bottom + 10, width: view.width-50, height: 52.0)
        PasswordTxtfield.frame = CGRect(x: 25, y: UsernameEmailTxtfield.bottom + 10, width: view.width-50, height: 52.0)
        LoginBttn.frame = CGRect(x: 25, y: PasswordTxtfield.bottom + 10, width: view.width-50, height: 52.0)
        CreateAccountBttn.frame = CGRect(x: 25, y: LoginBttn.bottom + 10, width: view.width-50, height: 52.0)
        TermsAndConditinonBttn.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        PrivacyPolicyBttn.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-50, width: view.width-20, height: 50)
        configureheaderview()
    }
    func configureheaderview(){
        guard let backroundview = HeaderView.subviews.first else {
            return
        }
        backroundview.frame = HeaderView.bounds
        //add insta logo image
        let logoimage = UIImageView(image: UIImage(named: "logo"))
        HeaderView.addSubview(logoimage)
        logoimage.contentMode = .scaleAspectFit
        logoimage.frame = CGRect(x: HeaderView.width/4.0, y: view.safeAreaInsets.top, width: HeaderView.width/2, height: HeaderView.height - view.safeAreaInsets.top)
    }
    
    func AddSubViews(){
        view.addSubview(UsernameEmailTxtfield)
        view.addSubview(PasswordTxtfield)
        view.addSubview(LoginBttn)
        view.addSubview(CreateAccountBttn)
        view.addSubview(TermsAndConditinonBttn)
        view.addSubview(PrivacyPolicyBttn)
        view.addSubview(HeaderView)
    }
    
    @objc private func didTapLoginBttn(){
        PasswordTxtfield.resignFirstResponder()
        UsernameEmailTxtfield.resignFirstResponder()
        guard let UsernameEmail = UsernameEmailTxtfield.text, !UsernameEmail.isEmpty, let password = PasswordTxtfield.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        //login functions
        var username:String?
        var email:String?
        if UsernameEmail.contains("@"), UsernameEmail.contains("."){
            email = UsernameEmail
        }else{
            username = UsernameEmail
        }
        Authmanage.shared.LoginUser(username: username, email: email, password: password) { enter in
            DispatchQueue.main.async {
                if enter {
                    //login from the user
                    self.dismiss(animated: true, completion: nil)
                }else{
                    //it will show the error
                    let alert = UIAlertController(title: "Login Error", message: "entered email and password is wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc private func didTapCreateAccountBttn(){
        let regvc = RegisterViewController()
        regvc.title = "Create New Account"
        let vc = UINavigationController(rootViewController: regvc)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @objc private func didTapTermsAndConditionBttn(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapPrivacyPolicyBttn(){
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UsernameEmailTxtfield{
            PasswordTxtfield.becomeFirstResponder()
        }else if textField == PasswordTxtfield{
            didTapLoginBttn()
        }
        return true
    }
}
