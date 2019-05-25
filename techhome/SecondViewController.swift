//
//  SecondViewController.swift
//  techhome
//
//  Created by 马晨骁 on 2018/3/30.
//  Copyright © 2018年 macintech. All rights reserved.
//

import UIKit
import SwiftSocket

class SecondViewController: UIViewController {

    @IBOutlet weak var LitAutSetVal: UISwitch!
    @IBOutlet weak var TemSetNum: UITextField!
    @IBOutlet weak var WatSetNum: UITextField!
    @IBOutlet weak var LitSetNum: UISegmentedControl!
    @IBOutlet weak var GivSetNum: UITextField!
    @IBOutlet weak var WatSlider: UISlider!
    @IBOutlet weak var LitNow: UISegmentedControl!
    @IBOutlet weak var TemSetVal: UIStepper!
    @IBOutlet weak var GivSetVal: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        let client1=TCPClient(address: "172.93.45.197", port: 12345)
        switch client1.connect(timeout: 10){
        case .success:
            var oper1="2"
            client1.send(string: oper1)
            guard let data100 = client1.read(1024*1) else { return }
            oper1="11"
            client1.send(string: oper1)
            guard let data11 = client1.read(1024*1) else { return }
            var response = String(bytes: data11, encoding: .utf8)
            var index = response?.index((response?.startIndex)!, offsetBy:3)
            var result = response?.substring(to: index!)
            var num1:Float = 0.1
            num1=Float(result!)!/10.0
            TemSetNum.text=String(num1)+"摄氏度"
            TemSetVal.value=Double(num1)
        
            oper1="2"
            client1.send(string: oper1)
            guard let data101 = client1.read(1024*1) else { return }
            oper1="12"
            client1.send(string: oper1)
            guard let data12 = client1.read(1024*1) else { return }
            response = String(bytes: data12, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:3)
            result = response?.substring(to: index!)
            num1=Float(result!)!/10.0
            WatSetNum.text=String(num1)+"%"
            WatSlider.value=num1
        
            oper1="2"
            client1.send(string: oper1)
            guard let data102 = client1.read(1024*1) else { return }
            oper1="13"
            client1.send(string: oper1)
            guard let data13 = client1.read(1024*1) else { return }
            response = String(bytes: data13, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:1)
            result = response?.substring(to: index!)
            var num3:Int
            num3 = Int(result!)!-1
            LitNow.selectedSegmentIndex=num3
            
            oper1="2"
            client1.send(string: oper1)
            guard let data103 = client1.read(1024*1) else { return }
            oper1="14"
            client1.send(string: oper1)
            guard let data14 = client1.read(1024*1) else { return }
            response = String(bytes: data14, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:1)
            result = response?.substring(to: index!)
            num3=Int(result!)!
            if num3==3
            {
                LitAutSetVal.isOn=true
            }else{
                LitAutSetVal.isOn=false
            }
            
            
            client1.send(string:"6")
        case .failure(let error):
            break
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AdCut(_ sender: Any) {
        TemSetNum.text=String(format:"%.1f",TemSetVal.value)+"摄氏度"
    }
    @IBAction func WatCha(_ sender: Any) {
        WatSetNum.text=String(format:"%.1f",Float(Int(WatSlider.value*10))/10)+"%"
    }
    
    @IBAction func SavUpd(_ sender: Any) {
        let num11=String(format:"%03d",Int(TemSetVal.value * 10))
        let num12=String(format:"%03d",Int(WatSlider.value * 10))
        print(TemSetVal.value,WatSlider.value)
        let num13=String((LitNow.selectedSegmentIndex+1))
        print(num11+num12+num13)
        var num14:String
        if LitAutSetVal.isOn==true
        {
            num14="3"
        }else{
            num14="4"
        }
        let client2=TCPClient(address: "172.93.45.197", port: 12345)
        switch client2.connect(timeout: 10){
        case .success:
            var oper2="1"
            client2.send(string:oper2)
            guard let data200 = client2.read(1024*1) else { return }
            oper2="11"
            client2.send(string:oper2)
            guard let data201 = client2.read(1024*1) else { return }
            client2.send(string:num11)
            guard let data202 = client2.read(1024*1) else { return }
            
            oper2="1"
            client2.send(string:oper2)
            guard let data203 = client2.read(1024*1) else { return }
            oper2="12"
            client2.send(string:oper2)
            guard let data204 = client2.read(1024*1) else { return }
            client2.send(string:num12)
            guard let data205 = client2.read(1024*1) else { return }
            
            oper2="1"
            client2.send(string:oper2)
            guard let data206 = client2.read(1024*1) else { return }
            oper2="13"
            client2.send(string:oper2)
            guard let data207 = client2.read(1024*1) else { return }
            client2.send(string:num13)
            guard let data208 = client2.read(1024*1) else { return }
            
            oper2="1"
            client2.send(string:oper2)
            guard let data212 = client2.read(1024*1) else { return }
            oper2="14"
            client2.send(string:oper2)
            guard let data213 = client2.read(1024*1) else { return }
            client2.send(string:num14)
            guard let data214 = client2.read(1024*1) else { return }
            
            oper2="1"
            client2.send(string:oper2)
            guard let data209 = client2.read(1024*1) else { return }
            oper2="31"
            client2.send(string:oper2)
            guard let data210 = client2.read(1024*1) else { return }
            client2.send(string:"3")
            guard let data211 = client2.read(1024*1) else { return }
        
            client2.send(string:"6")
        case .failure(let error):
            break
        }
    }
    @IBAction func GivSetCha(_ sender: Any) {
        GivSetNum.text=String(Int(GivSetVal.value))+"块鱼食"
    }
    
    @IBAction func GivNumUpd(_ sender: Any) {
        let num21=String(format:"%03d",Int(GivSetVal.value))
        print(num21)
        let client3=TCPClient(address: "172.93.45.197", port: 12345)
        switch client3.connect(timeout: 10){
        case .success:
            var oper3="1"
            client3.send(string:oper3)
            guard let data300 = client3.read(1024*1) else { return }
            oper3="21"
            client3.send(string:oper3)
            guard let data302 = client3.read(1024*1) else { return }
            client3.send(string:num21)
            guard let data301 = client3.read(1024*1) else { return }
            client3.send(string:"6")
        case .failure(let error):
            break
        }
        }
}

