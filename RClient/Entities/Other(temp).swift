//
//  Other(temp).swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import Foundation


struct DescriptionMd: Codable {
    let type: DescriptionMdType
    let value: [SrcElement]
}

enum DescriptionMdType: String, Codable {
    case bigEmoji = "BIG_EMOJI"
    case lineBreak = "LINE_BREAK"
    case orderedList = "ORDERED_LIST"
    case paragraph = "PARAGRAPH"
}

struct SrcElement: Codable {
    let type: String
    let value: String
}

enum ValueType: String, Codable {
    case emoji = "EMOJI"
    case link = "LINK"
    case listItem = "LIST_ITEM"
    case mentionUser = "MENTION_USER"
    case plainText = "PLAIN_TEXT"
}

struct ImageDimensions: Codable {
    let width, height: Int
}

struct Block: Codable {
    let type, blockID, callID, appID: String

    enum CodingKeys: String, CodingKey {
        case type
        case blockID = "blockId"
        case callID = "callId"
        case appID = "appId"
    }
}

struct File: Codable {
    let id, name: String
    let type, username: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, type, username
    }
}

struct Md: Codable {
    let type: String
    let value: [MdValue]?
}

struct MdValue: Codable {
    let type: String
    let value: ValueUnion?
    let unicode, shortCode: String?
}

struct PurpleValue: Codable {
    let src: SrcElement?
    let label: [SrcElement]?
    let type, value: String?
}


enum Label: Codable {
    case srcElement(SrcElement)
    case srcElementArray([SrcElement])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([SrcElement].self) {
            self = .srcElementArray(x)
            return
        }
        if let x = try? container.decode(SrcElement.self) {
            self = .srcElement(x)
            return
        }
        throw DecodingError.typeMismatch(Label.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Label"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .srcElement(let x):
            try container.encode(x)
        case .srcElementArray(let x):
            try container.encode(x)
        }
    }
}

struct URLElement: Codable {
    let url: String
    let meta: CustomFields
}

enum SysMes: Codable {
    case bool(Bool)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        throw DecodingError.typeMismatch(SysMes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SysMes"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

enum T: String, Codable {
    case c = "c"
    case uj = "uj"
    case ul = "ul"
}
