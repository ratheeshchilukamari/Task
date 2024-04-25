//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Ratheesh Chilukamari on 25/04/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.layer.cornerRadius = 4
        viewContainer.layer.masksToBounds = false
        viewContainer?.layer.shadowColor = UIColor.lightGray.cgColor
        viewContainer?.layer.shadowOffset =  CGSize.zero
        viewContainer?.layer.shadowOpacity = 0.5
        viewContainer?.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
