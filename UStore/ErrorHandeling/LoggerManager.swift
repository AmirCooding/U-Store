//
//  LoggerManager.swift
//  UStore
//
//  Created by Amir Lotfi on 12.09.24.
//

import Foundation
import os
struct LoggerManager {
    static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "App"
    )

    // Example of logging with emojis for clarity
    static func logHttpError(_ error: HttpError) {
        logger.error("❌ \(error.localizedDescription, privacy: .public)")
    }

    static func logAuthError(_ error: AuthError) {
        logger.error("⚠️ API Error: \(error.localizedDescription, privacy: .public)")
    }

    static func logInfo(_ message: String) {
        logger.info("ℹ️ Info: \(message, privacy: .public)")
    }
    
    static func logMessageAndError(_ message: String, error: Error) {
          logger.error("🛑 \(message) - Error: \(error.localizedDescription, privacy: .public)")
      }
}
