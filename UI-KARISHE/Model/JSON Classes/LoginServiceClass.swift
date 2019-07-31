// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let login = try? newJSONDecoder().decode(Login.self, from: jsonData)

import Foundation

// MARK: - Login
struct LoginClass: Codable {
    let success: Bool
    let data: LoginDataClass
    let msg: String
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let id, userLogin, userNicename, userEmail: String
    let userURL, userRegistered, userStatus, displayName: String
    let etBanExpired, etBanNote, location, address: String
    let phone, mobile, etAvatar, etAvatarURL: String
    let postCount, commentCount, hourRate, facebook: String
    let twitter, registerStatus: String
    let banned: Bool
    let userHourRate, userProfileID, userCurrency, userSkills: String
    let userAvailable, paypal, avatar, avatarMobile: String
    let joinDate, firstName, lastName, dataDescription: String
    let label: String
    let authorURL: String
    let ajaxnonce, logoajaxnonce, dataID, banExpired: String
    let banNote, msg: String
    let redirectURL: String
    let dataDo: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userLogin = "user_login"
        case userNicename = "user_nicename"
        case userEmail = "user_email"
        case userURL = "user_url"
        case userRegistered = "user_registered"
        case userStatus = "user_status"
        case displayName = "display_name"
        case etBanExpired = "et_ban_expired"
        case etBanNote = "et_ban_note"
        case location, address, phone, mobile
        case etAvatar = "et_avatar"
        case etAvatarURL = "et_avatar_url"
        case postCount = "post_count"
        case commentCount = "comment_count"
        case hourRate = "hour_rate"
        case facebook, twitter
        case registerStatus = "register_status"
        case banned
        case userHourRate = "user_hour_rate"
        case userProfileID = "user_profile_id"
        case userCurrency = "user_currency"
        case userSkills = "user_skills"
        case userAvailable = "user_available"
        case paypal, avatar
        case avatarMobile = "avatar_mobile"
        case joinDate = "join_date"
        case firstName = "first_name"
        case lastName = "last_name"
        case dataDescription = "description"
        case label
        case authorURL = "author_url"
        case ajaxnonce, logoajaxnonce
        case dataID = "id"
        case banExpired = "ban_expired"
        case banNote = "ban_note"
        case msg
        case redirectURL = "redirect_url"
        case dataDo = "do"
    }
}
