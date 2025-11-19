lang=en
CVSS_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c
COVOST2_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/covost2
ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech
PRETRAIN_ROOT=$ROOT/pretrain_models

# PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/prep_cvss_c_multilingual_data.py \
#     --covost-data-root $COVOST2_ROOT/ --cvss-data-root $CVSS_ROOT/ \
#     --output-root $CVSS_ROOT/$lang-hi \
#     --src-lang $lang \
#     --target-type unit --unit-type km1000 --reduce-unit \
#     --vocoder-checkpoint $PRETRAIN_ROOT/unit-based_HiFi-GAN_vocoder/mHuBERT.layer11.km1000.en/g_00500000 --vocoder-cfg $PRETRAIN_ROOT/unit-based_HiFi-GAN_vocoder/mHuBERT.layer11.km1000.en/config.json


export OMP_NUM_THREADS=1 MKL_NUM_THREADS=1 OMP_THREAD_LIMIT=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export OMP_WAIT_POLICY=ACTIVE
export PYTHONWARNINGS=ignore

PYTHONPATH=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/fairseq \
python /Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/preprocess_scripts/prep_cvss_c_multilingual_data.py \
  --covost-data-root /Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/covost2 \
  --cvss-data-root /Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c \
  --output-root /Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c/en-hi \
  --src-lang en \
  --target-type unit --unit-type km1000 --reduce-unit \
  --vocoder-checkpoint /Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/pretrain_models/unit-based_HiFi-GAN_vocoder/mHuBERT.layer11.km1000.en/g_00500000 \
  --vocoder-cfg /Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/pretrain_models/unit-based_HiFi-GAN_vocoder/mHuBERT.layer11.km1000.en/config.json