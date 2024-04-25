//
//  DetailsViewController.swift
//  Task
//
//  Created by Ratheesh Chilukamari on 25/04/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    var details : Post!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Details"
        if (details != nil) {
            lblTitle.text = "\(details.id): \(details.title)"
            lblBody.text = "Body: \(details.body)"
        }
    }
    

    static func getInstance()-> DetailsViewController{
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    }

}
