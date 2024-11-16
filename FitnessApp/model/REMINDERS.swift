//
//  REMINDERS.swift
//  FitnessApp
//
//  Created by Mac on 2024-11-11.
//

import Firebase
import FirebaseFirestore

struct REMINDERS {
    let title: String
    let body: String

    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        title = snapshotValue["title"] as! String
        body = snapshotValue["body"] as! String
    }
}

