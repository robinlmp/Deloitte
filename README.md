# Deloitte
ClothesStore

- [x] 1. Alomafire
    - [x] Replace with native code
- [x] 2. SFSymbols
    - [x] Image placeholder could be replaced with a custom SVG based on customised SFSymbols.
NOTE: I added them manually initially because of targeting iOS12 so they are added via the assets
- [ ] 3. Enum for type safety 
    - [x] Basic implementation for VC initialisation
    - [x] Started this process but needs more thought. Currently done for placeholder image
NOTE: Aware this is a basic implementation and could be taken much further
- [x] 4. Add products to Wishlist and Basket
    - [x] Add Wishlist 
    - [x] Add them whilst app is running
    - [x] Update quantity in basket as multiples are added
    - [x] Move items from wish list to basket
    - [x] Update stock availability
    - [ ] Update stock availability live
    - [x] Add basket total price 
- [x] 5. Convert UIKit Collection view to SwiftUI
    - [x] Need to look into doing SwiftUI within UIKit app
- [ ] 6. Use Combine to make TabBar reactive
    - [ ] Need to do some serious learning about Combine and understand app better to connect badges to data
NOTE: Failed to get Combine working. I’ve not used with UIKit / manually set up combine before and couldn’t get it working. 
    - [x] Add badges to tab bar icons
- [x] 7. Generally improve UI of app (fine issues to fix). Problems identified:
    - [x] Highlighting on tap of WishList button in product details highlights white which doesn’t display because it has a white background
    - [x] Various alignment issues and button actions missing
    - [x] Adjustment of ’total’ alignment
NOTE: Animation problem when rapidly adding items to basket in quick succession
NOTE: Just realised I’ve not tested in dark mode.
NOTE: Left the old 
