lang=en
CVSS_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c
ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech

PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/convert_s2st_tsv_to_s2tt_tsv.py \
    --s2st-tsv-dir $CVSS_ROOT/${lang}-hi/fbank2unit \
    --s2tt-tsv-dir $CVSS_ROOT/${lang}-hi/fbank2text 

cp $CVSS_ROOT/${lang}-hi/tgt_unigram6000/spm* $CVSS_ROOT/${lang}-hi/fbank2text 