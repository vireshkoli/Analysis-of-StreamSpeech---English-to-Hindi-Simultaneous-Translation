export CUDA_VISIBLE_DEVICES=0

ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech
DATA_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c

LANG=en
file=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/checkpoints/streamspeech.simul-s2st.en-hi/checkpoint_last.pt
output_dir=$ROOT/res/streamspeech.simultaneous.${LANG}-hi/streaming-asr

chunk_size=960

PYTHONPATH=$ROOT/fairseq simuleval --data-bin ${DATA_ROOT}/${LANG}-hi/fbank2unit \
    --user-dir ${ROOT}/researches/ctc_unity \
    --source ${DATA_ROOT}/${LANG}-hi/simuleval/test/wav_list.txt --target ${DATA_ROOT}/${LANG}-hi/simuleval/test/src.txt \
    --model-path $file \
    --config-yaml config_gcmvn.yaml --multitask-config-yaml config_mtl_asr_st_ctcst.yaml \
    --agent $ROOT/agent/speech_to_text.asr.streamspeech.agent.py\
    --output $output_dir/chunk_size=$chunk_size \
    --source-segment-size $chunk_size \
    --quality-metrics BLEU --latency-metrics AL AP DAL StartOffset EndOffset LAAL ATD NumChunks RTF \
    --device cpu --computation-aware 