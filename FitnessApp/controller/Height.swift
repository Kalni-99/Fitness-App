//
//  Height.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-13.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class Height: UIViewController {
    
    let genderTopic = UILabel()
    let optionLbl = UILabel()
    let toggleSwitch = UISwitch()
    let feetTxt = UILabel()
    let centiTxt = UILabel()
    let heightTxt = UITextField()
    let cmLbl = UILabel()
    
    
    let continueBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureGenderTopic()
        configureOptionLbl()
        configureToggle()
        
        configureFeetTxt()
        configureCentiTxt()
        
        configureHeightTxt()
        configureCmLbl()
        
        configureContinueBtn()
        
    }
    
    func configureGenderTopic(){
        genderTopic.text = "Height"
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
        optionLbl.text = "Enter height in feet or centimeters"
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
    
    func configureFeetTxt(){
        feetTxt.text = "Feet"
        feetTxt.textAlignment = .left
        feetTxt.textColor = .white
        feetTxt.translatesAutoresizingMaskIntoConstraints = false
        
        setUpFeetLbl()
        
    }
    
    func setUpFeetLbl(){
        view.addSubview(feetTxt)
        
        NSLayoutConstraint.activate([
            
            feetTxt.widthAnchor.constraint(equalToConstant: 150),
            feetTxt.heightAnchor.constraint(equalToConstant: 40),
            ])
        feetTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        feetTxt.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 25).isActive = true
        
    }

    func configureCentiTxt(){
        centiTxt.text = "Centimeters"
        centiTxt.textAlignment = .left
        centiTxt.textColor = .white
        centiTxt.translatesAutoresizingMaskIntoConstraints = false
        
        setUpCentiLbl()
        
    }
    
    func setUpCentiLbl(){
        view.addSubview(centiTxt)
        
        NSLayoutConstraint.activate([
            
            centiTxt.widthAnchor.constraint(equalToConstant: 150),
            centiTxt.heightAnchor.constraint(equalToConstant: 40),
            ])
        centiTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        centiTxt.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 20).isActive = true
        
    }
    
    @objc func toggleSwitchValueChanged() -> String{
        
         if toggleSwitch.isOn {
             // Handle toggle switch ON state
             print("Toggle switch is ON")
             cmLbl.text = "Cm"
             return "cm"
             
             
         } else {
             // Handle toggle switch OFF state
             print("Toggle switch is OFF")
             cmLbl.text = "feet"
             return "feet"
             
         }
     }
    
    func configureHeightTxt(){
        heightTxt.returnKeyType = .done
        heightTxt.autocorrectionType = .no
        heightTxt.layer.borderWidth = 1.5
        heightTxt.layer.borderColor = UIColor.white.cgColor
        //heightTxt.placeholder = "00"
        heightTxt.attributedPlaceholder = NSAttributedString(
            string: "00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        heightTxt.autocapitalizationType = .none
        heightTxt.textColor = .white
        heightTxt.textAlignment = .center

        
        setupHeightTxt()
    }
    func setupHeightTxt(){
        self.view.addSubview(heightTxt)
        
        heightTxt.layer.cornerRadius = 5
        heightTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            heightTxt.widthAnchor.constraint(equalToConstant: 80),
            heightTxt.heightAnchor.constraint(equalToConstant: 40),
            //heightTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        heightTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        heightTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
    }
    
    
    func configureCmLbl(){
        cmLbl.text = "feet"
        cmLbl.textAlignment = .center
        cmLbl.textColor = .gray
        cmLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpCmLbl()
    }
    
    func setUpCmLbl(){
        self.view.addSubview(cmLbl)
        
        NSLayoutConstraint.activate([
            
            cmLbl.widthAnchor.constraint(equalToConstant: 350),
            cmLbl.heightAnchor.constraint(equalToConstant: 40),
            //cmLbl.centerXAnchor.constraint(equalTo: cmLbl.centerXAnchor),
            ])
        cmLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        cmLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        
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
        
        
        continueBtn.addTarget(self, action: #selector(gotoHeight), for: .touchUpInside)
    }
    
    @objc func gotoHeight(){
        if let text = heightTxt.text, text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            // The text field is empty
            let alert = UIAlertController(title: "Error",
                                                  message: "Please eneter height to proceed.",
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
            if(val == "cm"){
                print(val)
                let heightCm = heightTxt.text
                
                let validateHeight :Int? = Int(heightTxt.text!)
                if (validateHeight! > 0 && validateHeight! < 200){
                    docRef.updateData(["height_measurement_type": "cm" , "height": heightCm as Any]) { error in
                        if let error = error {
                            // Handle the error
                            print("Error updating document: \(error)")
                        } else {
                            // Field added successfully
                            print("Field successfully added")
                        }
                    }
                }
                else{
                    let alert = UIAlertController(title: "Error",
                                                          message: "Please eneter a valid height to proceed.",
                                                          preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            present(alert, animated: true, completion: nil)
                }

            }
            else if(val == "feet"){
                print(val)
                let heightFeet = heightTxt.text
                let floatHeight = Float(heightFeet!)
                if(floatHeight! > 0 && floatHeight! < 7){
                    let heightInCentimeters = floatHeight! * 30.48
                    docRef.updateData(["height_measurement_type": "feet" , "height": String(heightInCentimeters) as Any]) { error in
                        if let error = error {
                            // Handle the error
                            print("Error updating document: \(error)")
                        } else {
                            // Field added successfully
                            print("Field successfully added")
                        }
                    }
                }else{
                    let alert = UIAlertController(title: "Error",
                                                          message: "Please eneter a valid height to proceed.",
                                                          preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            present(alert, animated: true, completion: nil)
                }
                }

            }
            
            let prev_weight = PrevWeight()
            prev_weight.title = "Current weight"
            navigationController?.pushViewController(prev_weight, animated: true)
        }
        
    }



