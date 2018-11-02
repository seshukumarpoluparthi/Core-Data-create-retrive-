//
//  EnterContactViewController.swift
//  pb1
//
//  Created by apple on 11/2/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import CoreData

class EnterContactViewController: UIViewController {
    var contact1 = [Contacts]()
    var p_name : String = ""
    var p_no : String = ""
    var pos : Int = 0
    var postion=0
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_Number: UITextField!
    
    @IBAction func btn_Save(_ sender: Any) {
        //saveData()
        updateUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_Name.delegate = self
        txt_Number.delegate = self
        txt_Name.text = p_name
        txt_Number.text = p_no
    }
    
    func saveData(){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
         let managedContext = appdelegate.persistentContainer.viewContext
        
        let newcont = Contacts(context: managedContext)
        newcont.personName = txt_Name.text!
        newcont.personNumber = txt_Number.text!
        
//        let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedContext)
//        let item = NSManagedObject(entity : entity!,insertInto :managedContext)
//        item.setValue(txt_Name.text!, forKey: "personName")
//        item.setValue(txt_Number.text!, forKey: "personNumber")
        
        do{
            try managedContext.save()
           self.navigationController?.popViewController(animated: true)
        } catch let err as NSError{
            print("failed to save" , err)
        }
    }
    func updateUser() {
        
        guard  let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appdelegate.persistentContainer.viewContext
        
        do{
            contact1 = try managedContext.fetch(Contacts.fetchRequest())
            print(contact1)
            for data in 0..<contact1.count
            {
                if postion==data
                {
                    contact1[data].personName=self.txt_Name.text
                    contact1[data].personNumber=self.txt_Number.text
                    try managedContext.save()
                }
            }
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
extension EnterContactViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
