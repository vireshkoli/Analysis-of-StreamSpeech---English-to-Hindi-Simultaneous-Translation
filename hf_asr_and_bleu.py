#!/usr/bin/env python3
"""
hf_asr_and_bleu.py
Usage:
  # transcribe all wavs in a folder and compute corpus BLEU vs a reference file
  python hf_asr_and_bleu.py --wav-dir /path/to/wavs --ref-file /path/to/refs.txt \
       --out-preds preds.txt --model Harveenchadha/vakyansh-wav2vec2-hindi-him-4200

  # transcribe a single wav
  python hf_asr_and_bleu.py --wav /path/to/out_infer.wav --out-preds preds.txt
"""

import argparse
from transformers import pipeline
import glob
import os
import soundfile as sf
import sacrebleu

def transcribe_wav_list(wav_paths, model_name="Harveenchadha/vakyansh-wav2vec2-hindi-him-4200", device=-1):
    # device=-1 => CPU; set device=0 for first GPU
    asr = pipeline("automatic-speech-recognition", model=model_name, device=device)
    preds = []
    for p in wav_paths:
        print("Transcribing:", p)
        # pipeline can take file paths directly
        res = asr(p)
        text = res.get("text", "").strip()
        preds.append(text)
    return preds

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--wav-dir", type=str, default=None, help="directory with wav files (will be sorted)")
    ap.add_argument("--wav", type=str, default=None, help="single wav file")
    ap.add_argument("--ref-file", type=str, default=None, help="reference transcripts (one per line)")
    ap.add_argument("--out-preds", type=str, default="hf_preds.txt", help="where to save transcripts")
    ap.add_argument("--model", type=str, default="Harveenchadha/vakyansh-wav2vec2-hindi-him-4200")
    ap.add_argument("--device", type=int, default=-1)  # -1 => CPU
    args = ap.parse_args()

    wavs = []
    if args.wav:
        wavs = [args.wav]
    elif args.wav_dir:
        # pick typical simuleval output wav naming patterns, sort to keep order stable
        wavs = sorted(glob.glob(os.path.join(args.wav_dir, "*.wav")))
        if len(wavs) == 0:
            raise SystemExit("No wav files found in " + args.wav_dir)
    else:
        raise SystemExit("Provide --wav or --wav-dir")

    preds = transcribe_wav_list(wavs, model_name=args.model, device=args.device)

    # save predictions
    with open(args.out_preds, "w", encoding="utf-8") as f:
        for p in preds:
            f.write(p.strip() + "\n")
    print(f"Wrote {len(preds)} predictions -> {args.out_preds}")

    # if references provided, compute sacrebleu
    if args.ref_file:
        with open(args.ref_file, "r", encoding="utf-8") as f:
            refs = [line.strip() for line in f.readlines()]
        if len(refs) != len(preds):
            print("WARNING: #preds != #refs:", len(preds), len(refs))
        bleu = sacrebleu.corpus_bleu(preds, [refs])
        print("SacreBLEU:", bleu.score)
        print(bleu.format())

if __name__ == "__main__":
    main()