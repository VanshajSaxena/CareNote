//
//  MedicalParameter.swift
//  TestOCR/Users/yashtayal/Downloads/TestOCR 3/TestOCR/MedicalParameter.swift
//
//  Created by Yash Tayal on 05/06/24.
//
import UIKit
import Vision
import VisionKit
import Foundation

private struct TextInImage: Comparable, CustomStringConvertible {
    var xPosition: Int
    var yPosition: Int
    var text: String
    
    var description: String {
        return "X: \(xPosition) Y: \(yPosition) Text: \(text)"
    }
    
    static func < (lhs: TextInImage, rhs: TextInImage) -> Bool {
        lhs.yPosition > rhs.yPosition
    }
    
}

private let parameterListSplitted = ["Packed", "Cell", "Volume", "Mean", "Corpuscular", "Volume"]

struct RecordedParameter: CustomStringConvertible {
    var name: String
    var value: Float
    
    var description: String {
        "\(name) : \(value)"
    }
}

private var parametersInImage: [TextInImage] = []
private var textsInImage: [TextInImage] = []
private var ySortedTextsInImage: [TextInImage] = []

private var recordedParameters: [RecordedParameter] = []

func getRecordedParameters() -> [RecordedParameter] {
    return recordedParameters
}

private var neighbours: [TextInImage] = []

func getText(from image: UIImage) {
    guard let cgImage = image.cgImage else { return }
    
    let requestHandler = VNImageRequestHandler(cgImage: cgImage)
    
    let request = VNRecognizeTextRequest()
    
    do {
        try requestHandler.perform([request])
    } catch {
        print("Error")
    }
    
    guard let observations = request.results else {
        return
    }
    
    var boundingBoxes: [CGRect] = []
    var recognizedStrings: [String?] = []
    
    for observation in observations {
        let normalizedBoundingBox = observation.boundingBox
        let boundingBox = VNImageRectForNormalizedRect(normalizedBoundingBox, Int(image.size.width), Int(image.size.height))
        boundingBoxes.append(boundingBox)
        recognizedStrings.append(observation.topCandidates(1).first?.string)
    }
    
    //        let recognizedStrings = observations.compactMap { observation in return observation.topCandidates(1).first?.string
    //        }
    
    for i in 0..<boundingBoxes.count {
        textsInImage.append(TextInImage(xPosition: Int(boundingBoxes[i].origin.x), yPosition: Int(boundingBoxes[i].origin.y), text: recognizedStrings[i]!))
        print("Box \(i)")
        print(boundingBoxes[i])
        print(boundingBoxes[i].origin.y)
        print(recognizedStrings[i]!)
    }
    
    ySortedTextsInImage = textsInImage.sorted()
    
    for i in ySortedTextsInImage {
        print(i)
    }
    
    findParameter()
}

private func findParameter() {
    for i in textsInImage {
        let subTexts = i.text
        print(subTexts)
        if let score = dictionary[subTexts] {
            parametersInImage.append(i)
            print(score)
        } else if parameterListSplitted.contains(String(subTexts).lowercased()) {
            parametersInImage.append(i)
            break
        }
        
    }
    print("\n\n\n")
    for parameter in parametersInImage {
        print(parameter)
    }
    findParameterValue()
}

private func findParameterValue() {
    for parameter in parametersInImage {
        for i in textsInImage {
            if abs(parameter.yPosition - i.yPosition) <= 10 && parameter.text != i.text {
                if let value = Float(i.text) {
                    recordedParameters.append(RecordedParameter(name: parameter.text, value: value))
                }
            }
        }
    }
    
    print("\n\n\n")
    for parameter in recordedParameters {
        print(parameter)
    }
}

func copyCSVToDocuments(fileName: String) {
    let fileManager = FileManager.default
    
//    print("Looking for file named: \(fileName).csv in bundle.")
    
    if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        print("File found in bundle at path: \(bundlePath)")
        let documentsPath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
        
        if !fileManager.fileExists(atPath: documentsPath.path) {
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: documentsPath.path)
                print("CSV file copied to documents directory")
            } catch {
                print("Error copying file: \(error.localizedDescription)")
            }
        } else {
            print("CSV file already exists in documents directory")
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

//var dictionary = [
//    "Absolute basophil count (ABC)": "Basophils",
//    "Absolute eosinophil count (AEC)": "Eosinophils",
//    "Absolute lymphocyte count (ALC)": "Lymphocytes",
//    "Absolute monocyte count (AMC)": "Monocytes",
//    "Absolute neutrophil count (ANC)": "Neutrophil",
//    "Acidophils": "Eosinophils",
//    "Acidophilic granulocytes": "Eosinophils",
//    "Acidophilic leukocytes": "Eosinophils",
//    "Acidophils (Eosinophils)": "Eosinophils",
//    "Albumin": "Albumin",
//    "Albumin Assay": "Albumin",
//    "Albumin Concentration": "Albumin",
//    "Albumin Measurement": "Albumin",
//    "Albumin Test": "Albumin",
//    "Albumin Value": "Albumin",
//    "Alkaline Phosphatase (ALP)": "Alkaline Phosphatase (ALP)",
//    "Average Corpuscular Hemoglobin Concentration": "MCHC",
//    "Basophil concentration": "Basophils",
//    "Basophil count": "Basophils",
//    "Basophil count (Absolute)": "Basophils",
//    "Basophil fraction": "Basophils",
//    "Basophil index": "Basophils",
//    "Basophil level": "Basophils",
//    "Basophil population": "Basophils",
//    "Basophil percentage": "Basophils",
//    "Basophil subset": "Basophils",
//    "Basophilic cells": "Basophils",
//    "Basophilic cytoplasm": "Basophils",
//    "Basophilic cytoplasmic granules": "Basophils",
//    "Basophilic granulocytes": "Basophils",
//    "Basophilic leukocytes": "Basophils",
//    "Basophilocytosis": "Basophils",
//    "Basophils": "Basophils",
//    "Basos": "Basophils",
//    "Blood Albumin": "Albumin",
//    "Blood Albumin Assay": "Albumin",
//    "Blood Albumin Concentration": "Albumin",
//    "Blood Albumin Level": "Albumin",
//    "Blood Albumin Measurement": "Albumin",
//    "Blood Albumin Test": "Albumin",
//    "Blood Albumin Value": "Albumin",
//    "Blood Creatinine": "Creatinine",
//    "Blood Haematocrit": "PCV",
//    "Blood Haemoglobin": "Hemoglobin",
//    "Blood Hb": "Hemoglobin",
//    "Blood Hct": "Hematocrit",
//    "Blood Hgb": "Hemoglobin",
//    "Blood MCH": "MHC",
//    "Blood MCHC": "MCHC",
//    "Blood PCV": "PCV",
//    "Blood RBC": "RBC",
//    "Blood Red Blood Cells": "RBC",
//    "Blood RDW": "RDW",
//    "Blood Serum Creatinine": "Creatinine",
//    "Blood Urea": "Urea",
//    "Blood Urea Level": "Urea",
//    "Blood Urea Nitrogen (BUN)": "Urea",
//    "Blood Urea Nitrogen Level": "Urea",
//    "Blood Urea Test": "Urea",
//    "Blood Urate": "Uric Acid",
//    "Blood Urate Level": "Uric Acid",
//    "Blood Uric Acid": "Uric Acid",
//    "Blood Uric Acid Level": "Uric Acid",
//    "Blood WBC": "WBC",
//    "BUN": "Urea",
//    "Chloride": "Chloride",
//    "CorrectParameter": "CorrectParameter",
//    "Cr (Serum)": "Creatinine",
//    "Cr-S": "Creatinine",
//    "Creatinine": "Creatinine",
//    "Creatinine (Serum)": "Creatinine",
//    "Creatinine in Serum": "Creatinine",
//    "e-GFR": "eGFR",
//    "eGFR": "eGFR",
//    "eGFR (estimated Glomerular Filtration Rate)": "eGFR",
//    "eGFR (ml/min/1.73 m²)": "eGFR",
//    "eGFR Calculation": "eGFR",
//    "eGFR Level": "eGFR",
//    "eGFR Measurement": "eGFR",
//    "eGFR Reading": "eGFR",
//    "eGFR Result": "eGFR",
//    "eGFR Score": "eGFR",
//    "eGFR Test": "eGFR",
//    "eGFR Value": "eGFR",
//    "Eos": "Eosinophils",
//    "Eosinophil concentration": "Eosinophils",
//    "Eosinophil count": "Eosinophils",
//    "Eosinophil count (Absolute)": "Eosinophils",
//    "Eosinophil fraction": "Eosinophils",
//    "Eosinophil index": "Eosinophils",
//    "Eosinophil level": "Eosinophils",
//    "Eosinophil percentage": "Eosinophils",
//    "Eosinophil population": "Eosinophils",
//    "Eosinophil subset": "Eosinophils",
//    "Eosinophilia": "Eosinophils",
//    "Eosinophilic cells": "Eosinophils",
//    "Eosinophilic granulocytes": "Eosinophils",
//    "Eosinophilic leukocytes": "Eosinophils",
//    "Eosinophils": "Eosinophils",
//    "Estimated Glomerular Filtration Rate": "eGFR",
//    "Estimated Glomerular Filtration Rate (eGFR)": "eGFR",
//    "Est. GFR": "eGFR",
//    "Erythrocyte Concentration": "RBC",
//    "Erythrocyte Count": "RBC",
//    "Erythrocyte Level": "RBC",
//    "Erythrocyte MCH": "MHC",
//    "Erythrocyte MCHC": "MCHC",
//    "Erythrocyte MCV": "MVC",
//    "Erythrocytes": "RBC",
//    "GFR (estimated)": "eGFR",
//    "GFR Estimate": "eGFR",
//    "GFR Estimation": "eGFR",
//    "Glomerular Filtration Rate": "eGFR",
//    "Granulocytes": "Neutrophil",
//    "Haematocrit": "PCV",
//    "Haematocrit Measurement": "PCV",
//    "Haematocrit Test": "PCV",
//    "Haematocrit Value": "PCV",
//    "Haemoglobin": "Hemoglobin",
//    "Haemoglobin Concentration": "Hemoglobin",
//    "Haemoglobin Level": "Hemoglobin",
//    "Haemoglobin Measurement": "Hemoglobin",
//    "Hematocrit": "Hematocrit",
//    "Hematocrit (US spelling)": "PCV",
//    "Hematocrit Level": "Hematocrit",
//    "Hematocrit Measurement": "Hematocrit",
//    "Hematocrit Percentage": "Hematocrit",
//    "Hematocrit Test": "Hematocrit",
//    "Hematocrit Value": "Hematocrit",
//    "Hct": "Hematocrit",
//    "Hct Level": "PCV",
//    "Hct Percentage": "Hematocrit",
//    "Hct Reading": "Hematocrit",
//    "Hct Test": "Hematocrit",
//    "HCT": "Hematocrit",
//    "HCT Level": "Hematocrit",
//    "HCT Measurement": "Hematocrit",
//    "HCT Value": "Hematocrit",
//    "Hemoglobin": "Hemoglobin",
//    "Hemoglobin Concentration": "Hemoglobin",
//    "Hemoglobin Level": "Hemoglobin",
//    "Hemoglobin Measurement": "Hemoglobin",
//    "Hgb": "Hemoglobin",
//    "Hgb Concentration": "Hemoglobin",
//    "Hgb Level": "Hemoglobin",
//    "Lymphocyte concentration": "Lymphocytes",
//    "Lymphocyte count": "Lymphocytes",
//    "Lymphocyte fraction": "Lymphocytes",
//    "Lymphocyte index": "Lymphocytes",
//    "Lymphocyte level": "Lymphocytes",
//    "Lymphocyte percentage": "Lymphocytes",
//    "Lymphocyte population": "Lymphocytes",
//    "Lymphocyte subset": "Lymphocytes",
//    "Lymphocytes": "Lymphocytes",
//    "Lymphocytopenia": "Lymphocytes",
//    "Lymphocytosis": "Lymphocytes",
//    "Lymphocytosis (Absolute)": "Lymphocytes",
//    "Lymphoid cells": "Lymphocytes",
//    "Lymphoid leukocytes": "Lymphocytes",
//    "Lymphs": "Lymphocytes",
//    "MCV": "MVC",
//    "MCV (Mean Cell Volume)": "MVC",
//    "MCV (Mean Corpuscular Volume)": "MVC",
//    "MCV Level": "MVC",
//    "MCV Measurement": "MVC",
//    "MCV Reading": "MVC",
//    "MCV Test": "MVC",
//    "Mean Cell Hemoglobin": "MHC",
//    "Mean Cell Volume": "MVC",
//    "Mean Cell Volume (MCV)": "MVC",
//    "Mean Corpuscular Hemoglobin": "MHC",
//    "Mean Corpuscular Hemoglobin (MCH)": "MHC",
//    "Mean Corpuscular Hemoglobin Concentration": "MCHC",
//    "Mean Corpuscular Volume": "MVC",
//    "Mean Corpuscular Volume (MCV)": "MVC",
//    "Mean Erythrocyte Volume": "MVC",
//    "Mean RBC Hemoglobin": "MHC",
//    "Mean RBC Volume": "MVC",
//    "Mean Red Cell Hemoglobin": "MHC",
//    "Mean Red Cell Hemoglobin (MCH)": "MHC",
//    "Mean Red Cell Volume": "MVC",
//    "Mean Red Cell Volume (MCV)": "MVC",
//    "MCH": "MHC",
//    "MCH Concentration": "MCHC",
//    "MCH Test": "MHC",
//    "MCH Value": "MHC",
//    "MCHC": "MCHC",
//    "MCHC Concentration": "MCHC",
//    "MCHC Level": "MCHC",
//    "MCHC Test": "MCHC",
//    "MCHC Value": "MCHC",
//    "MHC": "MHC",
//    "Monocyte concentration": "Monocytes",
//    "Monocyte count": "Monocytes",
//    "Monocyte fraction": "Monocytes",
//    "Monocyte index": "Monocytes",
//    "Monocyte level": "Monocytes",
//    "Monocyte percentage": "Monocytes",
//    "Monocyte population": "Monocytes",
//    "Monocyte subset": "Monocytes",
//    "Monocytes": "Monocytes",
//    "Monocytosis": "Monocytes",
//    "Mononuclear cells": "Monocytes",
//    "Neutrophil concentration": "Neutrophil",
//    "Neutrophil count": "Neutrophil",
//    "Neutrophil fraction": "Neutrophil",
//    "Neutrophil index": "Neutrophil",
//    "Neutrophil level": "Neutrophil",
//    "Neutrophil percentage": "Neutrophil",
//    "Neutrophil population": "Neutrophil",
//    "Neutrophil subset": "Neutrophil",
//    "Neutrophilia": "Neutrophil",
//    "Neutrophilic cells": "Neutrophil",
//    "Neutrophilic granulocytes": "Neutrophil",
//    "Neutrophilic leukocytes": "Neutrophil",
//    "Neutrophils": "Neutrophil",
//    "PCV": "PCV",
//    "Plasma Albumin": "Albumin",
//    "Plasma Albumin Assay": "Albumin",
//    "Plasma Albumin Concentration": "Albumin",
//    "Plasma Albumin Level": "Albumin",
//    "Plasma Albumin Measurement": "Albumin",
//    "Plasma Albumin Test": "Albumin",
//    "Plasma Albumin Value": "Albumin",
//    "Plasma Creatinine": "Creatinine",
//    "Plasma Creatinine Level": "Creatinine",
//    "Plasma Creatinine Measurement": "Creatinine",
//    "Plasma Creatinine Test": "Creatinine",
//    "Plasma Creatinine Value": "Creatinine",
//    "Plasma Urate": "Uric Acid",
//    "Plasma Urate Level": "Uric Acid",
//    "Plasma Uric Acid": "Uric Acid",
//    "Plasma Uric Acid Level": "Uric Acid",
//    "RBC": "RBC",
//    "RBC Count": "RBC",
//    "RBC MCH": "MHC",
//    "RBC MCHC": "MCHC",
//    "RBC MCV": "MVC",
//    "RBC Measurement": "RBC",
//    "RBC Test": "RBC",
//    "RDW": "RDW",
//    "Red Blood Cell Count": "RBC",
//    "Red Blood Cell MCH": "MHC",
//    "Red Blood Cell MCHC": "MCHC",
//    "Red Blood Cell MCV": "MVC",
//    "Red Blood Cell Measurement": "RBC",
//    "Red Blood Cell Test": "RBC",
//    "Red Blood Cells": "RBC",
//    "Red Blood Corpuscles": "RBC",
//    "Red Cell Count": "RBC",
//    "Red Cell Distribution Width": "RDW",
//    "Red Cell Hemoglobin": "MHC",
//    "Red Cell Hemoglobin Concentration": "MCHC",
//    "Red Cell MCH": "MHC",
//    "Red Cell MCHC": "MCHC",
//    "Red Cell Mean Corpuscular Hemoglobin": "MHC",
//    "Red Cell Mean Corpuscular Hemoglobin Concentration": "MCHC",
//    "Red Cell Mean Corpuscular Volume": "MVC",
//    "Red Cell Mean Volume": "MVC",
//    "Red Cell Measurement": "RBC",
//    "Red Cell Test": "RBC",
////    "Red Cell Volume": "MVC",
//    "Red Cells": "RBC",
//    "Red Cell Volume": "MVC",
//    "Serum Creatinine": "Creatinine",
//    "Serum Creatinine Level": "Creatinine",
//    "Serum Creatinine Measurement": "Creatinine",
//    "Serum Creatinine Test": "Creatinine",
//    "Serum Creatinine Value": "Creatinine",
//    "Serum Urea": "Urea",
//    "Serum Urea Level": "Urea",
//    "Serum Urea Nitrogen": "Urea",
//    "Serum Urea Nitrogen Level": "Urea",
//    "Serum Urea Test": "Urea",
//    "Serum Urea Value": "Urea",
//    "Serum Urate": "Uric Acid",
//    "Serum Urate Level": "Uric Acid",
//    "Serum Uric Acid": "Uric Acid",
//    "Serum Uric Acid Level": "Uric Acid",
//    "Urea": "Urea",
//    "Urea Concentration": "Urea",
//    "Urea Level": "Urea",
//    "Urea Measurement": "Urea",
//    "Urea Nitrogen (BUN)": "Urea",
//    "Urea Nitrogen Level": "Urea",
//    "Urea Test": "Urea",
//    "Urea Value": "Urea",
//    "Uric Acid": "Uric Acid",
//    "Uric Acid Concentration": "Uric Acid",
//    "Uric Acid Level": "Uric Acid",
//    "Uric Acid Measurement": "Uric Acid",
//    "Uric Acid Test": "Uric Acid",
//    "Uric Acid Value": "Uric Acid",
//    "WBC": "WBC",
//    "WBC Count": "WBC",
//    "WBC Measurement": "WBC",
//    "WBC Test": "WBC",
//    "White Blood Cell Count": "WBC",
//    "White Blood Cells": "WBC"
//  ]
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



// Function to copy the CSV file from the bundle to the Documents directory
//func copyCSVToDocuments(fileName: String) {
//    let fileManager = FileManager.default
//
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
////        print("\(fileName).csv")
//        print("CSV file not found in bundle")
//    }
//}
//---=-=00987654567890-09876543
