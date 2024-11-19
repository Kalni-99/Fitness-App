//
//  AftWeight.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-13.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AftWeight: UIViewController {
    
    let weightTopic = UILabel()
    let optionLbl = UILabel()
    let toggleSwitch = UISwitch()
    let poundTxt = UILabel()
    let kgTxt = UILabel()
    let weightTxt = UITextField()
    let motiLbl1 = UILabel()
    let difWeightTxt = UILabel()
    let motiLbl2 = UILabel()
    let lbsLbl = UILabel()
    
    
    let continueBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureWeightTopic()
        configureOptionLbl()
        configureToggle()
        
        configurePoundTxt()
        configureKgTxt()
        
        configureWeightTxt()
        configureLbsLbl()
        
        configureMotiLbl1()
        configureDifWeightTxt()
        configureMotiLbl2()
        
        configureContinueBtn()
        
    }
    
    func configureWeightTopic(){
        weightTopic.text = "Target weight"
        weightTopic.textAlignment = .center
        weightTopic.textColor = .white
        weightTopic.font = UIFont(name: weightTopic.font.fontName, size: 24)
        weightTopic.translatesAutoresizingMaskIntoConstraints = false
        
        setUpWeightLbl()
    }
    
    func setUpWeightLbl(){
        self.view.addSubview(weightTopic)
        
        NSLayoutConstraint.activate([
            
            weightTopic.widthAnchor.constraint(equalToConstant: 350),
            weightTopic.heightAnchor.constraint(equalToConstant: 40),
            weightTopic.centerXAnchor.constraint(equalTo: weightTopic.centerXAnchor),
            ])
        weightTopic.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
    
    func configureOptionLbl(){
        optionLbl.text = "Enter target weight in ponds or killos"
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
    
    func configureToggle(){
        // Customize the toggle switch properties
               toggleSwitch.isOn = false
               toggleSwitch.addTarget(self, action: #selector(toggleSwitchValueChanged), for: .valueChanged)
        view.addSubview(toggleSwitch)
        // Position and size the toggle switch using Auto Layout or frame-based layout
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        toggleSwitch.onTintColor = UIColor.orange
        toggleSwitch.thumbTintColor = UIColor.gray
        
        let newSwitchSize = CGSize(width: 100, height: 50)
                toggleSwitch.transform = CGAffineTransform(scaleX: newSwitchSize.width / toggleSwitch.bounds.size.width,
                                                            y: newSwitchSize.height / toggleSwitch.bounds.size.height)
        toggleSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        toggleSwitch.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 170).isActive = true

    }
    
    func configurePoundTxt(){
        poundTxt.text = "Pounds"
        poundTxt.textAlignment = .left
        poundTxt.textColor = .white
        poundTxt.translatesAutoresizingMaskIntoConstraints = false
        
        setUpPoundLbl()
        
    }
    
    func setUpPoundLbl(){
        view.addSubview(poundTxt)
        
        NSLayoutConstraint.activate([
            
            poundTxt.widthAnchor.constraint(equalToConstant: 150),
            poundTxt.heightAnchor.constraint(equalToConstant: 40),
            ])
        poundTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        poundTxt.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 25).isActive = true
        
    }

    func configureKgTxt(){
        kgTxt.text = "Killo grams"
        kgTxt.textAlignment = .left
        kgTxt.textColor = .white
        kgTxt.translatesAutoresizingMaskIntoConstraints = false
        
        setUpKgLbl()
        
    }
    
    func setUpKgLbl(){
        view.addSubview(kgTxt)
        
        NSLayoutConstraint.activate([
            
            kgTxt.widthAnchor.constraint(equalToConstant: 150),
            kgTxt.heightAnchor.constraint(equalToConstant: 40),
            ])
        kgTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        kgTxt.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 20).isActive = true
        
    }
    
    @objc func toggleSwitchValueChanged() -> String{
         if toggleSwitch.isOn {
             // Handle toggle switch ON state
             //print("Toggle switch is ON")
             lbsLbl.text = "Kg"
             return "killos"
         } else {
             // Handle toggle switch OFF state
             //print("Toggle switch is OFF")
             lbsLbl.text = "Lbs"
             return "pounds"
         }
     }
    
    func configureWeightTxt(){
        weightTxt.returnKeyType = .done
        weightTxt.autocorrectionType = .no
        weightTxt.layer.borderWidth = 1.5
        weightTxt.layer.borderColor = UIColor.white.cgColor
        //weightTxt.placeholder = "00"
        weightTxt.attributedPlaceholder = NSAttributedString(
            string: "00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        weightTxt.autocapitalizationType = .none
        weightTxt.textColor = .white
        weightTxt.textAlignment = .center

        
        setupWeightTxt()
    }
    func setupWeightTxt(){
        self.view.addSubview(weightTxt)
        
        weightTxt.layer.cornerRadius = 5
        weightTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            weightTxt.widthAnchor.constraint(equalToConstant: 80),
            weightTxt.heightAnchor.constraint(equalToConstant: 40),
            //heightTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        weightTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        weightTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
    }
    
    
    func configureLbsLbl(){
        lbsLbl.text = "Lbs"
        lbsLbl.textAlignment = .center
        lbsLbl.textColor = .gray
        lbsLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpLbsLbl()
    }
    
    func setUpLbsLbl(){
        self.view.addSubview(lbsLbl)
        
        NSLayoutConstraint.activate([
            
            lbsLbl.widthAnchor.constraint(equalToConstant: 350),
            lbsLbl.heightAnchor.constraint(equalToConstant: 40),
            //cmLbl.centerXAnchor.constraint(equalTo: cmLbl.centerXAnchor),
            ])
        lbsLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        lbsLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        
    }
    
    func configureMotiLbl1(){
        //motiLbl1.text = "I want to lose"
        motiLbl1.textAlignment = .left
        motiLbl1.textColor = .gray
        motiLbl1.translatesAutoresizingMaskIntoConstraints = false
        
        setUpMoti1Lbl1()
    }
    
    func setUpMoti1Lbl1(){
        self.view.addSubview(motiLbl1)
        
        NSLayoutConstraint.activate([
            
            motiLbl1.widthAnchor.constraint(equalToConstant: 350),
            motiLbl1.heightAnchor.constraint(equalToConstant: 40),
            ])
        motiLbl1.topAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        motiLbl1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35).isActive = true
        
    }
    
    func configureDifWeightTxt(){
        //difWeightTxt.text = "8"
        difWeightTxt.textAlignment = .left
        difWeightTxt.textColor = .white
        difWeightTxt.translatesAutoresizingMaskIntoConstraints = false
        
        setUpDifWeightTxt()
    }
    
    func setUpDifWeightTxt(){
        self.view.addSubview(difWeightTxt)
        
        NSLayoutConstraint.activate([
            
            difWeightTxt.widthAnchor.constraint(equalToConstant: 100),
            difWeightTxt.heightAnchor.constraint(equalToConstant: 40),
            ])
        difWeightTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        difWeightTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 145).isActive = true
        
    }
    
    func configureMotiLbl2(){
        //motiLbl2.text = "kg from the current weight"
        motiLbl2.textAlignment = .right
        motiLbl2.textColor = .gray
        motiLbl2.translatesAutoresizingMaskIntoConstraints = false
        
        setUpMoti1Lbl2()
    }
    
    func setUpMoti1Lbl2(){
        self.view.addSubview(motiLbl2)
        
        NSLayoutConstraint.activate([
            
            motiLbl2.widthAnchor.constraint(equalToConstant: 350),
            motiLbl2.heightAnchor.constraint(equalToConstant: 40),
            ])
        motiLbl2.topAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        motiLbl2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
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
        
        
        continueBtn.addTarget(self, action: #selector(gotoAftWeight), for: .touchUpInside)
    }
    
    @objc func gotoAftWeight(){
        
        if let text = weightTxt.text, text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            // The text field is empty
            let alert = UIAlertController(title: "Error",
                                                  message: "Please eneter target weight to proceed.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
        }else{
            let val = toggleSwitchValueChanged()
            let db = Firestore.firestore()
            let currentUser = Auth.auth().currentUser
            let email = currentUser?.email
            let collectionRef = db.collection("user_tbl")
            let docRef = collectionRef.document(email!)
            if(val == "killos"){
                //print(val)
                let weightKg = weightTxt.text
                docRef.updateData(["measurement_type": "kg" , "target_weight": weightKg as Any]) { error in
                    if let error = error {
                        // Handle the error
                        print("Error updating document: \(error)")
                    } else {
                        // Field added successfully
                        print("Field successfully added")
                        self.getBMIData()
                    }
                }
            }
            else if(val == "pounds"){
                //print(val)
                let weightPound = weightTxt.text
                let floatWeight = Float(weightPound!)!
                let weightInKilograms = floatWeight * 0.45359237
                docRef.updateData(["measurement_type": "lbs" , "target_weight": weightInKilograms as Any]) { error in
                    if let error = error {
                        // Handle the error
                        print("Error updating document: \(error)")
                    } else {
                        // Field added successfully
                        print("Field successfully added")
                        self.getBMIData()
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                // Code to be executed after the delay
                let home = Username()
                home.title = "Username"
                self.navigationController?.pushViewController(home, animated: true)
            }
            
        }
        
    }
    
    func getBMIData(){
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = collectionRef.document(email!)
        db.collection("user_tbl").document(email!).getDocument {(document, error) in
            if let document = document, document.exists {
                let data = document.data()
                //print(data as Any)
                db.collection("user_tbl").document(email!).getDocument {(document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        
                        if let StrHeight = data?["height"] as? String {
                            print("Height: \(StrHeight)")
                            if let StrWeight = data?["weight"] as? String {
                                print("Weight: \(StrWeight)")
                                let FloatHeight = Float(StrHeight)
                                let Floatweight = Float(StrWeight)
                                let heightInMeters = FloatHeight! / 100
                                let BMI_val : Float =  (Floatweight! / (heightInMeters * heightInMeters))
                                print(BMI_val)
                                docRef.updateData(["BMI": BMI_val as Any]) { error in
                                    if let error = error {
                                        // Handle the error
                                        print("Error updating document: \(error)")
                                    } else {
                                        // Field added successfully
                                        print("BMI successfully added")
                                    }
                                }
                            }
                        }
                    } else {
                        print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
                //print(data as Any)

            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

}

