//
//  DataModel.swift
//  StudentDatabaseManager
//
//  Created by E5000846 on 07/06/24.
//

import Foundation
import UIKit


protocol Student {
    var stdId: Int { get }
    var name: String { get }
    var DOB: Date { get }
    var age: Int { get }
    var image: UIImage { get }
    var gender: String { get }
}

struct DataStruct : Student{
    var stdId: Int
    var name: String
    var DOB : Date
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: DOB, to: Date())
        return ageComponents.year ?? 0
    }
    var image: UIImage
    var gender: String
}


struct TableSourceData {
    static var arrayOfStudent: [DataStruct] = []
    
    mutating func setData(_ newStudent : DataStruct) -> Void{
        TableSourceData.arrayOfStudent.append(newStudent)
    }
       
    
     static func getData() -> [DataStruct] {
       return arrayOfStudent
    }
}
