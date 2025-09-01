
import SwiftUI
import Foundation

 let baseUrl = "https://api.unsplash.com/photos/"
enum AppConstants {
    static let unsplashAccessKey = "ABs6iQKnptJCIOtg6ViOR2Nm2gq1X-_j5zNIb_A_kuA"
    static let appNameForAttribution = "EndlessGallery"
}

enum EndPoints {
    case randomPhotos(page: Int)
    
    func getEndPoint() -> String {
        switch self {
        case .randomPhotos(let page):
            return "\(baseUrl)?page=\(page)&per_page=30&client_id=\(AppConstants.unsplashAccessKey)"
              
        }
    }
}

struct Photo: Codable, Identifiable {
    let id: String
    let slug: String?
    let createdAt: String?
    let updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls
    let likes: Int?
    let views: Int?
    let downloads: Int?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, likes, views, downloads
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
    let smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}


//struct AlternativeSlugs: Codable {
//    let en, es, ja, fr: String
//    let it, ko, de, pt: String
//    let id: String
//}

//enum AssetType: String, Codable {
//    case photo = "photo"
//}

//struct Exif: Codable {
//    let make, model, name, exposureTime: String?
//    let aperture, focalLength: String?
//    let iso: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case make, model, name
//        case exposureTime = "exposure_time"
//        case aperture
//        case focalLength = "focal_length"
//        case iso
//    }
//}

//struct WelcomeLinks: Codable {
//    let linksSelf, html, download, downloadLocation: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case html, download
//        case downloadLocation = "download_location"
//    }
//}

//struct Location: Codable {
//    let name, city, country: String?
//    let position: Position
//}

//struct Position: Codable {
//    let latitude, longitude: Double?
//}

//struct TopicSubmissions: Codable {
//    let streetPhotography, travel: FashionBeauty?
//    let people: The3_DRenders?
//    let fashionBeauty, sports, wallpapers: FashionBeauty?
//    let nature, the3DRenders: The3_DRenders?
//
//    enum CodingKeys: String, CodingKey {
//        case streetPhotography = "street-photography"
//        case travel, people
//        case fashionBeauty = "fashion-beauty"
//        case sports, wallpapers, nature
//        case the3DRenders = "3d-renders"
//    }
//}

//struct FashionBeauty: Codable {
//    let status: Status
//    let approvedOn: Date?
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case approvedOn = "approved_on"
//    }
//}

//enum Status: String, Codable {
//    case approved = "approved"
//    case rejected = "rejected"
//}

//struct The3_DRenders: Codable {
//    let status: String
//}



//struct User: Codable {
//    let id: String
//    let updatedAt: Date
//    let username, name, firstName: String
//    let lastName: String?
//    let portfolioURL: String?
//    let bio, location: String?
//    let links: UserLinks
//    let profileImage: ProfileImage
//    let instagramUsername: String?
//    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int
//    let totalIllustrations, totalPromotedIllustrations: Int
//    let acceptedTos, forHire: Bool
//    let social: Social
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case updatedAt = "updated_at"
//        case username, name
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case twitterUsername = "twitter_username"
//        case portfolioURL = "portfolio_url"
//        case bio, location, links
//        case profileImage = "profile_image"
//        case instagramUsername = "instagram_username"
//        case totalCollections = "total_collections"
//        case totalLikes = "total_likes"
//        case totalPhotos = "total_photos"
//        case totalPromotedPhotos = "total_promoted_photos"
//        case totalIllustrations = "total_illustrations"
//        case totalPromotedIllustrations = "total_promoted_illustrations"
//        case acceptedTos = "accepted_tos"
//        case forHire = "for_hire"
//        case social
//    }
//}

//struct UserLinks: Codable {
//    let linksSelf, html, photos, likes: String
//    let portfolio: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case html, photos, likes, portfolio
//    }
//}

//struct ProfileImage: Codable {
//    let small, medium, large: String
//}

//struct Social: Codable {
//    let instagramUsername: String?
//    let portfolioURL: String?
//    let twitterUsername, paypalEmail: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case instagramUsername = "instagram_username"
//        case portfolioURL = "portfolio_url"
//        case twitterUsername = "twitter_username"
//        case paypalEmail = "paypal_email"
//    }
//}

