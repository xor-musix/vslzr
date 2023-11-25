# vslzr - Real-time music visualizer

## VSXu by vovoid

As of November 2023, the [vovoid's VSXu repository](https://github.com/vovoid/vsxu) lacks the *[cal3d](https://github.com/mp3butcher/Cal3D) git sub module* and because I am new to C++ and all this stuff, my limited knowledge and understanding, I was not able to compile it!

The Slackware distribution offers a [tarball of VSXu](https://slackbuilds.org/repository/15.0/graphics/vsxu/?search=vsxu) containing all the necessary modules to build VSXu.

Unfortunately this also did not compile first - hence I started digging deeper. 

## vslzr

This repository is my attempt to make VSXu compile & run under linux again. At the moment I do not take Windows or MacOS into account.

In the long run, I really would like to develop this fabulous software further to support my specific needs for audio visualization in real-time. To delimit from the VSXu product-line, which seems to be closed source now, I have chosen a different name for my experiments already.

The original *VSXu README.md* file is renamed to [vovoid.md](./vovoid.md).

## Compile & Run

The documentation of VSXu claims cmake support. Indeed there is some sort of cmake available, but again I was not able to make it work, due to my limited understanding of cmake and the C++ build process in general, I guess.

For now I want to compile and run the Artiste program only. First execute the following command

    $ cmake -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -S. -B./build -G Ninja 

 and then 

    $ cmake --build ./build --config Debug --target all --

and finally run VSXu Artiste

    $ ./build/programs/artiste/vsxu_artiste

Following -D flags are not working currently

	-DVSXU_DEBUG=1             // compile error
	-DENGINE_SCRIPTING=0       // "file not found" error
