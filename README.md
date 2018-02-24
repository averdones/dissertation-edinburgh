The files submitted can be used to reproduce all the results obtained in the project.
Additionally, a small DEMO was added where the user can plot any frame from three different video sequences.

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
The script with the small demo is the one called DEMO.m.
The instructions to run it can be foun inside the script.


---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
DOCUMENTATION

The project is divided into three parts:
- pre-processing
- detection
- tracking

The main script of the project is main.m. This script calls the rest of the scripts.

Inside the main.m script, two main scripts are called:
- main_create_pcl.m
- main_particle_filter.m

The first one handles the pre-processing stage and the detection part.
The second one handles the tracking part.


---------------------------------------------------------------------------------------------------------
main_create_pcl.m calls the following relevant scripts:
- personDetectionAllFrames: detects the person using color (blue gown and pink gloves) and depth (region growing algorithm)
- personDetectionAllFramesNoColorBack.m: detects the person using only depth (background subtraction method)

---------------------------------------------------------------------------------------------------------
main_particle_filter.m calls the following relevant scripts:
- particle_filter_rshoulder
- particle_filter_relbow
- particle_filter_lshoulder
- particle_filter_lelbow

These four scripts are the particle filters for each joint tracked. They could be joined as one in future improvements.

---------------------------------------------------------------------------------------------------------
The rest of the scripts are called by one or more fo the scripts described here.
