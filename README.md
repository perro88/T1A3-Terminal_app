# Pre-start vehicle check

- Author: James Perrin
- [Github link](https://github.com/perro88/T1A3-Terminal_app)

## Plan

### A vehicle pre-start checklist application

Develop an application that will help the user complete a pre-start check on their vehicle and save the results for others to review.

- Login the user
- Show a list of current vehicles to select from
- Guide the user through a checklist to perform and save the results
- Enable managers/admin to add and remove vehicles from the list

### App limitations

Single user, multiple session application

## Statement of Purpose

From my experience in the mining industry I noticed a reliance on physical paper checklists. Only to be entered into a computer and then disposed of. What if we could dissolve this process and enter it directly. This is the problem I'm trying to solve with my app. My aim is to digitize this process so information does not have to be re-entered manually and we can save a few trees as well.
My application will allow the user to be able to create a account and sign in. Once signed in they can select their vehicle out of the fleet of vehicles available, complete a quick and effective pre-start check by following prompts and then save their report for future reference.
There will be an added function for managers to add and remove vehicles to the list as they come on and off site.
My application is targeted towards civil contractors and mining operators that are in need of a simplified device to keep records of vehicles on a daily basis. The application is intended to be used everyday before operation of the vehicle to ensure that the vehicle is in proper working condition.

## Feature list

- (MVP) Authenticate users
- (MVP) Select a vehicle
- (MVP) Create checklist for vehicle

- (EXTRA) Generate vehicle report

## User Interaction

1. user enters username email and password. If email exists in the csv file and the password is correct user is signed in. If email does not exist, user is prompted if they would like to create an account and signed in if selecting yes.
   If a user enters the wrong password a error msg will display and the user will be prompted for their password again.

2. User is presented with an already defined list of vehicles which they can fill out and create a check list record.
3. Admin can sign in and add vehicles to the vehicle pool. If a admin tries to enter more than 5 vehicles an error message will show and will not be able to add more vehicles. The same will apply for duplicate vehicles.

Feature: User can create an account and sign in.
Implementation:

- Prompt user if they would like to create an account or sign in
- If sign in ask for username and password
- Check username and password against existing user records
- Sign in if correct/ show error if not and ask for username and password again
- If creating an account ask for username and password
- If username is already existing show error and ask for username and password again
- If username does not exist, sign user in.

Feature: User can fill out a vehicle checklist
Implementation:

- Show user list of vehicles
- Allow user to select vehicle
- When vehicle is selected guide user through checklist
- When checklist complete show user a review of selections
- Prompt user to save, edit or discard the checklist

Feature: Admin sign and adds vehicles to selections
Implementation:

- When signing in show different menu if user is admin
- Show admin list of vehicles
- Prompt admin if they want to add a vehicle
- If yes ask for vehicle registration, make and model
- Show error if registration already exist on another vehicle/ prompt for registration again
- Allow admin to save or discard vehicle after show their input

## Implementation Plan

[Link to Trello](https://trello.com/b/BPyQOCkS/pre-start-checklist)

Trello was instrumental in developing the application.
It helped to brake my application down into its 3 main features and keep myself accountable to complete them within a time frame.  
My checklist:

### User can create an account and sign in.

A log in/ sign up feature that gives user permission to access the next feature

- Create username/password prompts
- Create place for existing user records
- Create a loop for errors to restart sign in process
- Create login to check against records
- Create "create account" to add to records
  Due 7th April

### User can fill out a vehicle checklist

Be able to select a vehicle from a list. perform a pre-start check and then save it.

- Create list of vehicles to present to the user
- Allow user to select vehicle
- After vehicle is selected direct user to the checklist
- Create checklist to be filled out
- Once checklist complete. show user a review of selections
- Prompt user to save, edit or discard checklist
- Create save file for checklist
- Exit user out
  Due 8th April

### Admin sign and adds vehicles to selections

Admin sign in that has a different menu that can add and remove vehicles to the list.

- Create different menu for admin signs in
- Show admin list of vehicles
- Create prompt to ask admin if they want to add vehicles
- Prompt for vehicle registration, make and model
- Create loop to re-input registration
- Save vehicle to list
- Quit out
  Due 9th April

## Control Flow Diagram

![App Diagram](/docs/pre-start-terminal-app.png)

![Data Structure Diagram](/docs/pre-start-app-data-stucts.png)

## HELP

Installation  
You get download the application from my Github repository.  
[Github link](https://github.com/perro88/T1A3-Terminal_app).  
After cloning the repository on to your local computer open up your terminal and change into the 'src' directory.

Running the application  
To run the application type `./start.sh` in your terminal.
If you are an existing user there is also an option to login straight away. After entering the start command follow it by entering `-u=` followed by their username and `-p=` for their password.  
eg. `./start.sh -u=username -p=password`

User Navigation  
The welcome menu list the following options:

- Login: Where a registered user can login.
- New_User: Where a new user can create a username and password
- Quit: Exit out of the application

The Vehicle menu gives the user a selection of vehicles to choose from. Please select a vehicle that the user wants to perform a pre-start check on.  
After selecting a vehicle the user will be directed through a list of prompts to be completed on the vehicle to ensure that it is in safe working condition.  
`Pass` means there is no damage or issues with that component.  
`fail` means there is outstanding damage or insufficient fluid  
If there are any fails it is recommended that the issue should be fixed immediately before proceeding to the next prompt.  
If the issue can not be fixed immediately it is highly recommended that the vehicle should not be operated until the issue is fixed.

On completion the results of the pre-start is saved for future reference. Access to results are limited to the admin functions.

Administration Navigation  
Admin users can access the Admin menu by entering an alternative
login.  
username = admin Password = zzz  
The Admin menu list the following options:

- Remove_Vehicle: Shows a list of active vehicles. Press the space bar to select vehicles to be removed and enter to confirm.
- Add_Vehicle: Enter the make and registration of the vehicle you wish to be saved to the list.
- Vehicle_log: Is the saved results of all Pre-starts that have been completed. It has records of the username, vehicle details and it pass/fail results.
- Quit: Exit out of the application.

Dependencies

This application requires the the use of a few gem dependencies.

- bundler
- tty-prompt
- colorize
- pastel
- tty-fonts

System/hardware requirements

Windows: 7 or newer  
MAC: OS X v10.7 or higher  
Linux: Ubuntu

Processor: Minimum 1 GHz; Recommended 2GHz or more  
Hard Drive: Minimum 32 GB; Recommended 64 GB or more  
Memory (RAM): Minimum 1 GB; Recommended 4 GB or above

## References

Craig Cox Evolution Mining LV Pre Start ChecklistThis generic vehicle inspection checklist aims to identify defects and mechanical issues of any vehicle. Most importantly, n., 2021. Evolution Mining LV Pre Start. [online] Public-library.safetyculture.io. Available at: <https://public-library.safetyculture.io/products/vehicle-inspection-checklist-WeOrc> [Accessed 11 April 2021].  
GitHub. 2021. fazibear/colorize. [online] Available at: <https://github.com/fazibear/colorize> [Accessed 11 April 2021].  
GitHub. 2021. piotrmurach/pastel. [online] Available at: <https://github.com/piotrmurach/pastel> [Accessed 11 April 2021].  
GitHub. 2021. piotrmurach/tty-font. [online] Available at: <https://github.com/piotrmurach/tty-font> [Accessed 11 April 2021].  
GitHub. 2021. piotrmurach/tty-prompt. [online] Available at: <https://github.com/piotrmurach/tty-prompt> [Accessed 11 April 2021].  
Ruby-doc.org. 2021. Ruby-Doc.org: Documenting the Ruby Language. [online] Available at: <https://ruby-doc.org/> [Accessed 11 April 2021].  
RubyGuides. 2021. How to Read & Parse CSV Files With Ruby. [online] Available at: <https://www.rubyguides.com/2018/10/parse-csv-ruby/> [Accessed 11 April 2021].
