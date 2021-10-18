//
//  TableViewCell.swift
//  multipleFileDownload
//
//  Created by ADMS on 04/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var img:UIImageView!

    @IBOutlet weak var btnCancel:UIButton!

    @IBOutlet weak var btnDownload:UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
