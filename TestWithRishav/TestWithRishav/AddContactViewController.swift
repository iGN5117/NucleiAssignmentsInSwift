//
//  AddContactViewController.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 21/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit
//struct contactInfo {
//    var sections: [String] = ["","","",""]
//    var rowData: [:]
//}
class AddContactViewController: UIViewController, UITextFieldDelegate, PhoneButtonClickedProtocol, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var CustomStaticView: UIView!
    var newContact: Contact = Contact()
    @IBOutlet weak var CirclePhotoHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var ButtonInStaticView: UIButton!
    @IBOutlet weak var StaticViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var addPhoneTableView: UITableView!
    var datePickerView: UIView?
    var datePicker: UIDatePicker?
    var imagePicker = UIImagePickerController()
    var typesOfPhone = ["home","work","school","iPhone","mobile","main","home fax","work fax","pager","other"]
    let cellID = "Cell"
    var countTypesOfPhone = 1, countTypesOfEmail = 1, countTypesOfDate = 1
    var buttonText: [Int: String] = [:]
    let addPhoneButton =
        UIButton(type: .contactAdd)
    var cellToAdd: AddPhoneTableViewCell?
    // @IBOutlet var addPhoneText: UITextField?
    var indexClicked: IndexPath?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func chooseImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    //    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
    //        print("adada")
    //        print(image)
    //        self.imageView.image = image
    //        self.dismiss(animated: true, completion: { () -> Void in
    //               })
    //
    //
    //    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            newContact.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        addPhoneTableView.delegate = self
        addPhoneTableView.dataSource = self
        // Do any additional setup after loading the view.
        addPhoneButton.addTarget(self, action: #selector(addPhone), for: .touchUpInside)
        addPhoneTableView.register(UINib(nibName: "AddPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "addPhone")
        addPhoneTableView.register(UINib(nibName: "ContactInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "addContactInfo")
        addPhoneTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "addNotes")
        self.navigationItem.title = "Add"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addContact))
        addPhoneTableView.separatorStyle = .none
        
        ButtonInStaticView.alpha = 1.0
        datePicker = UIDatePicker(frame: CGRect(x: super.view.bounds.minX, y: super.view.bounds.midY + 60, width: super.view.bounds.width, height: 200))
        datePicker?.backgroundColor = .gray
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(selectDate), for: .valueChanged)
        datePickerView = UIView(frame: CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY + 100, width: self.view.bounds.width, height: 250))
        datePickerView!.addSubview(datePicker!)
        datePickerView?.backgroundColor = .gray
        //let getDateButton = UIButton(type: .contactAdd)
        //datePickerView!.addSubview(getDateButton)
        //getDateButton.addTarget(self, action: #, for: <#T##UIControl.Event#>)
        //addPhoneTableView.estimatedRowHeight = 185
        //self.addPhoneTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
    //    @objc func addContact() {
    //
    //        var newContactName: String = ""
    //        var newContactCompany: String = ""
    //        var newContactNumbers: [String : String] = [:]
    //        var newContactEmails: [String : String] = [:]
    //        var newContactDates: [String : String] = [:]
    //        for section in 0...3 {
    //            var rows: Int
    //            switch section {
    //            case 0:
    //                rows = 3
    //            case 1:
    //                rows = countTypesOfPhone
    //            case 2:
    //                rows = countTypesOfEmail
    //            case 3:
    //                rows = countTypesOfDate
    //            default:
    //                rows = 0
    //            }
    //            for row in 0...rows {
    //                let indexPath = IndexPath(row: row, section: section)
    //                let cell = addPhoneTableView.cellForRow(at: indexPath)
    //                if (cell as? ContactInfoTableViewCell) != nil {
    //                    let addContactInfoTableViewCell = cell as! ContactInfoTableViewCell
    //                    if row != 2 {
    //                        newContactName += addContactInfoTableViewCell.contactInfoTextField.text!
    //                        if row == 0 {
    //                            newContactName += " "
    //                        }
    //                    }
    //                    else {
    //                        newContactCompany = addContactInfoTableViewCell.contactInfoTextField.text!
    //                    }
    //                }
    //                else if (cell as? AddPhoneTableViewCell) != nil {
    //                    let addPhoneTableViewCell = cell as! AddPhoneTableViewCell
    //                    if section == 1 {                   newContactNumbers[(addPhoneTableViewCell.showTypesOfPhoneButton.titleLabel?.text)!] = addPhoneTableViewCell.typesOfPhoneTextField.text
    //                    }
    //                    else if section == 2 {
    //                        newContactEmails[(addPhoneTableViewCell.showTypesOfPhoneButton.titleLabel?.text)!] = addPhoneTableViewCell.typesOfPhoneTextField.text
    //                    }
    //                    else if section == 3 {
    //                        newContactDates[(addPhoneTableViewCell.showTypesOfPhoneButton.titleLabel?.text)!] = addPhoneTableViewCell.typesOfPhoneTextField.text
    //                    }
    //                }
    //                else if (cell as? NotesTableViewCell) != nil {
    //
    //                }
    //            }
    //        }
    //        newContact = Contact(name: newContactName, numbers: newContactNumbers, emails: newContactEmails, dates: newContactDates, company: newContactCompany)
    //        print("Added \(newContactName) successfully!!")
    //        self.navigationController?.popViewController(animated: true)
    //    }
    @objc func addContact() {
        Contact.contactsList[""] = nil
        Contact.contactsList[newContact.getName()] = newContact
        print("Added \(newContact.getName()) successfully!!")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectDate() {
        if let indexClicked = indexClicked {
            let cell = addPhoneTableView.cellForRow(at: indexClicked) as? AddPhoneTableViewCell
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            cell?.typesOfPhoneTextField.text = dateFormatter.string(from: (datePicker!.date))
            
        }
        
    }
    
    //Implementing all scroll viw functions here copy paste to an extension ;ater
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let toScroll = scrollView.contentOffset.y
        if scrollView.contentOffset.y < 0 {
            // print("adadad")
            if self.StaticViewHeightConstant.constant < 241 {
                self.StaticViewHeightConstant.constant += abs(toScroll/2)
                if abs(toScroll) > 1 {
                    ButtonInStaticView.alpha += abs(1/toScroll)
                }
            }
        }
        else {
            if StaticViewHeightConstant.constant >= 90 && CirclePhotoHeightConstant.constant >= 60 {
                self.StaticViewHeightConstant.constant -= toScroll/2
                if toScroll > 1 {
                    ButtonInStaticView.alpha -= 1/toScroll
                }
            }
        }
    }
    
    
    
    
    func changeButtonText(_ toChange: String) {
        print(toChange)
        if let indexClicked = indexClicked, let cell = addPhoneTableView.cellForRow(at: indexClicked) as? AddPhoneTableViewCell {
            cell.showTypesOfPhoneButton.setTitle(toChange + "  >", for: .normal)
        }
        
    }
    func textFieldSelected(index: IndexPath) {
        indexClicked = index
        print("index changed to \(indexClicked)")
    }
    func buttonTapped(index: IndexPath) {
        indexClicked = index
        let typesOfPhoneView = storyboard?.instantiateViewController(identifier: "ShowTypesOfPhoneViewController") as! ShowTypesOfPhoneViewController
        typesOfPhoneView.addPhoneViewDelegate = self
        self.present(typesOfPhoneView, animated: true, completion: nil)
    }
    
    @objc func addPhone(_ sender: Any) {
        // print("outside if")
        countTypesOfPhone += 1
        addPhoneTableView.bounds.size.height += 44
        //        var v = IndexPath(
        addPhoneTableView.reloadData()
        //var newIndex = IndexPath(row: countTypesOfPhone, section: 1)
    }
    
    @objc func addEmail(_ sender: Any) {
        // print("outside if")
        countTypesOfEmail += 1
        addPhoneTableView.bounds.size.height += 44
        addPhoneTableView.reloadData()
    }
    
    @objc func addDate(_ sender: Any) {
        // print("outside if")
        // addPhoneTableView.addSubview(datePicker!)
        countTypesOfDate += 1
        addPhoneTableView.bounds.size.height += 44
        addPhoneTableView.reloadData()
    }
    
    
}

//Table
extension AddContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 3
        case 1:
            return countTypesOfPhone
        case 2:
            return countTypesOfEmail
        case 3:
            return countTypesOfDate
        case 4:
            return 1
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: addPhoneTableView.bounds.midX, y: addPhoneTableView.bounds.midY, width: 320, height: 44))
        footerView.backgroundColor = .white
        
        return footerView
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 1:
                countTypesOfPhone -= 1
            case 2:
                countTypesOfEmail -= 1
            case 3:
                countTypesOfDate -= 1
            default:
                break
            }
            if indexPath.row != 0 {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        <#code#>
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let ContactsCellToAdd = addPhoneTableView.dequeueReusableCell(withIdentifier: "addContactInfo", for: indexPath) as! ContactInfoTableViewCell
            ContactsCellToAdd.contactDelegate = newContact
            ContactsCellToAdd.indexDelegate = indexPath
            ContactsCellToAdd.contactInfoTextField.delegate = ContactsCellToAdd
            if indexPath.row == 0 {
                if !(newContact.firstName.isEmpty ) {
                    ContactsCellToAdd.contactInfoTextField.text = newContact.firstName
                }
                else {
                    ContactsCellToAdd.contactInfoTextField.text = ""
                    ContactsCellToAdd.contactInfoTextField.placeholder = "First Name"
                }
            }
            else if indexPath.row == 1 {
                if !(newContact.lastName.isEmpty ) {
                    ContactsCellToAdd.contactInfoTextField.text = newContact.lastName
                }
                else {
                    ContactsCellToAdd.contactInfoTextField.text = ""
                    ContactsCellToAdd.contactInfoTextField.placeholder = "Last Name"
                }
            }
            else {
                if !(newContact.company.isEmpty ) {
                    ContactsCellToAdd.contactInfoTextField.text = newContact.company
                }
                else {
                    ContactsCellToAdd.contactInfoTextField.text = ""
                    ContactsCellToAdd.contactInfoTextField.placeholder = "Company"
                }
            }
            return ContactsCellToAdd
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                var addPhoneTableViewCell = addPhoneTableView.dequeueReusableCell(withIdentifier: self.cellID)
                if addPhoneTableViewCell == nil {
                    addPhoneTableViewCell = UITableViewCell(style: .default, reuseIdentifier: self.cellID)
                    addPhoneButton.tag = 12
                    addPhoneButton.sizeToFit()
                    addPhoneTableViewCell?.accessoryView = addPhoneButton
                    addPhoneTableViewCell?.textLabel!.text = "Add Phone"
                }
                return addPhoneTableViewCell!
            }else {
                var setButtonText = true
                cellToAdd = addPhoneTableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath) as? AddPhoneTableViewCell
                if !(cellToAdd?.typesOfPhoneTextField.text!.isEmpty ?? false) {
                    cellToAdd?.typesOfPhoneTextField.text = ""
                }
                if newContact.numbers.keys.count > indexPath.row - 1 {
                    let keyToCheck = [String](newContact.numbers.keys)[indexPath.row - 1]
                    print("Checking key \(keyToCheck)")
                    if let valueAtKeyExists = newContact.numbers[keyToCheck] {
                        print("Found value \(valueAtKeyExists) at key \(keyToCheck)")
                        cellToAdd?.typesOfPhoneTextField.text = valueAtKeyExists
                        cellToAdd?.showTypesOfPhoneButton.setTitle(keyToCheck, for: .normal)
                        setButtonText = false
                    }
                }
                if let textToChange = buttonText[indexPath.row] {
                    print("Setting text!")
                    cellToAdd?.showTypesOfPhoneButton.titleLabel?.text = textToChange
                }
                cellToAdd?.phoneTappedDelegate = self
                cellToAdd?.contactDelegate = newContact
                cellToAdd?.typesOfPhoneTextField.delegate = cellToAdd
                cellToAdd?.index = indexPath
                if setButtonText {
                    cellToAdd?.showTypesOfPhoneButton.setTitle(typesOfPhone[indexPath.row], for: .normal)
                }
                //addPhoneTableView.bounds.size.height += (cellToAdd!.bounds.size.height)
                return cellToAdd!
            }
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                var addEmailTableViewCell = addPhoneTableView.dequeueReusableCell(withIdentifier: self.cellID)
                if addEmailTableViewCell == nil {
                    addEmailTableViewCell = UITableViewCell(style: .default, reuseIdentifier: self.cellID)
                    let addEmailButton = UIButton(type: .contactAdd)
                    addEmailButton.sizeToFit()
                    addEmailButton.addTarget(self, action: #selector(addEmail), for: .touchUpInside)
                    addEmailTableViewCell?.accessoryView = addEmailButton
                    addEmailTableViewCell?.textLabel!.text = "Add Email"
                    
                }
                return addEmailTableViewCell!
            }else {
                var setButtonText = true
                cellToAdd = addPhoneTableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath) as? AddPhoneTableViewCell
                cellToAdd?.typesOfPhoneTextField.inputView = .none
                if !(cellToAdd?.typesOfPhoneTextField.text!.isEmpty ?? false) {
                    cellToAdd?.typesOfPhoneTextField.text = ""
                }
                if newContact.emails.keys.count > indexPath.row - 1 {
                    let keyToCheck = [String](newContact.emails.keys)[indexPath.row - 1]
                    if let valueAtKeyExists = newContact.emails[keyToCheck] {
                        cellToAdd?.typesOfPhoneTextField.text = valueAtKeyExists
                        cellToAdd?.showTypesOfPhoneButton.setTitle(keyToCheck, for: .normal)
                        setButtonText = false
                    }
                }
                if let textToChange = buttonText[indexPath.row] {
                    print("Setting text!")
                    cellToAdd?.showTypesOfPhoneButton.titleLabel?.text = textToChange
                }
                cellToAdd?.phoneTappedDelegate = self
                cellToAdd?.contactDelegate = newContact
                cellToAdd?.typesOfPhoneTextField.delegate = cellToAdd
                cellToAdd?.index = indexPath
                if setButtonText {
                    cellToAdd?.showTypesOfPhoneButton.setTitle(typesOfPhone[indexPath.row], for: .normal)
                }
                //addPhoneTableView.bounds.size.height += (cellToAdd!.bounds.size.height)
                return cellToAdd!
            }
        }
        else if indexPath.section == 3 {
            if indexPath.row == 0 {
                var addPhoneTableViewCell = addPhoneTableView.dequeueReusableCell(withIdentifier: self.cellID)
                if addPhoneTableViewCell == nil {
                    addPhoneTableViewCell = UITableViewCell(style: .default, reuseIdentifier: self.cellID)
                    let addDateButton = UIButton(type: .contactAdd)
                    addDateButton.sizeToFit()
                    addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
                    addPhoneTableViewCell?.accessoryView = addDateButton
                    addPhoneTableViewCell?.textLabel!.text = "Add Date"
                    
                    
                }
                return addPhoneTableViewCell!
            }else {
                cellToAdd = addPhoneTableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath) as? AddPhoneTableViewCell
                var setButtonText = true
                cellToAdd?.typesOfPhoneTextField.inputView = datePicker
                if !(cellToAdd?.typesOfPhoneTextField.text!.isEmpty ?? false) {
                    cellToAdd?.typesOfPhoneTextField.text = ""
                }
                
                if newContact.dates.keys.count > indexPath.row - 1 {
                    let keyToCheck = [String](newContact.dates.keys)[indexPath.row - 1]
                    if let valueAtKeyExists = newContact.dates[keyToCheck] {
                        cellToAdd?.typesOfPhoneTextField.text = valueAtKeyExists
                        cellToAdd?.showTypesOfPhoneButton.setTitle(keyToCheck, for: .normal)
                        setButtonText = false
                    }
                }
                
                if setButtonText {
                    cellToAdd?.showTypesOfPhoneButton.setTitle(typesOfPhone[indexPath.row], for: .normal)
                }
                cellToAdd?.contactDelegate = newContact
                cellToAdd?.typesOfPhoneTextField.delegate = cellToAdd
                cellToAdd?.phoneTappedDelegate = self
                cellToAdd?.index = indexPath
                //addPhoneTableView.bounds.size.height += (cellToAdd!.bounds.size.height)
                return cellToAdd!
            }
        }
            
            
        else if indexPath.section == 4 {
            let NotesCellToAdd = addPhoneTableView.dequeueReusableCell(withIdentifier: "addNotes", for: indexPath) as! NotesTableViewCell
            NotesCellToAdd.notesTextView.delegate = NotesCellToAdd
            NotesCellToAdd.contactDelegate = newContact
            return NotesCellToAdd
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 185
        }
        else {
            return 44
        }
    }
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if indexPath.section == 3 {
    //            if indexPath.row == 0 {
    //                let cellLayoutMargins = cell.layoutMarginsGuide
    //                datePicker?.topAnchor.constraint(equalTo: cellLayoutMargins.topAnchor, constant: 20).isActive = true
    //                datePicker?.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 0).isActive = true
    //            }
    //        }
    //    }
}


//extension AddContactViewController: UIScrollViewDelegate {
//
//}
