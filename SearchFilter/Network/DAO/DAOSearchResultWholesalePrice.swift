//
//  DAOSearchResultWholesalePrice.swift
//
//  Created by Patrick Marshall on 3/16/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOSearchResultWholesalePrice: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let countMin = "count_min"
    static let countMax = "count_max"
    static let price = "price"
  }

  // MARK: Properties
  public var countMin: Int?
  public var countMax: Int?
  public var price: String?

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
    countMin = json[SerializationKeys.countMin].int
    countMax = json[SerializationKeys.countMax].int
    price = json[SerializationKeys.price].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = countMin { dictionary[SerializationKeys.countMin] = value }
    if let value = countMax { dictionary[SerializationKeys.countMax] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.countMin = aDecoder.decodeObject(forKey: SerializationKeys.countMin) as? Int
    self.countMax = aDecoder.decodeObject(forKey: SerializationKeys.countMax) as? Int
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(countMin, forKey: SerializationKeys.countMin)
    aCoder.encode(countMax, forKey: SerializationKeys.countMax)
    aCoder.encode(price, forKey: SerializationKeys.price)
  }

}
