import Foundation
import Testing

@testable import RebrickableLegoAPIClient

// Tests for all LegoAPI methods. Each test requires REBRICKABLE_API_KEY set in the environment
// otherwise it will be skipped (to avoid failing CI without credentials).

private func apiKeyOrSkip() -> RebrickableLegoAPIClientAPIConfiguration? {
    let apiKey = ProcessInfo.processInfo.environment["REBRICKABLE_API_KEY"]
    if apiKey == nil || apiKey == "" {
        print("Skipping test because REBRICKABLE_API_KEY is not set")
        return nil
    }
    return RebrickableLegoAPIClientAPIConfiguration(apiKey: apiKey)
}

@Test func CalllegoColorsRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let color: Color = try await LegoAPI.legoColorsRead(id: "1", apiConfiguration: config)
    #expect(color.id != nil)
}

@Test func CalllegoElementsRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    // example element id used by Rebrickable API; adjust if necessary
    let element: Element = try await LegoAPI.legoElementsRead(
        elementId: "4190230", apiConfiguration: config
    )
    #expect(!element.elementId!.isEmpty)
}

@Test func CalllegoMinifigsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let list: SetList = try await LegoAPI.legoMinifigsList(
        page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(list.results.count >= 0)
}

@Test func CalllegoColorsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let colorsList: ColorsList = try await LegoAPI.legoColorsList(
        page: 1, pageSize: 10, apiConfiguration: config
    )
    #expect(!colorsList.results!.isEmpty)
}

@Test func CalllegoMinifigsPartsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let parts: SetPartsList = try await LegoAPI.legoMinifigsPartsList(
        setNum: "minifig-1", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(parts.results.count >= 0)
}

@Test func CalllegoMinifigsRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let set: ModelSet = try await LegoAPI.legoMinifigsRead(
        setNum: "fig-002476", apiConfiguration: config
    )
    #expect(!set.setNum!.isEmpty)
}

@Test func CalllegoMinifigsSetsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let sets: SetList = try await LegoAPI.legoMinifigsSetsList(
        setNum: "fig-002476", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(sets.results.count >= 0)
}

@Test func CalllegoPartCategoriesList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let list: PartCategoriesList = try await LegoAPI.legoPartCategoriesList(
        page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(list.results!.count >= 0)
}

@Test func CalllegoPartCategoriesRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let cat: PartCategory = try await LegoAPI.legoPartCategoriesRead(
        id: 1, apiConfiguration: config
    )
    #expect(cat.id ?? 0 > 0)
}

@Test func CalllegoPartsColorsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let list: PartColorsList = try await LegoAPI.legoPartsColorsList(
        partNum: "3001", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(list.results.count >= 0)
}

@Test func CalllegoPartsColorsRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let pc: PartColor = try await LegoAPI.legoPartsColorsRead(
        partNum: "3001", colorId: "1", apiConfiguration: config
    )
    #expect(!pc.colorName.isEmpty)
}

@Test func CalllegoPartsColorsSetsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let sets: SetList = try await LegoAPI.legoPartsColorsSetsList(
        partNum: "3001", colorId: "1", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(sets.results.count >= 0)
}

@Test func CalllegoPartsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let parts: PartsList = try await LegoAPI.legoPartsList(
        page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(parts.results.count >= 0)
}

@Test func CalllegoPartsRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let part: Part = try await LegoAPI.legoPartsRead(partNum: "3001", apiConfiguration: config)
    #expect(!part.partNum!.isEmpty)
}

@Test func CalllegoSetsAlternatesList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let list: MocList = try await LegoAPI.legoSetsAlternatesList(
        setNum: "0000-1", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(list.results!.count >= 0)
}

@Test func CalllegoSetsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let sets: SetList = try await LegoAPI.legoSetsList(
        page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(sets.results.count >= 0)
}

@Test func CalllegoSetsMinifigsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let list: SetMinifigsList = try await LegoAPI.legoSetsMinifigsList(
        setNum: "0000-1", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(list.results.count >= 0)
}

@Test func CalllegoSetsPartsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let parts: SetPartsList = try await LegoAPI.legoSetsPartsList(
        setNum: "0000-1", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(parts.results.count >= 0)
}

@Test func CalllegoSetsRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let set: ModelSet = try await LegoAPI.legoSetsRead(setNum: "21036-1", apiConfiguration: config)
    #expect(!set.setNum!.isEmpty)
}

@Test func CalllegoSetsSetsList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let list: SetList = try await LegoAPI.legoSetsSetsList(
        setNum: "0000-1", page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(list.results.count >= 0)
}

@Test func CalllegoThemesList() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let themes: ThemesList = try await LegoAPI.legoThemesList(
        page: 1, pageSize: 5, apiConfiguration: config
    )
    #expect(themes.results.count >= 0)
}

@Test func CalllegoThemesRead() async throws {
    guard let config = apiKeyOrSkip() else { return }
    let theme: Theme = try await LegoAPI.legoThemesRead(id: 1, apiConfiguration: config)
    #expect(theme.id > 0)
}
