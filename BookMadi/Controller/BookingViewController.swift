//
//  ViewController.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 04/02/21.
//

import UIKit

class BookingViewController: BaseViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBackgroundImg: UIImageView!
    @IBOutlet weak var headerTitlelbl: UILabel!
    @IBOutlet weak var roundTripBtn: UIButton!
    @IBOutlet weak var oneWayBtn: UIButton!
    
    @IBOutlet weak var flightDetailView: UIView!
    
    @IBOutlet weak var sourceBtn: UIButton!
    @IBOutlet weak var destinationBtn: UIButton!
    
    @IBOutlet weak var returnDateImage: UIImageView!
    @IBOutlet weak var returnLBL: UILabel!
    
    @IBOutlet weak var departureTf: UITextField!
    
    @IBOutlet weak var returnTf: UITextField!
    
    @IBOutlet weak var numOfAdultsBtn: UIButton!
    @IBOutlet weak var numOfKidsBtn: UIButton!
    @IBOutlet weak var luggageWeightBtn: UIButton!
    
    @IBOutlet weak var flightClassCollectionView: UICollectionView!
    @IBOutlet weak var nonStopFlightSwitch: UISwitch!
    @IBOutlet weak var searchFlightsBtn: UIButton!
    var selectedMode = UIButton()
    
    var selectedButtonLayer : CAShapeLayer?
    
    let flightClass = [FlightClassType.Economy,FlightClassType.Business,FlightClassType.Elite]
    
    var flightRequest = FlightQuoteRequest()
    
    let bookingViewModel = BookingViewModel()
    
    var pickerArr = [String]()
    
    private lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.backgroundColor = .white
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(picker:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        for view in datePicker.subviews {
            view.setValue(UIColor.white, forKeyPath: "backgroundColor")
        }
        return datePicker
    }()
    
    private lazy var pickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        return picker
    }()
    
    private lazy var datePickerToolBar : UIToolbar = {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        
        toolBar.items = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDatePickerDone(sender:)))]
        
        toolBar.sizeToFit()
        return toolBar
    }()
    
    private lazy var pickerToolBar : UIToolbar = {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        
        toolBar.items = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDone(sender:)))]
        
        toolBar.sizeToFit()
        return toolBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightClassCollectionView.register(UINib(nibName: "FlightClassCell", bundle: nil), forCellWithReuseIdentifier: "FlightClassCell")
        
        numOfAdultsBtn.addObserver(self, forKeyPath: Constants.btnTitleKey, options: .new, context: nil)
        numOfKidsBtn.addObserver(self, forKeyPath: Constants.btnTitleKey, options: .new, context: nil)
        luggageWeightBtn.addObserver(self, forKeyPath: Constants.btnTitleKey, options: .new, context: nil)
        
        setupInitialComponent()
        
        selectedButtonLayer = roundTripBtn.addLine(length: 30, color: .white, width: 1.3)
        flightDetailView.layer.cornerRadius = 30.0
        searchFlightsBtn.layer.cornerRadius = 10.0
        selectedMode = roundTripBtn
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        flightClassCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
//        self.collectionView(flightClassCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        selectedMode.sendActions(for: .touchUpInside)
    }
    
    
    deinit {
        numOfAdultsBtn.removeObserver(self, forKeyPath: Constants.btnTitleKey)
        numOfKidsBtn.removeObserver(self, forKeyPath: Constants.btnTitleKey)
        luggageWeightBtn.removeObserver(self, forKeyPath: Constants.btnTitleKey)
        
        print("BookingViewController Deinit called")
        
    }
    
    func setupInitialComponent(){
        if let departDate = Date().add(component: .day, value: 0)?.toString(format: Constants.serverFormat){
            departureTf.text = Date().add(component: .day, value: 0)?.toString(format: Constants.uiFormat)
            flightRequest.departDate = departDate
        }
        
        if let returnDate = Date().add(component: .day, value: 1)?.toString(format: Constants.serverFormat){
            returnTf.text = Date().add(component: .day, value: 1)?.toString(format: Constants.uiFormat)
            flightRequest.returnDate = returnDate
        }
    }
    
    
    @IBAction func roundTripBtnAction(_ sender: Any) {
        selectedButtonLayer?.removeFromSuperlayer()
        selectedButtonLayer = roundTripBtn.addLine(length: 30.0, color: .white, width: 1.3)
        returnTf.isHidden = false
        returnLBL.isHidden = false
        returnDateImage.isHidden = false
        oneWayBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3), for: .normal)
        roundTripBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        selectedMode = roundTripBtn
    }
    
    @IBAction func oneWayBtnAction(_ sender: Any) {
        selectedButtonLayer?.removeFromSuperlayer()
        selectedButtonLayer = oneWayBtn.addLine(length: 30.0, color: .white, width: 1.3)
        returnTf.isHidden = true
        returnLBL.isHidden = true
        returnDateImage.isHidden = true
        roundTripBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3), for: .normal)
        oneWayBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        selectedMode = oneWayBtn
    }
    
    //MARK: Source/Destination Btn Actions
    @IBAction func sourceBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchPlacesViewController") as? SearchPlacesViewController
        vc?.senderView = "Source"
        vc?.searchDelegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func destinationBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchPlacesViewController") as? SearchPlacesViewController
        vc?.senderView = "Destination"
        vc?.searchDelegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //MARK: Passenger Details
    
    @IBAction func numOfAdultBtnAction(_ sender: Any) {
        pickerView.tag = 1
        pickerArr = Constants.numOfAdults
        addSubviews()
    }
    
    @IBAction func numOfKidsBtnAction(_ sender: Any) {
        pickerView.tag = 2
        pickerArr = Constants.numOfKids
        addSubviews()
        
    }
    
    @IBAction func luggageWeightAction(_ sender: Any) {
        pickerView.tag = 3
        pickerArr = Constants.numOfBags
        addSubviews()
    }
    
    @IBAction func searchFlightBtnAction(_ sender: Any) {
       
        self.view.activityStartAnimating(activityColor: Constants.primaryColor!, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.35))
        
        bookingViewModel.fetchFlightPrices(request: flightRequest) { [weak self](flightPrices, error) in
            self?.view.activityStopAnimating()
            if let err = error{
                print(err)
            }else{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BookingDetailsViewController") as? BookingDetailsViewController
                vc?.flightRequest = self?.flightRequest
                vc?.flightData = flightPrices
                vc?.departAttribString = self?.sourceBtn.attributedTitle(for: .normal)
                vc?.returnAttribString = self?.destinationBtn.attributedTitle(for: .normal)
                self?.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
    func addSubviews(){
        self.view.addSubview(self.pickerView)
        pickerView.reloadAllComponents()
        self.view.addSubview(self.pickerToolBar)
    }
    
}

//MARK: Flight Class
extension BookingViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flightClass.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightClassCell", for: indexPath) as! FlightClassCell
        cell.flightType = flightClass[indexPath.row].rawValue
        cell.addTint = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FlightClassCell
        flightRequest.ticketClass = flightClass[indexPath.row]
        cell?.addTint = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FlightClassCell
        cell?.addTint = true
    }
}

// MARK: Observer
extension BookingViewController{
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == Constants.btnTitleKey{
            if let btn = object as? UIButton{
                let color = bookingViewModel.getTitleColor(object: btn, keyPath: keyPath!)
                btn.tintColor = color
                btn.setTitleColor(color, for: .normal)
            }
        }
    }
}

extension BookingViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == departureTf || textField == returnTf{
            textField.inputView = self.datePicker
            textField.inputAccessoryView = self.datePickerToolBar
            self.datePicker.tag = textField.tag
        }
        
        if textField == departureTf{
            datePicker.minimumDate = Date()
        }
        
        if textField == returnTf{
            datePicker.minimumDate = departureTf.text?.toDate(format: "dd-MM-yyyy")
        }
        
    }
    
    @objc private func dateChanged(picker : UIDatePicker) {
        switch picker.tag {
        case 1:
            if let departDate = picker.date.toString(format: Constants.serverFormat){
                departureTf.text = picker.date.toString(format: Constants.uiFormat)
                flightRequest.departDate = departDate
            }
            break
            
        case 2:
            if let returnDate = picker.date.toString(format: Constants.serverFormat){
                returnTf.text = picker.date.toString(format: Constants.uiFormat)
                flightRequest.returnDate = returnDate
            }
            break
            
        default:
            print("Invalid tag")
        }
    }
    
    @objc private func onDatePickerDone(sender : UIBarButtonItem) {
        self.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @objc private func onDone(sender : UIBarButtonItem) {
        self.pickerView.removeFromSuperview()
        self.pickerToolBar.removeFromSuperview()
    }
    
}

extension BookingViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            numOfAdultsBtn.setTitle(pickerArr[row], for: UIControl.State.normal)
            flightRequest.adults = Int(pickerArr[row]) ?? 0
            break
        case 2:
            numOfKidsBtn.setTitle(pickerArr[row], for: UIControl.State.normal)
            flightRequest.children = Int(pickerArr[row]) ?? 0
            break
        case 3:
            luggageWeightBtn.setTitle(pickerArr[row], for: UIControl.State.normal)
            flightRequest.luggage = Int(pickerArr[row]) ?? 0
            break
            
        default:
            print("Invalid Tag")
        }
    }
}

extension BookingViewController:SelectedOption{
    
    func selectedOption(place: searchPlaces?, index: Int, senderView: String) {
        if let selectedPlace = place{
            if let attString = bookingViewModel.getAttributedString(spacing: 10.5, sender: senderView, placeName: selectedPlace.placeName ?? "", cityId: selectedPlace.cityId ?? ""){
                if senderView == "Source"{
                    setAttributedString(btn: sourceBtn, title: attString)
                    flightRequest.source = selectedPlace.cityId ?? ""
                }else{
                    setAttributedString(btn: destinationBtn, title: attString)
                    flightRequest.destination = selectedPlace.cityId ?? ""
                }
            }
        }
    }
    
    func setAttributedString(btn:UIButton,title:NSMutableAttributedString){
        btn.setAttributedTitle(title, for: .normal)
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byWordWrapping
    }
}
