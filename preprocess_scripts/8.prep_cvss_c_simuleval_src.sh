lang=en
CVSS_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c
ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech


for split in train dev test
do
    PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/extract_simuleval_src.py \
        --input-tsv $CVSS_ROOT/${lang}-hi/fbank2unit/$split.tsv \
        --wav-list $CVSS_ROOT/${lang}-hi/simuleval/$split/wav_list.txt \
        --output-src $CVSS_ROOT/${lang}-hi/simuleval/$split/src.txt
done
