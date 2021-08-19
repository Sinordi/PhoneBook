//
//  ViewController.swift
//  Phone book
//
//  Created by Сергей Кривошапко on 18.08.2021.
//

import UIKit
import Contacts

class PhoneBookViewController: UITableViewController {
    
    //    let phoneBookArray: [ContactModel] = [
    //        ContactModel(phoneNumber: "1", nameOfContact: "A", lastNameOfContact: "AA"),
    //        ContactModel(phoneNumber: "2", nameOfContact: "B", lastNameOfContact: "BB"),
    //        ContactModel(phoneNumber: "3", nameOfContact: "C", lastNameOfContact: "CC")
    //    ]
    
    var phoneBookArray = [ContactModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "ContactsCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        fetchContactData()
        
    }
    
    //Определение кол-ва строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phoneBookArray.count
    }
    
    //Наполнение строк данными из массива
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ContactsCell
        cell.fullNameOfContact.text = phoneBookArray[indexPath.row].nameOfContact + " " + phoneBookArray[indexPath.row].lastNameOfContact
        cell.phoneNumberOfContact.text = phoneBookArray[indexPath.row].phoneNumber
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(phoneBookArray[indexPath.row].phoneNumber)
        let phone = phoneBookArray[indexPath.row].phoneNumber
        let cleanPhoneNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let urlString:String = "tel://\(cleanPhoneNumber)"

        if let phoneCallURL = URL(string: urlString) {
            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    func fetchContactData() {
        
        //The object that fetches and saves contacts, groups, and containers from the user's contacts database.
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { getAccess, error in
            
            if let error = error {
                print("access request error with \(error)")
            } else {
                print("Accsess success")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    request.sortOrder = CNContactSortOrder.userDefault
                    try store.enumerateContacts(with: request, usingBlock: { contact, UnsafeMutablePointer in
                        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? " "
                        
                        if phoneNumber != "" {
                            let nameOfContact = contact.givenName
                            let lastNameOfContact = contact.familyName
                            let contactModel = ContactModel(phoneNumber: phoneNumber, nameOfContact: nameOfContact, lastNameOfContact: lastNameOfContact)
                            self.phoneBookArray.append(contactModel)
                        }
                    })
                    self.tableView.reloadData()
                } catch let error {
                    print("Failed to enumirate contacts with \(error)")
                }
            }
        }
        
    }
}

