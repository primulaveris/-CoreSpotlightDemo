//
//  MeetupViewController.swift
//  MeetupDemo
//
//  Created by Marian OShea on 02/12/2015.
//  Copyright © 2015 Marian O'Shea. All rights reserved.
//

import UIKit

public final class MeetupViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    public var meetup: Meetup?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard let meetup = meetup, link = meetup.link else {return}

        let url = NSURL.init(string: link)
        let request = NSURLRequest.init(URL: url!)
        webView.loadRequest(request)
        
        if let activity = meetup.userActivity {
            activity.eligibleForSearch = true
            activity.contentAttributeSet?.relatedUniqueIdentifier = nil
            userActivity = activity
        }
    }
    
    override public func updateUserActivityState(activity: NSUserActivity){
        guard let meetup = meetup else {return}
        if let info = meetup.userActivityUserInfo {
            activity.addUserInfoEntriesFromDictionary(info)
        }
    }
}
