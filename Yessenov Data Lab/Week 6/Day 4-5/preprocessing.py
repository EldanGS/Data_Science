# coding= utf-8
import pandas as pd
import re
from nltk.stem.snowball import SnowballStemmer
import pymorphy2
from stop_words import get_stop_words
from multiprocessing import Process, Manager

from nltk.corpus import stopwords

stop_words = set(stopwords.words("russian"))
# stemmer = SnowballStemmer('russian')
morph = pymorphy2.MorphAnalyzer()

class parallelizer(Process):

        def __init__(self, thread_id, thread_num, dict, filename, new_csv_binary = None):
            Process.__init__(self)
            self.thread_id = thread_id
            self.thread_num = thread_num
            self.dict = dict
            self.new_csv_binary = new_csv_binary
            self.filename = filename


        def func1(self):
            count_texts = 0
            csv = pd.read_csv(self.filen ame)


            for index, row in csv.iterrows():
                if index % self.thread_num != self.thread_id:
                    continue
                temp_text = ""  # пустышка для склеивания текста
                s = str(row['txt']).split(' ')
                count_texts = count_texts + 1

                for word in s:
                    if word not in stop_words:
                        if word not in ('Клиент:', 'Оператор:', ' ', ')', '(', ':') and re.search('.\d{2}.\d{2}.',
                                                                                                  word) == None and word.isdigit() == False:
                            temp_text = temp_text + morph.parse(word)[0].normal_form + ' '

                self.dict.update({index: temp_text.lower()})

        def run(self):
            self.func1()

def preprocess(filename, output='output.csv', delimeter=',', threads = 6):
    csv = pd.read_csv(filename, delimeter)
    manager = Manager()
    dict = manager.dict()
    processes = []

    for i in range(6):
        bot = parallelizer(i, threads, dict, filename)
        processes.append(bot)
        bot.run()
        bot.start()

    for p in processes:
        p.join()

    list_of_texts = []
    for val in dict.values():
        list_of_texts.append(val.encode('utf-8'))

    pd.Series(list_of_texts).to_csv(output, delimeter)
    return ("File " + output + " has been saved.")
