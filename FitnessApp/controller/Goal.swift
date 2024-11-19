//
//  Goal.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-13.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class Goal: UIViewController {
    
    let genderTopic = UILabel()
    let optionLbl = UILabel()
    
    let rectrangleView1 = UIView()
    let fitLbl = UILabel()
    let radioButton = UIButton()
    
    let rectrangleView2 = UIView()
    let weightLbl = UILabel()
    let radioButton1 = UIButton()
    
    let rectrangleView3 = UIView()
    let strongLbl = UILabel()
    let radioButton2 = UIButton()
    
    let rectrangleView4 = UIView()
    let muscleLbl = UILabel()
    let radioButton3 = UIButton()
    
    let continueBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureGenderTopic()
        configureOptionLbl()
        
        setupFitContainer()
        setupWeightContainer()
        setupStrongContainer()
        setupMusleContainer()
        
        configureContinueBtn()
        
    }
    
    func configureGenderTopic(){
        genderTopic.text = "Choose main goal"
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

    //fit container
    func setupFitContainer(){
        let imageName = "fruit.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView1.addSubview(imageView)
        
        rectrangleView1.frame = CGRect(x:60, y: 200, width: 280 , height: 60)
        rectrangleView1.backgroundColor = UIColor.gray
        rectrangleView1.layer.opacity = 0.5
        rectrangleView1.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView1)
        
        fitLbl.text = "Keep it fit"
        fitLbl.textAlignment = .center
        fitLbl.textColor = .white
        fitLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView1.addSubview(fitLbl)
        NSLayoutConstraint.activate([
            
            fitLbl.widthAnchor.constraint(equalToConstant: 350),
            fitLbl.heightAnchor.constraint(equalToConstant: 40),
            fitLbl.centerXAnchor.constraint(equalTo: rectrangleView1.centerXAnchor),
            fitLbl.centerYAnchor.constraint(equalTo: rectrangleView1.centerYAnchor),
            ])

        
        
        radioButton.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton.addTarget(self, action: #selector(fitCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView1.addSubview(radioButton)
    }
    @objc func fitCheckboxButtonTapped()-> String {
        radioButton.isSelected = !radioButton.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton.isSelected {
            return "nil"
        }
        else{
            let goal = "Keep it fit"
            return goal
        }
    }
    
    //weight container
    func setupWeightContainer(){
        let imageName = "weight.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView2.addSubview(imageView)
        
        rectrangleView2.frame = CGRect(x:60, y: 300, width: 280 , height: 60)
        rectrangleView2.backgroundColor = UIColor.gray
        rectrangleView2.layer.opacity = 0.5
        rectrangleView2.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView2)
        
        weightLbl.text = "Loose weight"
        weightLbl.textAlignment = .center
        weightLbl.textColor = .white
        weightLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView2.addSubview(weightLbl)
        NSLayoutConstraint.activate([
            
            weightLbl.widthAnchor.constraint(equalToConstant: 350),
            weightLbl.heightAnchor.constraint(equalToConstant: 40),
            weightLbl.centerXAnchor.constraint(equalTo: rectrangleView2.centerXAnchor),
            weightLbl.centerYAnchor.constraint(equalTo: rectrangleView2.centerYAnchor),
            ])

        
        
        radioButton1.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton1.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton1.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton1.addTarget(self, action: #selector(weightCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView2.addSubview(radioButton1)
    }
    @objc func weightCheckboxButtonTapped()-> String {
        radioButton1.isSelected = !radioButton1.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton1.isSelected {
            return "nil"
        }
        else{
            let goal = "Loose weight"
            return goal
        }
    }
    
    //strong container
    func setupStrongContainer(){
        let imageName = "dumbell.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView3.addSubview(imageView)
        
        rectrangleView3.frame = CGRect(x:60, y: 400, width: 280 , height: 60)
        rectrangleView3.backgroundColor = UIColor.gray
        rectrangleView3.layer.opacity = 0.5
        rectrangleView3.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView3)
        
        strongLbl.text = "Get stronger"
        strongLbl.textAlignment = .center
        strongLbl.textColor = .white
        strongLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView3.addSubview(strongLbl)
        NSLayoutConstraint.activate([
            
            strongLbl.widthAnchor.constraint(equalToConstant: 350),
            strongLbl.heightAnchor.constraint(equalToConstant: 40),
            strongLbl.centerXAnchor.constraint(equalTo: rectrangleView3.centerXAnchor),
            strongLbl.centerYAnchor.constraint(equalTo: rectrangleView3.centerYAnchor),
            ])

        
        
        radioButton2.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton2.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton2.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton2.addTarget(self, action: #selector(strongCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView3.addSubview(radioButton2)
    }
    @objc func strongCheckboxButtonTapped()-> String {
        radioButton2.isSelected = !radioButton2.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton2.isSelected {
            return "nil"
        }
        else{
            let goal = "Get stronger"
            return goal
        }
    }
    //muscle container
    func setupMusleContainer(){
        let imageName = "muscles.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 20, y: 5, width: 50, height: 50)
        rectrangleView4.addSubview(imageView)
        
        rectrangleView4.frame = CGRect(x:60, y: 500, width: 280 , height: 60)
        rectrangleView4.backgroundColor = UIColor.gray
        rectrangleView4.layer.opacity = 0.5
        rectrangleView4.layer.cornerRadius = 10
        self.view.addSubview(rectrangleView4)
        
        muscleLbl.text = "Gain muscle mass"
        muscleLbl.textAlignment = .center
        muscleLbl.textColor = .white
        muscleLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleView4.addSubview(muscleLbl)
        NSLayoutConstraint.activate([
            
            muscleLbl.widthAnchor.constraint(equalToConstant: 350),
            muscleLbl.heightAnchor.constraint(equalToConstant: 40),
            muscleLbl.centerXAnchor.constraint(equalTo: rectrangleView4.centerXAnchor),
            muscleLbl.centerYAnchor.constraint(equalTo: rectrangleView4.centerYAnchor),
            ])

        
        
        radioButton3.frame = CGRect(x:200, y: -20, width: 100 , height: 100)
        radioButton3.setImage(UIImage.init(named: "unselected_radio.png"), for: .normal)
        radioButton3.setImage(UIImage.init(named: "selected_radio.png"), for: .selected)
        radioButton3.addTarget(self, action: #selector(muscleCheckboxButtonTapped), for: .touchUpInside)
        rectrangleView4.addSubview(radioButton3)
    }
    @objc func muscleCheckboxButtonTapped()-> String {
        radioButton3.isSelected = !radioButton3.isSelected
        
        // Perform any additional actions based on the checkbox state
        if radioButton3.isSelected {
            return "nil"
        }
        else{
            let goal = "Gain muscle mass"
            return goal
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
        
        
        continueBtn.addTarget(self, action: #selector(gotoHeight), for: .touchUpInside)
    }
    
    @objc func gotoHeight(){
        let val1 = fitCheckboxButtonTapped()
        let val2 = weightCheckboxButtonTapped()
        let val3 = strongCheckboxButtonTapped()
        let val4 = muscleCheckboxButtonTapped()
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = collectionRef.document(email!)
        
        if((val1 == "nil") && (val2 == "nil") && (val3 == "nil") && (val4 == "nil")){
            let alert = UIAlertController(title: "Error",
                                                  message: "Please select goal to proceed.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
            radioButton.isSelected = false
            radioButton1.isSelected = false
            radioButton2.isSelected = false
            radioButton3.isSelected = false
            
        }else{
            if(val1 != "nil"){
                print(val1)
                docRef.updateData(["goal": "Keep it fit"]) { error in
                    if let error = error {
                        // Handle the error
                        print("Error updating document: \(error)")
                    } else {
                        // Field added successfully
                        print("Field successfully added")
                    }
                }
            }
            else if(val2 != "nil"){
                docRef.updateData(["goal": "Loose weight"]) { error in
                    if let error = error {
                        // Handle the error
                        print("Error updating document: \(error)")
                    } else {
                        // Field added successfully
                        print("Field successfully added")
                    }
                }
            }
            else if(val3 != "nil"){
                docRef.updateData(["goal": "Get stronger"]) { error in
                    if let error = error {
                        // Handle the error
                        print("Error updating document: \(error)")
                    } else {
                        // Field added successfully
                        print("Field successfully added")
                    }
                }
            }
            else if(val4 != "nil"){
                docRef.updateData(["goal": "Gain muscle mass"]) { error in
                    if let error = error {
                        // Handle the error
                        print("Error updating document: \(error)")
                    } else {
                        // Field added successfully
                        print("Field successfully added")
                    }
                }
            }
            let height = Height()
            navigationController?.pushViewController(height, animated: true)
        }

    }
    
    @IBAction func radioButtonTapped(_ sender: UIButton) {
        radioButton.isSelected = !radioButton.isSelected
    }
}

