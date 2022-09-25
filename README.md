# Sample Decentralized Library Project

I have recently started on my journey to learn blockchain development. I am also a avid reader and that led me to think... what if there was a Decentralized Library.. that would be pretty cool. This is my effort to design one and learn on the go. I will keep improving it as I learn more.
For now I have added the bare bones functionality of addition, deletion and borrowing books. While I was doing some reasearch for the same I stumbled upon a educative tutorial on how to make a decentralized library using tron https://github.com/TRON-Developer-Hub/decentralized-library.git - a shoutout from me to they/them. It helped me lay down the core design because this is my first actual blockchain project from scratch. I am facing some coer design issues/questions at this moment in time which are not technical in nature but more related to the core design of the product i.e a decentralized library. While I mull over these questions I will add some features which I have in mind like-:

-> Update price of existing book.

-> Add commission to contract owner/owner can also change or set the commision but only owner.

-> Search for books owned by a certain owner [these will not be stored in storage as a mapping, I believe doing a for loop to find books owned by a owner is more gas efficient]

-> Add ipfs hash for actual book storage. I have checked storage with txt files, only reason I havent added this yet is because I am researching more ways to determine which way is most gas efficient.

-> Improve the days tracking logic. It uses uint256 and blockchain time atm. To make it more user-friendly it should use time in days while calling I believe.

-> This is way down the line but we can have a hot/popular metric to keep tabs on whoever is the most popular loaner of books and which book is extremely popular

The following are the core product design issues I am facing. I will update these after I sort out my thoughts and think about them a little more.

-> Pending update.

(Reminder to self - add comments to the project)
This is unfinished. I paused this to gain more knowledge of Solidity and off-chain storage techniques and optimization. Will return and complete this after more experience.
