
# -------------------------------------------------------
# vars
# -------------------------------------------------------
FILENAME_2D='hrnet_w32_mpii_256x256'
DIR_PTH='pth_files'
DIR_CNFG='config_files'
DIR_TLS='extra_files'
DIR_NNX='onnx_files'
SHAPE2D='1 3 256 256'
VERSION=11
DIR_blobs="blob_files"
DATASET_S='mpii'
# -------------------------------------------------------

# -------------------------------------------------------
# downloading pytorch pretrained pose model from mmpose zoo (hhrnet)
#
# (https://github.com/open-mmlab/mmdetection/blob/master/demo/MMDet_Tutorial.ipynb)
# (https://mmpose.readthedocs.io/en/latest/papers/backbones.html#hrnet-cvpr-2019)
# -------------------------------------------------------

if [ ! -d $DIR_PTH ]; then   
    mkdir $DIR_PTH
fi

if [ ! -f ./$DIR_PTH/$FILENAME_2D.pth ]; then   
	wget -c https://download.openmmlab.com/mmpose/top_down/hrnet/hrnet_w32_mpii_256x256-6c4f923f_20200812.pth -O $DIR_PTH/$FILENAME_2D.pth
fi

if [ ! -d $DIR_CNFG ]; then   
    mkdir $DIR_CNFG
fi

if [ ! -f ./$DIR_CNFG/$FILENAME_2D.py ]; then   
	wget -c https://raw.githubusercontent.com/open-mmlab/mmpose/master/configs/body/2d_kpt_sview_rgb_img/topdown_heatmap/mpii/hrnet_w32_mpii_256x256.py -O $DIR_CNFG/$FILENAME_2D.py
fi

if [ ! -f ./$DIR_CNFG/$DATASET_S.py ]; then   
    wget -c https://raw.githubusercontent.com/open-mmlab/mmpose/master/configs/_base_/datasets/mpii.py -O $DIR_CNFG/$DATASET_S.py
fi

python editpath.py $DIR_CNFG/$FILENAME_2D.py $DATASET_S

# -------------------------------------------------------

# -------------------------------------------------------
# converting pytorch to onnx 
# -------------------------------------------------------

if [ ! -d $DIR_NNX ]; then   
    mkdir $DIR_NNX
fi

if [ ! -d $DIR_TLS ]; then   
    mkdir $DIR_TLS
fi

if [ ! -f ./$DIR_TLS/pytorch2onnx.py ]; then   
    wget -c https://raw.githubusercontent.com/open-mmlab/mmpose/master/tools/deployment/pytorch2onnx.py -O $DIR_TLS/pytorch2onnx.py
fi

if [ ! -f ./$DIR_TLS/remove_initializer_from_input.py ]; then   
    wget -c https://raw.githubusercontent.com/microsoft/onnxruntime/master/tools/python/remove_initializer_from_input.py -O $DIR_TLS/remove_initializer_from_input.py
fi

if [ ! -f ./$DIR_NNX/$FILENAME_2D.onnx ]; then   
    python ./$DIR_TLS/pytorch2onnx.py $DIR_CNFG/$FILENAME_2D.py $DIR_PTH/$FILENAME_2D.pth --shape $SHAPE2D\
        --verify --show --output-file $DIR_NNX/$FILENAME_2D.onnx --opset-version ${VERSION}

    python ./$DIR_TLS/remove_initializer_from_input.py --input $DIR_NNX/$FILENAME_2D.onnx --output $DIR_NNX/$FILENAME_2D.onnx
fi

# -------------------------------------------------------

# -------------------------------------------------------
# converting onnx to blob
# -------------------------------------------------------
if [ ! -d $DIR_blobs ]; then   
    mkdir $DIR_blobs
fi

cd $DIR_blobs

#python ../blobconfiging.py -i ../$DIR_NNX/$FILENAME_2D.onnx -n 4 --cselector "anotheranotherother"
python ../blobconfiging.py -i ../$DIR_NNX/$FILENAME_2D.onnx -n 6 --cselector "anotheranotherother"
#python ../blobconfiging.py -i ../$DIR_NNX/$FILENAME_2D.onnx -n 8 --cselector "anotheranotherother"

# -------------------------------------------------------
