//
//  Resources.swift
//  RClient
//
//  Created by Andrew Steellson on 21.08.2023.
//

import Foundation

public enum R {
    
    enum SystemDebugError: String {
        case serverCreditionsContainerExists = "UserDefaults: ** Server creditions already configured **"
    }
    
    enum Strings: String {
        case rocketChatOpenServerUrl = " https://open.rocket.chat/"
        
        case joinServerFieldPreviewText = "Enter URL of your server:"
        
        case loginScreenWelcomeTitle = "Welcome to the Rocket.Chat!"
        case loginScreenSubtitle = "Enter your creditnails: "
        case loginScreenEmailFieldPlaceholder = "Enter email"
        case loginScreenPasswordFieldPlaceholder = "Enter password"
        
        case registrationTitleLabelText = "Please, fill in all this fields"
        case registrationScreenUsernameFieldPlaceholder = "Enter username"
        case registrationScreenFullNameFieldPlaceholder = "Enter your full name"
        case registrationScreenEmailFieldPlaceholder = "Enter valid email"
        case registrationScreenPasswordFieldPlaceholder = "Enter strong password"
        case registrationScreenReplyFieldPlaceholder = "Enter password again"
    }
}
