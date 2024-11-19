//
//  Username.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-16.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Username: UIViewController {
    
    let usernameTopic = UILabel()
    let optionLbl = UILabel()
    let toggleSwitch = UISwitch()
    let feetTxt = UILabel()
    let centiTxt = UILabel()
    let userTxt = UITextField()
    let cmLbl = UILabel()
    
    
    let continueBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureUserTopic()
        configureOptionLbl()
    
        
        configureUserTxt()
        
        configureContinueBtn()
        
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_exe_tbl")
        let docRef = db.collection("user_exe_tbl").document(email!)
        let data: [String: Any] = [
            "burned_calories" : 0 ,
            "total_exercise_hrs" : 0// Add more fields as needed
        ]
        docRef.setData(data) { error in
            if let error = error {
                // Handle the error
                print("Error writing document: \(error)")
            } else {
                // Data written successfully
                print("Document successfully written")
            }
        }
                
    }
    
    func configureUserTopic(){
        usernameTopic.text = "Username"
        usernameTopic.textAlignment = .center
        usernameTopic.textColor = .white
        usernameTopic.font = UIFont(name: usernameTopic.font.fontName, size: 24)
        usernameTopic.translatesAutoresizingMaskIntoConstraints = false
        
        setUpUsernameLbl()
    }
    
    func setUpUsernameLbl(){
        self.view.addSubview(usernameTopic)
        
        NSLayoutConstraint.activate([
            
            usernameTopic.widthAnchor.constraint(equalToConstant: 350),
            usernameTopic.heightAnchor.constraint(equalToConstant: 40),
            usernameTopic.centerXAnchor.constraint(equalTo: usernameTopic.centerXAnchor),
            ])
        usernameTopic.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
    
    func configureOptionLbl(){
        optionLbl.text = "Enter a name to continue"
        optionLbl.textAlignment = .center
        optionLbl.textColor = .gray
        optionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpOptionLbl()
    }
    
    func setUpOptionLbl(){
        self.view.addSubview(optionLbl)
        
        NSLayoutConstraint.activate([
            
            optionLbl.widthAnchor.constraint(equalToConstant: 350),
            optionLbl.heightAnchor.constraint(equalToConstant: 40),
            optionLbl.centerXAnchor.constraint(equalTo: optionLbl.centerXAnchor),
            ])
        optionLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        
    }
    
    func configureUserTxt(){
        userTxt.returnKeyType = .done
        userTxt.autocorrectionType = .no
        userTxt.layer.borderWidth = 1.5
        userTxt.layer.borderColor = UIColor.white.cgColor
        //userTxt.placeholder = "Username"
        userTxt.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        userTxt.autocapitalizationType = .none
        userTxt.textColor = .white
        userTxt.textAlignment = .center

        
        setupUserTxt()
    }
    func setupUserTxt(){
        self.view.addSubview(userTxt)
        
        userTxt.layer.cornerRadius =  20
        userTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            userTxt.widthAnchor.constraint(equalToConstant: 350),
            userTxt.heightAnchor.constraint(equalToConstant: 50),
            //heightTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        userTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        userTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //userTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
    }

    //continue button
    func configureContinueBtn(){
        continueBtn.configuration = .gray()
        continueBtn.configuration?.baseForegroundColor = .black
        continueBtn.configuration?.cornerStyle = .medium
        continueBtn.layer.borderWidth = 1
        continueBtn.layer.borderColor = UIColor.orange.cgColor
        continueBtn.layer.backgroundColor = UIColor.orange.cgColor

        continueBtn.setTitle("Continue", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        continueBtn.semanticContentAttribute = .forceRightToLeft
        
        setupContinueBtn()
    }
    
    func setupContinueBtn(){
        self.view.addSubview(continueBtn)
        
        continueBtn.layer.cornerRadius = 20
        
        continueBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            continueBtn.widthAnchor.constraint(equalToConstant: 320),
            continueBtn.heightAnchor.constraint(equalToConstant: 50),
            continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        continueBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -111).isActive = true
        /*loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true*/
        
        continueBtn.addTarget(self, action: #selector(gotoHome), for: .touchUpInside)

    }
    
    @objc func gotoHome(){
        if let text = userTxt.text, text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            // The text field is empty
            let alert = UIAlertController(title: "Error",
                                                  message: "Please eneter an username to proceed.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
        } else {
            // The text field has a non-empty value
            let currentDate = Date()

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium

            let formattedDate = dateFormatter.string(from: currentDate)
            print("Current date: \(formattedDate)")
            
            let db = Firestore.firestore()
            let currentUser = Auth.auth().currentUser
            let email = currentUser?.email
            let collectionRef = db.collection("user_tbl")
            let docRef = collectionRef.document(email!)
            docRef.updateData(["username": userTxt.text , "joined_date": formattedDate as Any]) { error in
                if let error = error {
                    // Handle the error
                    print("Error updating document: \(error)")
                } else {
                    // Field added successfully
                    print("Field successfully added")
                }
            }
            
            let home = Home()
            home.title = "Home"
            navigationController?.pushViewController(home, animated: true)
            
        }
    }
}
