//
//  DetailViewController.swift
//  Project1
//
//  Created by Berta Devant on 11/6/15.
//  Copyright © 2015 Berta Devant. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    //@IBOutlet weak var detailDescriptionLabel: UILabel! //IBOUtlet connects Interface Builder, weak because View owns it not in memory

    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String? { //no need to have object, we know is array of Strings
        didSet {
            // Update the view. If detailItem is change we configure the view
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem { //unwrapping and checking that detailItem has value
            if let imageView = self.detailImageView { //unwrapping and checking if imageview has value
                imageView.image = UIImage(named:detail) //UIImage is data type to load images, named passes name of image 
                                                        //by putting detail we pass the image selected by user and pass through detailItem
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "sharedTapped")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated) //super calls on parent method
        navigationController?.hidesBarsOnTap = true
        navigationItem.title = detailItem
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func sharedTapped()
    {
        let vc = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func socialFB ()
    {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc.setInitialText("Look at this great picture!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

