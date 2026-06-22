import Testing
@testable import GoogleStyleSwiftUI

struct GoogleStyleUITests {
  @Test
  func testLimitPolicyKeepsMinimumValueAsOne() {
    #expect(GSLimitPolicy.normalizedLimit(10) == 10)
    #expect(GSLimitPolicy.normalizedLimit(1) == 1)
    #expect(GSLimitPolicy.normalizedLimit(0) == 1)
    #expect(GSLimitPolicy.normalizedLimit(-1) == 1)
  }
}
