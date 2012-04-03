Space_Rock_Slider_Puzzle


This project is a simple iOS implementation of the slider puzzle otherwise known as Mystic Squares, the 15-puzzle, Gem Puzzle, Boss Puzzle, Game of Fifteen and apparently many others(1). 

I am building this project for a programming challenge suggested by a third party, but am interested in the mathematics of this game as well and it's relationship to the NP-hard problem in complexity theory. 

The base architecture of this project is a slightly modified template from Beginning iPhone Game Development, chapters 6-8, by Ben Britton Smith.  

I am using it as a convenience because the opengl es 1.1 currently supported by the largest number of iOS devices and I have no need for shaders at the moment. If I decide to someday make this puzzle 3D, I will consider porting it to 2.0 and the newer iOS connivence framework. 

The meat of this project is mostly in the messy Tile object where I work out all the collision logic and UI elements. 

If you have any comments for me please feel free to leave it and feel free to submit any enhancements you have made and wouldn't mind sharing. Happy Coding!

Thanks,
Michael

1. http://en.wikipedia.org/wiki/Fifteen_puzzle
2. Copyright (c) 2012 Norobo Studios

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.