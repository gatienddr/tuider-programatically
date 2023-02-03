//
//  User.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 01/12/2022.
//

import Foundation

final class Profil {

    var name: String
    var picPath: String
    var lastMessage: String
    private(set) var wasMatched: Bool = false

    private(set) static var all: [Profil] = []
    func setMatched(_ setMatch: Bool) {
        self.wasMatched = setMatch
    }

    init(name: String, picPath: String, lastMessage: String) {
        self.name = name
        self.picPath = picPath
        self.lastMessage = lastMessage
    }
}
