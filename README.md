# vslzr - Real-time music visualizer

## VSXu by Vovoid

As of November 2023, the [vovoid's VSXu repository](https://github.com/vovoid/vsxu) lacks the *[cal3d](https://github.com/mp3butcher/Cal3D) git sub module* and because I am new to C++ and all this stuff, and my knowledge and understanding is limited, I was not able to compile it!

But the Slackware distribution offers a [tarball of VSXu](https://slackbuilds.org/repository/15.0/graphics/vsxu/?search=vsxu) containing all the necessary modules to build VSXu.

Unfortunately this also did not compile first - hence I started digging deeper. 

This repository is my attempt to make **VSXu compile & run under linux** again. At the moment I do not take Windows or MacOS into account, because I do not have any of those systems.

## vslzr

In the long run, I would like to further develop *this fabulous software* to support my specific needs for real-time audio visualization. To differentiate myself from the [VZX Creative](https://store.steampowered.com/app/1740670/VZX_Creative/) product line, which now seems to be closed source, I have already chosen a different name for my experiments.

Please find the original *VSXu README.md* file renamed to [vovoid.md](./vovoid.md) next to this README file.

## Compile & Run

The documentation of VSXu claims cmake support. Indeed there is some sort of cmake available, but again I was not able to get it working just by using cmake. Due to my limited understanding of cmake and the C++ build process in general, I thought `cmake --build` could also be used - how naive.

At the moment I am following the procedure of the [arch linux package vsxu 0.6.3-1](https://aur.archlinux.org/packages/vsxu) by [Llewelyn Trahaearn](https://github.com/WoefulDerelict) to **compile & run VSXu** under Linux:

1. Configure and build the make files:
   
       mkdir build
       cd build
       cmake .. -DCMAKE_INSTALL_PREFIX="~/bin/vsxu_0.6.3.0" -DOpenGL_GL_PREFERENCE=GLVND

 2. Then build and install the software from inside the `build` folder:

        make
        make install

3. Finally run e.g. *VSXu Artiste*

       LD_LIBRARY_PATH=~/bin/vsxu_0.6.3.0/lib ~/bin/vsxu_0.6.3.0/bin/vsxu_artiste

Unfortunately the following -D flags are not working currently:

	-DVSXU_DEBUG=1             // compile error
	-DENGINE_SCRIPTING=0       // "file not found" error

## Current tasks

- [x] generate build files with cmake
- [x] compile and install software with make
- [x] execute software on linux
- [x] all shared assets are found at runtime
- [ ] fix direction of up and down navigation