import UIKit

class PeopleViewController: UITableViewController {
}

extension PeopleViewController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PeopleCell") as! PeopleCell
        switch indexPath.row {
        case 0:
            cell.displayNameLabel.text = "Kevin Conboy"
            cell.usernameLabel.text = "@alternatekev"
        case 1:
            cell.displayNameLabel.text = "Mel Choyce"
            cell.usernameLabel.text = "@melchoyce"
        case 2:
            cell.displayNameLabel.text = "Kelly Dwan"
            cell.usernameLabel.text = "@ryelle"
        default:
            break
        }
        return cell
    }
}