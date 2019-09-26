//
//  HealthProfileManager.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/15/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation
import HealthKit

extension HKBiologicalSex {
    
    var stringRepresentation: String {
        switch self {
        case .notSet: return "Unknown"
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        }
    }
}


class HealthProfileManager {
    
    var heightInMeter:Double?
    var weightInKg:Double?
    var weightInPound:Double?
    var heightInInches:Double?

    func initWithProfileData(height:Double, weight:Double,isKilogram:Bool, isFeet:Bool){
        
        self.isKg = isKilogram
        self.isFit = isFeet
        self.weight = weight
        self.bodyHeight = height
        
        self.saveUserData()
    }
    
    private var isKg: Bool? = nil {
        didSet {
            CalculateBMI()
        }
    }
    
    private var isFit: Bool? = nil {
        didSet {
            CalculateBMI()
        }
    }
    
    //Weight & Height Calculation
    var weight: Double? = nil {
        didSet {
            CalculateBMI()
        }
    }
    
    var bodyHeight: Double? = nil {
        didSet {
            CalculateBMI()
        }
    }
    
    private var bodyMassIndex: Double? = nil {
        didSet {
            updateUI()
        }
    }
    
    func CalculateBMI() {
        // BMI = weight / height^2
        
        guard let weight = weight, let bodyHeight = bodyHeight, let isKg = isKg,let isFit = isFit, bodyHeight > 0 else {
            return
        }
        var weightInKiloG:Double
        var heightInMeter:Double
        
        if isKg{
            weightInKiloG = weight
            
        }else{
            weightInKiloG = Measurement(value: weight, unit: UnitMass.pounds).converted(to: UnitMass.kilograms).value
        }
        
        if isFit{
            heightInMeter = Measurement(value: bodyHeight, unit: UnitLength.feet).converted(to: UnitLength.meters).value
        }else{
            heightInMeter = Measurement(value: bodyHeight, unit: UnitLength.centimeters).converted(to: UnitLength.meters).value
        }
        
        bodyMassIndex = weightInKiloG/(heightInMeter * heightInMeter)
    }
    
    func updateUI() {
        
        DispatchQueue.main.async {
            if let weight = self.weight {
                
                print("weight:\(weight)")
            }
            if let bodyHeight = self.bodyHeight {
                print("height:\(bodyHeight)")
            }
            if let bodyMassIndex = self.bodyMassIndex {
                print("bodyMassIndex:\(bodyMassIndex)")
            } else {
                print("Unknown")
                
            }
        }
    }
    
    func readWeightInPoundAndHeightInInces(completion: @escaping (_ weight: Double, _ height: Double) -> Void) {
        guard let heightType = HKSampleType.quantityType(forIdentifier: .height),
            let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
                print("Something horrible has happened.")
                return
        }
        
        HealthManagerKit.Shared.readMostRecentSample(for: weightType) { (sample, error) in
            if let sample = sample {
                self.weightInPound = sample.quantity.doubleValue(for: HKUnit.pound())
                HealthManagerKit.Shared.readMostRecentSample(for: heightType) { (sample, error) in
                    if let sample = sample {
                        self.heightInInches = sample.quantity.doubleValue(for: HKUnit.inch())
                        completion(self.weightInPound!, self.heightInInches!)
                    }
                }
                
            }
        }
    }
    
     func readWeightAndHeight() {
        
        guard let heightType = HKSampleType.quantityType(forIdentifier: .height),
            let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
                print("Something horrible has happened.")
                return
        }
        HealthManagerKit.Shared.readMostRecentSample(for: heightType) { (sample, error) in
            if let sample = sample {
                if AppUserDefaults.isFeetType(){
                    self.bodyHeight = sample.quantity.doubleValue(for: HKUnit.foot())
                }else{
                    self.bodyHeight = Measurement(value: sample.quantity.doubleValue(for: HKUnit.meter()), unit: UnitLength.meters).converted(to: UnitLength.centimeters).value
                }
                self.heightInMeter = sample.quantity.doubleValue(for: HKUnit.meter())
            }
        }
        HealthManagerKit.Shared.readMostRecentSample(for: weightType) { (sample, error) in
            if let sample = sample {
                if AppUserDefaults.isKgType(){
                    self.weight = Measurement(value: sample.quantity.doubleValue(for: HKUnit.pound()), unit: UnitMass.pounds).converted(to: UnitMass.kilograms).value
                }else{
                    self.weight = sample.quantity.doubleValue(for: HKUnit.pound())
                }
                self.weightInKg = Measurement(value: sample.quantity.doubleValue(for: HKUnit.pound()), unit: UnitMass.pounds).converted(to: UnitMass.kilograms).value
            }
        }
        
        updateUI()
    }
    
    private func saveUserData() {
        
        // Prepare Data
        guard let weight = weight,
            let bodyHeight = bodyHeight,
            let bodyMassIndex = bodyMassIndex else {
                return
        }
        guard let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass),
            let heightType = HKQuantityType.quantityType(forIdentifier: .height),
            let bodyMassIndexType = HKQuantityType.quantityType(forIdentifier: .bodyMassIndex) else {
                print("Something terrible has happened.")
                return
        }
        var weightQuantity:HKQuantity
        var heightQuantity:HKQuantity
        
        if isKg!{
            weightQuantity = HKQuantity(unit: HKUnit.gram(), doubleValue: Measurement(value: weight, unit: UnitMass.kilograms).converted(to: UnitMass.grams).value)
            
        }else{
            weightQuantity = HKQuantity(unit: HKUnit.pound(), doubleValue: weight)
        }
        
        if isFit!{
            heightQuantity = HKQuantity(unit: HKUnit.foot(), doubleValue: Double(bodyHeight).rounded(toPlaces: 1))
        }else{
            heightQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: Measurement(value: bodyHeight, unit: UnitLength.centimeters).converted(to: UnitLength.meters).value)
        }
        
        let bodyMassIndexQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: bodyMassIndex)
        
        // Save Data
        var errorOccured = false
        HealthManagerKit.Shared.writeSample(for: weightType, sampleQuantity: weightQuantity) { (sucess, error) in
            if !sucess, let error = error {
                errorOccured = true
                print(error.localizedDescription)
            }
        }
        HealthManagerKit.Shared.writeSample(for: heightType, sampleQuantity: heightQuantity) { (sucess, error) in
            if !sucess, let error = error {
                errorOccured = true
                print(error.localizedDescription)
            }
        }
        HealthManagerKit.Shared.writeSample(for: bodyMassIndexType, sampleQuantity: bodyMassIndexQuantity) { (sucess, error) in
            if !sucess, let error = error {
                errorOccured = true
                print(error.localizedDescription)
            }
        }
        
        // Error Handling
        if errorOccured {
            print("Failed to Save Data,Some error occured while writing to HealthKit.")
        } else {
            print("Success!Successfully saved your data to HealthKit.")
            
        }
    }
}
