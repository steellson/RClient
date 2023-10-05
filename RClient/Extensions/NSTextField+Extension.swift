//
//  NSTextField+Extension.swift
//  RClient
//
//  Created by Andrew Steellson on 28.08.2023.
//

import SwiftUI

// Remove TextField system blue selection
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
