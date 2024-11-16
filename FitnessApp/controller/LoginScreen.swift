//
//  LoginScreen.swift
//  FitnessApp
//
//  Created by Mac on 2024-11-11.
//

import UIKit
import FirebaseAuth

class LoginScreen: UIViewController {
    
    let rectrangleView = UIView()
    let usernameTxt = UITextField();
    let passwordTxt = UITextField();
    let loginLbl = UILabel();
    let loginBtn = UIButton();
    let forgotPw = UILabel();
    let noAccLbl = UILabel();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .orange
        
        rectrangleView.frame = CGRect(x:0, y: 350, width: 393 , height: 600)
        rectrangleView.backgroundColor = UIColor.black
        rectrangleView.layer.opacity = 0.9
        rectrangleView.layer.cornerRadius = 90
        self.view.addSubview(rectrangleView)
        configureLoginLableText()
        configureUsernameTxt()
        configurePasswordTxt()
        configureSignInBtn()
        configureForgotLbl()
        configurenoAccLbl()
        
    }
    
    func configurenoAccLbl(){
        noAccLbl.text = "Don't have an account"
        noAccLbl.textAlignment = .center
        noAccLbl.textColor = .white
        //loginLbl.font = UIFont(name: loginLbl.font.fontName, size: 28)
        noAccLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpNoAccLbl()
    }
    
    func setUpNoAccLbl(){
        rectrangleView.addSubview(noAccLbl)
        
        NSLayoutConstraint.activate([
            
            noAccLbl.widthAnchor.constraint(equalToConstant: 350),
            noAccLbl.heightAnchor.constraint(equalToConstant: 40),
            noAccLbl.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            ])
        noAccLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170).isActive = true
        
        noAccLbl.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoSignUp))
        noAccLbl.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func gotoSignUp(){
        let signup = SignUpScreen()
        signup.title = "SignUp"
        navigationController?.pushViewController(signup, animated: true)
    }
    
    func configureSignInBtn(){
        loginBtn.configuration = .gray()
        loginBtn.configuration?.baseForegroundColor = .black
        loginBtn.configuration?.cornerStyle = .medium
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.orange.cgColor
        loginBtn.layer.backgroundColor = UIColor.orange.cgColor

        loginBtn.setTitle("SignIn", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        loginBtn.semanticContentAttribute = .forceRightToLeft
        
        setupSignInBtn()
    }
    
    func setupSignInBtn(){
        rectrangleView.addSubview(loginBtn)
        
        loginBtn.layer.cornerRadius = 20
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginBtn.widthAnchor.constraint(equalToConstant: 180),
            loginBtn.heightAnchor.constraint(equalToConstant: 40),
            //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -218).isActive = true
        loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true;
        loginBtn.isUserInteractionEnabled = true
        
        loginBtn.addTarget(self, action: #selector(gotoHome), for: .touchUpInside)
        
    }
    
    @objc public func gotoHome(){
        
        guard let email = usernameTxt.text, !email.isEmpty,
              let password = passwordTxt.text, !password.isEmpty else{
            let alert = UIAlertController(title: "Error",
                                                  message: "Please eneter valid credentials.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
            return
        }
        
        //get auth instance
        //attempt sign in
        //if fail , display err msg
        //if pass continue to create acc
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self]result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                //show acc creation
                //strongSelf.showLoggedAccount(email : email, password : password)
                return
            }
            strongSelf.showLoggedAccount(email : email, password : password)

            print("You have signed in")
            strongSelf.usernameTxt.isHidden = true
            strongSelf.passwordTxt.isHidden = true
        })
    }
    
    func showLoggedAccount(email : String, password : String){
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self ]result,error in
            
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                //show acc creation
                print("Login fail")
                return
            }
            print("You have signed in")
            
            let home  = Home()
            self?.navigationController?.pushViewController(home, animated: true)
            
        })
    }
    
    func configureForgotLbl(){
        forgotPw.text = "Forgot Password"
        forgotPw.textAlignment = .left
        forgotPw.textColor = .white
        //loginLbl.font = UIFont(name: loginLbl.font.fontName, size: 28)
        forgotPw.translatesAutoresizingMaskIntoConstraints = false
        
        setUpForgotPwLbl()
        
    }
    
    func setUpForgotPwLbl(){
        rectrangleView.addSubview(forgotPw)
        
        NSLayoutConstraint.activate([
            
            forgotPw.widthAnchor.constraint(equalToConstant: 350),
            forgotPw.heightAnchor.constraint(equalToConstant: 40),
            ])
        forgotPw.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -218).isActive = true
        forgotPw.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 28).isActive = true
        
        //forgotPw.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoGender))
        forgotPw.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func gotoGender(){
        let gender = Gender()
        gender.title = "Gender"
        navigationController?.pushViewController(gender, animated: true)
    }   
    
    func configureLoginLableText(){
        loginLbl.text = "SignIn"
        loginLbl.textAlignment = .center
        loginLbl.textColor = .white
        loginLbl.font = UIFont(name: loginLbl.font.fontName, size: 28)
        loginLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpLoginLable()
    }
    func setUpLoginLable(){
        rectrangleView.addSubview(loginLbl)
        
        NSLayoutConstraint.activate([
            
            loginLbl.widthAnchor.constraint(equalToConstant: 350),
            loginLbl.heightAnchor.constraint(equalToConstant: 40),
            loginLbl.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            loginLbl.topAnchor.constraint(equalTo: rectrangleView.topAnchor,constant: 15)
            ])
    }
    
    func configureUsernameTxt(){
        usernameTxt.returnKeyType = .done
        usernameTxt.autocorrectionType = .no
        usernameTxt.layer.borderWidth = 1.5
        usernameTxt.layer.borderColor = UIColor.white.cgColor
//        usernameTxt.placeholder = "Email"
        usernameTxt.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        usernameTxt.autocapitalizationType = .none
        usernameTxt.textColor = .white
        usernameTxt.textAlignment = .center
        
        setUpUsernameTxt()
    }
    func setUpUsernameTxt(){
        rectrangleView.addSubview(usernameTxt)
        
        usernameTxt.layer.cornerRadius = 20
        usernameTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            usernameTxt.widthAnchor.constraint(equalToConstant: 350),
            usernameTxt.heightAnchor.constraint(equalToConstant: 40),
            usernameTxt.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            usernameTxt.topAnchor.constraint(equalTo: rectrangleView.topAnchor,constant: 90)
            
        ])
    }
    
    func configurePasswordTxt(){
        passwordTxt.returnKeyType = .done
        passwordTxt.autocorrectionType = .no
        passwordTxt.layer.borderWidth = 1.5
        passwordTxt.layer.borderColor = UIColor.white.cgColor
//        passwordTxt.placeholder =  "Password"
        passwordTxt.attributedPlaceholder = NSAttributedString(
                    string: "Password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                )
        passwordTxt.textColor = .white
        passwordTxt.textAlignment = .center
        
        setUpPasswordTxt()
    }
    func setUpPasswordTxt(){
        rectrangleView.addSubview(passwordTxt)
        
        passwordTxt.layer.cornerRadius = 20
        passwordTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            passwordTxt.widthAnchor.constraint(equalToConstant: 350),
            passwordTxt.heightAnchor.constraint(equalToConstant: 40),
            passwordTxt.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            passwordTxt.topAnchor.constraint(equalTo: rectrangleView.topAnchor,constant: 160)
        ])
    }
    

}


