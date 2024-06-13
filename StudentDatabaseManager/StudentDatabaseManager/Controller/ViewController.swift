//
//  ViewController.swift
//  StudentDatabaseManager
//
//  Created by E5000846 on 05/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var StudentDataTable: UITableView!
    
    @IBOutlet weak var headingLB: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var studentArray  = [DataStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
        print(UIImage(named: "profile") as Any)
        //Setting up the labels, image
        settingUpTable()
        setUpProfileImage()
        setUpHeadingLb()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareData()
    }
    
    func prepareData(){
        studentArray = TableSourceData.getData()
        StudentDataTable.reloadData()
    }
    

    func settingUpTable(){
        StudentDataTable.delegate = self
        StudentDataTable.dataSource = self
    }
    
    func setUpProfileImage(){
    
        
    }
    
    //Setting up the Header Label
    func setUpHeadingLb(){
        let headingLB = UILabel()
            headingLB.text = "🧑🏻‍🎓 Student Manager"
            headingLB.font = UIFont.boldSystemFont(ofSize: 24)
            headingLB.textColor = .systemCyan
            headingLB.textAlignment = .center
            headingLB.layer.cornerRadius = 10
            headingLB.layer.masksToBounds = true
            headingLB.layer.shadowColor = UIColor.white.cgColor
            headingLB.layer.shadowOffset = CGSize(width: 3, height: 5)
            headingLB.layer.shadowOpacity = 0.3
            headingLB.layer.shadowRadius = 4
            
            // Adjust the size of the headingLB to fit the text
            headingLB.sizeToFit()
            
            // Set a maximum width for the label
            let maxWidth = self.view.frame.width - 40 // Adjust as needed
            headingLB.frame.size.width = min(headingLB.frame.width, maxWidth)
            
            self.navigationItem.titleView = headingLB
    }
}



//MARK: - TableViewdelegate Protocol extension
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentDetailsViewController") as? StudentDetailsViewController
        vc?.StudentArray = studentArray[indexPath.row]
        self.present(vc ?? UIViewController(), animated: true)
        
    }
}


//MARK: - TableViewDataSource Protocol extension
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = StudentDataTable.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else{
            return UITableViewCell()
        }
        
        cell.nameLB.text = studentArray[indexPath.row].name
        cell.profileImg.image = studentArray[indexPath.row].image

        return cell
    }
}
