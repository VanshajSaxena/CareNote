//
//  DataClasses.swift
//  CareNote
//
//  Created by Batch-2 on 28/05/24.
//

import Foundation

enum Gender {
    case male
    case female
    case unknown
}

class Patient {
    var userName: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var email: String
    var dateOfBirth: Date
    
    struct currentHealthDetails {
        var height: String
        var weight: String
        var bloodGroup: String
        var Allergies: String
    }
    
    init(userName: String, firstName: String, lastName: String, gender: Gender, email: String, dateOfBirth: Date) {
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.email = email
        self.dateOfBirth = dateOfBirth
    }
}

class Consultation {
    var dataOfConsultation: Date
    var title: String
    var doctorName: String
    struct Prescription {
        var title: String
        var dateOfPrescription: Date
        var description: String
        var recommendedMedication: [Medicines]
    }
    init(dataOfConsultation: Date, title: String, doctorName: String) {
        self.dataOfConsultation = dataOfConsultation
        self.title = title
        self.doctorName = doctorName
    }
}

struct Medicines {
    
}

class Doctor {
    var name: String
    var speciality: String
    var contactNumber: Int
    var clinicAddress: String
    
    init(name: String, speciality: String, contactNumber: Int, clinicAddress: String) {
        self.name = name
        self.speciality = speciality
        self.contactNumber = contactNumber
        self.clinicAddress = clinicAddress
    }
}
