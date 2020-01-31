//
//  ShowTypesOfPhoneViewController.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 23/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit

class ShowTypesOfPhoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var addPhoneViewDelegate: AddContactViewController?
    var editPhoneViewDelegate: EditContact?
    let cellID = "cell"
    var tableViewCell: UITableViewCell!
    @IBOutlet weak var typesOfPhoneTableView: UITableView!
    var typesOfPhone = ["home","work","school","iPhone","mobile","main","home fax","work fax","pager","other"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typesOfPhoneTableView.delegate = self
        typesOfPhoneTableView.dataSource = self
        self.modalPresentationStyle = .currentContext
        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesOfPhone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableViewCell = typesOfPhoneTableView.dequeueReusableCell(withIdentifier: self.cellID)
        if tableViewCell == nil {
            tableViewCell = UITableViewCell(style: .default, reuseIdentifier: self.cellID)
            tableViewCell?.textLabel!.text = typesOfPhone[indexPath.row]
            tableViewCell?.accessoryType = tableViewCell!.isSelected ? .checkmark:.none
        }
        return tableViewCell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = typesOfPhoneTableView.indexPathForSelectedRow
        
        let currentCell = typesOfPhoneTableView.cellForRow(at: indexPath!) as UITableViewCell?
        currentCell?.accessoryType = .checkmark
        addPhoneViewDelegate?.changeButtonText((currentCell?.textLabel!.text)!)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
