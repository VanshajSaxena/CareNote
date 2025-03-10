//
//  DataClasses.swift
//  CareNote
//
//  Created by Batch-2 on 28/05/24.
//

import Foundation
import UIKit

// Gender Enum Representing Possible Genders
enum Gender: String, Codable {
    case male
    case female
    case other
    case unknown
}

// Represents a user in the CareNote app
class User: Codable {
    var id: UUID
    var userName: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var contact: Int?
    var address: String?
    var email: String
    var dateOfBirth: Date
    
    // Holds the Current health metrics of the user
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
class Consultation: Codable {
    var id: UUID
    var dateOfConsultation: Date
    var title: String
    var user: User
    var doctor: Doctor
    var consultationDocuments: [ConsultationDocument]?
    struct Prescription {
        var title: String
        var dateOfPrescription: Date
        var description: String
        var recommendedMedication: [Medicine]
    }
    init(id: UUID, dateOfConsultation: Date, title: String, user: User, doctor: Doctor, consultationDocuments: [ConsultationDocument]? = nil) {
        self.id = id
        self.dateOfConsultation = dateOfConsultation
        self.title = title
        self.user = user
        self.doctor = doctor
        self.consultationDocuments = consultationDocuments
    }
}

// Documents after a doctor visit
struct ConsultationDocument: Codable {
    var title: String
    var dateOfVisit : Date   // variable date of visit added by Sameer Verma to display and save the visit date of the patient.
    var documentType: String
    var content: String?
    var note: String?
}

// Represents a single medicine
struct Medicine: Codable {
    var id: UUID
    var name: String
    var unitOfMeasure: String
}

// Represents a doctor in the CareNote app
class Doctor: Codable {
    var id: UUID
    var name: String
    var speciality: String?
    var contactNumber: Int?
    
    init(id: UUID, name: String, speciality: String? = nil, contactNumber: Int? = nil) {
        self.id = id
        self.name = name
        self.speciality = speciality
        self.contactNumber = contactNumber
    }
}

struct Images: Codable {
    var id: UUID
    var name: String
    var imageData: Data?
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageData
    }
    
    // Initializer that accepts UIImage
    init(id: UUID, name: String, image: UIImage?) {
        self.id = id
        self.name = name
        self.imageData = image?.jpegData(compressionQuality: 1.0)
    }
}

enum TimeSegment {
    case day, week, month, year
}

// sameer verma created the data models
struct DoctorVisitDetailsDataStore{
    var dateOfVisit : String
    var nameOfDoctor : String
//    var hospitalName : String
    var reasonOfVisit : String
    var nextAppointmentDate : String
    var adviceByDoctor : String?
    
    init(dateOfVisit: String, nameOfDoctor: String, reasonOfVisit: String, nextAppointmentDate: String, adviceByDoctor: String? = nil) {
        self.dateOfVisit = dateOfVisit
        self.nameOfDoctor = nameOfDoctor
        self.reasonOfVisit = reasonOfVisit
        self.nextAppointmentDate = nextAppointmentDate
        self.adviceByDoctor = adviceByDoctor
    }
}
