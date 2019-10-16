// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let testMobileJSON = try? newJSONDecoder().decode(TestMobileJSON.self, from: jsonData)

import Foundation

struct MobileDevJSON: Codable {
    var data: [mobileDevDatum]
    let paginate, msg: String
    let success: Bool
    let maxNumPages: Int
    let total: String
    
    enum CodingKeys: String, CodingKey {
        case data, paginate, msg, success
        case maxNumPages = "max_num_pages"
        case total
    }
}

// MARK: - Datum
struct mobileDevDatum: Codable {
    let postParent: Int
    let postTitle, postName, postContent, postExcerpt: String
    let postAuthor: String
    let postStatus: PostStatus
    let id: Int
    let postType: PostType
    let commentCount: String
    let guid: String
    let statusText: StatusText
    let postDate: String
    let taxInput: TaxInput
    let projectCategory: [Int]
    let projectType: [mobileDevJSONAny]
    let country: [Int]
    let address, avatar, postCount, etFeatured: String
    let etExpiredDate, etBudget, deadline, totalBids: String
    let bidAverage: Double
    let accepted, projectDeadline: String
 //   let etPaymentPackage: EtPaymentPackage
    let postViews: PostViews
    let datumID: Int
    let permalink: String
    let unfilteredContent, thePostThumnail, featuredImage, thePostThumbnail: String
    let etAvatar: String
    let authorURL: String
    let authorName, budget: String
   // let bidBudgetText: BidBudgetText
    let ratingScore: Int
    let projectComment, projectCommentTrim, postContentTrim: String
    let countWord: Int
    let projectStatusView: ProjectStatusView
    let textStatusJS: TextStatusJS
    let currentUserBid: Bool
    let postedBy: String
    let skill: [Skill]
    let listSkills, textTotalBid: String
 //   let textCountry: TextCountry
    
    enum CodingKeys: String, CodingKey {
        case postParent = "post_parent"
        case postTitle = "post_title"
        case postName = "post_name"
        case postContent = "post_content"
        case postExcerpt = "post_excerpt"
        case postAuthor = "post_author"
        case postStatus = "post_status"
        case id = "ID"
        case postType = "post_type"
        case commentCount = "comment_count"
        case guid
        case statusText = "status_text"
        case postDate = "post_date"
        case taxInput = "tax_input"
        case projectCategory = "project_category"
        case projectType = "project_type"
        case country, address, avatar
        case postCount = "post_count"
        case etFeatured = "et_featured"
        case etExpiredDate = "et_expired_date"
        case etBudget = "et_budget"
        case deadline
        case totalBids = "total_bids"
        case bidAverage = "bid_average"
        case accepted
        case projectDeadline = "project_deadline"
    //    case etPaymentPackage = "et_payment_package"
        case postViews = "post_views"
        case datumID = "id"
        case permalink
        case unfilteredContent = "unfiltered_content"
        case thePostThumnail = "the_post_thumnail"
        case featuredImage = "featured_image"
        case thePostThumbnail = "the_post_thumbnail"
        case etAvatar = "et_avatar"
        case authorURL = "author_url"
        case authorName = "author_name"
        case budget
     //   case bidBudgetText = "bid_budget_text"
        case ratingScore = "rating_score"
        case projectComment = "project_comment"
        case projectCommentTrim = "project_comment_trim"
        case postContentTrim = "post_content_trim"
        case countWord = "count_word"
        case projectStatusView = "project_status_view"
        case textStatusJS = "text_status_js"
        case currentUserBid = "current_user_bid"
        case postedBy = "posted_by"
        case skill
        case listSkills = "list_skills"
        case textTotalBid = "text_total_bid"
      //  case textCountry = "text_country"
    }
}

//enum BidBudgetText: String, Codable {
//    case the0تومان = "0تومان"
//}

//enum EtPaymentPackage: String, Codable {
//    case b1 = "B1"
//    case the001 = "001"
//}

enum PostStatus: String, Codable {
    case archive = "archive"
    case complete = "complete"
    case publish = "publish"
}

enum PostType: String, Codable {
    case project = "project"
}

enum PostViews: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(PostViews.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PostViews"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum ProjectStatusView: String, Codable {
    case اتماممهلتپیشنهاد = "اتمام مهلت پیشنهاد"
    case تکمیلشد = "تکمیل شد"
    case فعال = "فعال"
}

// MARK: - Skill
struct Skill: Codable {
    let name: String
}

enum StatusText: String, Codable {
    case آرشیوشده = "آرشیو شده"
    case فعال = "فعال"
    case کاملشده = "کامل شده"
}

// MARK: - TaxInput
struct TaxInput: Codable {
    let skill, projectCategory: [Country]
    let projectType: [mobileDevJSONAny]
    let country: [Country]
    
    enum CodingKeys: String, CodingKey {
        case skill
        case projectCategory = "project_category"
        case projectType = "project_type"
        case country
    }
}

// MARK: - Country
struct Country: Codable {
    let termID: Int
    let name, slug: String
    let termGroup, termTaxonomyID: Int
    let taxonomy: TaxonomyMobileDev
    let countryDescription: String
    let parent, count: Int
    let filter: FilterMobileDev
    let termOrder: String
    
    enum CodingKeys: String, CodingKey {
        case termID = "term_id"
        case name, slug
        case termGroup = "term_group"
        case termTaxonomyID = "term_taxonomy_id"
        case taxonomy
        case countryDescription = "description"
        case parent, count, filter
        case termOrder = "term_order"
    }
}

enum FilterMobileDev: String, Codable {
    case raw = "raw"
}

enum TaxonomyMobileDev: String, Codable {
    case country = "country"
    case projectCategory = "project_category"
    case skill = "skill"
}

//enum TextCountry: String, Codable {
//    case empty = ""
//    case بوشهر = "بوشهر"
//    case تهران = "تهران"
//}

enum TextStatusJS: String, Codable {
    case کارآرشیوشدهاست = "کار آرشیو شده است"
    case کارفعالاست = "کار فعال است"
    case کارکاملشدهاست = "کار کامل شده است"
}

// MARK: - Encode/decode helpers

class mobileDevJSONNull: Codable, Hashable {
    
    public static func == (lhs: mobileDevJSONNull, rhs: mobileDevJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(mobileDevJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKeyMobileDev: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class mobileDevJSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(mobileDevJSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return mobileDevJSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return mobileDevJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKeyMobileDev.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKeyMobileDev>, forKey key: JSONCodingKeyMobileDev) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return mobileDevJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKeyMobileDev.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKeyMobileDev>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is mobileDevJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKeyMobileDev.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKeyMobileDev>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKeyMobileDev(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is mobileDevJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKeyMobileDev.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is mobileDevJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try mobileDevJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKeyMobileDev.self) {
            self.value = try mobileDevJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try mobileDevJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try mobileDevJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKeyMobileDev.self)
            try mobileDevJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try mobileDevJSONAny.encode(to: &container, value: self.value)
        }
    }
}
