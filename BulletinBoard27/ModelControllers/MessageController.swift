//
//  MessageController.swift
//  BulletinBoard27
//
//  Created by Colin Smith on 7/8/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation


class MessageController {
    
    static let shared = MessageController()
    
    
    var messages: [Message] = []
    
    
    //MARK: - CRUD
    
    //CREATE
    func saveMessage(_ text: String){
        
        let messageToSave = Message(text: text)
        let database = CloudKitController.shared.publicDB
        CloudKitController.shared.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { (success) in
            if success{
                print("HALE YEA")
                self.messages.append(messageToSave)
            }
        }
    }
    //READ
    func fetchMessageRecords() {
        let database = CloudKitController.shared.publicDB
        CloudKitController.shared.fetchRecordsOf(type: Message.typeKey, database: database) { (records, error) in
            if let error = error {
                print("Error Saving record to cloudkit \(#function),  \(error.localizedDescription) /n---/n \(error)")
            }
            guard let foundRecords = records else {return}
            let messages = foundRecords.compactMap({Message(record: $0)})
            self.messages = messages
        }
    }
    //UPDATE
    
    //DELETE
    
}
