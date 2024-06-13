//
//  SecondViewController.swift
//  StudentDatabaseManager
//
//  Created by E5000846 on 05/06/24.
//

import UIKit

class SecondViewController: UIViewController{
      @IBOutlet weak var imageView: UIImageView!
    

    let headerLB = UILabel(frame: CGRect(x: 130, y: 59, width: 347, height: 20))
    let nameLb = UILabel(frame: CGRect(x: 40, y: 360, width: 69, height: 21))
    let stdLb = UILabel(frame: CGRect(x: 40, y: 453, width: 128 , height: 21))
    let dateLb = UILabel(frame: CGRect(x: 40, y: 550, width: 128, height: 21))
    let genderLb = UILabel(frame: CGRect(x: 40, y: 643, width: 80, height: 21))
    let imageBtn = UIButton(frame: CGRect(x: 97, y: 140, width: 184, height: 132))
    
    
    let nameTxt = UITextField(frame: CGRect(x: 165, y: 355, width: 183, height: 34))
    let stdIdTxt = UITextField(frame: CGRect(x: 165, y: 448, width: 185, height: 34))
    let datePicker = UIDatePicker(frame: CGRect(x: 90, y: 543, width: 70, height: 34))
    
    var genderTxt = UIPickerView(frame: CGRect(x: 165, y: 630, width: 120, height: 50))
    let gendersData = ["Male" , "Female"]
    var genderSelected : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        setUpFormsLabel()
        setUpTextView()
        setUpSubmitButton()
        settingUpImageBtn()
        setUpDatePicker()
    }
    
    
    //Image view
    func setUpImageView(){
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
    }
    
    //setting Up all forms Label
    func setUpFormsLabel(){
        headerLB.text = "Add New Students"
        nameLb.text = "Name : "
        stdLb.text = "Student ID : "
        dateLb.text = "DOB :"
        genderLb.text = "Gender : "
        
        view.addSubview(headerLB)
        view.addSubview(nameLb)
        view.addSubview(stdLb)
        view.addSubview(dateLb)
        view.addSubview(genderLb)
    }
    
    //Setting up the text Views
    func setUpTextView(){
      
        nameTxt.placeholder = "Enter your Name"
        nameTxt.borderStyle = .roundedRect
        nameTxt.textAlignment = .left
        nameTxt.clearButtonMode = .whileEditing
        nameTxt.font = UIFont.systemFont(ofSize: 14)
        
        
        stdIdTxt.placeholder = "Enter your Employee Id"
        stdIdTxt.borderStyle = .roundedRect
        stdIdTxt.textAlignment = .left
        stdIdTxt.font = UIFont.systemFont(ofSize: 14)
        
        
        genderTxt.delegate = self
        genderTxt.dataSource = self
     
        view.addSubview(nameTxt)
        view.addSubview(stdIdTxt)
        view.addSubview(genderTxt)
    }
    
  
    func setUpDatePicker(){
        datePicker.calendar = .current
        datePicker.datePickerMode = .date
        datePicker.maximumDate = .now
        datePicker.backgroundColor = .white
        view.addSubview(datePicker)
    }
    
    //setting up the submit button
    func  setUpSubmitButton(){
        let submitBtn = UIButton(frame: CGRect(x: 159, y: 705, width: 75, height: 35))
        submitBtn.addTarget(self, action: #selector(dataTransfer), for: .touchUpInside)
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.backgroundColor = .systemBlue
        submitBtn.setTitleColor(.systemGray2, for: .highlighted)
        view.addSubview(submitBtn)
    }
    
    //Data transfer Using the Submit Button
    @objc func dataTransfer(){
        if (validateID() == true && validateName() == true ){
            var tableSourceData = TableSourceData()
            guard let empIdText = stdIdTxt.text, !empIdText.isEmpty,
                  let empId = Int(empIdText),
                  let name = nameTxt.text, !name.isEmpty,
                  let image = imageView.image
            else {
                showAction("Fill Details", "Please Fill all the text Field Properly")
                return
            }
            
            if let defaultImage = UIImage(named: "profile"),
               let defaultImageData = defaultImage.pngData(),
               let selectedImageData = image.pngData(),
               defaultImageData == selectedImageData {
                showAction("Select Image","Please Select an Image")
                return
            }
            
            let newStudentData = DataStruct(stdId: empId, name: name, DOB: datePicker.date, image: image,gender: genderSelected)
            tableSourceData.setData(newStudentData)
            showAction("Added Successfully", "New Student has been added succesfully")
        }
    }
    
    //setting up the submit button
    func  settingUpImageBtn(){
        let imageBtn = UIButton(frame: CGRect(x: 97, y: 135, width: 184, height: 132))
        imageBtn.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        imageBtn.setTitle("Change Image", for: .normal)
        imageBtn.backgroundColor = .systemBlue
        imageBtn.setImage(.add, for: .normal)
        imageBtn.backgroundColor = .none
        imageBtn.setTitleColor(.systemGray2, for: .highlighted)
        view.addSubview(imageBtn)
    }
    
    //Action to Image Picker
    @objc func imagePicker(){
        let photoVc = UIImagePickerController()
        photoVc.sourceType = .photoLibrary
        photoVc.delegate = self
        photoVc.allowsEditing = true
        present(photoVc,animated: true)
    }
    
    func showAction(_ title:String ,_ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func validateID() -> Bool {
         guard let id = stdIdTxt.text, !id.isEmpty else {
             showAction("Enter Id","ID cannot be empty.")
           return false
         }
         guard let _ = Int(id) else {
           showAction("Numeric Id","Please enter a numeric ID.")
           return false
         }
         return true
       }
       func validateName() -> Bool {
         guard let name = nameTxt.text, !name.isEmpty else {
           showAction("Enter Name","Name cannot be empty.")
           return false
         }
         let nameCharacterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
         if name.rangeOfCharacter(from: nameCharacterSet.inverted) != nil {
           showAction("Enter valid Credentials","Please enter a valid name (alphabetic characters only).")
           return false
         }
         return true
       }

    }


//MARK: - UIImagePickerControllerDelegate Methods
extension SecondViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = image
        }
        
        picker.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true , completion: nil)
    }
}



//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gendersData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gendersData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderSelected = gendersData[row]
       print(gendersData[row])
    }
}
