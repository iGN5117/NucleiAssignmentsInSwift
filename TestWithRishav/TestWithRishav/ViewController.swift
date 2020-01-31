//
//  ViewController.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 20/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var contactsDict:[String: [Contact]] = [:]
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var contactToEdit: Contact?
    var sortedKeys: [String] = []
    var toggle = true
    var contacts = [Contact](Contact.contactsList.values)
    var tableViewCell: UITableViewCell!
    let v = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Populator.populate()
        contacts = [Contact](Contact.contactsList.values)
        // Do any additional setup after loading the view
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Contacts"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(goToAddContact))
        
//        let sections = Populator.Populator.contacts.map({(ele: Contact) -> String in String(ele.getName().prefix(1).uppercased())})
//        for s in sections {
//            print(s)
//        }
        for contact in contacts {
            if contactsDict[String(contact.getName().prefix(1).uppercased())] == nil {
                contactsDict[String(contact.getName().prefix(1).uppercased())] = []
            }
            contactsDict[String(contact.getName().prefix(1).uppercased())]?.append(contact)
        }
        sortedKeys = [String](contactsDict.keys)
        sortedKeys.sort(by: <)
        for key in sortedKeys {
            contactsDict[key] = contactsDict[key]!.sorted(by: <)
        }
    }
    let cellID = "Cell"
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsDict.count
    }
    override func viewDidAppear(_ animated: Bool) {
        Contact.contactsList[""] = nil
        contactsDict = [:]
        contacts = [Contact](Contact.contactsList.values)
        for contact in contacts {
            if contactsDict[String(contact.getName().prefix(1).uppercased())] == nil {
                contactsDict[String(contact.getName().prefix(1).uppercased())] = []
            }
            contactsDict[String(contact.getName().prefix(1).uppercased())]?.append(contact)
        }
        sortedKeys = [String](contactsDict.keys)
        sortedKeys.sort(by: <)
        for key in sortedKeys {
            contactsDict[key] = contactsDict[key]!.sorted(by: <)
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedKeys[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contactsDict[sortedKeys[section]]!.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellID)
        if tableViewCell == nil {
            tableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: self.cellID)
           // tableViewCell.detailTextLabel!.text = "This is hello world number \(indexPath.row)"
            tableViewCell.textLabel!.textColor = .red
            tableViewCell.textLabel!.highlightedTextColor = .blue
            let editButton = UIButton(type: .roundedRect)
            editButton.setTitle("Edit", for: .normal)
            editButton.sizeToFit()
            tableViewCell.accessoryView = editButton
          //  tableViewCell.accessoryType = tableViewCell.selected
            tableViewCell.selectionStyle = .none
           // tableViewCell.translatesAutoresizingMaskIntoConstraints = false
           
        }
        
        let key = sortedKeys[indexPath.section]
        tableViewCell.textLabel!.text = contactsDict[key]![indexPath.row].getName()
         tableViewCell.detailTextLabel!.text = contactsDict[key]![indexPath.row].getNumber()
        tableViewCell.imageView?.image = contactsDict[key]![indexPath.row].image
        return tableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
           // let name = tableViewCell.textLabel!.text!
            contacts.remove(at: indexPath.row)
            let keyToRemove = sortedKeys[indexPath.section]
            contactsDict[keyToRemove]!.remove(at: indexPath.row)
            let cell = tableView.cellForRow(at: indexPath)
            let nameToRemove = cell?.textLabel?.text
            tableView.deleteRows(at: [indexPath], with: .fade)
            Contact.contactsList[nameToRemove!] = nil
            if contactsDict[keyToRemove]!.isEmpty {
                contactsDict[keyToRemove] = nil
                sortedKeys.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .fade)
            }
         }
//        if editingStyle == .insert {
//            Populator.contacts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
    }
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let currentCell = tableView.cellForRow(at: indexPath)
            let nameOfContactToEdit = (currentCell?.textLabel?.text)!
            print(nameOfContactToEdit)
            self.contactToEdit = Contact.contactsList[nameOfContactToEdit]
                success(true)
            self.performSegue(withIdentifier: "editContactSegue", sender: self)
            })
        closeAction.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 1, alpha: 1)
            return UISwipeActionsConfiguration(actions: [closeAction])
    
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedKeys
    }
   @IBAction func returned(segue: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! EditContact
        destination.contactToEdit = self.contactToEdit
        destination.countTypesOfPhone = (self.contactToEdit?.numbers.count ?? 0) + 1
        destination.countTypesOfEmail = (self.contactToEdit?.emails.count ?? 0) + 1
        print("ye jaa raha hai \((self.contactToEdit?.emails.count ?? 0) + 1)")
        destination.countTypesOfDate = (self.contactToEdit?.dates.count ?? 0) + 1
    }
    
    @IBAction func goToAddContact(_ sender: Any) {
        let addContactViewController = storyboard?.instantiateViewController(identifier: "AddContactViewController") as! AddContactViewController
        self.navigationController?.pushViewController(addContactViewController, animated: true)
    }
}


