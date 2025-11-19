# lang=en-hi
# DATA_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c/$lang
# ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech
# PRETRAIN_ROOT=$ROOT/pretrain_models


# N_CLUSTERS=100 #<number_of_clusters_used_for_kmeans>
# TYPE=hubert #<one_of_logmel/cpc/hubert/w2v2>
# CKPT_PATH=$PRETRAIN_ROOT/mHuBERT/mhubert_base_vp_en_es_fr_it3.pt #<path_of_pretrained_acoustic_model>
# LAYER=11 #<layer_of_acoustic_model_to_extract_features_from>
# MANIFEST=$DATA_ROOT #<tab_separated_manifest_of_audio_files_for_training_kmeans>
# KM_MODEL_PATH=$ROOT/preprocess_scripts/mhubert.km1000.layer11.pt #<output_path_of_the_kmeans_model>



# PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/create_manifest.py --data-root $DATA_ROOT

# for split in train dev test
# do
#     PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/quantize_with_kmeans.py \
#         --feature_type $TYPE \
#         --kmeans_model_path $KM_MODEL_PATH \
#         --acoustic_model_path $CKPT_PATH \
#         --layer $LAYER \
#         --manifest_path $DATA_ROOT/$split.txt \
#         --out_quantized_file_path $DATA_ROOT/$split.km1000
# done



#!/bin/bash

lang=en-hi
DATA_ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/datasets/cvss/cvss-c/$lang
ROOT=/Users/vireshkoli/Documents/MTech/Machine_Learning/ML_Project/StreamSpeech
PRETRAIN_ROOT=$ROOT/pretrain_models

N_CLUSTERS=100  # number_of_clusters_used_for_kmeans
TYPE=hubert      # one_of_logmel/cpc/hubert/w2v2
CKPT_PATH=$PRETRAIN_ROOT/mHuBERT/mhubert_base_vp_en_es_fr_it3.pt  # path_of_pretrained_acoustic_model
LAYER=11         # layer_of_acoustic_model_to_extract_features_from
MANIFEST=$DATA_ROOT
KM_MODEL_PATH=$ROOT/preprocess_scripts/mhubert.km1000.layer11.pt   # trained kmeans model

# -----------------------------------------------------------------------------
# 1️⃣  Create Manifest Files
# -----------------------------------------------------------------------------
echo "=== Creating manifests for $lang ==="
PYTHONPATH=$ROOT/fairseq python $ROOT/preprocess_scripts/create_manifest.py --data-root $DATA_ROOT
echo "=== Finished creating manifests ==="

# -----------------------------------------------------------------------------
# 2️⃣  Quantize each split (train/dev/test)
# -----------------------------------------------------------------------------
for split in train dev test; do
  echo "=== Quantizing ${split} ==="

  OMP_NUM_THREADS=1 \
  MKL_NUM_THREADS=1 \
  OMP_THREAD_LIMIT=1 \
  OMP_WAIT_POLICY=ACTIVE \
  PYTHONFAULTHANDLER=1 \
  PYTHONWARNINGS=ignore \
  PYTHONPATH=$ROOT/fairseq \
  python $ROOT/preprocess_scripts/quantize_with_kmeans.py \
    --feature_type $TYPE \
    --kmeans_model_path $KM_MODEL_PATH \
    --acoustic_model_path $CKPT_PATH \
    --layer $LAYER \
    --manifest_path $DATA_ROOT/${split}.txt \
    --out_quantized_file_path $DATA_ROOT/${split}.km1000 \
    # --extension .mp3.wav 2>&1 | tee /tmp/quantize_${split}.log

  echo "=== Finished ${split} (log: /tmp/quantize_${split}.log) ==="
done

echo "✅ All splits processed for $lang"