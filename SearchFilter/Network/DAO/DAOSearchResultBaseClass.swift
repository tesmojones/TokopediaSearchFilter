//
//  DAOSearchResultBaseClass.swift
//
//  Created by Patrick Marshall on 3/16/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOSearchResultBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let data = "data"
    static let header = "header"
  }

  // MARK: Properties
  public var status: DAOSearchResultStatus?
  public var data: [DAOSearchResultData]?
  public var header: DAOSearchResultHeader?

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
    status = DAOSearchResultStatus(json: json[SerializationKeys.status])
    if let items = json[SerializationKeys.data].array { data = items.map { DAOSearchResultData(json: $0) } }
    header = DAOSearchResultHeader(json: json[SerializationKeys.header])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value.dictionaryRepresentation() }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = header { dictionary[SerializationKeys.header] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? DAOSearchResultStatus
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [DAOSearchResultData]
    self.header = aDecoder.decodeObject(forKey: SerializationKeys.header) as? DAOSearchResultHeader
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(header, forKey: SerializationKeys.header)
  }

}
