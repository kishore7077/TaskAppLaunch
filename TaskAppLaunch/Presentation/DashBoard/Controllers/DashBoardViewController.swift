//
//  DashBoardViewController.swift
//  TaskAppLaunch
//
//  Created by Kishore on 20/01/23.
//

import UIKit

class DashBoardViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Constants and Variables
    let sectionsTypes : [DashBoardTableSections] = [.companyName, .launchesList]
    var launchesDetailsListArray = [LaunchesDetails]()
    var sortedData = [LaunchesDetails]()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerCell()
        self.callGetLaunchesDetails()
    }
    
    //MARK: - Additional functions
    func registerCell() {
        self.tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tableView.register(UINib(nibName: "LauncheDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "LauncheDetailsTableViewCell")
    }
    
    func setupUI() {
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 }
    }
    
    fileprivate func callGetLaunchesDetails(){

        ApiHandler.getData(url: AppUrls.getAllLaunches, parameters: nil, method: .get, headers: nil, view: self) { (data, error) in
           self.hideActivityIndicator()

            if let data = data{
                print(data)
                do{
                    if let launchesData = try? JSONDecoder().decode([LaunchesDetails].self, from: data){
                        self.launchesDetailsListArray = launchesData
                        self.sortedData = launchesData
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }else{
                print("Error")
                toastMessage(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func showLaunchDetailsScreen(wikipediaLink: String) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchDetailsViewController") as? LaunchDetailsViewController {
            vc.url = wikipediaLink
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    //MARK: - IBActions

    @IBAction func filterBtnAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Filter's", message: "", preferredStyle: .alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Sort by year", style: UIAlertAction.Style.default, handler: { action in
            
            self.sortedData = self.launchesDetailsListArray.sorted(by: { $0.year ?? 0 > $1.year ?? 0 })

            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Sort by name", style: .default, handler: { action in
            self.sortedData = self.launchesDetailsListArray.sorted(by: { $0.name ?? "" < $1.name ?? ""})
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel applied filtere's", style: .default, handler: { action in
            self.sortedData = self.launchesDetailsListArray
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    

}

//MARK: - UITableViewDelegate and UITableViewDataSource {

extension DashBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = self.sectionsTypes[section]
        
        switch sectionType {
        case .companyName:
            return 1
        case .launchesList:
            return self.sortedData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.sectionsTypes[indexPath.section]
        
        switch cellType {
        case .companyName:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell {
                cell.titleLbl.textColor = .black
                cell.bgView.backgroundColor = .white
                cell.titleLbl.font = UIFont.systemFont(ofSize: 13)
                cell.titleLbl.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

              return cell
            }
        case .launchesList:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "LauncheDetailsTableViewCell", for: indexPath) as? LauncheDetailsTableViewCell {
                
                cell.setUpData(with: self.sortedData[indexPath.row])
                
              return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = self.sectionsTypes[indexPath.section]
        //LaunchDetailsViewController
        switch sectionType {
        case .companyName:
            print("")
        case .launchesList:
            self.showLaunchDetailsScreen(wikipediaLink: self.sortedData[indexPath.row].links?.wikipedia ?? "https://www.google.com")
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as? TitleTableViewCell {
            headerView.titleLbl.text = self.sectionsTypes[section].rawValue
            return headerView
        }
        return UIView()
    }
}

//MARK: - DashBoardTableSections types

enum DashBoardTableSections: String {
    case companyName = "COMPANY"
    case launchesList = "LAUNCHES"
}
