//
//  ConfirmationViewController.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 01/03/21.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var printTicket: UIButton!
    @IBOutlet weak var downloadTicketBtn: UIButton!
    @IBOutlet weak var parentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printTicket.layer.cornerRadius = 10.0
        printTicket.layer.borderWidth = 1.0
        printTicket.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        
    }
    
    
    @IBAction func printTicket(_ sender: Any) {
        
    }
    
    deinit {
        print("Payment Deinit called")
    }
}
