
Dependencies of Project
==================
Install repo
To install Repo:

Make sure you have a bin/ directory in your home directory and that it is included in your path:
~~~
mkdir ~/bin
PATH=~/bin:$PATH
~~~
Download the Repo tool and ensure that it is executable:
~~~
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
~~~
Get Bebop sdk source code
~~~
repo init -u https://github.com/Parrot-Developers/arsdk_manifests.git
repo sync
~~~

REQUIRED EXTERNAL TOOLS

These external tools are required to build the SDK:

* git
* build-essential (only for Linux)
* autoconf
* libtool
* libavahi-client-dev
* libavcodec-dev
* libavformat-dev
* libswscale-dev
* libncurses5-dev
* mplayer
~~~
sudo apt-get install PACKAGE_NAME
~~~
Build

~~~
./build.sh -p arsdk-native -t TASK OTHER_ARGS
~~~
Tasks available are:

* build-sdk (Build native sdk)
* build-sample (Build all native samples)
* build-sample-SAMPLE_NAME (Build unix sdk sample for SAMPLE_NAME)
Such as
~~~
./build.sh -p arsdk-native -t build-sdk -j
~~~
The output will be in <SDK>/out/Unix-base/staging/usr/

Add below to ~/.bashrc
~~~
source <SDK>/out/arsdk-native/staging/native-wrapper.sh. 
~~~
To compile The Project
==================
Replace the SDK_DIR in makefile with your own PATH of SDK 

On Linux and MacOS X platform :
~~~
make
~~~
==================
- BebopDroneDecodeStream : 
This is the main class. It will operate the connexion to the drone, the setup of the network and video part. 
It will also register for commands callback and send commands. If you need to add callbacks, add it in registerARCommandsCallbacks.

In this class, the callback for a new frame received will be called. When it does, it will take a free empty frame from a pool (to avoid an allocation each time a frame is received), put the received data in this free frame and add the free frame to a frame buffer.
An other thread will loop, and try to take a frame and pass it to the decoder. Once the frame has been decoded, it will write the decoded frame in a pipe file. MPlayer will read this pipe file and display the frames.

- DecoderManager
This is an util class that will perform h264 frame decoding thanks to ffmpeg.

- ihm 
This is an util class that will catch inputs from console and send these events to BebopDroneDecodeStream. It will also display some pieces of information about the drone, like its battery level and its flying state.


When you run this sample, be sure to be in the console to catch your keyboard event. As MPlayer will open a new window, you could have to click again in the console.
The ihm inputs are implemented on an azerty keyboard. Feel free to adapt it just by changing the key comparison in the function IHM_InputProcessing.
