//
//  ViewController.swift
//  pb1
//
//  Created by apple on 11/2/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
  //  var items : [NSManagedObject] = []
   // var cons = [contact]()
    var contact1 = [Contacts]()
    
  //  var cons = [contact(name:"seshu",phno:"754673"),contact(name:"seshu",phno:"754673"),contact(name:"seshu",phno:"754673"),contact(name:"seshu",phno:"754673")]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        tableView.tableFooterView = UIView()
        retrieveData()
      //  updateUser()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveData()
        tableView.reloadData()
    }
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
      
    //    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        do {
          //  let result = try managedContext.fetch(fetchRequest)
            contact1 = try managedContext.fetch(Contacts.fetchRequest())
            for i in contact1{
                print(i.personName!)
                print(i.personNumber!)
            }
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "personName") as! String)
//                print(data.value(forKey: "personNumber") as! String)
//            }
        } catch {
            print("Failed")
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

            let first = contact1.first
            first?.personNumber! += "added"
            try managedContext.save()

        } catch {
            print(error.localizedDescription)
        }

    }
    
    
    
    
    
    
    
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConTableViewCell", for: indexPath) as! ConTableViewCell
        cell.contactName.text = contact1[indexPath.row].personName!
        cell.phoneNumber.text = contact1[indexPath.row].personNumber!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
       
            let cond = contact1[indexPath.row]
            if editingStyle == .delete{
                managedContext.delete(cond)
            do{
                try managedContext.save()
            } catch let error as NSError{
                print("Error While Deleting Note: \(error.userInfo)")
                }
        //Code to Fetch New Data From The DB and Reload Table.
                do{
        contact1 = try managedContext.fetch(Contacts.fetchRequest())
                }catch let error as NSError{
                    print("Error While Deleting Note: \(error.userInfo)")
                }
              tableView.reloadData()
//         contact1.remove(at: indexPath.row)
     //    tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = contact1[indexPath.row].personName!
        let phno = contact1[indexPath.row].personNumber!
        print(name)
        print(phno)
        let stbd = UIStoryboard(name: "Main", bundle: nil)
        let vc = stbd.instantiateViewController(withIdentifier: "EnterContactViewController") as! EnterContactViewController
        vc.p_name = contact1[indexPath.row].personName!
        vc.p_no = contact1[indexPath.row].personNumber!
        vc.postion=indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}

