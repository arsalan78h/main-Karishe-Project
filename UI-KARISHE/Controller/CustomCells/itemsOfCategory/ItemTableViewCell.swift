//Created by Real Life Swift on 02/12/2018

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            // Make it card-like
            containerView.layer.cornerRadius = 3.0
            containerView.layer.masksToBounds = false
            containerView.layer.shadowOpacity = 0.8
            containerView.layer.shadowRadius = 2
            containerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            containerView.backgroundColor = .white
            contentView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        }
    }
    
//    @IBOutlet weak var clippingView: UIView! {
//        didSet {
//            clippingView.layer.cornerRadius = 10
//            clippingView.backgroundColor = UIColor(named: "Red")
//            clippingView.layer.masksToBounds = true
//        }
//    }
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var skillsPostLabel: UILabel!
    @IBOutlet weak var totalBidsLabel: UILabel! 
    @IBOutlet weak var budgetBidLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
