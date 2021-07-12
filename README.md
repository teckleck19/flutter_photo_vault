# Photo Vault (using flutter)
---
Note: Coded as Android Application in mind.
### To Run:
#### Using Android Studio and  its Virtual (Emulated) Device
1. Download as zip
2. Unzip
3. Open project in Android Studio
4. Start Virtual Device in Android Virtual Device Manager
5. Run main.dart once the Virtual Device is linked up.
#### Using flutter (assuming you installed flutter)
1. Download as zip
2. Unzip
3. Open your command prompt/shell
4. Change directory to YOURPATH/appsverse_photon_app/
5. Run "flutter run"
---
### How To Use App:
1. Once you are in the app, Login with password "123456ABCDEF" (this is hardcoded)
2. After logging in, use the floating button at the bottom left to add new albums with new passwords.
3. Click on albums, enter the correct password to get into album gallery
4. Once you are in the gallery, use the floating button at the bottom left to add new photos.
5. Click on photo to enlarge photo.
---
### Limitation of this implementation of the App:
1. It does not really lock your photos, you can still access it using your phone's file manager.
2. This app copies what is in your gallery and does not delete even after choosing from gallery.

### Future work
1. Learn how to truly lock the photos in albums, so that users cannot access from other file managers.
2. User create their own password for login.
3. Cleaning textfield after changing screens (Because pressing the backbutton will actually show the filled textfield)
3. Better UI design using ThemeData instead of creating styles for each widget.
4. Extract widgets that are too long.
5. Use Hero instead of Navigating to new screens for enlarging images.

