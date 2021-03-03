//
//  SearchPlacesTableViewController.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 07/02/21.
//

import UIKit

protocol SelectedOption:class {
    func selectedOption(place:searchPlaces?,index:Int,senderView:String)
}


class SearchPlacesViewController: UITableViewController {
    
    let spinner = UIActivityIndicatorView(style: .medium)
    
    var searchResult : [searchPlaces]?{
        didSet{
            self.tableView.reloadData()
        }
    }
    let bookingViewModel = BookingViewModel()
    var searchDelegate : SelectedOption?
    var senderView = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePush()
    }
    
    func configurePush(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Places"
        navigationItem.searchController = search
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResult?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPlaceCell", for: indexPath)
        cell.textLabel?.text = searchResult?[indexPath.row].placeName
        cell.detailTextLabel?.text = searchResult?[indexPath.row].placeId
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        searchDelegate?.selectedOption(place: searchResult?[indexPath.row], index: indexPath.row, senderView: senderView)
    }
    
    deinit {
        print("SearchPlacesViewController Deinit called")
    }
}

extension SearchPlacesViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count % 2 == 0 && text.count > 0{
            tableView.showActivityIndicator()
            bookingViewModel.searchPlace(place: text) { [weak self](places, error) in
                if let err = error{
                    print(err)
//                    self?.searchResult?.removeAll()
                }else{
                    if let pla = places{
                        self?.tableView.hideActivityIndicator()
                        self?.searchResult = pla
                    }
                }
            }
        }else{
            if text.count == 0{
                self.searchResult?.removeAll()
            }
        }
    }
}
