ShopNow Fancy
====================

This project contains a custom scrollable collection view, which basically mimics (in a very simple way) the behavior of the iOS `UITableView`. It reuses its `cells` and keeps only a bare minimum of such `cells` instantiated.

`Cells` are custom `UIView` subclasses that contain either a `MKMapView` or `UIImageView` on the left side and two labels on the right side. The two different types can be specified via the `SNFTableViewCell` `cellType` property.

All Objective-C files use the `SNF` prefix.

### Project Setup

Clone the project:

	$ git clone https://github.com/leviathan/Shopnow-Fancy.git
	$ cd Shopnow Fancy
	$ gem install cocoapods
	$ pod setup
	$ pod install

Build and run the `Shopnow Fancy.xcworkspace` project using XCode (or any IDE of your choice).

#### Cocoapods

http://www.raywenderlich.com/12139/introduction-to-cocoapods

#### Ruby Version Manager (RVM)

Using a custom RVM set in order to keep the required ruby gems (I'm looking at you cocoapods) separated from anything else, which is installed on the developer machine.

You will need ruby 1.9.3-p327 installed.

#### Project Structure

Project files are structured according to the following layout.

<pre>
/ProjectName
    /Shared
        /Application      # App delegate and related files
        /Controllers      # Base view controllers
        /Models           # Models, Core Data schema etc
        /Views            # Shared views
        /Library          # Anything that falls outside of the MVC pattern
        /Support          # Categories and helpers
    /iPhone
        …                 # Same structure as 'Shared' but with interface specific classes
    /iPad
        …
    /Other sources        # Prefix headers, main.m
    /Supporting files     # Info.plist
/Resources                # Images, videos, .strings files
/Vendor                   # 3rd party dependencies not managed by CocoaPods
</pre>

***

### External Dependencies

External dependencies are managed via cocoapods. Check the Podfile to see, which external components and libraries are beeing used in the project.

### todos

- The project contains a Twitter API client, which is intended to be hooked up to the user's Twitter account. Currently the `SNFTwitterApiClient` just returns some dummy tweets. The tweet data should be parsed properly in the API client.
- The `SNFViewController` just displays a dummy view controller, when the user taps on a cell. This should be visually more pleasing.
- The `SNFTableViewCell` `mapView` or  `imageView` are currently empty. Once the Twitter API client returns some actual tweets, then the `mapView` could show the map location of the tweet and the `imageView` could show the tweets attached image (if any).









