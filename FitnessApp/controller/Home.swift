//
//  Landing.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-16.
//

import UIKit
import Firebase
import FirebaseAuth
import EventKit
import UserNotifications
import CoreMotion

class Home: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        self.tabBar.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        //create instance of view controller
        let landing = Landing()
        let notify = NotifyVC()
        let profile = AccountVC()
        
        
        //ssign view controller to tab bar
        self.setViewControllers([landing,notify,profile], animated: false)
        
        guard let items = self.tabBar.items else{
            return
        }
        let images = ["house","bell","brain.head.profile"]
        
        for x in 0...2{
            items[x].image = UIImage(systemName: images[x])
        }
        
        //change tint color
        self.tabBar.tintColor = .orange
    }

}
//////////////////////
class NotifyVC: UIViewController
{
    
    let notificationCenter = UNUserNotificationCenter.current()
    let stackView = UIStackView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .black
        
        setupViewsDatePicker()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("Permission Denied")
            }
        }
        reminderTextField.text = nil
        bodyTextField.text = nil
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        db.collection("reminder_tbl").document(email!).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                if let title = data?["title"] as? String {
                    if(title != nil){
                        let cardView = UIView(frame: CGRect(x: 20.0, y: 360, width: 350, height: 60.0))
                        cardView.backgroundColor = .gray
                        cardView.layer.cornerRadius = 10.0
                        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                        cardView.layer.shadowRadius = 2.0
                        cardView.layer.shadowOpacity = 0.2
                        cardView.layer.opacity = 0.5
                        view.addSubview(cardView)
                        
                        
                        let imageName = "bell.png"
                        let image = UIImage(named: imageName)
                        let imageView = UIImageView(image: image!)
                        imageView.frame = CGRect(x: 15.0, y: 14.0, width: 22.0, height: 25.0)
                        cardView.addSubview(imageView)
                        
                        var label1 = UILabel()
                        label1 = UILabel(frame: CGRect(x: 120.0, y: 10.0, width: cardView.frame.width - 70.0, height: 30.0))
                        label1.text = reminderTextField.text
                        label1.textColor = .darkGray
                        label1.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
                        cardView.addSubview(label1)
                        label1.text = title
                    }
                }

            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    private var selectedDate: Date?
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .dateAndTime
        //datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()

    private func setupViewsDatePicker() {
        // ...
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            // ...
            datePicker.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private lazy var reminderTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.autocapitalizationType = .none
        textField.textColor = .white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Reminder"
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private lazy var bodyTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.autocapitalizationType = .none
        textField.textColor = .white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Body"
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .gray()
        button.configuration?.cornerStyle = .medium
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.backgroundColor = UIColor.orange.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setTitle("Add Reminder", for: .normal)
        button.addTarget(self, action: #selector(scheduleAction), for: .touchUpInside)
        return button
    }()
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(bodyTextField)
        view.addSubview(reminderTextField)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            bodyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bodyTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -220),
            bodyTextField.widthAnchor.constraint(equalToConstant: 320),
            bodyTextField.heightAnchor.constraint(equalToConstant: 50),
            
            reminderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reminderTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -280),
            reminderTextField.widthAnchor.constraint(equalToConstant: 320),
            reminderTextField.heightAnchor.constraint(equalToConstant: 50),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160),    addButton.widthAnchor.constraint(equalToConstant: 320),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    

    
    @objc func scheduleAction(_ sender: Any)
    {
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async
            { [self] in
                let title = self.reminderTextField.text!
                let message = self.bodyTextField.text!
                let date = self.datePicker.date
                
                if(settings.authorizationStatus == .authorized)
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { (error) in
                        if(error != nil)
                        {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                    let ac = UIAlertController(title: "Notification Scheduled", message: "At " + self.formattedDate(date: date), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                    self.present(ac, animated: true)
                    
                    let db = Firestore.firestore()
                    let currentUser = Auth.auth().currentUser
                    let email = currentUser?.email
                        let docRef = db.collection("reminder_tbl").document(email!)
                            let data: [String: Any] = [
                                "title": reminderTextField.text as Any,
                                "body" : bodyTextField.text as Any,
                                "stste" : true
                                // Add more fields as needed
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
                    db.collection("reminder_tbl").document(email!).getDocument { [self] (document, error) in
                        if let document = document, document.exists {
                            let data = document.data()
                            
                            if let title = data?["title"] as? String {
                                let cardView = UIView(frame: CGRect(x: 20.0, y: 360, width: 350, height: 60.0))
                                cardView.backgroundColor = .gray
                                cardView.layer.cornerRadius = 10.0
                                cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                                cardView.layer.shadowRadius = 2.0
                                cardView.layer.shadowOpacity = 0.2
                                cardView.layer.opacity = 0.5
                                view.addSubview(cardView)
                                
                                
                                let imageName = "bell.png"
                                let image = UIImage(named: imageName)
                                let imageView = UIImageView(image: image!)
                                imageView.frame = CGRect(x: 15.0, y: 14.0, width: 22.0, height: 25.0)
                                cardView.addSubview(imageView)
                                
                                var label1 = UILabel()
                                label1 = UILabel(frame: CGRect(x: 120.0, y: 10.0, width: cardView.frame.width - 70.0, height: 30.0))
                                label1.text = ""
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    label1.text = title
                                    label1.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
                                    cardView.addSubview(label1)
                                }
                                
                                reminderTextField.text = nil
                                bodyTextField.text = nil
                            }

                        } else {
                            print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
                        }
                    }
                    
                    
                }
                else
                {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default)
                    { (_) in
                        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString)
                        else
                        {
                            return
                        }
                        
                        if(UIApplication.shared.canOpenURL(setttingsURL))
                        {
                            UIApplication.shared.open(setttingsURL) { (_) in}
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in}))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
    
}
//////////////////////

class AccountVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let userLbl = UILabel();
    let joinTimeLbl = UILabel();
    let dateLbl = UILabel();
    let imageButton = UIButton()
    
    let rectrangleTotHr = UIView()
    let totLbl = UILabel();
    let totValLbl = UILabel();
    
    let rectrangleBMI = UIView()
    let BMILbl = UILabel();
    let BMIValLbl = UILabel();
    
    let usernameTxt = UITextField()
    let saveBtn = UIButton();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Profile"
        
        let imageName = "user-3.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        //imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 120, y: 150, width: 160, height: 160)
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        configureLoginLableText()
        configureImgBtn()
        configureJoinTimeLbl()
        configureDateLbl()
        
        setupTotHrContainer()
        setupBMIContainer()
        
        configureUsernameTxt()
        configureSaveBtn()
        
        getTotHrs()
        
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = collectionRef.document(email!)
        db.collection("user_tbl").document(email!).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                if let bmi = data?["BMI"] as? Float {
                    print("BMI: \(bmi)")
                    BMIValLbl.text = String(bmi)
                }
                if let name = data?["username"] as? String {
                    print("Name: \(name)")
                    userLbl.text = String(name)
                }
                if let joinDate = data?["joined_date"] as? String {
                    //print("Join date: \(joinDate)")
                    dateLbl.text = String(joinDate)
                }

            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Call your function here
        getTotHrs()
    }
    
    func getTotHrs(){
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_exe_tbl")
        let docRef = collectionRef.document(email!)
        db.collection("user_exe_tbl").document(email!).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                if let hrs = data?["total_exercise_hrs"] as? Int {
                    //print("Total hours: \(hrs)")
                    totValLbl.text = String(hrs)
                }

            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    func configureLoginLableText(){
        userLbl.text = "Minija"
        userLbl.textAlignment = .center
        userLbl.textColor = .white
        userLbl.font = UIFont(name: userLbl.font.fontName, size: 22)
        userLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpUserLable()
    }
    func setUpUserLable(){
        view.addSubview(userLbl)
        
        NSLayoutConstraint.activate([
            
            userLbl.widthAnchor.constraint(equalToConstant: 350),
            userLbl.heightAnchor.constraint(equalToConstant: 40),
            userLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userLbl.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 380)
            ])
    }
    
    func configureImgBtn(){
        imageButton.setImage(UIImage(named: "edit.png"), for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        view.addSubview(imageButton)
        
        setUpImgBtn()
    }
    func setUpImgBtn(){
        
        imageButton.layer.cornerRadius = 20
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageButton.widthAnchor.constraint(equalToConstant: 45),
            imageButton.heightAnchor.constraint(equalToConstant: 45),
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
    }
    
    @objc func imageButtonTapped() {
        // Implement your button tap action here
    }
    
    func configureJoinTimeLbl(){
        joinTimeLbl.text = "Joined"
        joinTimeLbl.textAlignment = .left
        joinTimeLbl.textColor = .gray
        joinTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpJoinTimeLbl()
    }
    func setUpJoinTimeLbl(){
        view.addSubview(joinTimeLbl)
        
        NSLayoutConstraint.activate([
            
            joinTimeLbl.widthAnchor.constraint(equalToConstant: 260),
            joinTimeLbl.heightAnchor.constraint(equalToConstant: 40),
            //joinTimeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinTimeLbl.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 410)
            ])
        joinTimeLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
    }
    func configureDateLbl(){
        dateLbl.text = ""
        dateLbl.textAlignment = .right
        dateLbl.textColor = .gray
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpDateLbl()
    }
    func setUpDateLbl(){
        view.addSubview(dateLbl)
        
        NSLayoutConstraint.activate([
            
            dateLbl.widthAnchor.constraint(equalToConstant: 260),
            dateLbl.heightAnchor.constraint(equalToConstant: 40),
            dateLbl.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 410)
            ])
        dateLbl.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -110).isActive = true
    }
    
    //tot hour container
    func setupTotHrContainer(){
        rectrangleTotHr.frame = CGRect(x:30, y: 420, width: 150 , height: 70)
        rectrangleTotHr.backgroundColor = UIColor.purple
        rectrangleTotHr.layer.opacity = 0.4
        rectrangleTotHr.layer.cornerRadius = 20
        self.view.addSubview(rectrangleTotHr)
        
        totValLbl.text = ""
        totValLbl.textAlignment = .center
        totValLbl.textColor = .white
        totValLbl.font = UIFont(name: totValLbl.font.fontName, size: 24)
        totValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleTotHr.addSubview(totValLbl)
        NSLayoutConstraint.activate([
            
            totValLbl.widthAnchor.constraint(equalToConstant: 350),
            totValLbl.heightAnchor.constraint(equalToConstant: 30),
            totValLbl.centerXAnchor.constraint(equalTo: rectrangleTotHr.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        totValLbl.topAnchor.constraint(equalTo: rectrangleTotHr.topAnchor, constant: 5).isActive = true
        
        totLbl.text = "Total hours"
        totLbl.textAlignment = .center
        totLbl.textColor = .white
        totLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleTotHr.addSubview(totLbl)
        NSLayoutConstraint.activate([
            
            totLbl.widthAnchor.constraint(equalToConstant: 350),
            totLbl.heightAnchor.constraint(equalToConstant: 40),
            totLbl.centerXAnchor.constraint(equalTo: rectrangleTotHr.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        totLbl.topAnchor.constraint(equalTo: rectrangleTotHr.topAnchor, constant: 30).isActive = true
    }
    
    //BMI container
    func setupBMIContainer(){
        rectrangleBMI.frame = CGRect(x:210, y: 420, width: 150 , height: 70)
        rectrangleBMI.backgroundColor = UIColor.purple
        rectrangleBMI.layer.opacity = 0.4
        rectrangleBMI.layer.cornerRadius = 20
        self.view.addSubview(rectrangleBMI)
        
        BMIValLbl.text = ""
        BMIValLbl.textAlignment = .center
        BMIValLbl.textColor = .white
        BMIValLbl.font = UIFont(name: BMIValLbl.font.fontName, size: 24)
        BMIValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleBMI.addSubview(BMIValLbl)
        NSLayoutConstraint.activate([
            
            BMIValLbl.widthAnchor.constraint(equalToConstant: 350),
            BMIValLbl.heightAnchor.constraint(equalToConstant: 30),
            BMIValLbl.centerXAnchor.constraint(equalTo: rectrangleBMI.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        BMIValLbl.topAnchor.constraint(equalTo: rectrangleBMI.topAnchor, constant: 5).isActive = true
        
        BMILbl.text = "BMI"
        BMILbl.textAlignment = .center
        BMILbl.textColor = .white
        BMILbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleBMI.addSubview(BMILbl)
        NSLayoutConstraint.activate([
            
            BMILbl.widthAnchor.constraint(equalToConstant: 350),
            BMILbl.heightAnchor.constraint(equalToConstant: 40),
            BMILbl.centerXAnchor.constraint(equalTo: rectrangleBMI.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        BMILbl.topAnchor.constraint(equalTo: rectrangleBMI.topAnchor, constant: 30).isActive = true
    }
    
    //username
    func configureUsernameTxt(){
        usernameTxt.returnKeyType = .done
        usernameTxt.autocorrectionType = .no
        usernameTxt.layer.borderWidth = 1.5
        usernameTxt.layer.borderColor = UIColor.white.cgColor
        usernameTxt.placeholder = "Username"
        usernameTxt.text = ""
        usernameTxt.autocapitalizationType = .none
        usernameTxt.textColor = .gray
        usernameTxt.textAlignment = .center

        
        SetupUsernameTxt()
    }
    func SetupUsernameTxt(){
        self.view.addSubview(usernameTxt)
        
        usernameTxt.layer.cornerRadius = 20
        usernameTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            usernameTxt.widthAnchor.constraint(equalToConstant: 320),
            usernameTxt.heightAnchor.constraint(equalToConstant: 50),
            usernameTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        usernameTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 550).isActive = true
    }
    
    //save button
    func configureSaveBtn(){
        saveBtn.configuration = .gray()
        saveBtn.configuration?.baseForegroundColor = .black
        saveBtn.configuration?.cornerStyle = .medium
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = UIColor.orange.cgColor
        saveBtn.layer.backgroundColor = UIColor.orange.cgColor

        saveBtn.setTitle("Save", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        saveBtn.semanticContentAttribute = .forceRightToLeft
        
        setupSaveBtn()
    }
    
    func setupSaveBtn(){
        self.view.addSubview(saveBtn)
        
        saveBtn.layer.cornerRadius = 20
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveBtn.widthAnchor.constraint(equalToConstant: 320),
            saveBtn.heightAnchor.constraint(equalToConstant: 50),
            saveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        saveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -111).isActive = true
        /*loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true*/
        
        
        saveBtn.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    
    @objc func saveProfile(){
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = collectionRef.document(email!)
        let user = usernameTxt.text
        docRef.updateData(["username": user as Any]) { error in
            if let error = error {
                // Handle the error
                print("Error updating document: \(error)")
            } else {
                // Field added successfully
                print("Field successfully added")
            }
        }
    }

}

//landing screen
class Landing: UIViewController {
    let userLbl = UILabel()
    
    var rectrangleStep = UIView()
    let stepValLbl = UILabel();
    let stepsLbl = UILabel();
    
    let rectrangleCal = UIView()
    let calLbl = UILabel();
    let calsLbl = UILabel();
    
    var nameLabel = UILabel()
    
    let activityMnager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var Waarmup: [WARMUP] = []
    
    let now = Date()
    let calendar = Calendar.current
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        requestMotionPermission()
        
        
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        print(email as Any)
        //let docRef = collectionRef.document(email!)
        db.collection("user_tbl").document(email!).getDocument { [self](document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                if let bmi = data?["BMI"] as? Float {
                    let db = Firestore.firestore()
                    if(bmi > 40){
                        // Fetch the data from Firestore
                        db.collection("moderate_tbl").getDocuments() { (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                var newWARMUP: [WARMUP] = []
                                for document in querySnapshot!.documents {
                                    let Waarmup = WARMUP(snapshot: document)
                                    newWARMUP.append(Waarmup)
                                }
                                self.Waarmup = newWARMUP
                                self.addCardViews()
                                print("Fetched \(self.Waarmup.count) WARMUP")
                            }
                        }
                    }else if(bmi < 30){
                        // Fetch the data from Firestore
                        db.collection("beginner_tbl").getDocuments() { (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                var newWARMUP: [WARMUP] = []
                                for document in querySnapshot!.documents {
                                    let Waarmup = WARMUP(snapshot: document)
                                    newWARMUP.append(Waarmup)
                                }
                                self.Waarmup = newWARMUP
                                self.addCardViews()
                                print("Fetched \(self.Waarmup.count) WARMUP")
                            }
                        }
                    }
                }

            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        func requestMotionPermission() {
            let activityManager = CMMotionActivityManager()
            let motionPermissionStatus = CMMotionActivityManager.authorizationStatus()

            switch motionPermissionStatus {
            case .authorized:
                // Motion activity tracking is already authorized, proceed with your code
                StartTrackingMotionActivity()
                print("Authorized")
            case .notDetermined:
                // Request permission
                activityManager.queryActivityStarting(from: Date(), to: Date(), to: .main) { (activities, error) in
                    if error == nil {
                        // Permission granted, proceed with your code
                        StartTrackingMotionActivity()
                        print("Authorized")
                    } else {
                        // Permission denied or error occurred
                        // Handle the error or prompt the user to grant permission manually
                    }
                }
            case .denied, .restricted:
                // Motion activity tracking is denied or restricted
                // Handle the denied or restricted state, prompt the user to grant permission manually
                break
            @unknown default:
                break
            }
            
            //createTableField()
        }
        
        func StartTrackingMotionActivity(){
            if CMMotionActivityManager.isActivityAvailable(){
                self.activityMnager.startActivityUpdates(to: OperationQueue.main){(data)in
                    DispatchQueue.main.async {
                       if let activity = data{
                           if activity.running == true{
                               print("running")
                           }
                           else if activity.walking == true{
                               print("walking")
                           }
                           else if activity.automotive == true{
                               print("automotive")
                           }
                        }
                    }
                }
            }else{
                let alert = UIAlertController(title: "Motion Activity Not Supported",
                                                      message: "Motion activity tracking is not supported on this device.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    @objc func backToLogin(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            
            let login = LoginScreen()
            self.navigationController?.pushViewController(login, animated: true)
        }
        catch{
            print("An error occured !")
        }
    }
    
    func addCardViews() {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .black
        
        
        
        var yPosition: CGFloat = 100.0
        let contentWidth = view.frame.width - 40.0
        
        
        // Create a welcome label
        let welcomeLable = UILabel(frame: CGRect(x: 20.0, y: 10, width: contentWidth, height: 30.0))
        welcomeLable.textColor = .white
        welcomeLable.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        scrollView.addSubview(welcomeLable)
        yPosition += 0.0
        
        //welcome text
        let hour = calendar.component(.hour, from: now)
        if(hour < 12 && hour > 0){
            //welcomeLbl.text = hour.codingKey.stringValue
            welcomeLable.text = "Good morning"
        }else if (hour < 2 && hour > 12){
            welcomeLable.text = "Good afternoon"
        }else{
            welcomeLable.text = "Good evening"
        }
        
        // Create a logged username label
        let loggedUserLable = UILabel(frame: CGRect(x: 20.0, y: 35, width: contentWidth, height: 30.0))
        loggedUserLable.textColor = .white
        loggedUserLable.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        scrollView.addSubview(loggedUserLable)
        yPosition += 0.0
        
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = db.collection("user_tbl").document(email!)
        docRef.getDocument { [weak self] (document, error) in
            DispatchQueue.main.async {
                if let document = document, document.exists {
                    let data = document.data()
                    
                    if let loggedUser = data?["username"] as? String {
                        print("Logged user: \(loggedUser)")
                        loggedUserLable.text = String(loggedUser)
                    }
                } else {
                    print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }

        

        
        // Create a "logout" button
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.configuration = .gray()
        logoutButton.configuration?.baseForegroundColor = .black
        logoutButton.configuration?.cornerStyle = .medium
        logoutButton.layer.borderColor = UIColor.orange.cgColor
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.backgroundColor = UIColor.orange.cgColor
        logoutButton.layer.cornerRadius = 5.0
        logoutButton.frame = CGRect(x: 270.0, y: 10, width: 85, height: 30.0)
        logoutButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        scrollView.addSubview(logoutButton)
        yPosition += 0.0
        
        if(FirebaseAuth.Auth.auth().currentUser != nil){
            logoutButton.isHidden = false
        }else{
            logoutButton.isHidden = true
        }
        
        //step container
        rectrangleStep = UIView(frame: CGRect(x: 20.0, y: yPosition, width: 150, height: 125.0))
        rectrangleStep.backgroundColor = UIColor.purple
        rectrangleStep.layer.opacity = 0.4
        rectrangleStep.layer.cornerRadius = 20
        scrollView.addSubview(rectrangleStep)
        
        let imageName = "feet.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 50, y: 5, width: 50, height: 50)
        rectrangleStep.addSubview(imageView)
        
        stepsLbl.text = "1500"
        stepsLbl.textAlignment = .center
        stepsLbl.textColor = .white
        stepsLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleStep.addSubview(stepsLbl)
        NSLayoutConstraint.activate([
            
            stepsLbl.widthAnchor.constraint(equalToConstant: 350),
            stepsLbl.heightAnchor.constraint(equalToConstant: 40),
            stepsLbl.centerXAnchor.constraint(equalTo: rectrangleStep.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        stepsLbl.topAnchor.constraint(equalTo: rectrangleStep.topAnchor, constant: 50).isActive = true
        
        stepValLbl.text = "Total steps"
        stepValLbl.textAlignment = .center
        stepValLbl.textColor = .white
        stepValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleStep.addSubview(stepValLbl)
        NSLayoutConstraint.activate([
            
            stepValLbl.widthAnchor.constraint(equalToConstant: 350),
            stepValLbl.heightAnchor.constraint(equalToConstant: 40),
            stepValLbl.centerXAnchor.constraint(equalTo: rectrangleStep.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        stepValLbl.topAnchor.constraint(equalTo: rectrangleStep.topAnchor, constant: 70).isActive = true
        yPosition += 150.0
        
        //calory container
        rectrangleCal.frame = CGRect(x:210, y: 100, width: 150 , height: 125)
        rectrangleCal.backgroundColor = UIColor.purple
        rectrangleCal.layer.opacity = 0.4
        rectrangleCal.layer.cornerRadius = 20
        scrollView.addSubview(rectrangleCal)
        
        let imageName1 = "kcal.png"
        let image1 = UIImage(named: imageName1)
        let imageView1 = UIImageView(image: image1!)
        
        imageView1.frame = CGRect(x: 50, y: 5, width: 50, height: 50)
        rectrangleCal.addSubview(imageView1)
        
        calsLbl.text = ""
        calsLbl.textAlignment = .center
        calsLbl.textColor = .white
        calsLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleCal.addSubview(calsLbl)
        NSLayoutConstraint.activate([
            
            calsLbl.widthAnchor.constraint(equalToConstant: 350),
            calsLbl.heightAnchor.constraint(equalToConstant: 40),
            calsLbl.centerXAnchor.constraint(equalTo: rectrangleCal.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        calsLbl.topAnchor.constraint(equalTo: rectrangleCal.topAnchor, constant: 50).isActive = true
        
        getTotCal()

        
        calLbl.text = "Burned Calories"
        calLbl.textAlignment = .center
        calLbl.textColor = .white
        calLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleCal.addSubview(calLbl)
        NSLayoutConstraint.activate([
            
            calLbl.widthAnchor.constraint(equalToConstant: 350),
            calLbl.heightAnchor.constraint(equalToConstant: 40),
            calLbl.centerXAnchor.constraint(equalTo: rectrangleCal.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        calLbl.topAnchor.constraint(equalTo: rectrangleCal.topAnchor, constant: 70).isActive = true
        
        for (index, warm) in Waarmup.enumerated() {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 80.0))
            cardView.backgroundColor = .gray
            cardView.layer.cornerRadius = 10.0
            cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cardView.layer.shadowRadius = 2.0
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.opacity = 0.5
            
            
            let imageName = "runner.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 10.0, y: 15.0, width: 50.0, height: 50.0)
            cardView.addSubview(imageView)
            
            nameLabel = UILabel(frame: CGRect(x: 120.0, y: 10.0, width: cardView.frame.width - 70.0, height: 30.0))
            nameLabel.text = warm.exe_name
            nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(nameLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            
            
            let durationLabel = UILabel()
            durationLabel.text = "duration: \(warm.exe_hours)"
            durationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(durationLabel)
            
            cardView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
                stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
                stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10.0)
            ])
            
            
            let imageName1 = "play-button.png"
            let image1 = UIImage(named: imageName1)
            let imageView1 = UIImageView(image: image1!)
            imageView1.frame = CGRect(x: cardView.frame.width - 55.0, y: 25.0, width: 30.0, height: 30.0)
            cardView.addSubview(imageView1)
            
            // Add a tap gesture recognizer to the card view
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
            cardView.addGestureRecognizer(tapGesture)
            cardView.isUserInteractionEnabled = true
            cardView.tag = index
            
            scrollView.addSubview(cardView)
            
            yPosition += 100.0
        }
        // Set the content size of the scroll view
        let contentHeight = yPosition + 20.0
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Add the scroll view to the main view
        view.addSubview(scrollView)
                
    }
    @objc func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view else { return }
        guard let index = cardView.tag as Int? else { return }
        let selectedWarmUp = Waarmup[index]
        
        let exeDetails = ExeDetails(warmUp: selectedWarmUp)
        navigationController?.pushViewController(exeDetails, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Call your function here
        getTotCal()
    }
    
    func getTotCal(){
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_exe_tbl")
        let docRef = db.collection("user_exe_tbl").document(email!)
        db.collection("user_exe_tbl").document(email!).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                if let burnCal = data?["burned_calories"] as? Int {
                    print("Total cal: \(burnCal)")
                    calsLbl.text = String(burnCal)
                }
            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
