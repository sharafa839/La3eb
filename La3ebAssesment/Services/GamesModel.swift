//
//  GamesModel.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation
import Foundation

// MARK: - ChatSessionResponse
struct GameModel: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [GameModelResult]?
    var seoTitle, seoDescription, seoKeywords, seoH1: String?
    var noindex, nofollow: Bool?
    var description: String?
    var filters: Filters?
    var nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description, filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    var years: [FiltersYear]?
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    var from, to: Int?
    var filter: String?
    var decade: Int?
    var years: [YearYear]?
    var nofollow: Bool?
    var count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
    var year, count: Int?
    var nofollow: Bool?
}

// MARK: - Result
struct GameModelResult: Codable {
    var toGameUIModel:GameDetailUIModel {
        GameDetailUIModel(self)
    }
    
    var openBefore:Bool? = false
    var favourite:Bool?
    var id: Int?
    var slug, name, nameOriginal, description: String?
    var metacritic: Int?
    var metacriticPlatforms: [MetacriticPlatform]?
    var released: String?
    var tba: Bool?
    var updated: String?
    var backgroundImage, backgroundImageAdditional: String?
    var website: String?
    var rating: Double?
    var ratingTop: Int?
    var ratings: [Rating]?
    var reactions: [String: Int]?
    var added: Int?
    var addedByStatus: AddedByStatus?
    var playtime, screenshotsCount, moviesCount, creatorsCount: Int?
    var achievementsCount, parentAchievementsCount: Int?
    var redditURL: String?
    var redditName, redditDescription, redditLogo: String?
    var redditCount, twitchCount, youtubeCount, reviewsTextCount: Int?
    var ratingsCount, suggestionsCount: Int?
    var alternativeNames: [String]?
    var metacriticURL: String?
    var parentsCount, additionsCount, gameSeriesCount: Int?
    var userGame: String?
    var reviewsCount: Int?
    var saturatedColor, dominantColor: String?
    var parentPlatforms: [ParentPlatform]?
    var platforms: [PlatformElement]?
    var stores: [Store]?
    var developers, tags, publishers: [Developer]?
    var gener:[Genre]?
    var esrbRating: EsrbRating?
    var clip: String?
    var descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description, metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case ratings, reactions, added
        case addedByStatus = "added_by_status"
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticURL = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case platforms, stores, developers, tags, publishers
        case gener = "gener"
        case esrbRating = "esrb_rating"
        case clip
        case descriptionRaw = "description_raw"
   
        
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    var yet, owned, beaten, toplay: Int?
    var dropped, playing: Int?
}

enum Color: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    var id: Int?
    var name, slug: String?
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var domain: String?
    var language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    var platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    var platform: PlatformPlatform?
    var releasedAt: String?
    var requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    var id: Int?
    var name, slug: String?
    var image, yearEnd: String?
    var yearStart: Int?
    var gamesCount: Int?
    var imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    var minimum, recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    var id: Int?
    var title: Title?
    var count: Int?
    var percent: Double?
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    var id: Int?
    var image: String?
}

// MARK: - Store
struct Store: Codable {
    var id: Int?
    var store: Genre?
}

// MARK: - Encode/decode helpers

