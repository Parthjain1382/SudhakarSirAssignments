//
//  StudentDetailsViewController.swift
//  StudentDatabaseManager
//
//  Created by E5000846 on 07/06/24.
//

import UIKit

class StudentDetailsViewController: UIViewController {

    
    var StudentArray = DataStruct(stdId: 1, name: "", DOB: Date() , image: UIImage(named: "profile")!,gender: "")
    
    let nameField = UILabel(frame: CGRect(x: 190, y: 355, width: 183, height: 34))
    let stdIdField = UILabel(frame: CGRect(x: 190, y: 448, width: 185, height: 34))
    let dobField = UILabel(frame: CGRect(x: 190, y: 543, width: 110, height: 34))
    let ageField = UILabel(frame: CGRect(x: 190, y: 630, width: 97, height: 34))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        setUpFormsLabel()
        setUpDetailLabel()
    }
    
    //Image view
    func setUpImageView(){
        let profileImg = UIImageView()
        profileImg.frame = CGRect(x: 104, y: 116, width: 184, height: 154)
        profileImg.image = StudentArray.image
        view.addSubview(profileImg)
    }
    
    //setting Up all forms Label
    func setUpFormsLabel(){
        let headerLB = UILabel(frame: CGRect(x: view.self.frame.size.width*0.3, y: 59, width: 347, height: 20))
        let nameLb = UILabel(frame: CGRect(x: 40, y: 360, width: 300, height: 21))
        let stdIdLb = UILabel(frame: CGRect(x: 40, y: 453, width: 300 , height: 21))
        let dateLb = UILabel(frame: CGRect(x: 40, y: 550, width: 300, height: 21))
        let ageLb = UILabel(frame: CGRect(x: 40, y: 643, width: 300, height: 21))
        
        headerLB.text = "About Information"
        nameLb.text = "Name : "
        stdIdLb.text = "Student ID : "
        dateLb.text = "Date of Birth : "
        ageLb.text = "Age :"
        
        view.addSubview(headerLB)
        view.addSubview(nameLb)
        view.addSubview(stdIdLb)
        view.addSubview(dateLb)
        view.addSubview(ageLb)
    }
    
    func setUpDetailLabel(){
        
        nameField.text = StudentArray.name + " " + "(\(StudentArray.gender))"
        stdIdField.text = String(StudentArray.stdId)
        dobField.text = String("\(StudentArray.DOB)".prefix(10))
        ageField.text = String(StudentArray.age)
     
        view.addSubview(nameField)
        view.addSubview(stdIdField)
        view.addSubview(dobField)
        view.addSubview(ageField)
    }
}
