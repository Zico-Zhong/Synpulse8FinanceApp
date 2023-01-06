# Mobile Application - Financer - Flutter Project

## Abstract
In this project, we create a mobile application called Financer, which can be run on any popular platforms(Android & IOS), based on Flutter.
Financer is an application which simply enables users to search for financial instruments (i.e stocks), learn more information about the stocks, and add them to their portfolio.

## Functionalities
The user will be able to undertake the following actions in the mobile app:
  - Register and login users via:
    - Phone Number (Account / Username)
    - Password (One-Time-Password)
  - Search for financial instruments
  - View information on the financial instrument
    - Real-time price of the financial instrument
    - Historical price data of the financial instrument
    - News related to the financial instrument
  - Share the financial instrument with external parties.
  - Follow the financial instrument in the process adding it to their watch list (portfolio)
  - Manage their watch list by adding(as the previous one) or removing financial instruments
  - Have an overview of the losses and gains in the dashboard

## Expected Improvements or something not accomplished
Due to the limitation of time, as well as various personal reasons including health condition, network firewall of my current location etc, some of the functionalities are not accomplished yet, check the list containing all the items don't work as expectation as follow:

  - Firebase Application
  As I suppose, the problem should only happen within Chinese Mainland, due to the interception from the network firewall governed by the China Government. Have tried to follow the instructions of Firebase console step by step to configure the application, keeping the VPN on, tried to run the service on emulator as well as real mobile device which are with Google Play service enabled, but still got a Network Error (Connection Time Out). As a result of that, 
    - Register & Login only done in User interface
    - Follow only done in user interface
    - Portfolio management only done in user interface

  - Amount of accessible financial instruments within the application
  Only 5 financial instruments are available in this application for demostration, there is not an API which enables the users to fetch a list with a bunch of financial instruments.

  - Historical price data showing
  The graph shows the historical data is completely in hard-code, which means that it is not the true price statistics of such financial instrument, instead, only the hand-written graph placed there. The reason why I implement this feature like that is hard to say, firstly, the API documentation is hard to understand since it's a little bit much professional for people who are not familar with finance, furthermore, the data should be fetched and saved to the database, then retrieve them when needed, however, Firebase is not working now, but at very least, the user interface is done with a hand-written graph in the corresponding page.
  
## Instruction to run the application
- Run on your own machines:
  - Code editor - Android Studio or Visual Studio Code has been already installed on your laptop
  - Flutter installed and configured
  - Connect your mobile device with your laptop
  - Enable the Debug Mode on your mobile device
  - Run the main.dart via the code editor on your machine
- Run on a emulator:
  - Code editor - Android Studio or Visual Studio Code has been already installed on your laptop
  - Flutter installed and configured
  - Virtual machine installed, for instance, at least one Android Virtual Device should be availble through the Emulator
  - Run the virtual machine
  - Run the main.dart via the code editor on your machine
  
## Application Tour Planning
- First of all, users are led to the landing page with two selections, Log In or Sign up, when they start the application.
- In the Login page, user is able to choose login with mobile, or with email and password directly, a sign up button is also available for people who want to register. After successful login, the user will land up the dashboard.
- In the Register page, user have to input their mobile, enter an valid OTP, then they would be led to a page with a form for the user to fill the email and password, the system will lead them to the welcome screen once the user enter all the required items correctly.
- Welcome screen shows the various financial instruments to the users in the main body. Users are also able to search for the items they want to learn in the search bar, then the financial instruments in the main body would be refreshed to the items matching the input of the user.
- Dashboard shows the Gainers & Losers, a shortcut of portfolio of the user, user can access the full list of their portfolio by either clicking on the See All button or click on the Portfolio's icon in the bottom navigation bar.
- Users can view the details of financial instrument by clicking the card(bar) of the items, via the item details page. Within that they can see the price, fluctuation data, historical data, as well as the news related to the selected instrument. User is also able to follow or unfollow the current financial instrument by either clicking the Follow(Followed) button at the middle of the screen, or the litte star icon on the top menu bar.
