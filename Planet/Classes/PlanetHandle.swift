//
//  PlanetHandle.swift
//  Planet_Example
//
//  Created by yulong mei on 2021/2/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

public protocol Tract {
    var name: String { get }
    
    var diameter: String { get }
    
    var age: String { get }
}

 extension Planet: Tract {
    public var name: String {
        switch self {
        case .Mercury:
            return "水星"
        case .Venus:
            return "金星"
        case .Earth:
            return "地球"
        case .Mars:
            return "火星"
        case .Jupiter:
            return "木星"
        case .Saturn:
            return "土星"
        case .Uranus:
            return "天王星"
        case .Neptune:
            return "海王星"
        }
    }
    
    public var diameter: String {
        switch self {
        case .Mercury:
            return "1"
        case .Venus:
            return "2"
        case .Earth:
            return "3"
        case .Mars:
            return "4"
        case .Jupiter:
            return "5"
        case .Saturn:
            return "6"
        case .Uranus:
            return "7"
        case .Neptune:
            return "8"
        }
    }
    
    public var age: String {
        switch self {
        case .Mercury:
            return "100"
        case .Venus:
            return "200"
        case .Earth:
            return "300"
        case .Mars:
            return "400"
        case .Jupiter:
            return "500"
        case .Saturn:
            return "600"
        case .Uranus:
            return "700"
        case .Neptune:
            return "800"
        }
    }
    
    
}
