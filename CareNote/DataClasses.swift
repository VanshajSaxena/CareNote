//
//  DataClasses.swift
//  CareNote
//
//  Created by Batch-2 on 28/05/24.
//

import Foundation

// Gender Enum Representing Possible Genders
enum Gender {
    case male
    case female
    case other
    case unknown
}

// Represents a patient in the CareNote app
class Patient {
    var id: UUID
    var userName: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var contact: Int?
    var address: String?
    var email: String
    var dateOfBirth: Date
    
    // Holds the Current health metrics of the patient
    struct CurrentHealthDetails {
        var height: String?
        var weight: String?
        var bloodGroup: String?
        var allergies: String?
    }
    
    init(id: UUID, userName: String, firstName: String, lastName: String, gender: Gender, contact: Int? = nil, address: String? = nil, email: String, dateOfBirth: Date) {
        self.id = id
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.contact = contact
        self.address = address
        self.email = email
        self.dateOfBirth = dateOfBirth
    }
}

// Represents a single consultation or a doctor visit
class Consultation {
    var id: UUID
    var dateOfConsultation: Date
    var title: String
    var patient: Patient
    var doctor: Doctor
    var consultationDocuments: [ConsultationDocument]?
    struct Prescription {
        var title: String
        var dateOfPrescription: Date
        var description: String
        var recommendedMedication: [Medicine]
    }
    init(id: UUID, dateOfConsultation: Date, title: String, patient: Patient, doctor: Doctor, consultationDocuments: [ConsultationDocument]? = nil) {
        self.id = id
        self.dateOfConsultation = dateOfConsultation
        self.title = title
        self.patient = patient
        self.doctor = doctor
        self.consultationDocuments = consultationDocuments
    }
}

// Documents after a doctor visit
struct ConsultationDocument {
    var title: String
    var documentType: String
    var note: String?
}

// Represents a single medicine
struct Medicine {
    var name: String
    var unitOfMeasure: String
}

// Represents a doctor in the CareNote app
class Doctor {
    var id: UUID
    var name: String
    var speciality: String
    var contactNumber: Int?
    
    init(id: UUID, name: String, speciality: String, contactNumber: Int? = nil) {
        self.id = id
        self.name = name
        self.speciality = speciality
        self.contactNumber = contactNumber
    }
}

// This class represents an abstract MedicalParameter that can be used to create more specific
// medical parameters like, bloodPressureSystolic, bloodSugar, eGFR, etc.
class MedicalParameter {
    var name: String
    var unitOfMeasure: String
    // private(set) keyword is used to make properties publicly redable but privately modifiable.
    private(set) var history: [(value: Any, date: Date)]? // history is an array of a tuple that can hold previous values of a parameter.
    
    init(name: String, unitOfMeasure: String, history: [(value: Any, date: Date)]? = nil) {
        self.name = name
        self.unitOfMeasure = unitOfMeasure
        self.history = history
    }
    
    func addValue(_ value: Any, date: Date) {
        history?.append((value: value, date: date))
    }
    
    func displayHistory(){
        print("History of parameter: \(name).")
        if let historyExists = history {
            for entry in historyExists {
                print("Value: \(entry.value) \(unitOfMeasure), Date: \(entry.date).")
            }
        }
    }
    
    func getValues() -> [Any]? {
        return history?.map { $0.value }
    }

    func getDates() -> [Date]? {
        return history?.map { $0.date }
    }
}

