//
//  Coinage.swift
//  ByteCoin
//
//  Created by Harry Wright on 12/10/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Coinage {
    let value: Double
    var valueFormatted: String {
        return String(format: "%.2f", value)
    }
}
