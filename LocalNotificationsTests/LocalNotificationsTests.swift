//
//  LocalNotificationsTests.swift
//  LocalNotificationsTests
//
//  Created by Mohamed Sobhi  Fouda on 8/9/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import XCTest
@testable import LocalNotifications

class LocalNotificationsTests: XCTestCase {
    
    var vc: ViewController!
    
    var segmentedControl = UISegmentedControl()
    var delayValue = UILabel()
    var slider = UISlider()
    var setNotificationButton = UIButton()
    
    override func setUp() {
        super.setUp()
        
        segmentedControl.insertSegment(withTitle: "Audi", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "BMW", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Tesla", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
        vc = ViewController()
        vc.slider = slider
        vc.delayValue = delayValue
        vc.segmentedControl = segmentedControl
        
        vc.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSliderInitializationAfterViewDidLoad() {
        // slider min:2.0, max: 12.0,  delay value = slider.min
        XCTAssertEqual(vc.slider.minimumValue, 2.0, "Slider min should be 2.0")
        XCTAssertEqual(vc.slider.maximumValue, 12.0, "Slider max shoud be 12.0")
        XCTAssertEqual(vc.delay, 2.0, "Initial delay should be equal slider min")
    }
    
    func testInitialValueDelayLabel() {
        let delayLabelText = vc.delayValue.text!
        XCTAssertEqual(delayLabelText, "2.0")
    }
    
    func testDelayValueWhenSliderMoved() {
        vc.slider.value = 5.0
        vc.sliderValueChanged(vc.slider)
        
        let delayLabelText = vc.delayValue.text!
        XCTAssertEqual(delayLabelText, "5.0", "Delay label text should reflect slider move")
    }
    
    func testSelectedImageName() {
        XCTAssertEqual(vc.imageName, "audi", "Selected segment 0 is Audi imageName")
        
        vc.segmentedControl.selectedSegmentIndex = 1
        vc.segmentedControlValueChanged(vc.segmentedControl)
        XCTAssertEqual(vc.imageName, "bmw", "Select segment 1 should update imageName to BMW")
        
        vc.segmentedControl.selectedSegmentIndex = 2
        vc.segmentedControlValueChanged(vc.segmentedControl)
        XCTAssertEqual(vc.imageName, "tesla", "Select segment 2 should update imageName to Tesla")
    }
}

