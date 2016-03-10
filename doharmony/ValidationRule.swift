//
//  ValidationRule.swift
//  Validator
//
//  Created by Andres on 10/27/15.
//  Copyright © 2015 Andres Canal. All rights reserved.
//

import UIKit

public protocol ValidationRuleProtocol {
	func validationRule() -> ((fieldText: String) -> Bool)
}

public enum Lenght {
	case Is
	case Maximum
	case Minimum
	case In
}

public enum ValidationRule: ValidationRuleProtocol {
	case Exclusion([String])
	case Format(String)
	case Inclusion([String])
	case Email
	case Length(Lenght,Any)
	case False
	case True
	
	public func validationRule() -> ((fieldText: String) -> Bool){
		switch self {
		case let .Exclusion(exclusionElements):
			return { (fieldText: String) -> Bool in
				
				for exclusionElement in exclusionElements {
					if ((fieldText.rangeOfString(exclusionElement)) != nil) {
						return false
					}
				}
				return true
			}
			
		case let .Format(regex):
			return { (fieldText: String) -> Bool in
				let regexTest = NSPredicate(format:"SELF MATCHES %@", regex)
				return regexTest.evaluateWithObject(fieldText)
			}
			
		case let .Inclusion(inclusionElements):
			return { (fieldText: String) -> Bool in
				
				for inclusionElement in inclusionElements {
					if ((fieldText.rangeOfString(inclusionElement)) != nil) {
						return true
					}
				}
				return false
			}
			
		case .Email:
			return { (fieldText: String) -> Bool in
				let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
				let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
				return emailTest.evaluateWithObject(fieldText)
			}
			
		case .Length(Lenght.Is, let exact as Int):
			return { (fieldText: String) -> Bool in
				return fieldText.characters.count == exact
			}
			
		case .Length(Lenght.Minimum, let minimum as Int):
			return { (fieldText: String) -> Bool in
				return fieldText.characters.count >= minimum
			}
			
		case .Length(Lenght.Maximum , let maximum as Int):
			return { (fieldText: String) -> Bool in
				return fieldText.characters.count <= maximum
			}
			
		case .Length(Lenght.In , let interval as HalfOpenInterval<Int>):
			return { (fieldText: String) -> Bool in
				return interval.contains(fieldText.characters.count)
			}
			
		case .Length(Lenght.In , let interval as ClosedInterval<Int>):
			return { (fieldText: String) -> Bool in
				return interval.contains(fieldText.characters.count)
			}
			
		case .True:
			return { (fieldText: String) -> Bool in
				return true
			}

		case .False:
			return { (fieldText: String) -> Bool in
				return false
			}

		default:
			return { (fieldText: String) -> Bool in
				return false
			}
		}
	}
}
