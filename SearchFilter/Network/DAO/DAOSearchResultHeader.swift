//
//  DAOSearchResultHeader.swift
//
//  Created by Patrick Marshall on 3/16/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOSearchResultHeader: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let totalData = "total_data"
    static let processTime = "process_time"
    static let additionalParams = "additional_params"
    static let totalDataNoCategory = "total_data_no_category"
  }

  // MARK: Properties
  public var totalData: Int?
  public var processTime: Float?
  public var additionalParams: String?
  public var totalDataNoCategory: Int?

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
    totalData = json[SerializationKeys.totalData].int
    processTime = json[SerializationKeys.processTime].float
    additionalParams = json[SerializationKeys.additionalParams].string
    totalDataNoCategory = json[SerializationKeys.totalDataNoCategory].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = totalData { dictionary[SerializationKeys.totalData] = value }
    if let value = processTime { dictionary[SerializationKeys.processTime] = value }
    if let value = additionalParams { dictionary[SerializationKeys.additionalParams] = value }
    if let value = totalDataNoCategory { dictionary[SerializationKeys.totalDataNoCategory] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.totalData = aDecoder.decodeObject(forKey: SerializationKeys.totalData) as? Int
    self.processTime = aDecoder.decodeObject(forKey: SerializationKeys.processTime) as? Float
    self.additionalParams = aDecoder.decodeObject(forKey: SerializationKeys.additionalParams) as? String
    self.totalDataNoCategory = aDecoder.decodeObject(forKey: SerializationKeys.totalDataNoCategory) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(totalData, forKey: SerializationKeys.totalData)
    aCoder.encode(processTime, forKey: SerializationKeys.processTime)
    aCoder.encode(additionalParams, forKey: SerializationKeys.additionalParams)
    aCoder.encode(totalDataNoCategory, forKey: SerializationKeys.totalDataNoCategory)
  }

}
