//
//  ViewController.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-10.
//

import UIKit

class splash: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!

    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = "loginImg.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: -90, y: 0, width: 600, height: 850)
        //imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        nextButton.addTarget(self, action: #selector(startHighlight), for: .touchDown)
        nextButton.addTarget(self, action: #selector(stopHighlight), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(stopHighlight), for: .touchUpOutside)
        
        let imageName1 = "logo.png"
        let image1 = UIImage(named: imageName1)
        let imageView1 = UIImageView(image: image1!)
        imageView1.frame = CGRect(x:220.0, y: 280.0, width: 140.0, height: 140.0)
        imageView1.layer.masksToBounds = false
        imageView1.layer.opacity = 0.8
        imageView1.layer.cornerRadius = imageView1.frame.size.height/2
        imageView1.clipsToBounds = true
        imageView.addSubview(imageView1)

        configureButton()
    }
    func configureButton(){
        nextButton.configuration = .gray()
        nextButton.configuration?.baseForegroundColor = .orange
        nextButton.configuration?.cornerStyle = .medium
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor

        nextButton.setTitle("Get Started", for: .normal)
        nextButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        nextButton.semanticContentAttribute = .forceRightToLeft
        //nextButton.configuration = .filled()
        //nextButton.configuration?.baseBackgroundColor = .systemPink
        setupButton()
    }
    func setupButton(){
        view.addSubview(nextButton)
        
        nextButton.layer.cornerRadius = 20
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        //nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        nextButton.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
    }
    @objc func startHighlight(sender: UIButton) {
        nextButton.layer.borderColor = UIColor.systemPink.cgColor
        nextButton.layer.borderWidth = 1
    }
    @objc func stopHighlight(sender: UIButton) {
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.borderWidth = 1
    }
    
    @objc func gotoLogin(){
        let loginScreen = LoginScreen()
        loginScreen.title = "Login"
        navigationController?.pushViewController(loginScreen, animated: true)
    }
}

