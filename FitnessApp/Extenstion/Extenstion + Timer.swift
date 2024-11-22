//
//  Extenstion + Timer.swift
//  FitnessApp
//
//  Created by Kalani Kapuduwa on 2024-11-22.
//

import Foundation
import SwiftUI
extension Timer {
    static func animateNumber(number: Binding<Int>, busy: Binding<Bool>, start: Int, end: Int, duration: Double = 1.0) {
        busy.wrappedValue = true
        let startTime = Date()
        Timer.scheduledTimer(withTimeInterval: 1/120, repeats: true) { timer in
            let now = Date()
            let interval = now.timeIntervalSince(startTime)
            if !busy.wrappedValue {
                timer.invalidate()
            }
            if interval >= duration {
                number.wrappedValue = end
                timer.invalidate()
                busy.wrappedValue = false
            } else {
                number.wrappedValue = start + Int(Double(end - start)*(interval/duration))
            }
        }
    }
}
