//
//  Message.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

class Message {
    var title: String?
    var dateString: String?
    var who: WhoType?
}

enum WhoType {
    case me
    case chatBot
}
