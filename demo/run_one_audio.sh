export CUDA_VISIBLE_DEVICES=0

ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech
PRETRAIN_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/pretrain_models
VOCODER_CKPT=$PRETRAIN_ROOT/unit-based_HiFi-GAN_vocoder/mHuBERT.layer11.km1000.en/g_00500000 
VOCODER_CFG=$PRETRAIN_ROOT/unit-based_HiFi-GAN_vocoder/mHuBERT.layer11.km1000.en/config.json 

LANG=en
file=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech/checkpoints/streamspeech.simul-s2st.en-hi/checkpoint_last.pt
output_dir=$ROOT/res/streamspeech.simultaneous.${LANG}-hi/simul-s2st

chunk_size=320
PYTHONPATH=$ROOT/fairseq python $ROOT/demo/infer.py \
    --data-bin ${ROOT}/configs/en-hi \
    --user-dir ${ROOT}/researches/ctc_unity \
    --agent-dir ${ROOT}/agent \
    --model-path $file \
    --config-yaml config_gcmvn.yaml \
    --multitask-config-yaml config_mtl_asr_st_ctcst.yaml \
    --segment-size 320 \
    --extra-output-dir $output_dir/debug_infer \
    --vocoder $VOCODER_CKPT --vocoder-cfg $VOCODER_CFG --dur-prediction


chunk_size=320
PYTHONPATH=$ROOT/fairseq simuleval \
  --data-bin ${ROOT}/configs/${LANG}-hi \
  --user-dir ${ROOT}/researches/ctc_unity --agent-dir ${ROOT}/agent \
  --source example/wav_list.txt --target example/target.txt \
  --model-path $file \
  --config-yaml config_gcmvn.yaml --multitask-config-yaml config_mtl_asr_st_ctcst.yaml \
  --agent $ROOT/agent/speech_to_speech.streamspeech.agent.py \
  --vocoder $VOCODER_CKPT --vocoder-cfg $VOCODER_CFG --dur-prediction \
  --output $output_dir/chunk_size=$chunk_size \
  --source-segment-size $chunk_size \
  --latency-metrics AL AP DAL StartOffset EndOffset LAAL ATD NumChunks DiscontinuitySum DiscontinuityAve DiscontinuityNum RTF \
  --device cpu --computation-aware \
  --output-asr-translation True
  # --quality-metrics ASR_BLEU  \