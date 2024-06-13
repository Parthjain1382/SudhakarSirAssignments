//
//  ProfileTableViewCell.swift
//  StudentDatabaseManager
//
//  Created by E5000846 on 05/06/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let identifier = "ProfileTableViewCell"
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var nameLB: UILabel!
   
   
    override func awakeFromNib
    () {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
