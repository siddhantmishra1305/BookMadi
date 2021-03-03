//
//  BookingDetailsViewController.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 19/02/21.
//

import UIKit

class BookingDetailsViewController: BaseViewController {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var flightListView: UITableView!
    @IBOutlet weak var secondaryView: UIView!
    
    @IBOutlet weak var flightCount: UILabel!
    @IBOutlet weak var sortByBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    var flightData : FlightQuote?
    var flightRequest : FlightQuoteRequest!
    var departAttribString : NSAttributedString?
    var returnAttribString : NSAttributedString?
    let bookingViewModel = BookingViewModel()
    
    var selectedIndex :Int?{
        didSet{
            self.calendarView.scrollToItem(at: IndexPath(item: selectedIndex!+2, section: 0), at: .right, animated: false)
        }
    }
    
    var dates : [Date]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCell")
        flightListView.register(UINib(nibName: "FlightDetail", bundle: nil), forCellReuseIdentifier: "FlightDetail")
        flightCount.text = "\(flightData?.quotes?.count ?? 0) flights available"
        dates = bookingViewModel.getAllDates(to: flightRequest.departDate.toDate(format: Constants.serverFormat)!)
        selectedIndex = flightRequest.departDate.toDate(format: Constants.serverFormat)!.days(from:Date())
        setupUIComponents()
    }
    
    
    func setupUIComponents(){
        secondaryView.layer.cornerRadius = 30.0
        sortByBtn.layer.cornerRadius = 10.0
        filterBtn.layer.cornerRadius = filterBtn.bounds.width / 2
    }
    
    deinit {
        print("BookingDetailsViewController Deinit called")
    }
    
}

extension BookingDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.cellData = dates[indexPath.item]
        
        if dates[indexPath.item].toString(format: Constants.serverFormat) == flightRequest.departDate{
            cell.selectedCell = true
        }else{
            cell.selectedCell = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flightRequest.departDate = dates[indexPath.item].toString(format: Constants.serverFormat)!
        self.view.activityStartAnimating(activityColor: Constants.primaryColor!, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.35))
        
        bookingViewModel.fetchFlightPrices(request: flightRequest) { [weak self](flightPrices, error) in
            self?.view.activityStopAnimating()
            if let err = error{
                print(err)
            }else{
                self?.flightData = flightPrices
                self?.calendarView.reloadData()
                self?.flightListView.reloadData()
            }
        }
        
        
    }
    
}

extension BookingDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flightData?.quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightDetail", for: indexPath) as! FlightDetail
        cell.bookingViewModel = bookingViewModel
        cell.flightInfo = flightData
        cell.quote = flightData?.quotes?[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FlightDetailViewController") as! FlightDetailViewController
        vc.quote = flightData?.quotes?[indexPath.section]
        vc.flightInfo = flightData
        vc.flightRequest = flightRequest
        vc.preselectedSeats = [1,6,10,45,23,60]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
