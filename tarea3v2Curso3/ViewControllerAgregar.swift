//
//  ViewControllerAgregar.swift
//  tarea3v2Curso3
//
//  Created by Yolanda Martínez on 3/6/16.
//  Copyright © 2016 Yolanda Martínez. All rights reserved.
//

import UIKit

protocol ProtocoloAgregar
{
    func agregaLibro(titulo : String, isbn : String, autores : String, urlFotoPortada : String)
}

class ViewControllerAgregar: UIViewController {
    
    var delegado : ProtocoloAgregar!

    var titulo : String!
    var autores : String!
    var urlFotoPortada : String!
    
    func llamada(let isbn : String)
    {
        
        let urlStr = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
        let url = NSURL(string: urlStr)
        
        do
        {
            let datos = try NSData(contentsOfURL: url!, options: NSDataReadingOptions())
            if datos.length != 2   // si regresa {} quiero que salga el mensaje
            {
                let texto = NSString(data: datos, encoding: NSUTF8StringEncoding)
                print (texto)
                
                do
                {
                    let json = try NSJSONSerialization.JSONObjectWithData(datos, options: NSJSONReadingOptions.MutableLeaves)
                    
                    let dico1 = json as! NSDictionary
                    let dico2 = dico1["ISBN:" + isbn] as! NSDictionary
                    self.titulo = dico2["title"] as! NSString as String
                    
                    var autores = ""
                    if dico2["authors"] != nil
                    {
                        let arre1 = dico2["authors"] as! NSArray
                        for var autor in arre1
                        {
                            let dico3 = autor as! NSDictionary
                            autores += (dico3["name"] as! NSString as String) + "\n"
                        }
                    }
                    self.autores = autores
                    self.urlFotoPortada = ""
                    
                    if dico2["cover"] != nil
                    {
                        let dico4 = dico2["cover"] as! NSDictionary
                        
                        //let dico4 = arre2[0] as! NSDictionary
                        
                        let strurl = dico4["medium"] as! NSString as String
                        
                        self.urlFotoPortada = strurl
                    }
                 
                    delegado.agregaLibro(self.titulo, isbn: isbn, autores: self.autores, urlFotoPortada : self.urlFotoPortada)
                    
                }
                    
                catch _ {
                    
                }
                
            }
            else
            {
                let alerta = UIAlertController(title: "Error", message: "Ese libro no existe", preferredStyle: UIAlertControllerStyle.Alert)
                alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                presentViewController(alerta, animated: true, completion: nil)
            }
        }
        catch
        {
            print ("Error")
        }
    }
    
    @IBAction func oprimioBuscar(sender: UITextField) {
        llamada(sender.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
