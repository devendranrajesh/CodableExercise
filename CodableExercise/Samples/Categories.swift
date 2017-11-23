import Foundation

struct QuickBrowse: Decodable {
    let summary: Summary
    let categoryId: Int
    let productCount: Int
    let subcategories: [Subcategory]
    let products: [Product]
    let sortOptions: [SortOption]

    enum CodingKeys: String, CodingKey {
        case response
        case summary
    }

    enum Response: String, CodingKey {
        case categoryId = "category_id"
        case productCount = "product_count"
        case productCollection = "product_collection"
        case category
        case sortOptions = "sort_options"
    }

    enum Category: String, CodingKey {
        case subcategories
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.summary = try values.decode(Summary.self, forKey: .summary)
        let response = try values.nestedContainer(keyedBy: Response.self, forKey: .response)
        self.products = try response.decode([Product].self, forKey: .productCollection)
        self.sortOptions = try response.decode([SortOption].self, forKey: .sortOptions)

        self.categoryId = try response.decode(Int.self, forKey: .categoryId)
        self.productCount = try response.decode(Int.self, forKey: .productCount)

        let categories = try response.nestedContainer(keyedBy: Category.self, forKey: .category)
        self.subcategories = try categories.decode([Subcategory].self, forKey: .subcategories)
    }

}

struct Subcategory: Codable {
    let name: String
    let categoryId: Int
    let imageInfo: ImageInfo
    enum CodingKeys: String, CodingKey {
        case name
        case categoryId = "category_id"
        case imageInfo = "image_info"
    }
}

struct ImageInfo: Codable {
    let schemaId: String
    let imageRule: Int
    enum CodingKeys: String, CodingKey {
        case schemaId = "schema_id"
        case imageRule = "image_rule"
    }
}

struct Product: Codable {
    let name: String
    let numberOfReviews: Int
    enum CodingKeys: String, CodingKey {
        case name
        case numberOfReviews = "number_of_reviews"
    }
}

struct SortOption: Codable {
    let schemaId: String
    let sortValue: Int
    let selected: Bool
    enum CodingKeys: String, CodingKey {
        case schemaId = "schema_id"
        case sortValue = "sort_value"
        case selected
    }
}

struct Summary: Codable {
    let transactionId: String
    let cacheSeconds: Int
    let cacheAlwaysCheckServer: Bool
    enum CodingKeys: String, CodingKey {
        case transactionId = "transaction_id"
        case cacheSeconds = "cache_seconds"
        case cacheAlwaysCheckServer = "cache_always_check_server"
    }
}

