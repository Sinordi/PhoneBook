//
//  ContactsCell.swift
//  Phone book
//
//  Created by Сергей Кривошапко on 19.08.2021.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var fullNameOfContact: UILabel!
    @IBOutlet weak var phoneNumberOfContact: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
    }
    
}
