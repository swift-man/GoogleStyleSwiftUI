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

  @Test
  func testLimitPolicyTruncatesTextUsingNormalizedLimit() {
    #expect(GSLimitPolicy.limitedText("SwiftUI", limit: 5) == "Swift")
    #expect(GSLimitPolicy.limitedText("SwiftUI", limit: 10) == "SwiftUI")
    #expect(GSLimitPolicy.limitedText("SwiftUI", limit: 0) == "S")
  }

  @Test
  func testInputColorPolicyUsesNormalColorWhenIdle() {
    #expect(GSInputColorPolicy.color(errorMessage: "",
                                     isFocused: false) == GSColorStyle.normal.color)
  }

  @Test
  func testInputColorPolicyUsesActiveColorWhenFocused() {
    #expect(GSInputColorPolicy.color(errorMessage: "",
                                     isFocused: true) == GSColorStyle.active.color)
  }

  @Test
  func testInputColorPolicyPrioritizesErrorColor() {
    #expect(GSInputColorPolicy.color(errorMessage: "Required",
                                     isFocused: false) == GSColorStyle.error.color)
    #expect(GSInputColorPolicy.color(errorMessage: "Required",
                                     isFocused: true) == GSColorStyle.error.color)
  }
}
