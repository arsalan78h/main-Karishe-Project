
import Foundation

// MARK: - TokenClass
struct TokenClass: Codable {
    let token: String
    let tokenExpires: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case token
        case tokenExpires = "token_expires"
        case user
    }
}
// MARK: - User
struct User: Codable {
    let data: DataClass
    let id: Int
    let caps: Caps
    let capKey: String
    let roles: [String]
    let allcaps: Allcaps
    let filter: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case data
        case id = "ID"
        case caps
        case capKey = "cap_key"
        case roles, allcaps, filter
    }
}

// MARK: - Allcaps
struct Allcaps: Codable {
    let read, editPosts, deletePosts, editOthersAEPrivateMessage: Bool
    let visualChat, freelancer: Bool
    
    enum CodingKeys: String, CodingKey {
        case read
        case editPosts = "edit_posts"
        case deletePosts = "delete_posts"
        case editOthersAEPrivateMessage = "edit_others_ae_private_message"
        case visualChat = "visual_chat"
        case freelancer
    }
}

// MARK: - Caps
struct Caps: Codable {
    let freelancer: Bool
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, userLogin, userPass, userNicename: String
    let userEmail, userURL, userRegistered, userActivationKey: String
    let userStatus, displayName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userLogin = "user_login"
        case userPass = "user_pass"
        case userNicename = "user_nicename"
        case userEmail = "user_email"
        case userURL = "user_url"
        case userRegistered = "user_registered"
        case userActivationKey = "user_activation_key"
        case userStatus = "user_status"
        case displayName = "display_name"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
