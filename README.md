# Gaze Vector Regression Testing

## Directory structure:

```
git pull https://github.com/korymath/gazevectorregression
```

Data files as *.mat files should be located in

``` 
/data
```

run_single_test provides a single experiment 

Need to set train and test data files

## Model building

Model is built in build_single_model.m

Can edit the way that the model is built by changing the mdl to other model builders from MATLAB.

modelBuildingIdeas.m has several ideas to try. I think that the best option will be a bagged regression, wishing there was a more automated trial set up in matlab.

One thing to do would be to output all the experiments to train and test directories so that we could rerun validations in Python autoML libraries, and faster c-modules to see if we could build up a solid single model.

## Notes on data from :

all calibrations are sweep, eyes, free

the column switches between sweep and task

RXX - XX patient number

Calib(C|P) - cups or pasta, when this changes, task changes, always three for each
assume new task mean adjustment

_B_ - ignore (both eye and movement)

NN - 01, 02, 03 in sequence trials -- 1 and 2 are before then a whole bunch of trials, then 3 is the after trials calibration

_combined_segments - eye data,

TODO: 

TESTING 1 on 2 and 1 on 3 compare
