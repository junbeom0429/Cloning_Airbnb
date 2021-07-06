//
//  Enum.swift
//  airbnb
//
//  Created by JB on 2021/07/07.
//

import Foundation

public enum Direction: Int {
    case Up
    case Down
    case Left
    case Right

    public var isX: Bool { return self == .Left || self == .Right }
    public var isY: Bool { return !isX }
}
