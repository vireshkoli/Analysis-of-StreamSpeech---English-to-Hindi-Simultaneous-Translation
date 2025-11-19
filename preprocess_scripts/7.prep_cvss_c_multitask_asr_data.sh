lang=en
CVSS_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c
ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech


PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/prep_cvss_c_multitask_data.py \
    --data-dir $CVSS_ROOT/${lang}-hi/fbank2unit \
    --output-dir $CVSS_ROOT/${lang}-hi/src_unigram6000 \
    --lang $lang \
    --is-src-text \
    --vocab-type unigram --vocab-size 3077