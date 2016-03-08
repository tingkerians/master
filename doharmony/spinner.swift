//
//  loadingIndicator.swift
//  doharmony
//
//  Created by khemer d great on 08/03/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import Foundation
import UIKit

class Spinner {
    
    var spinnerView: UIActivityIndicatorView!
    
    init(view: UIViewController){
        spinnerView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        spinnerView.frame = CGRectMake(0, 0, 100, 100)
        
        spinnerView.translatesAutoresizingMaskIntoConstraints = true
        
        spinnerView.autoresizingMask = [ .FlexibleTopMargin, .FlexibleBottomMargin,
            .FlexibleLeftMargin, .FlexibleRightMargin ]
        
        spinnerView.center = view.view.center
        spinnerView.hidesWhenStopped = true
        
        view.view.addSubview(spinnerView)
    }
    
    func start(){
        spinnerView.startAnimating()
    }
    
    func stop(){
        
        spinnerView.performSelector("stopAnimating", withObject: nil, afterDelay: 0.9)
        
    }
    
}