//
//  GCDBlackBox.swift
//  On-the-Map
//
//  Created by Christine Chang on 2/16/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
