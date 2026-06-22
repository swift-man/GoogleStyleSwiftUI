import Foundation

enum GSLimitPolicy {
  static func normalizedLimit(_ limit: Int) -> Int {
    max(1, limit)
  }
}
