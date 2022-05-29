//
//  ArbuzStatus.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

enum ArbuzStatus: String, Codable, Hashable {
    case ready = "Спелый"
    case notReady = "Не спелый"
    case gone = "Сорван"
    
    public init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .ready
            return
        }
        self = ArbuzStatus(rawValue: rawValue) ?? .ready
    }
    
}
