//
//  PaymentViewController.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 26/02/21.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var cardTypesView: UIView!
    @IBOutlet weak var totalPriceView: UIView!
    
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var cardDetailsView: UIView!
    
    @IBOutlet weak var baseFare_lbl: UILabel!
    @IBOutlet weak var tax_lbl: UILabel!
    @IBOutlet weak var totalPrice_lbl: UILabel!
    
    @IBOutlet weak var cardHolder_tf: UITextField!
    @IBOutlet weak var cardNum_tf: UITextField!
    @IBOutlet weak var expiry_tf: UITextField!
    @IBOutlet weak var cvv_tf: UITextField!
    
    var price:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parentView.layer.cornerRadius = 20.0
        cardTypesView.layer.cornerRadius = 10.0
        cardDetailsView.layer.cornerRadius = 10.0
        totalPriceView.layer.cornerRadius = 10.0
        proceedBtn.layer.cornerRadius = 10.0
        
        _ = cardHolder_tf.addLine(length: cardHolder_tf.bounds.width+150, color: Constants.titleColor!, width: 0.3)
        _ = cardNum_tf.addLine(length: cardHolder_tf.bounds.width+150, color: Constants.titleColor!, width: 0.3)
        _ = expiry_tf.addLine(length: cardHolder_tf.bounds.width, color: Constants.titleColor!, width: 0.3)
        _ = cvv_tf.addLine(length: cardHolder_tf.bounds.width, color: Constants.titleColor!, width: 0.3)
        
        baseFare_lbl.text = "\u{20B9}\(price!)"
        let tax = Int.random(in: 400...1500)
        tax_lbl.text = "\u{20B9}\(tax)"
        totalPrice_lbl.text = "\u{20B9}\(price! + tax)"
    }
    
    @IBAction func proceedBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("Payment Deinit called")
    }
}
