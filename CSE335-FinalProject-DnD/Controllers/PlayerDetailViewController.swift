//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var classPickerView: UIPickerView!
    @IBOutlet weak var initiativeTextField: UITextField!
    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var acTextField: UITextField!
    @IBOutlet weak var ppTextField: UITextField!
    @IBOutlet weak var bliButton: UIButton!
    @IBOutlet weak var chaButton: UIButton!
    @IBOutlet weak var deafButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var grapButton: UIButton!
    @IBOutlet weak var invButton: UIButton!
    
    // MARK: Variables
    
    var imagePicker = UIImagePickerController()
    var player : Player!
    let classes : [String] = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.classPickerView.delegate = self
        self.classPickerView.dataSource = self

        self.navigationItem.title = player.name!
        
        self.nameTextField.text = player.name!
        self.initiativeTextField.text = String(player.initiative!)
        self.hpTextField.text = String(player.maxHP!)
        self.acTextField.text = String(player.ac!)
        self.ppTextField.text = String(player.pp!)
        
        self.nameTextField.delegate = self
        self.initiativeTextField.delegate = self
        self.hpTextField.delegate = self
        self.acTextField.delegate = self
        self.ppTextField.delegate = self
        self.imagePicker.delegate = self
        
        self.classPickerView.selectRow(classes.firstIndex(of: player.className!)!, inComponent: 0, animated: false)
        
        if (player.conditions?.firstIndex(of: "Blinded") != nil) { bliButton.isSelected = true }
        if (player.conditions?.firstIndex(of: "Charmed") != nil) { chaButton.isSelected = true }
        if (player.conditions?.firstIndex(of: "Deafened") != nil) { deafButton.isSelected = true }
        if (player.conditions?.firstIndex(of: "Frightened") != nil) { friButton.isSelected = true }
        if (player.conditions?.firstIndex(of: "Grappled") != nil) { grapButton.isSelected = true }
        if (player.conditions?.firstIndex(of: "Invisible") != nil) { invButton.isSelected = true }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.conditions = []
        if(bliButton.isSelected){ player.conditions?.append("Blinded") }
        if(chaButton.isSelected){ player.conditions?.append("Charmed") }
        if(deafButton.isSelected){ player.conditions?.append("Deafened") }
        if(friButton.isSelected){ player.conditions?.append("Frightened") }
        if(grapButton.isSelected){ player.conditions?.append("Grappled") }
        if(invButton.isSelected){ player.conditions?.append("Invisible") }
    }
    
    // MARK: IBActions
    
    @IBAction func blindedTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func charmedTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func deafTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func frightTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func grappledTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func invisibleTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Select Image From:", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classes[row]
    }
    
    // MARK: UIPickerViewDelegate Methods
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        player.className = classes[pickerView.selectedRow(inComponent: 0)]
    }
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch(textField) {
        case self.nameTextField:
            player.name! = self.nameTextField.text!
            break
        case self.initiativeTextField:
            player.initiative! = Int(self.initiativeTextField.text!)!
            break
        case self.hpTextField:
            player.maxHP! = Int(self.hpTextField.text!)!
            break
        case self.acTextField:
            player.ac! = Int(self.acTextField.text!)!
            break
        case self.ppTextField:
            player.pp! = Int(self.ppTextField.text!)!
            break
        default:
            print("ERROR: Invalid text field")
            break
        }
    }
    
    // MARK: Private Methods
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openLibrary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        player.image = image.pngData()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
