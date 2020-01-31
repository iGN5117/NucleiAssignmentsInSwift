//
//  AddPhoneTableViewCell.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 21/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit

protocol PhoneButtonClickedProtocol {
    func buttonTapped(index: IndexPath)
    func textFieldSelected(index: IndexPath)
}

class AddPhoneTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var showTypesOfPhoneButton: UIButton!
    @IBOutlet weak var typesOfPhoneTextField: UITextField!
    
    var index: IndexPath?
    var phoneTappedDelegate: PhoneButtonClickedProtocol?
    var contactDelegate: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //        override func prepareForReuse() {
    //            typesOfPhoneTextField.text = ""
    //            showTypesOfPhoneButton.titleLabel?.text = "Phone >"
    //        }
    
    
    // TODO: change delegate type to VC class type for edit and add and set save button to enabled there.
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //        <#code#>
    //    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let index = index {
            phoneTappedDelegate?.textFieldSelected(index: index)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if index?.section == 3 {
            print("here i am")
            let dateToSave = textField.text
            contactDelegate?.dates[showTypesOfPhoneButton.titleLabel?.text ?? "Birthday"] = dateToSave
            print("saved \(dateToSave) at key \(showTypesOfPhoneButton.titleLabel?.text ?? "Birthday")")
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if index?.section == 1 {
            let numberToSave = textField.text?.isEmpty ?? true ? string : textField.text! + string
            contactDelegate?.numbers[showTypesOfPhoneButton.titleLabel?.text ?? "Mobile"] = numberToSave
        }
        else if index?.section == 2 {
            let emailToSave = textField.text?.isEmpty ?? true ? string : textField.text! + string
            contactDelegate?.emails[showTypesOfPhoneButton.titleLabel?.text ?? "Mobile"] = emailToSave
            print("saved \(emailToSave) at key \(showTypesOfPhoneButton.titleLabel?.text ?? "Mobile")")
        }
        else if index?.section == 3 {
            print("here i am")
            let dateToSave = textField.text?.isEmpty ?? true ? string : textField.text! + string
            contactDelegate?.dates[showTypesOfPhoneButton.titleLabel?.text ?? "Birthday"] = dateToSave
            print("saved \(dateToSave) at key \(showTypesOfPhoneButton.titleLabel?.text ?? "Birthday")")
        }
        //        else if index?.section == 3 {
        //            let dateToSave = textField.text?.isEmpty ?? true ? string : textField.text! + string
        //            if let keyExists = contactDelegate?.emails[(showTypesOfPhoneButton.titleLabel?.text)!]
        //            {
        //               var stringArray = keyExists
        //                stringArray.append(emailToSave)
        //                contactDelegate?.emails[(showTypesOfPhoneButton.titleLabel?.text)!] = stringArray
        //            }
        //            else {
        //                var stringArray = [String]()
        //                stringArray.append(emailToSave)
        //                contactDelegate?.emails[(showTypesOfPhoneButton.titleLabel?.text)!] = stringArray
        //            }
        //        }
        return true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func phoneButtonClicked(_ sender: Any) {
        //handle old button text here
        if index?.section == 1 {
            if !(typesOfPhoneTextField.text?.isEmpty ?? true) {
                contactDelegate?.numbers[showTypesOfPhoneButton.titleLabel?.text ?? "Mobile"] = nil
            }
        }
        else if index?.section == 2 {
            if !(typesOfPhoneTextField.text?.isEmpty ?? true) {
                contactDelegate?.emails[showTypesOfPhoneButton.titleLabel?.text ?? "Mobile"] = nil
            }
        }
        if let index = index {
            phoneTappedDelegate?.buttonTapped(index: index)
        }
        //handle new button text here
        if index?.section == 1 {
            let newKey = showTypesOfPhoneButton.titleLabel?.text ?? "Mobile"
            contactDelegate?.numbers[newKey] = typesOfPhoneTextField.text
        }
        else if index?.section == 2 {
            let newKey = showTypesOfPhoneButton.titleLabel?.text ?? "Mobile"
            contactDelegate?.emails[newKey] = typesOfPhoneTextField.text
        }
    }
    
}


