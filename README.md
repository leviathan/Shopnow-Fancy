ShopNow Fancy
====================

This is the "ShopNow Fancy" iOS Test solution for the ShopNow GmbH. All Objective-C files use the 'SNF' prefix for ShopNow.

### Project Setup

Clone the project including submodules:

	$ git clone --recursive xxx
	$ cd Shopnow Fancy
	$ gem install cocoapods
	$ pod setup
	$ pod install

Build and run the 'Shopnow Fancy.xcworkspace' project using XCode (or any IDE of your choice).

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
        …               # Same structure as 'Shared' but with interface specific classes
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









