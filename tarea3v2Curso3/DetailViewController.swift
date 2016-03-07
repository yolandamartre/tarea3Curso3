//
//  DetailViewController.swift
//  tarea3v2Curso3
//
//  Created by Yolanda Martínez on 3/6/16.
//  Copyright © 2016 Yolanda Martínez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var foto: UIImageView!

    @IBOutlet weak var lbTitulo: UILabel!
    
    @IBOutlet weak var lbIsbn: UILabel!
    
    @IBOutlet weak var lbAutores: UILabel!
    
    var detailItem: NSDictionary!
    
    /*? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.configureView()
        
        if detailItem != nil
        {
            let surl = detailItem.valueForKey("urlFotoPortada") as! String?
            if surl != ""
            {
                let urlImg = NSURL(string: surl!)
                let imagenData = NSData(contentsOfURL: urlImg!)
                foto.image = UIImage(data: imagenData!)
            }
            
            lbTitulo.text = (detailItem.valueForKey("titulo") as! String)
            lbAutores.text = (detailItem.valueForKey("autores") as! String)
            lbIsbn.text = (detailItem.valueForKey("isbn") as! String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

