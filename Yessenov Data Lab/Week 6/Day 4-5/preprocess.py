#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

import json
import re
import pickle

from nltk.corpus import stopwords
from pymystem3 import Mystem
import operator

data = pd.read_csv('data/guide_raw.csv')

m = Mystem()
stop_words = set(stopwords.words('russian'))

badwords = [u'я', u'а', u'да', u'но', u'тебе', u'мне', u'ты', u'и', u'у', u'на', u'ща', u'ага',
            u'так', u'там', u'какие', u'который', u'какая', u'туда', u'давай', u'короче', u'кажется', u'вообще',
            u'ну', u'не', u'чет', u'неа', u'свои', u'наше', u'хотя', u'такое', u'например', u'кароч', u'как-то',
            u'нам', u'хм', u'всем', u'нет', u'да', u'оно', u'своем', u'про', u'вы', u'м', u'тд',
            u'вся', u'кто-то', u'что-то', u'вам', u'это', u'эта', u'эти', u'этот', u'прям', u'либо', u'как', u'мы',
            u'просто', u'блин', u'очень', u'самые', u'твоем', u'ваша', u'кстати', u'вроде', u'типа', u'пока', u'ок',u'в',
            u'б',u'г',u'д',u'е',u'ж',u'з',u'й',u'к',u'л',u'ф',u'н',u'о',u'п',u'р',u'с',u'т',u'ч',u'ц',u'ч',
            u'ш',u'щ',u'ь',u'ъ',u'ы',u'э','ю']

popluarCountries = [u'казахстан', u'россия',u'узбекистан',u'киргизия',
                    u'сша',u'штаты',u'америка',u'китай',u'туркменистан',
                    u'сирия',u'монголия',u'франция',u'англия',u'турция']

KZCities = [u'алма-ата',u'алматы',u'караганда',u'караганды',
            u'уральск',u'орал',u'усть-каменогорск',u'оскемен',
            u'кокшетау',u'кокчетав',u'семей',u'семипалатинск',
            u'тараз',u'шымкент',u'астана',u'павлодар',
            u'актобе',u'атырау',u'актау',u'кызылорда',
            u'петропавловск',u'талдыкорган',u'костанай',u'шу',
            u'жезказган',u'байконур',u'туркестан',u'экибастуз',
            u'астан',u'столица',u'город',u'столичный',u'рк',
            u'жамбылский',u'алматинский',u'акмолинский',
            u'западный',u'восточный',u'северный',u'южный',
            u'центральный']

Time = [u'январь',u'февраль',u'март',u'апрель',
        u'май',u'июнь',u'июль',u'август',
        u'сентябрь',u'октябрь',u'ноябрь',u'декабрь',
        u'понедельник',u'вторник',u'среда',u'четверг',
        u'пятница',u'суббота',u'воскресенье',u'день',
        'завтра','сегодня','вчера']

Numerals = [u'ноль',u'один',u'два',u'три',
            u'четыре'u'пять',u'шесть',u'семь',
            u'восемь',u'девять',u'десять',u'сто',
            u'тысяча',u'миллион',u'миллиард',u'триллион']


def Lemmatisator(data):
    lemma = m.lemmatize(data)
    return ''.join(lemma)


def stopwordsEleminator(data, negation=True):
    for word in stop_words:
        if (word == u'не' or word == u'ни') and (negation == True):
            continue
        if word in data:
            for i in range(data.count(word)):
                data.remove(word)
    return data


def dataCleaner(data, negationConcat=False):  # False if clear all, True if clear and concatinate negations
    cleanedData = re.sub("[^а-яА-ЯЁё]", " ", data)  # leave only russian text
    cleanedData = Lemmatisator(cleanedData)
    cleanedData = cleanedData.lower().split()
    cleanedData = stopwordsEleminator(cleanedData, negationConcat)

    if negationConcat == True:
        for i in range(0, len(cleanedData) - 1):
            if (cleanedData[i] == u'не' or cleanedData[i] == u'ни'):
                cleanedData[i + 1] = ('не' + cleanedData[i + 1])
        cleanedData = stopwordsEleminator(cleanedData, False)

    return cleanedData


def duplicateEleminator(data):
    uniqueData = list()
    cnt = 0

    for item in data:
        if item not in uniqueData:
            uniqueData.append(item)
        else:
            cnt += 1
    print("Duplicates:{}".format(cnt))
    return uniqueData


def duplicatedTextEleminator(data):
    uniqueData = list()
    cnt = 0
    for item1 in data:
        duplicate = False
        for item2 in data:
            if (item1["text"] == item2["text"]) and (item1["manual_sentiment"] != item2["manual_sentiment"]):
                duplicate = True
                cnt += 1
        if duplicate == False:
            uniqueData.append(item1)
    print("Duplicates with simillar text:{}".format(cnt))
    return uniqueData

if __name__ == '__main__':
    badwords.extend(popluarCountries)
    badwords.extend(KZCities)
    badwords.extend(Time)
    badwords.extend(Numerals)

    for word in badwords:
        stop_words.add(word)

    with open('data/guide_raw.csv') as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    with open("data_prepared.json", "w", encoding='utf-8') as outfile:
        outfile.write('[')
        for i in range(0, len(rows)):
            json.dump(rows[i], outfile, ensure_ascii=False)
            if i + 1 < len(rows):
                outfile.write(',')
            outfile.write('\n')
        outfile.write(']')

    # for i in range(0, len(data)):
    #     print('before\n', data.loc[i]["txt"])
    #     data.loc[i]["txt"] = dataCleaner(data.loc[i]["txt"])
    #     print('after', data.loc[i]["txt"])
