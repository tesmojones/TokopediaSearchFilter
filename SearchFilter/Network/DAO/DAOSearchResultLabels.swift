//
//  DAOSearchResultLabels.swift
//
//  Created by Patrick Marshall on 3/16/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOSearchResultLabels: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let color = "color"
  }

  // MARK: Properties
  public var title: String?
  public var color: String?

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
    title = json[SerializationKeys.title].string
    color = json[SerializationKeys.color].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = color { dictionary[SerializationKeys.color] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.color = aDecoder.decodeObject(forKey: SerializationKeys.color) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(color, forKey: SerializationKeys.color)
  }

}
