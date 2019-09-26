//
//  HealthManager.swift
//
//
//  Created by Vishal Nandoriya on 7/21/18.
//  Copyright © 2017 Vishal Nandoriya. All rights reserved.
//

import Foundation
import HealthKit

class HealthManagerKit {
        
    class var Shared: HealthManagerKit {
        struct Static {
            static var onceToken: Int = 0
            static var instance = HealthManagerKit()
        }
        return Static.instance
    }
    
    let healthKitStore:HKHealthStore = HKHealthStore()

    
    //MARK:
    //MARK: Auth
    func authorizeHealthKit(completion:@escaping(_ success:Bool, _ error:NSError?) -> Void)
    {
        // 1. Set the types you want to read from HK Store
        let healthKitTypesToRead : Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!,
            
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!,
//            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!,
//            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,

            HKObjectType.workoutType()
            ]
        
        // 2. Set the types you want to write to HK Store
        let healthKitTypesToWrite : Set<HKObjectType> = [
//            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
//            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
//            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,

            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!,

            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!,
//            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!,
//            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!,


            HKQuantityType.workoutType()
            ]
        
        // 3. If the store is not available (for instance, iPad) return an error and don't go on.
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: "com.iMobDev.iutilities", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            completion(false,error as NSError)

            return;
        }
        
        // 4.  Request HealthKit authorization
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite as? Set<HKSampleType>, read: healthKitTypesToRead) { (success, error) -> Void in
            if error != nil {
                completion(success,error! as NSError)
            }else{
                completion(success,nil)

            }
        }
    }
    
    func getAgeSexAndBloodType() throws -> (age: Int,
        biologicalSex: HKBiologicalSex,
        bloodType: HKBloodType) {
            
            do {
                //1. This method throws an error if these data are not available.
                let birthdayComponents =  try self.healthKitStore.dateOfBirthComponents()
                let biologicalSex =       try self.healthKitStore.biologicalSex()
                let bloodType =           try self.healthKitStore.bloodType()
                
                //2. Use Calendar to calculate age.
                let today = Date()
                let calendar = Calendar.current
                let todayDateComponents = calendar.dateComponents([.year],
                                                                  from: today)
                let thisYear = todayDateComponents.year!
                let age = thisYear - birthdayComponents.year!
                
                //3. Unwrap the wrappers to get the underlying enum values.
                let unwrappedBiologicalSex = biologicalSex.biologicalSex
                let unwrappedBloodType = bloodType.bloodType
                
                return (age, unwrappedBiologicalSex, unwrappedBloodType)
            }
    }

    // Function to get a BMR daily calories intake, based on:
    // Weight, Height, Age, and Gender
    //(completion: @escaping (_ weight: Double, _ height: Double,_ age: Int) -> Void)
    func getBMR(weight:Double, height:Double, age:Int, gender: String, completion: @escaping (_ bmr: Int)-> Void){
        //Declare local variables
        var BMR = 0.0
        var weightCalculation = 0.0
        var heightCalculation = 0.0
        var ageCalculaition = 0.0
        
        //If Gender is Male, use the following formula: BMR=66.47+ (13.75 x W) + (5.0 x H) - (6.75 x A)
        if gender == "Male" {
            weightCalculation = 13.75 * toKilograms(weight: weight)
            heightCalculation = 5.0 * toCentimeters(height: height)
            ageCalculaition = 6.75 * Double(age)
            
            BMR = 66.47 + weightCalculation  + heightCalculation - ageCalculaition
            completion(Int(BMR))
        }
            //Else Gender is Female, use the following formula: BMR=665.09 + (9.56 x W) + (1.84 x H) - (4.67 x A)
        else{
            weightCalculation = 9.56 * toKilograms(weight: weight)
            heightCalculation = 1.84 * toCentimeters(height: height)
            ageCalculaition = 4.67 * Double(age)
            
            BMR =  665.09 + weightCalculation + heightCalculation - ageCalculaition
            
            completion(Int(BMR))
        }
    }
    
    func getBMRCalculation(completion: @escaping (_ bmr: Int)-> Void){
        let healthProfileManager = HealthProfileManager()
        healthProfileManager.readWeightInPoundAndHeightInInces { (weight, height) in
            self.getBMR(weight: weight, height: height, age: AppUserDefaults.getUserAge(), gender: AppUserDefaults.getUserSex()) { (bmr) in
                completion(bmr)
            }
            
        }
    }
        
    // Function to convert from pounds to killograms
    private func toKilograms(weight:Double)->Double{
        return weight/2.2
    }
    
    // Function to convert from inches into centemiters
    private func toCentimeters(height:Double)->Double{
        return height*2.54
    }
    
    
    
    //MARK:
    //MARK: Steps Count
    func retrieveCurrentDayStepCount(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        //   Define the Step Quantity Type
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        //   Get the start of the day
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        //  Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        var interval = DateComponents()
        interval.day = 1
        
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                
                //  Something went Wrong
                return
            }
            
            if let myResults = results{
                let calendar = Calendar.current
                let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: Date())
                
                myResults.enumerateStatistics(from: oneDayAgo!, to: Date()) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        
                        print("Steps = \(steps)")
                        completion(steps)
                        
                    }
                }
            }
            
            
        }
        
        healthKitStore.execute(query)
    }
    
    func getWalkingRunningMile(completion: @escaping (Double, NSError?) -> ()){
        guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Something went wrong retriebing quantity type distanceWalkingRunning")
        }
//        let date =  Date()
//        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
//        let newDate = cal.startOfDay(for: date)
        
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                  timeZone: nil,
                                  era: nil,
                                  year: curryear,
                                  month: currmonth,
                                  day: currday-7,
                                  hour: nil,
                                  minute: nil,
                                  second: nil,
                                  nanosecond: nil,
                                  weekday: nil,
                                  weekdayOrdinal: nil,
                                  quarter: nil,
                                  weekOfMonth: nil,
                                  weekOfYear: nil,
                                  yearForWeekOfYear: nil)
        
        let dates = calendar.date(from: last)!
        
        let predicate = HKQuery.predicateForSamples(withStart: dates, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
            var value: Double = 0
            
            if error != nil {
                print("something went wrong")
            } else if let quantity = statistics?.sumQuantity() {
                value = quantity.doubleValue(for: HKUnit.mile())
            }
            DispatchQueue.main.async {
                completion(value,nil)
            }
        }
        self.healthKitStore.execute(query)
    }
    
    func getAllSteps(completion: @escaping (Double, [Double], NSError?) -> ()) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                  timeZone: nil,
                                  era: nil,
                                  year: curryear,
                                  month: currmonth,
                                  day: currday-7,
                                  hour: nil,
                                  minute: nil,
                                  second: nil,
                                  nanosecond: nil,
                                  weekday: nil,
                                  weekdayOrdinal: nil,
                                  quarter: nil,
                                  weekOfMonth: nil,
                                  weekOfYear: nil,
                                  yearForWeekOfYear: nil)
        
        let dates = calendar.date(from: last)!
        
        let predicate = HKQuery.predicateForSamples(withStart: dates, end: Date(), options: [])
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
            query, results, error in
            var steps: Double = 0
            var allSteps = [Double]()
            if let myResults = results {
                for result in myResults as! [HKQuantitySample] {
                    print(myResults)
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                    allSteps.append(result.quantity.doubleValue(for: HKUnit.count()))
                }
            }
            completion(steps, allSteps, error as NSError?)
            
        }
        self.healthKitStore.execute(query)
    }
    
    //MARK:
    //MARK: Recent Sample
    func readMostRecentSample(for type: HKSampleType, completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        let mostRecentSortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let sampleQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: 1, sortDescriptors: [mostRecentSortDescriptor]) { (query, result, error) in
            
            DispatchQueue.main.async {
                guard let samples = result as? [HKQuantitySample], let sample = samples.first else {
                    completion(nil, error)
                    return
                }
                completion(sample, nil)
            }
        }
        
        self.healthKitStore.execute(sampleQuery)
    }

    
    func writeSample(for quantityType: HKQuantityType, sampleQuantity: HKQuantity, completion: @escaping (Bool, Error?) -> Void) {
        
        let sample = HKQuantitySample(type: quantityType, quantity: sampleQuantity, start: Date(), end: Date())
        self.healthKitStore.save(sample) { (sucess, error) in
            DispatchQueue.main.async {
                completion(sucess, error)
            }
        }
    }

    //MARK: Sleep Analyis
    //MARK:
    func saveSleepAnalysis(categorySleepValue: Int, startTime: Date, endTime: Date, completion: @escaping ((Bool, Error?) -> Swift.Void)) {
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            let object = HKCategorySample(type: sleepType, value: categorySleepValue, start: startTime, end: endTime)
            
            self.healthKitStore.save(object, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    completion(false, error)
                    return
                }
                if success {
                    completion(true, nil)
                    
                } else {
                    // It was an error again
                }
                
            })
        }
    }

    func retrieveSleepAnalysis(resultsHandler: @escaping ([HKSample]?, Error?) -> Void) {
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {

            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // the block completion to execute
            
            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 30, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    return
                }
                if let result = tmpResult {
                    resultsHandler(result, error)
//                    for item in result {
//                        if let sample = item as? HKCategorySample {
//                            
//                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
//                            
//                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
//                        }
//                    }
                }
            }
            self.healthKitStore.execute(query)
        }
    }
    func dateForAllData() -> Date{
        
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                  timeZone: nil,
                                  era: nil,
                                  year: curryear,
                                  month: currmonth,
                                  day: currday-7,
                                  hour: nil,
                                  minute: nil,
                                  second: nil,
                                  nanosecond: nil,
                                  weekday: nil,
                                  weekdayOrdinal: nil,
                                  quarter: nil,
                                  weekOfMonth: nil,
                                  weekOfYear: nil,
                                  yearForWeekOfYear: nil)
        
        let dates = calendar.date(from: last)!
        return dates
    }
    
    func dateForOneDayDate() -> Date{
        //   Get the start of the day
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        return newDate
    }
    
    func getRetriveHealthData(type:HKSampleType?, startDate:Date, endDate:Date, completion: @escaping ([HKSample]?, NSError?) -> ())
    {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
            query, results, error in
            if error != nil {
                completion(nil,error as NSError?)
            }
            if let myResults = results {
                completion(myResults,nil)
            }
            
            
        }
        self.healthKitStore.execute(query)
    }
    
    //MARK:
    //MARK: Work out save
    func saveWorkout(workoutType:HKWorkoutActivityType, workoutStartDate:Date,workoutEndDate:Date,workoutDuration:TimeInterval,workoutEnergyBurned:Double,workoutTotalDistance:Double,workoutSteps:Double, completion: @escaping ((Bool, Error?) -> Swift.Void)) {
        
        //Setup the Calorie Quantity for total energy burned
        let calorieQuantity = HKQuantity(unit: HKUnit.kilocalorie(),
                                         doubleValue: workoutEnergyBurned)
        
        let stepsQuantity = HKQuantity(unit: HKUnit.count(),
                                       doubleValue: workoutSteps)
        
        let distanceQuantity = HKQuantity(unit: HKUnit.mile(),
                                          doubleValue: (workoutTotalDistance * 0.62137)) //Convert km to mile
        //Build the workout using data from your Prancercise workout
        let workout = HKWorkout(activityType: workoutType,
                                start: workoutStartDate,
                                end: workoutEndDate,
                                duration: workoutDuration,
                                totalEnergyBurned: calorieQuantity,
                                totalDistance: distanceQuantity,
                                device: HKDevice.local(),
                                metadata: nil)
        
        var samples = [HKSample]()
        
        //Verify that the energy quantity type is still available to HealthKit.
        guard let energyQuantityType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned) else {
            fatalError("*** Energy Burned Type Not Available ***")
        }
        
        guard let stepsQuantityType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else {
            fatalError("*** Steps Type Not Available ***")
        }
        
        let sampleCalories = HKQuantitySample(type: energyQuantityType,
                                              quantity: calorieQuantity,
                                              start: workoutStartDate,
                                              end: workoutEndDate)
        
        let sampleSteps = HKQuantitySample(type: stepsQuantityType,
                                           quantity: stepsQuantity,
                                           start: workoutStartDate,
                                           end: workoutEndDate)
        
        samples.append(sampleCalories)
        samples.append(sampleSteps)
        self.healthKitStore.save(workout) { (success, error) in
            
            guard error == nil else {
                completion(false, error)
                return
            }
            self.healthKitStore.add(samples,
                                    to: workout,
                                    completion: { (samples, error) in
                                        
                                        guard error == nil else {
                                            completion(false, error)
                                            return
                                        }
                                        
                                        completion(true, nil)
            })
        }
    }

    class func loadWorkoutsData(workoutActivityType: HKWorkoutActivityType, completion: @escaping (([HKWorkout]?, Error?) -> Swift.Void)){
        
        let workoutPredicate = HKQuery.predicateForWorkouts(with: workoutActivityType)
        
        let sourcePredicate = HKQuery.predicateForObjects(from: HKSource.default())
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [workoutPredicate,
                                                                           sourcePredicate])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(),
                                  predicate: compound,
                                  limit: 0,
                                  sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                    
                                    DispatchQueue.main.async {
                                        
                                        guard let samples = samples as? [HKWorkout],
                                            error == nil else {
                                                completion(nil, error)
                                                return
                                        }
                                        
                                        completion(samples, nil)
                                    }
        }
        
        HKHealthStore().execute(query)
    }
}

