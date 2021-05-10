//
//  Entry.swift
//  Gavin-Journal-CloudKit
//
//  Created by Gavin Woffinden on 5/10/21.
//

import Foundation
import CloudKit


struct EntryStringConstants {
    
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timeStampKey = "timestamp"
    static let recordTypeKey = "Entry"
    
}


class Entry {
    
    let title: String
    let body: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryStringConstants.recordTypeKey, recordID: entry.ckRecordID)
        self.setValuesForKeys([
            EntryStringConstants.titleKey : entry.title,
            EntryStringConstants.bodyKey : entry.body,
            EntryStringConstants.timeStampKey : entry.timestamp
        ])
    }
}


extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStringConstants.titleKey] as? String,
              let body = ckRecord[EntryStringConstants.bodyKey] as? String,
              let timestamp = ckRecord[EntryStringConstants.timeStampKey] as? Date
              else {return nil}
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}
