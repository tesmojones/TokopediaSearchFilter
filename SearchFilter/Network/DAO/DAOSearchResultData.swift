//
//  DAOSearchResultData.swift
//
//  Created by Patrick Marshall on 3/16/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOSearchResultData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let departmentId = "department_id"
    static let labels = "labels"
    static let discountExpired = "discount_expired"
    static let name = "name"
    static let uri = "uri"
    static let countReview = "count_review"
    static let badges = "badges"
    static let isFeatured = "is_featured"
    static let imageUri = "image_uri"
    static let stock = "stock"
    static let condition = "condition"
    static let price = "price"
    static let rating = "rating"
    static let countTalk = "count_talk"
    static let id = "id"
    static let shop = "shop"
    static let originalPrice = "original_price"
    static let wholesalePrice = "wholesale_price"
    static let discountPercentage = "discount_percentage"
    static let preorder = "preorder"
    static let imageUri700 = "image_uri_700"
    static let countSold = "count_sold"
  }

  // MARK: Properties
  public var departmentId: Int?
  public var labels: [DAOSearchResultLabels]?
  public var discountExpired: String?
  public var name: String?
  public var uri: String?
  public var countReview: Int?
  public var badges: [DAOSearchResultBadges]?
  public var isFeatured: Int?
  public var imageUri: String?
  public var stock: Int?
  public var condition: Int?
  public var price: String?
  public var rating: Int?
  public var countTalk: Int?
  public var id: Int?
  public var shop: DAOSearchResultShop?
  public var originalPrice: String?
  public var wholesalePrice: [DAOSearchResultWholesalePrice]?
  public var discountPercentage: Int?
  public var preorder: Int?
  public var imageUri700: String?
  public var countSold: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    departmentId = json[SerializationKeys.departmentId].int
    if let items = json[SerializationKeys.labels].array { labels = items.map { DAOSearchResultLabels(json: $0) } }
    discountExpired = json[SerializationKeys.discountExpired].string
    name = json[SerializationKeys.name].string
    uri = json[SerializationKeys.uri].string
    countReview = json[SerializationKeys.countReview].int
    if let items = json[SerializationKeys.badges].array { badges = items.map { DAOSearchResultBadges(json: $0) } }
    isFeatured = json[SerializationKeys.isFeatured].int
    imageUri = json[SerializationKeys.imageUri].string
    stock = json[SerializationKeys.stock].int
    condition = json[SerializationKeys.condition].int
    price = json[SerializationKeys.price].string
    rating = json[SerializationKeys.rating].int
    countTalk = json[SerializationKeys.countTalk].int
    id = json[SerializationKeys.id].int
    shop = DAOSearchResultShop(json: json[SerializationKeys.shop])
    originalPrice = json[SerializationKeys.originalPrice].string
    if let items = json[SerializationKeys.wholesalePrice].array { wholesalePrice = items.map { DAOSearchResultWholesalePrice(json: $0) } }
    discountPercentage = json[SerializationKeys.discountPercentage].int
    preorder = json[SerializationKeys.preorder].int
    imageUri700 = json[SerializationKeys.imageUri700].string
    countSold = json[SerializationKeys.countSold].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = departmentId { dictionary[SerializationKeys.departmentId] = value }
    if let value = labels { dictionary[SerializationKeys.labels] = value.map { $0.dictionaryRepresentation() } }
    if let value = discountExpired { dictionary[SerializationKeys.discountExpired] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = countReview { dictionary[SerializationKeys.countReview] = value }
    if let value = badges { dictionary[SerializationKeys.badges] = value.map { $0.dictionaryRepresentation() } }
    if let value = isFeatured { dictionary[SerializationKeys.isFeatured] = value }
    if let value = imageUri { dictionary[SerializationKeys.imageUri] = value }
    if let value = stock { dictionary[SerializationKeys.stock] = value }
    if let value = condition { dictionary[SerializationKeys.condition] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = countTalk { dictionary[SerializationKeys.countTalk] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = shop { dictionary[SerializationKeys.shop] = value.dictionaryRepresentation() }
    if let value = originalPrice { dictionary[SerializationKeys.originalPrice] = value }
    if let value = wholesalePrice { dictionary[SerializationKeys.wholesalePrice] = value.map { $0.dictionaryRepresentation() } }
    if let value = discountPercentage { dictionary[SerializationKeys.discountPercentage] = value }
    if let value = preorder { dictionary[SerializationKeys.preorder] = value }
    if let value = imageUri700 { dictionary[SerializationKeys.imageUri700] = value }
    if let value = countSold { dictionary[SerializationKeys.countSold] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.departmentId = aDecoder.decodeObject(forKey: SerializationKeys.departmentId) as? Int
    self.labels = aDecoder.decodeObject(forKey: SerializationKeys.labels) as? [DAOSearchResultLabels]
    self.discountExpired = aDecoder.decodeObject(forKey: SerializationKeys.discountExpired) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
    self.countReview = aDecoder.decodeObject(forKey: SerializationKeys.countReview) as? Int
    self.badges = aDecoder.decodeObject(forKey: SerializationKeys.badges) as? [DAOSearchResultBadges]
    self.isFeatured = aDecoder.decodeObject(forKey: SerializationKeys.isFeatured) as? Int
    self.imageUri = aDecoder.decodeObject(forKey: SerializationKeys.imageUri) as? String
    self.stock = aDecoder.decodeObject(forKey: SerializationKeys.stock) as? Int
    self.condition = aDecoder.decodeObject(forKey: SerializationKeys.condition) as? Int
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? String
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Int
    self.countTalk = aDecoder.decodeObject(forKey: SerializationKeys.countTalk) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.shop = aDecoder.decodeObject(forKey: SerializationKeys.shop) as? DAOSearchResultShop
    self.originalPrice = aDecoder.decodeObject(forKey: SerializationKeys.originalPrice) as? String
    self.wholesalePrice = aDecoder.decodeObject(forKey: SerializationKeys.wholesalePrice) as? [DAOSearchResultWholesalePrice]
    self.discountPercentage = aDecoder.decodeObject(forKey: SerializationKeys.discountPercentage) as? Int
    self.preorder = aDecoder.decodeObject(forKey: SerializationKeys.preorder) as? Int
    self.imageUri700 = aDecoder.decodeObject(forKey: SerializationKeys.imageUri700) as? String
    self.countSold = aDecoder.decodeObject(forKey: SerializationKeys.countSold) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(departmentId, forKey: SerializationKeys.departmentId)
    aCoder.encode(labels, forKey: SerializationKeys.labels)
    aCoder.encode(discountExpired, forKey: SerializationKeys.discountExpired)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(uri, forKey: SerializationKeys.uri)
    aCoder.encode(countReview, forKey: SerializationKeys.countReview)
    aCoder.encode(badges, forKey: SerializationKeys.badges)
    aCoder.encode(isFeatured, forKey: SerializationKeys.isFeatured)
    aCoder.encode(imageUri, forKey: SerializationKeys.imageUri)
    aCoder.encode(stock, forKey: SerializationKeys.stock)
    aCoder.encode(condition, forKey: SerializationKeys.condition)
    aCoder.encode(price, forKey: SerializationKeys.price)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(countTalk, forKey: SerializationKeys.countTalk)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(shop, forKey: SerializationKeys.shop)
    aCoder.encode(originalPrice, forKey: SerializationKeys.originalPrice)
    aCoder.encode(wholesalePrice, forKey: SerializationKeys.wholesalePrice)
    aCoder.encode(discountPercentage, forKey: SerializationKeys.discountPercentage)
    aCoder.encode(preorder, forKey: SerializationKeys.preorder)
    aCoder.encode(imageUri700, forKey: SerializationKeys.imageUri700)
    aCoder.encode(countSold, forKey: SerializationKeys.countSold)
  }

}
