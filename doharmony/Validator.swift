//
//  Validator.swift
//  Validator
//
//  Created by Andres on 10/16/15.
//  Copyright © 2015 Andres Canal. All rights reserved.
//


import Foundation
import UIKit

public class Validator {
	var fields = Array<Field>()
	
	public init(){}
	
	public func addField(field: Field) {
		fields.append(field)
	}
	
	public func anyError() -> Bool {
		return fields.filter{
			return $0.hasError()
		}.count != 0
	}
	
	public func allErrors() -> Array<Field> {
		return fields.filter{
			return $0.hasError()
		}
	}
	
	public func hasError(textField: UITextField) -> Field? {
		for field in fields where field.view == textField {
			if field.hasError() {
				return field
			}
		}
		return nil
	}	
}