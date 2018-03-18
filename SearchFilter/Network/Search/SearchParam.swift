//
//  SearchParam.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/16/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import Foundation

public struct SearchParam {
    public var query: String?
    public var pmin: String?
    public var pmax: String?
    public var wholesale: String?
    public var official: String?
    public var fshop: String?
    public var start: String?
    public var row: String?
    
    public init(query: String?, pmin: String?, pmax: String?, wholesale: Bool?, official: Bool?, fshop: String?, start: String?, row: String?) {
        self.query = query
        self.pmin = pmin
        self.pmax = pmax
        // Set Boolean data to string
        if wholesale! {
            self.wholesale = "true"
        } else {
            self.wholesale = "false"
        }
        if official! {
            self.official = "true"
        } else {
            self.official = "false"
        }
        self.fshop = fshop
        self.start = start
        self.row = row
    }
    
    public func asParam()->[String: Any] {
        return ["q": self.query ?? "",
                "pmin": self.pmin ?? "",
                "pmax": self.pmax ?? "",
                "wholesale": self.wholesale ?? "",
                "official": self.official ?? "",
                "fshop": self.fshop ?? "",
                "start": self.start ?? "",
                "rows": self.row ?? ""]
    }
}
