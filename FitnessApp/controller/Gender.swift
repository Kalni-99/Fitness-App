//
//  Gender.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-13.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Gender: UIViewController {
    
    let genderTopic = UILabel()
    let optionLbl = UILabel()
    
    let rectrangleView1 = UIView()
    let maleLbl = UILabel()
    let radioButton = UIButton()
    
    let rectrangleView2 = UIView()
    let femaleLbl = UILabel()
    let radioButton1 = UIButton()
    
    let rectrangleView3 = UIView()
    let otherLbl = UILabel()
    let radioButton2 = UIButton()
    
    let continueBtn = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureGenderTopic()
        configureOptionLbl()
        
        setupMaleContainer()
        setupFemaleContainer()
        setupOtherContainer()
        
        configureContinueBtn()
        
    }
    
    func configureGenderTopic(){
        genderTopic.text = "Choose gender"
        genderTopic.textAlignment = .center
        genderTopic.textColor = .white
        genderTopic.font = UIFont(name: genderTopic.font.fontName, size: 24)
        genderTopic.translatesAutoresizingMaskIntoConstraints = false
        
        setUpGenderLbl()
    }
    
    func setUpGenderLbl(){
        self.view.addSubview(genderTopic)
        
        NSLayoutConstraint.activate([
            
            genderTopic.widthAnchor.constraint(equalToConstant: 350),
            genderTopic.heightAnchor.constraint(equalToConstant: 40),
            genderTopic.centerXAnchor.constraint(equalTo: genderTopic.centerXAnchor),
            ])
        genderTopic.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
    
    func configureOptionLbl(){
        optionLbl.text = "Select option that apply"
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

    //male container
    func setupMaleContainer(){
        let imageName = "male.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView1.addSubview(imageView)
        
        rectrangleView1.frame = CGRect(x:60, y: 200, width: 280 , height: 60)
        rectrangleView1.backgroundColor = UIColor.gray
        rectrangleView1.layer.opacity = 0.5
        rectrangleView1.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView1)
        
        maleLbl.text = "Male"
        maleLbl.textAlignment = .center
        maleLbl.textColor = .white
        maleLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView1.addSubview(maleLbl)
        NSLayoutConstraint.activate([
            
            maleLbl.widthAnchor.constraint(equalToConstant: 350),
            maleLbl.heightAnchor.constraint(equalToConstant: 40),
            maleLbl.centerXAnchor.constraint(equalTo: rectrangleView1.centerXAnchor),
            maleLbl.centerYAnchor.constraint(equalTo: rectrangleView1.centerYAnchor),
            ])

        
        
        radioButton.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton.addTarget(self, action: #selector(maleCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView1.addSubview(radioButton)
        
    }
    @objc func maleCheckboxButtonTapped() -> String{
        radioButton.isSelected = !radioButton.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton.isSelected {
            return "nil"
        }else{
            let gender = "male"
            return gender
        }
       
    }

    
    //female container
    func setupFemaleContainer(){
        let imageName = "female.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView2.addSubview(imageView)
        
        rectrangleView2.frame = CGRect(x:60, y: 300, width: 280 , height: 60)
        rectrangleView2.backgroundColor = UIColor.gray
        rectrangleView2.layer.opacity = 0.5
        rectrangleView2.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView2)
        
        femaleLbl.text = "Female"
        femaleLbl.textAlignment = .center
        femaleLbl.textColor = .white
        femaleLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView2.addSubview(femaleLbl)
        NSLayoutConstraint.activate([
            
            femaleLbl.widthAnchor.constraint(equalToConstant: 350),
            femaleLbl.heightAnchor.constraint(equalToConstant: 40),
            femaleLbl.centerXAnchor.constraint(equalTo: rectrangleView2.centerXAnchor),
            femaleLbl.centerYAnchor.constraint(equalTo: rectrangleView2.centerYAnchor),
            ])

        
        
        radioButton1.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton1.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton1.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton1.addTarget(self, action: #selector(femaleCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView2.addSubview(radioButton1)
    }
    
    @objc func femaleCheckboxButtonTapped() -> String{
        radioButton1.isSelected = !radioButton1.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton1.isSelected {
            return "nil"
        }
        else{
            let gender = "female"
            return gender
        }
    }
    
    //other container
    func setupOtherContainer(){
        let imageName = "third-gender.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView3.addSubview(imageView)
        
        rectrangleView3.frame = CGRect(x:60, y: 400, width: 280 , height: 60)
        rectrangleView3.backgroundColor = UIColor.gray
        rectrangleView3.layer.opacity = 0.5
        rectrangleView3.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView3)
        
        otherLbl.text = "Other"
        otherLbl.textAlignment = .center
        otherLbl.textColor = .white
        otherLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView3.addSubview(otherLbl)
        NSLayoutConstraint.activate([
            
            otherLbl.widthAnchor.constraint(equalToConstant: 350),
            otherLbl.heightAnchor.constraint(equalToConstant: 40),
            otherLbl.centerXAnchor.constraint(equalTo: rectrangleView3.centerXAnchor),
            otherLbl.centerYAnchor.constraint(equalTo: rectrangleView3.centerYAnchor),
            ])

        
        
        radioButton2.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton2.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton2.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton2.addTarget(self, action: #selector(otherCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView3.addSubview(radioButton2)
    }
    
    @objc func otherCheckboxButtonTapped()-> String {
        radioButton2.isSelected = !radioButton2.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton2.isSelected {
            return "nil"
        }
        else{
            let gender = "other"
            return gender
        }
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
        
        
        continueBtn.addTarget(self, action: #selector(gotoGoal), for: .touchUpInside)
    }
    
    @objc func gotoGoal(){
        let val1 = maleCheckboxButtonTapped()
        let val2 = femaleCheckboxButtonTapped()
        let val3 = otherCheckboxButtonTapped()
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        
        if((val1 == "nil") && (val2 == "nil") && (val3 == "nil")){
            let alert = UIAlertController(title: "Error",
                                                  message: "Please select gender to proceed.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
            radioButton.isSelected = false
            radioButton1.isSelected = false
            radioButton2.isSelected = false
        }else{
            if(val1 != "nil"){
                print(val1)
                let docRef = db.collection("user_tbl").document(email!)
                    let data: [String: Any] = [
                        "gender": "male"     // Add more fields as needed
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
            else if(val2 != "nil"){
                    let docRef = db.collection("user_tbl").document(email!)
                    let data: [String: Any] = [
                        "gender": "female"     // Add more fields as needed
                    ]
                    docRef.setData(data) { error in
                        if let error = error {
                            // Handle the error\
                            print("Error writing document: \(error)")
                        } else {
                            // Data written successfully
                            print("Document successfully written")
                        }
                    }
            }
            else if(val3 != "nil"){
                    let docRef = db.collection("user_tbl").document(email!)
                    let data: [String: Any] = [
                        "gender": "other"     // Add more fields as needed
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
            let goal = Goal()
            navigationController?.pushViewController(goal, animated: true)
        }
    }
    
    @IBAction func radioButtonTapped(_ sender: UIButton) {
        radioButton.isSelected = !radioButton.isSelected
    }
}

