//
//  DAOSearchResultShop.swift
//
//  Created by Patrick Marshall on 3/16/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOSearchResultShop: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let isGold = "is_gold"
    static let reputationImageUri = "reputation_image_uri"
    static let location = "location"
    static let shopLucky = "shop_lucky"
    static let id = "id"
    static let city = "city"
    static let name = "name"
    static let uri = "uri"
  }

  // MARK: Properties
  public var isGold: Int?
  public var reputationImageUri: String?
  public var location: String?
  public var shopLucky: String?
  public var id: Int?
  public var city: String?
  public var name: String?
  public var uri: String?

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
    isGold = json[SerializationKeys.isGold].int
    reputationImageUri = json[SerializationKeys.reputationImageUri].string
    location = json[SerializationKeys.location].string
    shopLucky = json[SerializationKeys.shopLucky].string
    id = json[SerializationKeys.id].int
    city = json[SerializationKeys.city].string
    name = json[SerializationKeys.name].string
    uri = json[SerializationKeys.uri].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = isGold { dictionary[SerializationKeys.isGold] = value }
    if let value = reputationImageUri { dictionary[SerializationKeys.reputationImageUri] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = shopLucky { dictionary[SerializationKeys.shopLucky] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isGold = aDecoder.decodeObject(forKey: SerializationKeys.isGold) as? Int
    self.reputationImageUri = aDecoder.decodeObject(forKey: SerializationKeys.reputationImageUri) as? String
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.shopLucky = aDecoder.decodeObject(forKey: SerializationKeys.shopLucky) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isGold, forKey: SerializationKeys.isGold)
    aCoder.encode(reputationImageUri, forKey: SerializationKeys.reputationImageUri)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(shopLucky, forKey: SerializationKeys.shopLucky)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(uri, forKey: SerializationKeys.uri)
  }

}
