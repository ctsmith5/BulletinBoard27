//
//  CloudKitController.swift
//  BulletinBoard27
//
//  Created by Colin Smith on 7/8/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    static let shared = CloudKitController()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    //MARK: - CRUD
    
    //Create
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, complete: @escaping (Bool) -> Void){
        database.save(record) { (_, error) in
            if let error = error {
                print("Error Saving record to cloudkit \(#function),  \(error.localizedDescription) /n---/n \(error)")
            }
        }
        
    }
    //Read
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: type, predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error Saving record to cloudkit \(#function),  \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            if let records = records {
                completion(records, nil)
            }
        }
    }
}
