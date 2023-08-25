//
//  PeopleViewController.swift
//  IOSAssignment
//
//  Created by Viktor van Hulle on 25/08/2023.
//

import UIKit

class PeopleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad() //lifecycle event within peoplevc
        
        print("ya boy is swifty")
        // Do any additional setup after loading the view.
        setup()
        
        
        
    }


}

private extension PeopleViewController {
    func setup(){
        //UI logic for screen
        //set bg color
        self.view.backgroundColor = .white
    }
}
