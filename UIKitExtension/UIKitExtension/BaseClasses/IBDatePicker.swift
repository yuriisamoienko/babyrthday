//
//  IBDatePicker.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

open class IBDatePicker: UIDatePicker {
    
    // MARK: Public Properties
    public var onValueChandedCallback: (IBDatePicker) -> Void = { _ in }
    
    // MARK: Overriden functions
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        postInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
    // single enter point to override init in child classes
    open func postInit() {
        addTarget(self, action: #selector(onDatePickerValueChanged), for: .valueChanged)
    }

    // MARK: Private Functions
    
    @objc func onDatePickerValueChanged(_ datePicker: UIDatePicker) {
        onValueChandedCallback(self)
    }
}
