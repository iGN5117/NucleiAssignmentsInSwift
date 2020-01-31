//
//  ContactInfoTableViewCell.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 24/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit

class ContactInfoTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var contactInfoTextField: UITextField!
    var contactDelegate: Contact?
    var indexDelegate: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch indexDelegate?.row {
        case 0:
            contactDelegate?.firstName = textField.text?.isEmpty ?? true ? string : textField.text! + string
            print("Setting name to \(contactDelegate?.firstName)")
        case 1:
            contactDelegate?.lastName = textField.text?.isEmpty ?? true ? string : textField.text! + string
        case 2:
            contactDelegate?.company = textField.text?.isEmpty ?? true ? string : textField.text! + string
        default:
            break
        }
        return true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    @IBAction func saveContactInfo(_ sender: Any) {
    //    }
    
    
    
}
