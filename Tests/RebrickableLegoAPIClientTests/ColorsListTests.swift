import Foundation
import Testing

@testable import RebrickableLegoAPIClient

@Test func CalllegoColorsList() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let apiKey = ProcessInfo.processInfo.environment["REBRICKABLE_API_KEY"]

    if apiKey == nil || apiKey == "" {
        print("Skipping test because REBRICKABLE_API_KEY is not set")
        return
    }
    let config = RebrickableLegoAPIClientAPIConfiguration(apiKey: apiKey)

    let colorsList = try await LegoAPI.legoColorsList(
        page: 1, pageSize: 10, apiConfiguration: config)

    #expect(colorsList.count > 0)
}
