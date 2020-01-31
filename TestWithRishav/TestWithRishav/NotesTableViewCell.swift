//
//  NotesTableViewCell.swift
//  TestWithRishav
//
//  Created by Nilesh Gajwani on 24/01/20.
//  Copyright © 2020 Nilesh Gajwani. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell, UITextViewDelegate {
    var contactDelegate: Contact?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    override func prepareForReuse() {
    @IBOutlet weak var notesTextView: UITextView!
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textToSave = textView.text.isEmpty ? text : textView.text + text
        contactDelegate?.notes = textToSave
        return true
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
