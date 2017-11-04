//
//  DealersViewController.swift
//  Rulete
//
//  Created by Carlos De la mora on 10/30/17.
//  Copyright © 2017 carlosdelamora. All rights reserved.
//

import UIKit

class DealersViewController: UIViewController {
    
    var rulets:[Rulet] = [Rulet(id:"Yougi", tipoDeBola:"chica", leftOrRight:"left"), Rulet(id:"Hector",tipoDeBola: "chica", leftOrRight:"left")]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //we set the delegate
        tableView.delegate = self
        tableView.dataSource = self
        nameTextField.delegate = self
    }

}

extension DealersViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rulets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealerCell") as! DealerTableViewCell
        let dealer = rulets[indexPath.row]
        cell.dealerNameLabel.text = dealer.iDRuleta
        return cell
    }
}

extension DealersViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rulet = rulets[indexPath.row]
        let recordsViewController = storyboard?.instantiateViewController(withIdentifier: "recordsViewController") as! RecordsViewController
        recordsViewController.rulet = rulet
        navigationController?.pushViewController(recordsViewController, animated: true)
    }
}

extension DealersViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
