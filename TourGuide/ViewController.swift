//
//  ViewController.swift
//  TourGuide
//
//  Created by Marian O'Shea on 31/08/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import UIKit
import CoreLocation

public final class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    public var city: City?
    public var checkinDate = NSDate.init()
    public var lengthOfStay = 5

    private var meetupDataSource: MeetupDataSource?
    private var meetupItems :[Meetup]?

    let attractionCellId = "AttractionCell"
    let meetupCellId = "MeetupCell"

    override public func viewDidLoad() {
        super.viewDidLoad()
        meetupDataSource = MeetupDataSource()
        guard let city = city, meetupDataSource = meetupDataSource else {return}
        let location = city.location
        cityLabel.text = city.name

        meetupDataSource.infoForCoordinates((location?.coordinate)!, checkinDate: checkinDate, lengthOfStay: lengthOfStay) { (data, error) -> Void in
            if ((data != nil) && (error == nil)) {
                self.handleMeetupData(data as? [Meetup])
            } else {
                if (error != nil) {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    }

    private func handleMeetupData(data: [Meetup]?) {
        guard let data = data as [Meetup]! else {return}
        if  (data.count > 0) {
            meetupItems = data
            reloadData()
        }
    }

    private func reloadData() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let meetupItems = meetupItems else {return}

        let viewController = segue.destinationViewController as! MeetupViewController
        let indexPath = tableView.indexPathForSelectedRow
        let meetup = meetupItems[indexPath!.row]
        viewController.meetup = meetup
    }
}

extension ViewController: UITableViewDataSource {

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let meetupItems = meetupItems else {return 0}
        return meetupItems.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meetupCell = tableView.dequeueReusableCellWithIdentifier(meetupCellId, forIndexPath: indexPath) as! MeetupTableViewCell
        if let meetupItems = meetupItems {
            let meetup = meetupItems[indexPath.row]
            meetupCell.name.text = meetup.name
            meetupCell.date.text = meetup.dateString
            meetupCell.address.text = meetup.address
            meetupCell.meetupDescription.text = meetup.meetupDescription
        }
        return meetupCell
    }
}

