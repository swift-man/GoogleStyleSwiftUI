import Foundation

enum GSLimitPolicy {
  static func normalizedLimit(_ limit: Int) -> Int {
    max(1, limit)
  }

  static func limitedText(_ text: String, limit: Int) -> String {
    String(text.prefix(normalizedLimit(limit)))
  }
}
