//
//  AcronymTableViewCell.swift
//  AcronymApp
//
//  Created by Ramundo, Juan Pablo on 12/09/2021.
//

import UIKit

class AcronymTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var sinceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with result: LF) {
        titleLabel.text = result.lf.capitalized
        frequencyLabel.text = "Frequency: \(result.freq)"
        sinceLabel.text = "Since: \(result.since)"
    }
    
}
