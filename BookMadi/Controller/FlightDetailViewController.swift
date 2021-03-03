//
//  FlightDetailViewController.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 23/02/21.
//

import UIKit

class FlightDetailViewController: UIViewController {
    @IBOutlet weak var flightLogo: UIImageView!
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var source_lbl: UILabel!
    @IBOutlet weak var ticketPrice_lbl: UILabel!
    
    @IBOutlet weak var seatNo_lbl: UILabel!
    @IBOutlet weak var totalPassenger_lbl: UILabel!
    @IBOutlet weak var flightNo_lbl: UILabel!
    @IBOutlet weak var destination_lbl: UILabel!
    @IBOutlet weak var depart_lbl: UILabel!
    
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var seatSelectionMasterView: UIView!
    @IBOutlet weak var seatSelectionCollectionView: UICollectionView!
    @IBOutlet weak var class_btn: UIButton!
    
    var preselectedSeats : [Int]!
    let bookingViewModel = BookingViewModel()
    
    var seats:String?{
        didSet{
            seatNo_lbl.attributedText = bookingViewModel.getDepartAttribString(align: "left", str1: "Seat No",
                                                                               str2: seats ?? "0", str1Color: Constants.whiteOpaque!,
                                                                               str2Color: UIColor.white, str1Font: ProjectFont.medium(14.0).customFont,
                                                                               str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        }
    }
    
    var unselectedSeats : [Int]{
        switch selectedClass {
        case .Elite:
            return Array(1...16)
            
        case .Economy:
            return Array(41...76)
            
        case .Business:
            return Array(17...40)
            
        case .none:
            return Array(1...16)
        }
    }
    
    var iataCode:String?{
        didSet{
            let randNum = Int.random(in: 1000...9999)
            let flightNum = "\(iataCode!)\(randNum)"
            flightNo_lbl.attributedText = bookingViewModel.getDepartAttribString(align: "left", str1: "Flight No.",
                                                                                 str2: flightNum, str1Color: Constants.whiteOpaque!,
                                                                                 str2Color: UIColor.white, str1Font: ProjectFont.medium(14.0).customFont,
                                                                                 str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        }
    }
    
    var currentSeats = QueueArray<Int>()
    
    var flightInfo : FlightQuote?
    
    var quote : Quotes?
    
    var selectedClass : FlightClassType!
    
    var flightRequest : FlightQuoteRequest?{
        didSet{
            selectedClass = flightRequest?.ticketClass
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seatSelectionCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SeatCell")
        setupInitialUI()
    }
    
    func setupInitialUI(){
        parentView.layer.cornerRadius = 30.0
        seatSelectionMasterView.layer.cornerRadius = 10.0
        checkoutBtn.layer.cornerRadius = 10.0
        class_btn.setTitle(selectedClass.rawValue, for: .normal)
        
        if let carriers = quote?.outboundLeg?.carrierIds?.first{
            if let airlineCode = flightInfo?.carriers?.filter({$0.carrierId == carriers}).first?.name?.getAirlineCode(){
                let url = "\(Constants.imageBaseURL)\(airlineCode)"
                iataCode = airlineCode
                flightLogo.imageFromServerURL(url, placeHolder: nil)
                flightLogo.layer.cornerRadius = flightLogo.bounds.width / 2 
            }
        }
        
        
        if let source = quote?.outboundLeg?.originId{
            if let sourceAirportData = flightInfo?.places?.filter({$0.placeId == source}).first{
                let attribString = bookingViewModel.getDepartAttribString(align: "left", str1: sourceAirportData.cityName!,
                                                                          str2: sourceAirportData.iataCode!, str1Color: UIColor.white,
                                                                          str2Color: Constants.whiteOpaque!, str1Font: ProjectFont.medium(17.0).customFont,
                                                                          str2Font: ProjectFont.medium(14.0).customFont, nextLine: true)
                source_lbl.attributedText = attribString
            }
        }
        
        
        if let destination = quote?.outboundLeg?.destinationId{
            if let destionationAirportData = flightInfo?.places?.filter({$0.placeId == destination}).first{
                let attribString = bookingViewModel.getDepartAttribString(align: "left", str1: destionationAirportData.cityName!,
                                                                          str2: destionationAirportData.iataCode!, str1Color: UIColor.white,
                                                                          str2Color: Constants.whiteOpaque!, str1Font: ProjectFont.medium(17.0).customFont,
                                                                          str2Font: ProjectFont.medium(14.0).customFont, nextLine: true)
                destination_lbl.attributedText = attribString
            }
        }
        
        if let price = quote?.minPrice{
            ticketPrice_lbl.attributedText = bookingViewModel.getDepartAttribString(align: "left", str1: "Ticket Price",
                                                                                    str2: "\u{20B9}\(price)", str1Color: Constants.whiteOpaque!,
                                                                                    str2Color: UIColor.white, str1Font: ProjectFont.medium(14.0).customFont,
                                                                                    str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        }
        
        
        let travellers = flightRequest!.adults + flightRequest!.children
        
        totalPassenger_lbl.attributedText = bookingViewModel.getDepartAttribString(align: "left", str1: "Travellers",
                                                                                   str2: "\(travellers)", str1Color: Constants.whiteOpaque!,
                                                                                   str2Color: UIColor.white, str1Font: ProjectFont.medium(14.0).customFont,
                                                                                   str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        
        let randNum = Int.random(in: 1...9)
        
        if let departure = Date().add(component: .hour, value: randNum)?.toString(format: "hh:mm a"){
            
            depart_lbl.attributedText = bookingViewModel.getDepartAttribString(align: "left", str1: "Depart",
                                                                               str2: departure, str1Color: Constants.whiteOpaque!,
                                                                               str2Color: UIColor.white, str1Font: ProjectFont.medium(14.0).customFont,
                                                                               str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        }
        
        
        seatNo_lbl.attributedText = bookingViewModel.getDepartAttribString(align: "left", str1: "Seat No",
                                                                           str2: "0", str1Color: Constants.whiteOpaque!,
                                                                           str2Color: UIColor.white, str1Font: ProjectFont.medium(14.0).customFont,
                                                                           str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        
    }
    
    @IBAction func classBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func checkoutBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        let totalPrice = Int(flightInfo?.quotes?.first?.minPrice ?? 0)
        vc.price = totalPrice * ((flightRequest?.adults ?? 0) + (flightRequest?.children ?? 0))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        
        print("Flight Detail Deinit called")
        
    }
}

extension FlightDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unselectedSeats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCell", for: indexPath)
        
        seatCell.layer.cornerRadius = 10.0
        seatCell.layer.borderWidth = 1.0
        seatCell.layer.borderColor = Constants.selectedSeat?.cgColor
        seatCell.tag = unselectedSeats[indexPath.row]
        
        if preselectedSeats.contains(unselectedSeats[indexPath.row]){
            seatCell.backgroundColor = Constants.selectedSeat
        }else if currentSeats.contain(unselectedSeats[indexPath.row]){
            seatCell.backgroundColor = Constants.secondaryColor
        }else{
            seatCell.backgroundColor = .clear
        }
        
        return seatCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if !preselectedSeats.contains(cell!.tag){
            if currentSeats.count() == flightRequest!.children + flightRequest!.adults{
                _ = currentSeats.dequeue()
            }
            currentSeats.enqueue(unselectedSeats[indexPath.row])
        }
        
        seats = currentSeats.getAllElements()
        seatSelectionCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
    
}
