lang=en
CVSS_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c
ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech


PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/convert_s2st_tsv_to_s2tt_mtl_tsv.py \
    --s2st-tsv-dir $CVSS_ROOT/${lang}-hi/fbank2unit \
    --s2tt-mtl-tsv-dir $CVSS_ROOT/${lang}-hi/fbank2text_mtl \
    --src-lang $lang \
    --tgt-lang hi \
    --vocab-size 6519
