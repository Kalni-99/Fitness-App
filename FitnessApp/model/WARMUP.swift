//
//  WARMUP.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-11.
//

import Firebase
import FirebaseFirestore

struct WARMUP {
    let exe_name: String
    let exe_des: String
    let exe_seconds: Int
    let exe_rep: Int
    let exe_set: Int
    let exe_img : String

    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        exe_name = snapshotValue["exe_name"] as! String
        exe_des = snapshotValue["exe_des"] as! String
        exe_seconds = snapshotValue["exe_seconds"] as! Int
        exe_rep = snapshotValue["exe_rep"] as! Int
        exe_set = snapshotValue["exe_set"] as! Int
        exe_img = snapshotValue["exe_img"] as! String
    }
}
