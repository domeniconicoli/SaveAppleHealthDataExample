//
//  HealthKitAssistant.swift
//  SaveAppleHealthDataExample
//
//  Created by Domo on 03/12/2019.
//  Copyright © 2019 Domo. All rights reserved.
//

import HealthKit

open class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    public class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
 
        guard let stepsCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [stepsCount,
                                                        HKObjectType.workoutType()]
        
        let healthKitTypesToRead: Set<HKObjectType> = [stepsCount,
                                                       HKObjectType.workoutType()]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
        
    }
    
    public class func saveHeartRate(heartRateValue: Int,
                             date: Date,
                             completion: @escaping (Error?) -> Swift.Void) {
        
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            fatalError("Heart Rate Type is no longer available in HealthKit")
        }
        
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        let heartRateQuantity = HKQuantity(unit: heartRateUnit,
                                          doubleValue: Double(heartRateValue))
        
        let heartRateSample = HKQuantitySample(type: heartRateType,
                                                   quantity: heartRateQuantity,
                                                   start: date,
                                                   end: date)
        
        HKHealthStore().save(heartRateSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Heart Rate Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Heart Rate Sample")
            }
        }
        
    }
    
    public class func saveSteps(stepsCountValue: Int,
                             date: Date,
                             completion: @escaping (Error?) -> Swift.Void) {
        
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            fatalError("Step Count Type is no longer available in HealthKit")
        }
        
        let stepsCountUnit:HKUnit = HKUnit.count()
        let stepsCountQuantity = HKQuantity(unit: stepsCountUnit,
                                           doubleValue: Double(stepsCountValue))
        
        let stepsCountSample = HKQuantitySample(type: stepCountType,
                                               quantity: stepsCountQuantity,
                                               start: date,
                                               end: date)
        
        HKHealthStore().save(stepsCountSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Steps Count Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Steps Count Sample")
            }
        }
        
    }
    
    public class func saveDistance(distanceValue: Double,
                         date: Date,
                         completion: @escaping (Error?) -> Swift.Void) {
        
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Distance Type is no longer available in HealthKit")
        }
        
        let distanceUnit:HKUnit = HKUnit.meter()
        var valueToSave = distanceValue * 1000
        
        let distanceQuantity = HKQuantity(unit: distanceUnit,
                                            doubleValue: valueToSave)
        
        let distanceSample = HKQuantitySample(type: distanceType,
                                                quantity: distanceQuantity,
                                                start: date,
                                                end: date)
        
        HKHealthStore().save(distanceSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Distance Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Distance Sample")
            }
        }
        
    }
    
    public class func saveCaloriesBurned(caloriesBurnedValue: Double,
                            date: Date,
                            completion: @escaping (Error?) -> Swift.Void) {
        
        guard let caloriesBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            fatalError("Calories Burned Type is no longer available in HealthKit")
        }
        
        let caloriesBurnedUnit:HKUnit = HKUnit.calorie()
        let caloriesBurnedQuantity = HKQuantity(unit: caloriesBurnedUnit,
                                          doubleValue: caloriesBurnedValue * 1000)
        
        let caloriesBurnedSample = HKQuantitySample(type: caloriesBurnedType,
                                              quantity: caloriesBurnedQuantity,
                                              start: date,
                                              end: date)
        
        HKHealthStore().save(caloriesBurnedSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Calories Burned Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Calories Burned Sample")
            }
        }
        
    }
    
    public class func saveSleep(startDate: Date,
                            endDate: Date,
                            completion: @escaping (Error?) -> Swift.Void) {
        
        guard let sleepType = HKQuantityType.categoryType(forIdentifier: .sleepAnalysis) else {
            fatalError("Sleep Type is no longer available in HealthKit")
        }
        
        let sleepSample = HKCategorySample(type:sleepType,
                                           value: HKCategoryValueSleepAnalysis.inBed.rawValue,
                                           start: startDate,
                                           end: endDate)
        
        HKHealthStore().save(sleepSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Sleep Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Sleep Sample")
            }
        }
        
    }
    
    public class func saveFloorClimbed(floorClimbedCountValue: Int,
                                       date: Date,
                                       completion: @escaping (Error?) -> Swift.Void) {
    
        guard let floorClimbedCountType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            fatalError("Floor climbed Count Type is no longer available in HealthKit")
        }
        
        let floorClimbedCountUnit:HKUnit = HKUnit.count()
        let floorClimbedCountQuantity = HKQuantity(unit: floorClimbedCountUnit,
                                            doubleValue: Double(floorClimbedCountValue))
        
        let floorClimbedCountSample = HKQuantitySample(type: floorClimbedCountType,
                                                quantity: floorClimbedCountQuantity,
                                                start: date,
                                                end: date)
        
        HKHealthStore().save(floorClimbedCountSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Floor Climbed Count Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Floor Climbed Sample")
            }
        }
        
    }
    
    public class func saveBodyMass(bodyMassValue: Double,
                                date: Date,
                                completion: @escaping (Error?) -> Swift.Void) {
        
        guard let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            fatalError("Body Mass Type is no longer available in HealthKit")
        }
        
        let bodyMassQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo),
                                          doubleValue: bodyMassValue)
        
        let bodyMassSample = HKQuantitySample(type: bodyMassType,
                                                   quantity: bodyMassQuantity,
                                                   start: date,
                                                   end: date)
        
        HKHealthStore().save(bodyMassSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Body Mass Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Body Mass Sample")
            }
        }
        
    }
    
    public class func saveBMI(bmiValue: Double,
                                   date: Date,
                                   completion: @escaping (Error?) -> Swift.Void) {
        
        guard let bmiType = HKQuantityType.quantityType(forIdentifier: .bodyMassIndex) else {
            fatalError("BMI Type is no longer available in HealthKit")
        }
        
        let bmiQuantity = HKQuantity(unit: HKUnit.count(),
                                          doubleValue: bmiValue)
        
        let bmiSample = HKQuantitySample(type: bmiType,
                                              quantity: bmiQuantity,
                                              start: date,
                                              end: date)
        
        HKHealthStore().save(bmiSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving BMI Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved BMI Sample")
            }
        }
        
    }
    
    public class func saveFatPercentage(fatPercentageValue: Double,
                              date: Date,
                              completion: @escaping (Error?) -> Swift.Void) {
        
        guard let fatPercentageType = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage) else {
            fatalError("Fat Percentage Type is no longer available in HealthKit")
        }
        
        let fatPercentageQuantity = HKQuantity(unit: HKUnit.percent(),
                                     doubleValue: fatPercentageValue)
        
        let fatPercentageSample = HKQuantitySample(type: fatPercentageType,
                                         quantity: fatPercentageQuantity,
                                         start: date,
                                         end: date)
        
        HKHealthStore().save(fatPercentageSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Fat Percentage Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Fat Percentage Sample")
            }
        }
        
    }
    
    public class func deleteSample(for sampleType: HKSampleType,
                                date: Date,
                                completion: @escaping (Error?) -> Swift.Void) {
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: date,
                                                              end: Calendar.current.date(byAdding: .day, value: 1, to: date),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: 1000,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                       
            if let querySamples = samples as? [HKQuantitySample] {
                for sample in querySamples {
                    if sample.sourceRevision.source.name == "FitSync" {
                        HKHealthStore().delete(sample, withCompletion: { (success, error) in
                            if let err = error {
                                print("———> Could not delete sample \(sample.sampleType.identifier) from HealthKit: \(err)")
                            } else {
                                print("———> Deleted sample from HealthKit")
                            }
                        })
                    }
                }
 
            } else if let querySamples = samples {
                for item in querySamples {
                    if let sample = item as? HKCategorySample {
                        HKHealthStore().delete(sample, withCompletion: { (success, error) in
                            if let err = error {
                                print("———> Could not delete sample \(sample.sampleType.identifier) from HealthKit: \(err)")
                            } else {
                                print("———> Deleted sample from HealthKit")
                            }
                        })
                    }
                }
            }
            
            completion(nil)
                                            
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    
    public class func deleteSpecificSample(samples: [HKSample]) {
        
        for sample in samples {
            if sample.sourceRevision.source.name == "FitSync" {
                HKHealthStore().delete(sample, withCompletion: { (success, error) in
                    if let err = error {
                        print("———> Could not delete sample \(sample.sampleType.identifier) from HealthKit: \(err)")
                    } else {
                        print("———> Deleted sample from HealthKit")
                    }
                })
            }
        }
        
    }
    
    public class func readSample(for sampleType: HKSampleType,
                                   date: Date,
                                   completion: @escaping ([HKSample]?) -> ()) {
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: date,
                                                              end: Calendar.current.date(byAdding: .day, value: 1, to: date),
                                                              options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: 1000,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                            
                                            completion(samples)
                                            
        }
        
        HKHealthStore().execute(sampleQuery)
    }
        
}
