Space_Rock_Slider_Puzzle


This project is a simple iOS implementation of the slider puzzle otherwise known as Mystic Squares, the 15-puzzle, Gem Puzzle, Boss Puzzle, Game of Fifteen and apparently many others(1). 

I am interested in the mathematics of this game as well as the challenge building it on in iOS represents. Finding an optimal solution to this puzzle is NP hard and building this app gives me the opportunity to experiment with algorithm puzzles like this one. 

I am using a very simple opengl es game architecture as a convenience because the quickest way to get maximum performance and device range is to use opengl es 1.1. I chose this course, because virtually all iDevices running iOS 2.0 or greater should be able to run this app. I also wanted to get maximum performance so decided not to use Cocoa2d and, didn't need any of the functionality of the programable pipeline available in opengl 2.x.

The meat of this project is in the Tile object where I work out all the collision logic and UI elements, but I am also pleased with the the sprite rendering and ordering methods and my scene controller which took a while to fine tune, but is now working very smoothly (knock on wood). 

If you have any comments or suggestions, please feel free to contact me at contact.us@norobostudios.com.

Thanks!

1. http://en.wikipedia.org/wiki/Fifteen_puzzle