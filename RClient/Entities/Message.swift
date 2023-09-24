//
//  Message.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import Foundation

struct LastMessage: Codable {
    let id: String
    let t: String?
    let msg: String
    let groupable: Bool?
    let blocks: [Block]?
    let ts: String
    let u: File
    let rid, updatedAt: String
    let urls: [URLElement]?
    let mentions: [File]
    let channels: [JSONAny]
    let md: [Md]?
    let tmid: String?
    let tshow: Bool?
    let file: File?
    let files: [File]?
    let attachments: [Attachment]?
    let sandstormSessionID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case t, msg, groupable, blocks, ts, u, rid
        case updatedAt = "_updatedAt"
        case urls, mentions, channels, md, tmid, tshow, file, files, attachments
        case sandstormSessionID = "sandstormSessionId"
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
