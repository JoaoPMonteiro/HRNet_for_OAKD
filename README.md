### HRNet for the [OAK-D](https://docs.luxonis.com/projects/hardware/en/latest/pages/BW1098OAK.html)

---
**intro**

assorted routines to fetch [MMPose](https://github.com/open-mmlab/mmpose)'s pretrained [HRnet](https://github.com/HRNet/HRNet-Human-Pose-Estimation) 2D pose estimations model and convert it to onnx and myriad X blob formats

---

---
**overview of the main steps to replicate procedure**

* create virtual enviroment

* install *requirements.txt* 

---
>
>  [notes on the steps to create the environment frozen on the requirements file]
>
> *info on mmpose*
> https://github.com/open-mmlab/mmpose/blob/master/docs/install.md
> 
> *info on mmdetection*
> https://github.com/open-mmlab/mmdetection/blob/master/docs/get_started.md
>
> *main dependencies*
>
>	pip install torch==1.8.0 torchvision==0.9.0 torchaudio==0.8.0
>
>	pip install mmcv-full -f https://download.openmmlab.com/mmcv/dist/cu102/torch1.8.0/index.html
>
>	pip install openmim
>
>	mim install mmdet
>
>	mim install mmpose
>
>	pip install onnx
>
>	pip install onnxruntime
>
>	pip install blobconverter
>
---

* check variables in the *do_stuff.sh* file and adapt accordingly 

* call *do_stuff.sh*

