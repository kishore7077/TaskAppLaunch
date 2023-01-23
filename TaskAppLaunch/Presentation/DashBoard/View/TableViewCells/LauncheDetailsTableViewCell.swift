//
//  LauncheDetailsTableViewCell.swift
//  TaskAppLaunch
//
//  Created by Kishore on 20/01/23.
//

import UIKit
import SDWebImage

class LauncheDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var missionNameLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var rockedNameLbl: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var nowLbl: UILabel!
    @IBOutlet weak var patchImg: CustomImageView!
    @IBOutlet weak var launchSuccessStatusImg: CustomImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(with data: LaunchesDetails?) {
        self.missionNameLbl.text = data?.name
        self.dateTimeLbl.text = "\(dateToString(date: data?.date_local ?? ""))"
        self.rockedNameLbl.text = data?.rocket
        self.daysLbl.text = "NA"
        self.nowLbl.text = "NA"
        if let url = URL(string: data?.links?.patch?.large ?? "") {
            self.patchImg.loadImage(with: url)
        }
        self.launchSuccessStatusImg.image = (data?.success ?? false) ? UIImage(named: "check") : UIImage(named: "crossed")
    }
    
}



