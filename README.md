# On-the-Map
You can log in and pin your current location to a shared map by entering a location string that is reverse-geocoded to map coordinates. You can annotate your pin with a personal link or blurb. The shared map pulls the locations of other users stored in a Parse backend.

## Approach
The app follows the MVC pattern. The model contains networking code for the Parse API and Udacity API.

The app has 5 main view controllers:
1) Login View Controller
2) Map View Controller (embedded in a Tab View Controller)
3) List View Controller (embedded in a Tab View Controller)
4) Add Pin View Controller
5) Add Link View Controller

### Login View Controller
The login page checks the entered Udacity credentials against the record of credentials stored in the Parse server. If the credentials are valid, the user is authenticated. Otherwise, an error message is displayed, and the user has the option of registering an account.

### Map View Controller
The map view loads the last 100 pins added to the map by the app's users. Each pin has a callout that contains the full name of the user who added that pin, as well as the personal link or blurb the user included.

### List View Controller
The list view displays the pin data from the map view in table view form. When users tap on a row, they are taken to the link corresponding to that entry.

### Add Pin View Controller
In the pin-adding view, users enter a location string into a field. That location string is then reverse-geocoded to map coordinates. Invalid locations return an error message.

### Add Link View Controller
In the link-adding view, users can enter a personal link that will display on their pin's callout. This view also displays a truncated map view showing a pin on the location the user entered in the pin-adding view. When the user hits the submit button on this view to add the pin and link to the shared map, the app checks whether this user has previously added a pin (by checking whether objectID is nil). If so, then a PUT request is sent, updating their original pin. If not, then a POST request is sent, creating a brand new pin.

## Usage
On the Map is written in Swift 3. You can download it and run it in any version of Xcode and Simulator.

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request.
