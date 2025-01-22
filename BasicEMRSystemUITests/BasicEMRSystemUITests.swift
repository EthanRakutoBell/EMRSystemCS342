//
//  BasicEMRSystemUITests.swift
//  BasicEMRSystemUITests
//
//  Created by Ethan Bell on 12/1/2025.
//

import XCTest

final class BasicEMRSystemUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testAddPatient() throws {
        let app = XCUIApplication()
        app.launch()
        
        let addPatientButton = app.buttons["Add Patient"]
        XCTAssertTrue(addPatientButton.exists, "Add Patient Button Must Exist")
        addPatientButton.tap()
        
        let firstNameTextField = app.textFields["First Name"]
        firstNameTextField.tap()
        firstNameTextField.typeText( "Zoro" )
        
        let lastNameTextField = app.textFields["Last Name"]
        lastNameTextField.tap()
        lastNameTextField.typeText( "Roronoa" )
        
        let datePickerQuery = app.datePickers["DateOfBirthPicker"]
        datePickerQuery.tap()
        app.staticTexts["8"].tap()
        app.staticTexts["January 2025"].tap()
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "April")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "2000")
        app.buttons["PopoverDismissRegion"].tap()
        
        let heightTextField = app.textFields["HeightAmount"]
        heightTextField.tap()
        heightTextField.typeText( "190" )
        
        let heightUnitPicker = app.buttons["HeightUnitPicker"]
        heightUnitPicker.tap()
        let cmButton = app.buttons["cm"]
        cmButton.tap()
        
        app.keyboards.buttons["return"].tap()
        
        let weightTextField = app.textFields["WeightAmount"]
        weightTextField.tap()
        weightTextField.typeText( "80" )
        
        let weightUnitPicker = app.buttons["WeightPicker"]
        weightUnitPicker.tap()
        let kgButton = app.buttons["kg"]
        kgButton.tap()
        
        let bloodTypePicker = app.buttons["BloodTypePicker"]
        bloodTypePicker.tap()
        let bloodTypeIdentifier = app.buttons["Blood Type, Unknown"]
        bloodTypeIdentifier.tap()
        let ABPlusButton = app.buttons["AB+"]
        ABPlusButton.tap()
        
        app.keyboards.buttons["return"].tap()
        
        let saveButton = app.buttons["Save Patient"]
        saveButton.tap()
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
