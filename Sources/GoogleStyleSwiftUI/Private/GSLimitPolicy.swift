import Foundation

enum GSLimitPolicy {
  static func normalizedLimit(_ limit: Int) -> Int {
    max(1, limit)
  }

  static func limitedText(_ text: String, limit: Int) -> String {
    let normalizedLimit = normalizedLimit(limit)
    guard text.count > normalizedLimit else {
      return text
    }

    return String(text.prefix(normalizedLimit))
  }
}
