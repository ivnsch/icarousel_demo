//
//  ViewController.swift
//  CoverFlowExample
//
//  Created by ischuetz on 26/06/2014.
//  Copyright (c) 2014 ivanschuetz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    @IBOutlet var carousel:iCarousel
    
    var carouselUrls:NSURL[]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let paths = [
            "http://ivanschuetz.com/img/new/hipo.jpg",
            "http://ivanschuetz.com/img/new/chimp.jpg",
            "http://ivanschuetz.com/img/new/rabbit.jpg",
            "http://ivanschuetz.com/img/new/coast.jpg",
            "http://ivanschuetz.com/img/new/sea.jpg", ]
        
        var pathsUrls:NSURL[] = []
        for path in paths {
            pathsUrls += NSURL.URLWithString(path)
        }
        
        self.carouselUrls = pathsUrls
        
        carousel.reloadData()
        
        carousel.type = iCarouselType.CoverFlow2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        return carouselUrls ? carouselUrls.count : 0

    }

    func buttonTapped(sender: UIButton!) {
        let index = carousel.indexOfItemViewOrSubview(sender)
        
        let alert = UIAlertController(title: nil, message: "You tapped: " + String(index), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, var reusingView view: UIView!) -> UIView! {
        if view == nil {
            view = ReflectionView(frame: CGRectMake(0, 0, 200, 200))
            
            let imageView:FXImageView = FXImageView(frame: CGRectMake(0, 0, 200, 200))
            imageView.backgroundColor = UIColor.lightGrayColor()
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.tag = 100

            var button:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(0, 0, 200, 200)

            button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

            view.addSubview(imageView)
            view.addSubview(button)
            view.userInteractionEnabled = true
        }
        
        let imageView:FXImageView = view.viewWithTag(100) as FXImageView
        
        //show placeholder
//        imageView.processedImage = UIImage(named: "placeholder.png")
        
        //set image with URL. FXImageView will then download and process the image
        imageView.setImageWithContentsOfURL(carouselUrls[index])

        return view
    }
}