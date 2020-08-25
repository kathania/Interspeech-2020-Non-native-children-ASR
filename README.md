# Interspeech-2020-Non-native-children-ASR
This repository publishes two data augmentation tools used in our INTERSPEECH 2020 [paper]():
- Prosodic augmentation of speech data
- Adding false start noise to language modeling corpora

# Prosody modification
We provide a script (`scripts/prosody_modification/example.m`) to modify the prosody parameter (pitch and speaking-rate) of a speech signal [1]. In the script you can change the paramter/scale to modify pitch and speaking-rate of a speech signal. This we have used to augment the original data with prosody modified data for ASR training.

# Adding false start noise to text
We provide a script (`scripts/add_noise.py`) to add false start noise (e.g. program can be split into pro- program). This noise allows to mimic false starts in a language modeling corpora for speech recognition. An example run of the script is as follows: 
```
python3 scripts/add_noise.py --text-file input.txt --threshold 0.3 --min-word-length 3> input.txt.noised
```
The script expects an input text file with a list of sentences (`input.txt`), a threshold and minimum word length. The input text is formated where each sentence is placed in a newline and the words in sentence are separated by a space. The threshold helps randomize the process of adding false start noise to words. In the above example 30% of the words are transformed into false starts. The minimum word length specifies the minimum length of the word to consider for noising.

# Citation
<pre>
@inproceedings{Kathania2020,
  author={Hemant Kathania and Mittul Singh and Tamás Grósz and Mikko Kurimo},
  title={Data augmentation using prosody and false starts to recognize non-native children's speech},
  year=2020,
  booktitle={Proc. Interspeech 2020},
  pages={To appear}
}
</pre>

# References
[1]. X. Zhu, G. T. Beauregard, and L. L. Wyse, “Real-time signal es-timation  from  modified  short-time  fourier  transform  magnitudespectra,”IEEE  Transactions  on  Audio,  Speech,  and  LanguageProcessing, vol. 15, no. 5, pp. 1645–1653, 2007.
