//
//  Result+WebService.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

extension Result {
   public static func wrapWebServiceResult(success: Bool,
                                           result: Success?,
                                           error: Error?) -> Result<Success, Error> {

       if success, let result = result {
           return .success(result)
       } else if let error = error {
           return .failure(error)
       } else {
           let nsError = NSError.webServiceInvalidResponse
           return .failure(nsError)
       }
   }
}

extension NSError {
    @objc class var webServiceInvalidResponse: NSError {
        return NSError(domain: "com.breakingBad.ios.webservices",
                       code: 400,
                       userInfo: [NSLocalizedDescriptionKey: "invalidResponse"])
    }
}
