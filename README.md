# LootLogger
This is the example app from the Chapter 9 and Chapter 13 of Big Nerd Ranch 7th edition textbook (2020) but with my notes
In an attempt to make the app simpler, I made the following changes from the textbook
- skipped @discardableResult (Listing 9.6)
- skipped reusing cells (Listing 9.12)
- skipped checking size of table (Listing 9.15)
- the firstIndex(of:) is no longer supported, so replaced with firstIndex(where:) when adding a new item (Listing 9.16) and when removing an item (Listing 9.19)
- skipped the Item equality method (Listing 9.17)
- just adding Codable (Listing 13.1) gave errors to add encode and decode, so I added from the More Curious section, without adding the category (skipped Listing 13.11), but added Listing 13.12-13.14 
