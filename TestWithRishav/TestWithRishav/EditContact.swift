//
//  EditContact.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 21/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit

class EditContact: UIViewController, UITableViewDelegate, UITableViewDataSource, PhoneButtonClickedProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
   
    
    @IBOutlet weak var editContactTableView: UITableView!
    @IBOutlet weak var CirclePhotoHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var ButtonInStaticView: UIButton!
    var typesOfPhone = ["home","work","school","iPhone","mobile","main","home fax","work fax","pager","other"]
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var StaticViewHeightConstant: NSLayoutConstraint!
    var imagePicker = UIImagePickerController()
    var contactToEdit: Contact?
    var datePicker: UIDatePicker?
    var oldName: String?
    var countTypesOfPhone: Int?, countTypesOfEmail: Int?, countTypesOfDate: Int?
    var indexClicked: IndexPath?
    
    
    func textFieldSelected(index: IndexPath) {
           indexClicked = index
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let finalContact = contactToEdit {
            print("aagaya!!")
            print(finalContact.getName())
            editContactTableView.delegate = self
            editContactTableView.dataSource = self
            editContactTableView.register(UINib(nibName: "ContactInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "addContactInfo")
            editContactTableView.register(UINib(nibName: "AddPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "addPhone")
            editContactTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "addNotes")
            oldName = contactToEdit?.getName()
            self.navigationItem.title = "Edit"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(editContact))
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(selectDate), for: .valueChanged)
            if let imageExists = contactToEdit?.image {
                imageView.image = imageExists
            }
            //self.navigationItem.rightBarButtonItem = UIBarButtonItem(
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func chooseImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            contactToEdit!.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 185
        }
        else {
            return 44
        }
    }
    
    func buttonTapped(index: IndexPath) {
        indexClicked = index
        let typesOfPhoneView = storyboard?.instantiateViewController(identifier: "ShowTypesOfPhoneViewController") as! ShowTypesOfPhoneViewController
        typesOfPhoneView.editPhoneViewDelegate = self
        self.present(typesOfPhoneView, animated: true, completion: nil)
    }
    
    func changeButtonText(_ toChange: String) {
        print(toChange)
        if let indexClicked = indexClicked, let cell = editContactTableView.cellForRow(at: indexClicked) as? AddPhoneTableViewCell {
            cell.showTypesOfPhoneButton.setTitle(toChange + "  >", for: .normal)
        }
    }
    
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return countTypesOfPhone!
        case 2:
            return countTypesOfEmail!
        case 3:
            return countTypesOfDate!
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // var cellToDisplay: UITableViewCell
        if indexPath.section == 0 {
            let cellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "addContactInfo", for: indexPath) as! ContactInfoTableViewCell
            cellToDisplay.selectionStyle = .none
            cellToDisplay.contactDelegate = contactToEdit
            cellToDisplay.contactInfoTextField.delegate = cellToDisplay
            cellToDisplay.indexDelegate = indexPath
            switch indexPath.row {
            case 0:
                if !(contactToEdit?.firstName.isEmpty ?? true ) {
                    cellToDisplay.contactInfoTextField.text = contactToEdit?.firstName
                }else {
                    cellToDisplay.contactInfoTextField.text = ""
                    cellToDisplay.contactInfoTextField.placeholder = "First Name"
                }
            //cellToDisplay.contactInfoTextField.text = firstName
            case 1:
                if !(contactToEdit?.lastName.isEmpty ?? true ) {
                    cellToDisplay.contactInfoTextField.text = contactToEdit?.lastName
                }else {
                    cellToDisplay.contactInfoTextField.text = ""
                    cellToDisplay.contactInfoTextField.placeholder = "Last Name"
                }
            case 2:
                if !(contactToEdit?.company.isEmpty ?? true ) {
                    cellToDisplay.contactInfoTextField.text = contactToEdit?.company
                }else {
                    cellToDisplay.contactInfoTextField.text = ""
                    cellToDisplay.contactInfoTextField.placeholder = "Company Name"
                }
            default:
                break
            }
            
            return cellToDisplay
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                var defaultCellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "cell")
                if defaultCellToDisplay == nil {
                    defaultCellToDisplay = UITableViewCell(style: .default, reuseIdentifier: "cell")
                    defaultCellToDisplay?.textLabel?.text = "Add Phone"
                    let addPhoneButton = UIButton(type: .contactAdd)
                    defaultCellToDisplay?.selectionStyle = .none
                    addPhoneButton.addTarget(self, action: #selector(addPhone), for: .touchUpInside)
                    defaultCellToDisplay?.accessoryView = addPhoneButton
                }
                
                return defaultCellToDisplay!
            }
            else {
                let cellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath) as! AddPhoneTableViewCell
                var setButtonText = true
                let index = indexPath.row - 1
                if index < (contactToEdit?.numbers.count)! {
                    let typeOfNumber = [String](contactToEdit!.numbers.keys)[index]
                    let number = contactToEdit!.numbers[typeOfNumber]
                    cellToDisplay.showTypesOfPhoneButton.setTitle(typeOfNumber, for: .normal)//titleLabel?.text = typeOfNumber
                    cellToDisplay.typesOfPhoneTextField.text = number
                    cellToDisplay.showTypesOfPhoneButton.setTitle(typeOfNumber, for: .normal)
                    setButtonText = false
                } else {
                    cellToDisplay.showTypesOfPhoneButton.setTitle(typesOfPhone[indexPath.row], for: .normal)//titleLabel?.text = "Phone"
                    cellToDisplay.typesOfPhoneTextField.text = ""
                }
                cellToDisplay.selectionStyle = .none
                cellToDisplay.phoneTappedDelegate = self
                cellToDisplay.contactDelegate = contactToEdit
                cellToDisplay.index = indexPath
                cellToDisplay.typesOfPhoneTextField.delegate = cellToDisplay
                return cellToDisplay
            }
        }
            
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                var defaultCellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "cell")
                if defaultCellToDisplay == nil {
                    defaultCellToDisplay = UITableViewCell(style: .default, reuseIdentifier: "cell")
                    defaultCellToDisplay?.textLabel?.text = "Add Email"
                    let addEmailButton = UIButton(type: .contactAdd)
                    addEmailButton.addTarget(self, action: #selector(addEmail), for: .touchUpInside)
                    defaultCellToDisplay?.accessoryView = addEmailButton
                    defaultCellToDisplay?.selectionStyle = .none
                }
                return defaultCellToDisplay!
            }
            else {
                let cellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath) as! AddPhoneTableViewCell
                let index = indexPath.row - 1
                if index < (contactToEdit?.emails.count)! {
                    let typeOfEmail = [String](contactToEdit!.emails.keys)[index]
                    let email = contactToEdit!.emails[typeOfEmail]
                    cellToDisplay.showTypesOfPhoneButton.titleLabel?.text = typeOfEmail
                    cellToDisplay.typesOfPhoneTextField.text = email
                }else {
                    cellToDisplay.showTypesOfPhoneButton.setTitle(typesOfPhone[indexPath.row], for: .normal)//titleLabel?.text = "Phone"
                    cellToDisplay.typesOfPhoneTextField.text = ""
                }
                cellToDisplay.selectionStyle = .none
                cellToDisplay.phoneTappedDelegate = self
                cellToDisplay.index = indexPath
                cellToDisplay.contactDelegate = contactToEdit
                cellToDisplay.typesOfPhoneTextField.delegate = cellToDisplay
                return cellToDisplay
            }
        }
        else if indexPath.section == 3 {
            if indexPath.row == 0 {
                var defaultCellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "cell")
                if defaultCellToDisplay == nil {
                    defaultCellToDisplay = UITableViewCell(style: .default, reuseIdentifier: "cell")
                    let addDateButton = UIButton(type: .contactAdd)
                    addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
                    defaultCellToDisplay?.accessoryView = addDateButton
                    defaultCellToDisplay?.textLabel?.text = "Add Date"
                    defaultCellToDisplay?.selectionStyle = .none
                }
                return defaultCellToDisplay!
            }
            else {
                let cellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath) as! AddPhoneTableViewCell
                let index = indexPath.row - 1
                if index < (contactToEdit?.dates.count)! {
                    let typeOfDate = [String](contactToEdit!.dates.keys)[index]
                    let date = contactToEdit!.dates[typeOfDate]
                    cellToDisplay.showTypesOfPhoneButton.titleLabel?.text = typeOfDate
                    cellToDisplay.typesOfPhoneTextField.text = date
                }else {
                    cellToDisplay.showTypesOfPhoneButton.setTitle(typesOfPhone[indexPath.row], for: .normal)//titleLabel?.text = "Phone"
                    cellToDisplay.typesOfPhoneTextField.text = ""
                }
                cellToDisplay.selectionStyle = .none
                cellToDisplay.phoneTappedDelegate = self
                cellToDisplay.index = indexPath
                cellToDisplay.typesOfPhoneTextField.inputView = datePicker
                return cellToDisplay
            }
        }
        else if indexPath.section == 4 {
            let cellToDisplay = editContactTableView.dequeueReusableCell(withIdentifier: "addNotes", for: indexPath) as! NotesTableViewCell
            cellToDisplay.selectionStyle = .none
            if !(contactToEdit?.notes.isEmpty ?? true) {
                cellToDisplay.notesTextView.text = contactToEdit?.notes
            }else {
                cellToDisplay.notesTextView.text = ""
            }
            cellToDisplay.contactDelegate = contactToEdit
            cellToDisplay.notesTextView.delegate = cellToDisplay
            return cellToDisplay
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: editContactTableView.bounds.midX, y: editContactTableView.bounds.midY, width: editContactTableView.bounds.size.width, height: 44))
        footerView.backgroundColor = .white
        return footerView
    }
    
    
    
    //    @objc func editContact() {
    //        Contact.contactsList[oldName!] = nil
    //        let newContact: Contact
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
    //                rows = countTypesOfPhone!
    //            case 2:
    //                rows = countTypesOfEmail!
    //            case 3:
    //                rows = countTypesOfDate!
    //            default:
    //                rows = 0
    //            }
    //            for row in 0..<rows {
    //                let indexPath = IndexPath(row: row, section: section)
    //                let cell = editContactTableView.cellForRow(at: indexPath)
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
    
    @objc func editContact() {
        Contact.contactsList[oldName ?? ""] = nil
        print("Deleted contact with name \(oldName ?? "")")
        Contact.contactsList[contactToEdit?.getName() ?? ""] = contactToEdit
        print("Added contact with name \(contactToEdit?.getName())")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addPhone(_ sender: Any) {
        // print("outside if")
        countTypesOfPhone! += 1
        //editContactTableView.bounds.size.height += 44
        editContactTableView.reloadData()
    }
    @objc func addEmail(_ sender: Any) {
        // print("outside if")
        countTypesOfEmail! += 1
        // addPhoneTableView.bounds.size.height += 44
        editContactTableView.reloadData()
    }
    @objc func addDate(_ sender: Any) {
        // print("outside if")
        countTypesOfDate! += 1
        //    addPhoneTableView.bounds.size.height += 44
        editContactTableView.reloadData()
    }
    
    
    @objc func selectDate() {
        if let indexClicked = indexClicked {
            let cell = editContactTableView.cellForRow(at: indexClicked) as? AddPhoneTableViewCell
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            cell?.typesOfPhoneTextField.text = dateFormatter.string(from: (datePicker!.date))
        }
  
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let destination = segue.destination as! ViewController
    //        destination.c
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
