import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(codejo_api_serviceTests.allTests),
    ]
}
#endif
