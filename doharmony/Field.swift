//
//  Field.swift
//  Validator
//
//  Created by Andres on 10/27/15.
//  Copyright © 2015 Andres Canal. All rights reserved.
//

import UIKit

public struct Field {
	private(set) public var view: UITextField
	private var validationRule: (fieldText: String) -> Bool
	private(set) public var errorMessage: String
	private(set) public var viewLabel: UILabel;
    
	public init(view: UITextField, viewLabel: UILabel,errorMessage: String, validationRule: (fieldText: String) -> Bool) {
		self.view = view
		self.validationRule = validationRule
		self.errorMessage = errorMessage
        self.viewLabel = viewLabel;
	}
	
	public init(view: UITextField, viewLabel: UILabel,errorMessage: String, validationRule: ValidationRuleProtocol) {
		self.view = view
		self.validationRule = validationRule.validationRule()
		self.errorMessage = errorMessage
        self.viewLabel = viewLabel;
	}
	
	public func hasError() -> Bool {
		return !self.validationRule(fieldText: self.view.text!)
	}
	
	public func result() -> String {
		return self.hasError() ? self.errorMessage : ""
	}
}