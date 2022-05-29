//
//  Arbuz.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

struct Arbuz: Codable, Hashable {
    var id: Int?
    var weight: Double?
    var price: Double? // за кг
    var status: ArbuzStatus
//    var lineInRow: Int? // номер грядки
    var image: String?
    var name: String?
    var description: String?
    var quantity: Int?
}
