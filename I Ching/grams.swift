//
//  grams.swift
//  I Ching
//
//  Created by 陳佩琪 on 2023/5/24.
//

import Foundation
import UIKit
import CodableCSV


struct Trigram: Codable {
    let name: String
    let trigramImage: String
    let symbol: String
    let icon: String
    let number: String
}

extension Trigram {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "trigram")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}
 


struct Hexagram: Codable {
    let name: String
    let brief: String
    let gua: String
    let tuan: String
    let xiang: String
    let upperSymbol: String
    let loweSymbol: String
    let combination: String
    let number: String
    let hexagramImage: String
    }

extension Hexagram {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "hexagram")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}
