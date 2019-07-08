//
//  Message.swift
//  BulletinBoard27
//
//  Created by Colin Smith on 7/8/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    //Keys for Cloudkit storage
    static let typeKey = "Message"
    private let textKey = "Text"
    private let timestampKey = "Timestamp"
    
    let timestamp: Date
    let text: String
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Message.typeKey)
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        return record
    }
    
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    init?(record: CKRecord) {
        guard let text = record[textKey] as? String,
            let timestamp = record[timestampKey] as? Date else {return nil}
        self.text = text
        self.timestamp = timestamp
    }
}

