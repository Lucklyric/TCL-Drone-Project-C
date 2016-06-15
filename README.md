To compile The project
==================
On Linux and MacOS X platform :
make


Dependencies of BebopDroneDecodeStream
==================
~
repo init -u https://github.com/Parrot-Developers/arsdk_manifests.git
~



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
