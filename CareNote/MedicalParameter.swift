//
//  MedicalParameter.swift
//  TestOCR/Users/yashtayal/Downloads/TestOCR 3/TestOCR/MedicalParameter.swift
//
//  Created by Yash Tayal on 05/06/24.
//
import Foundation

/*
 
 
 */
//var dictionary = [
//    //HAEMOGLOBIN
//    "Hemoglobin":"Hemoglobin",
//    "Haemoglobin":"Hemoglobin",
//    "HAEMOGLOBIN (Hb)":"Hemoglobin",
//    "Hemoglobin (Hb)":"Hemoglobin",
//    "Blood Haemoglobin":"Hemoglobin",
//    "Blood Hb":"Hemoglobin",
//    "Blood hemoglobin":"Hemoglobin",
//    "Blood Hgb":"Hemoglobin",
//    "Haemoglobin Concentration":"Hemoglobin",
//    "Haemoglobin Level":"Hemoglobin",
//    "Haemoglobin Measurement":"Hemoglobin",
//    "Hb":"Hemoglobin",
//    "Hb Concentration":"Hemoglobin",
//    "Hb Level":"Hemoglobin",
//    "Hemoglobin Concentration":"Hemoglobin",
//    "Hemoglobin Level":"Hemoglobin",
//    "Hemoglobin Measurement":"Hemoglobin",
//    "Hgb":"Hemoglobin",
//    "Hgb Concentration":"Hemoglobin",
//    "Hgb Level":"Hemoglobin",
//    "Serum Haemoglobin":"Hemoglobin",
//    "Serum Hemoglobin":"Hemoglobin",
//
//    
//    
//    
//    
//    
//            
//            
//    // RED BLOOD CELL (RBC)
//    "Red blood Cell count":"RBC",
//    "Blood RBC":"RBC",
//    "Blood Red Blood Cells":"RBC",
//    "Erythrocyte Concentration":"RBC",
//    "Erythrocyte Count":"RBC",
//    "Erythrocyte Level":"RBC",
//    "Erythrocytes":"RBC",
//    "R. B. C":"RBC",
//    "R. B. C.":"RBC",
//    "R.B.C":"RBC",
//    "R.B.C.":"RBC",
//    "RBC":"RBC",
//    "RBC Analysis":"RBC",
//    "RBC Count":"RBC",
//    "RBC Level":"RBC",
//    "RBC Measurement":"RBC",
//    "RBC Test":"RBC",
//    "RBCs":"RBC",
//    "Red Blood Cell Concentration":"RBC",
//    "Red Blood Cell Count":"RBC",
//    "Red Blood Cells":"RBC",
//    "Red Blood Corpuscles":"RBC",
//    "Red Cell Concentration":"RBC",
//    "Red Cell Count":"RBC",
//    "Total RBC count":"RBC",
//    
//    //PCV
//    "Packed Cell Volume (PCV)":"PCV",
//    
//    
//    
//    
//    //MCV
//    "Mean Corpuscular Volume (MCV)":"MCV",
//    
//    //MCH
//    "MCH":"MCH",
//    
//    //MCHC
//    "MCHC":"MCHC",
//    
//    //RDW-CV (Red Cell Distribution Width - Coefficient of Variation)
//    "RDW":"RDW",
//    
//    
//            
//    //NEUTROPHIL
//    "NEUTROPHIL":"NEUTROPHIL",
//    "Absolute neutrophil count (ANC)":"NEUTROPHIL",
//    "Granulocytes":"NEUTROPHIL",
//    "Neutrophil":"NEUTROPHIL",
//    "Neutrophils":"NEUTROPHIL",
//    "Neutrophil concentration":"NEUTROPHIL",
//    "Neutrophil count":"NEUTROPHIL",
//    "Neutrophil count (Absolute)":"NEUTROPHIL",
//    "Neutrophil fraction":"NEUTROPHIL",
//    "Neutrophil index":"NEUTROPHIL",
//    "Neutrophil level":"NEUTROPHIL",
//    "Neutrophil percentage":"NEUTROPHIL",
//    "Neutrophil population":"NEUTROPHIL",
//    "Neutrophilic cells":"NEUTROPHIL",
//    "Neutrophilic granulocytes":"NEUTROPHIL",
//    "Neutrophilic polymorphs":"NEUTROPHIL",
//    "Neuts":"NEUTROPHIL",
//    "PMN":"NEUTROPHIL",
//    "Polymorphonuclear cells":"NEUTROPHIL",
//    "Polymorphonuclear leukocytes (PMNs)":"NEUTROPHIL",
//    "Polys":"NEUTROPHIL",
//    "Segs":"NEUTROPHIL",
//    
//    // Eosinophils
//    "Eosinophils":"Eosinophils",
//    "Absolute eosinophil count (AEC)":"Eosinophils",
//    "Acidophilic granulocytes":"Eosinophils",
//    "Acidophilic leukocytes":"Eosinophils",
//    "Acidophils":"Eosinophils",
//    "Acidophils (Eosinophils)":"Eosinophils",
//    "Eos":"Eosinophils",
//    "Eosinophil concentration":"Eosinophils",
//    "Eosinophil count":"Eosinophils",
//    "Eosinophil count (Absolute)":"Eosinophils",
//    "Eosinophil fraction":"Eosinophils",
//    "Eosinophil index":"Eosinophils",
//    "Eosinophil level":"Eosinophils",
//    "Eosinophil percentage":"Eosinophils",
//    "Eosinophil population":"Eosinophils",
//    "Eosinophil subset":"Eosinophils",
//    "Eosinophilia":"Eosinophils",
//    "Eosinophilic cells":"Eosinophils",
//    "Eosinophilic granulocytes":"Eosinophils",
//    "Eosinophilic leukocytes":"Eosinophils",
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //LYMPHOCYTE
//    "LYMPHOCYTE":"LYMPHOCYTE",
//    "LYMPHOCYTES":"LYMPHOCYTE",
//    "Absolute lymphocyte count (ALC)":"LYMPHOCYTE",
//    "Large lymphocytes":"LYMPHOCYTE",
//    "Lymphocyte concentration":"LYMPHOCYTE",
//    "Lymphocyte count":"LYMPHOCYTE","Lymphocyte fraction":"LYMPHOCYTE",
//    "Lymphocyte index":"LYMPHOCYTE",
//    "Lymphocyte level":"LYMPHOCYTE",
//    "Lymphocyte percentage":"LYMPHOCYTE",
//    "Lymphocyte population":"LYMPHOCYTE",
//    "Lymphocyte subset":"LYMPHOCYTE",
//    "Lymphocytes":"LYMPHOCYTE",
//    "Lymphocytic cells":"LYMPHOCYTE",
//    "Lymphocytic leukocytes":"LYMPHOCYTE",
//    "Lymphocytopenia":"LYMPHOCYTE",
//    "Lymphocytosis":"LYMPHOCYTE",
//    "Lymphocytosis (Absolute)":"LYMPHOCYTE",
//    "Lymphoid cells":"LYMPHOCYTE",
//    "Lymphoid leukocytes":"LYMPHOCYTE",
//    "Lymphs":"LYMPHOCYTE",
//    "Small lymphocytes":"LYMPHOCYTE"
//
//
//
//
//
//
//]


// Function to read the content of the CSV file
/*func readCSV(fileName: String) -> String? {
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
        print("CSV file not found")
        return nil
    }
    
    do {
        let contents = try String(contentsOfFile: filePath, encoding: .utf8)
        return contents
    } catch {
        print("Failed to read the CSV file: \(error.localizedDescription)")
        return nil
    }
}
var dictionary: [String: String] = [:]
// Function to convert CSV content to a dictionary
func csvToDictionary(csvContent: String) -> [String: String] {
    
    let lines = csvContent.components(separatedBy: "\n")
    
    for line in lines {
        let columns = line.components(separatedBy: ",")
        if columns.count == 2 {
            let key = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let value = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
            if !key.isEmpty && !value.isEmpty {
                dictionary[key] = value
            }
        }
    }
    
    return dictionary
}

// Usage
func processCSVFile() {
    if let csvContent = readCSV(fileName: "ParametersCSV") {
        let dictionary = csvToDictionary(csvContent: csvContent)
        print(dictionary)
    }
}
*/

//func copyCSVToDocuments(fileName: String) {
//    let fileManager = FileManager.default
//    if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
//        let documentsPath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
//        if !fileManager.fileExists(atPath: documentsPath.path) {
//            do {
//                try fileManager.copyItem(atPath: bundlePath, toPath: documentsPath.path)
//            } catch {
//                print("Error copying file: \(error.localizedDescription)")
//            }
//        }
//    } else {
//        print("CSV file not found in bundle")
//    }
//}
//
//// Function to get the path to the Documents directory
//func getDocumentsDirectory() -> URL {
//    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//}
//
//// Function to read the content of the CSV file from the Documents directory
//func readCSV(fileName: String) -> String? {
//    let filePath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
//    do {
//        let contents = try String(contentsOf: filePath, encoding: .utf8)
//        return contents
//    } catch {
//        print("Failed to read the CSV file: \(error.localizedDescription)")
//        return nil
//    }
//}
//
//var dictionary: [String: String] = [:]
//// Function to convert CSV content to a dictionary
//func csvToDictionary(csvContent: String) -> [String: String] {
// 
//    let lines = csvContent.components(separatedBy: .newlines)
//    
//    for line in lines {
//        let columns = line.components(separatedBy: ",")
//        if columns.count == 2 {
//            let key = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
//            let value = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
//            if !key.isEmpty && !value.isEmpty {
//                dictionary[key] = value
//            }
//        }
//    }
//    
//    return dictionary
//}
//
//// Function to read CSV and convert to dictionary, then print it
//func processCSVFile() {
//    if let csvContent = readCSV(fileName: "ParametersCSV") {
//        let dictionary = csvToDictionary(csvContent: csvContent)
//        print(dictionary)
//    }
//}
//


// Function to copy the CSV file from the bundle to the Documents directory
func copyCSVToDocuments(fileName: String) {
    let fileManager = FileManager.default
    if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        let documentsPath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
        if !fileManager.fileExists(atPath: documentsPath.path) {
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: documentsPath.path)
            } catch {
                print("Error copying file: \(error.localizedDescription)")
            }
        }
    } else {
        print("CSV file not found in bundle")
    }
}

// Function to get the path to the Documents directory
func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

// Function to read the content of the CSV file from the Documents directory
func readCSV(fileName: String) -> String? {
    let filePath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
    do {
        let contents = try String(contentsOf: filePath, encoding: .utf8)
        return contents
    } catch {
        print("Failed to read the CSV file: \(error.localizedDescription)")
        return nil
    }
}
var dictionary: [String: String] = [:]
// Function to convert CSV content to a dictionary
func csvToDictionary(csvContent: String) -> [String: String] {
   
    let lines = csvContent.components(separatedBy: .newlines)
    
    for line in lines {
        let columns = line.components(separatedBy: ",")
        if columns.count == 2 {
            let key = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let value = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
            if !key.isEmpty && !value.isEmpty {
                dictionary[key] = value
            }
        }
    }
    
    return dictionary
}

// Function to read CSV and convert to dictionary, then print it
func processCSVFile() {
    if let csvContent = readCSV(fileName: "ParametersCSV") {
        let dictionary = csvToDictionary(csvContent: csvContent)
        print(dictionary)
    }
}

// Example of using the functions

