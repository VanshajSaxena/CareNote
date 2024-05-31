//
//  DataController.swift
//  CareNote
//
//  Created by Batch-2 on 30/05/24.
//

import Foundation

class DataController {

    private var user: User?
    private var doctors: [Doctor]? = []
    private var consultations: [Consultation]? = []
    private var _parametersDict = ["Blood Pressure": "mmHg", "Blood Sugar": "mg/dL"]
    
    var medicalParameters : [MedicalParameter] = []
    
    static let shared = DataController()
    
    init(user: User? = nil, doctors: [Doctor]? = nil, consultations: [Consultation]? = nil) {
        self.user = user
        self.doctors = doctors
        self.consultations = consultations
        
        for (param, unit) in _parametersDict {
            let medicalParameter = MedicalParameter(name: param, unitOfMeasure: unit)
            medicalParameters.append(medicalParameter)
        }
    }
    
    func getMedicalParameters(name: String) -> MedicalParameter? {
        return medicalParameters.first { $0.name == name }
    }
    
    func getDoctor(name: String) -> Doctor? {
        return doctors?.first { $0.name == name }
    }
    
}
