//
//  PreferenceDetailVC.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/25/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

class PreferenceDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PreferenceDetailVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    // MARK: collectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
        /*
        if indexPath.row == 0 {
            
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "AddressListVC") as! AddressListVC
            //  obj.crytoObj = objCrypt
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 1 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "PassportListVC") as! PassportListVC
            //  obj.crytoObj = objCrypt
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 2 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "LicenseListVC") as! LicenseListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 3 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "InsuranceListVC") as! InsuranceListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 4 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "MembershipListVC") as! MembershipListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 5 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "VisaListVC") as! VisaListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 6 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "DelegateListVC") as! DelegateListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 7 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "VacationListVC") as! VacationListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 8 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "EmergencyListVC") as! EmergencyListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else  if indexPath.row == 9 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "PreferenceListVC") as! PreferenceListVC
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        
        
        
        
        */
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (DataUtil.screenWidth-60)/4
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "ProfileCollecCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProfileCollecCell
        
        
        cell.ttlLabel.text = "dsadasd"
        
        return cell
        
    }
    
    
    
}
class PrefRadioCollecCell: UICollectionViewCell{
    @IBOutlet weak var ttlLabel:UILabel!
    @IBOutlet weak var btn:UIButton!
}
class PrefBoxCollecCell: UICollectionViewCell{
    @IBOutlet weak var ttlLabel:UILabel!
    @IBOutlet weak var btn:UIButton!
}
