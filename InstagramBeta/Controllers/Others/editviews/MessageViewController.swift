//
//  MessageViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 06/01/23.
//

import UIKit

class MessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var MessageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
}
