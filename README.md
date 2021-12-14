# Deloitte
ClothesStore

I've completed most of the tasks. There is one that I've largely failed to do which is to use Combine to make the badge icons reactive. My experience of UIKit apps is largely of much more simple things with one or maybe two VCs so much knowledge and skill about passing around data between several VCs is lacking although I'm sure I'd quickly pick it up.

There were a couple of things in these tasks that I've not done before and I've enjoyed learning as I've worked through the tasks.

I've included the checklist I made and was working through as I worked on it. Many of the points noted below are discussed in much greater length in the comments within the code.

Thanks for giving me the opportunity to have a go at this.

Robin


- [x] 1. Alomafire
    - [x] Replace with native code
- [x] 2. SFSymbols
    - [x] Image placeholder could be replaced with a custom SVG based on customised SFSymbols.
 
NOTE: I added them manually initially because of targeting iOS12 so they are added via the assets

- [x] 3. Enum for type safety 
    - [x] Basic implementation for VC initialisation. Started this process but could be much more sophisticated
 
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
    - [x] Add badges to tab bar icons
   
NOTE: Failed to get Combine working. I’ve not used with UIKit / manually set up combine before and couldn’t get it working. 

- [x] 7. Generally improve UI of app (several issues to fix). Problems identified:
    - [x] Highlighting on tap of WishList button in product details highlights white which doesn’t display because it has a white background
    - [x] Various alignment issues and button actions missing
    - [x] Adjustment of ’total’ alignment
 
General notes:
- Animation problem when rapidly adding items to basket in quick succession
- There are a few issues with dark mode, especially around the SwiftUI integration
- The add to basket button on the wishlist cell doesn't behave very well (no feedback on interaction)
