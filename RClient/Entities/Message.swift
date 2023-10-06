//
//  Message.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: String
//    let t: T?
    let rid: Rid
    let ts: String
    let msg: String
    let u: U
    let groupable: Bool?
    let updatedAt: String
    let urls: [URLElement]?
    let mentions: [U]?
    let channels: [JSONAny]?
    let md: [Md]?
    let tmid: String?
    let tshow: Bool?
    let replies: [String]?
    let tcount: Int?
    let tlm: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rid, ts, msg, u, groupable // need add t
        case updatedAt = "_updatedAt"
        case urls, mentions, channels, md, tmid, tshow, replies, tcount, tlm
    }
}

struct MessageCreditions: Codable {
    let token: String
    let userID: String
    let roomId: String
}

struct Rid: Codable {
    
}

struct UpdatedAt: Codable {
    let date: Int

    enum CodingKeys: String, CodingKey {
        case date = "$date"
    }
}

struct EditedBy: Codable {
    let id, username: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
    }
}

enum MdType: String, Codable {
    case lineBreak = "LINE_BREAK"
    case paragraph = "PARAGRAPH"
}

struct ValueElement: Codable {
    let type: ValueType
    let value: ValueUnion
}

enum ValueUnion: Codable {
    case purpleValue(PurpleValue)
    case srcElementArray([SrcElement])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([SrcElement].self) {
            self = .srcElementArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(PurpleValue.self) {
            self = .purpleValue(x)
            return
        }
        throw DecodingError.typeMismatch(ValueUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .purpleValue(let x):
            try container.encode(x)
        case .srcElementArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


struct ValueValueClass: Codable {
    let src: Src?
    let label: [Src]?
    let type: ValueType?
    let value: String?
}

struct Src: Codable {
    let type: ValueType
    let value: String
}

struct LastMessage: Codable {
    let id: String
    let t: String?
    let msg: String
    let groupable: Bool?
    let blocks: [Block]?
    let ts: String
    let u: UElement
    let rid, updatedAt: String
    let urls: [URLElement]
    let mentions: [UElement]
    let channels: [JSONAny]
    let md: [Md]?
    let tmid: String?
    let tshow: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case t, msg, groupable, blocks, ts, u, rid
        case updatedAt = "_updatedAt"
        case urls, mentions, channels, md, tmid, tshow
    }
}

struct Attachment: Codable {
    let ts: String?
    let title, titleLink: String
    let titleLinkDownload: Bool
    let videoURL, videoType: String?
    let videoSize: Int?
    let type, description, format: String?
    let size: Int?
    let descriptionMd: [DescriptionMd]?
    let imageDimensions: ImageDimensions?
    let imagePreview, imageURL, imageType: String?
    let imageSize: Int?

    enum CodingKeys: String, CodingKey {
        case ts, title
        case titleLink = "title_link"
        case titleLinkDownload = "title_link_download"
        case videoURL = "video_url"
        case videoType = "video_type"
        case videoSize = "video_size"
        case type, description, format, size, descriptionMd
        case imageDimensions = "image_dimensions"
        case imagePreview = "image_preview"
        case imageURL = "image_url"
        case imageType = "image_type"
        case imageSize = "image_size"
    }
}
