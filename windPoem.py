import time, csv, urllib2, itertools
from yattag import Doc

# Generated poems settings
morning, afternoon1, afternoon2, evening = False, False, False, False
waiting = False
morningTime = '090000'
afternoon1Time = '120000'
afternoon2Time = '150000'
eveningTime = '180000'
morningTitle = "Fight"
afternoon1Title = "Thrash"
afternoon2Title = "Water"
eveningTitle = "Claim"

fontSizeTitle = 5
fontSizePoem = 3

baseOffset = 0
offsetMorning = 0
offsetAfternoon1 = 0
offsetAfternoon2 = 0
offsetEvening = 0

# Word arrays
#Load CSV wind data flie
wordsFile = "words.csv"
wordsData  = open(wordsFile, "r")
wordsReader = csv.reader(wordsData)
wordsArray = []
	
# Assign words to array
for row in wordsReader:
	wordsArray.append(row[0])

morningWords = []
afternoon1Words = []
afternoon2Words = []
eveningWords = []


######################################
######## DEFINE POEM FUNCTION ########
######################################

#https://rosettacode.org/wiki/Map_range#Python
#http://www.gnu.org/licenses/fdl-1.2.html
def maprange( a, b, s):
	(a1, a2), (b1, b2) = a, b
	return  b1 + ((s - a1) * (b2 - b1) / (a2 - a1))

def generatePoem(words, poemTitle, baseOffset, wordsOffset):
	#Import data from the web and save into CSV file
	response = urllib2.urlopen('http://www.firstfloor.org/~matt/WindPoem.txt')
	html = response.read()
	dataRaw = open("data.csv","w")
	dataRaw.write(html)
		
	#Load CSV wind data flie
	dataFile  = open("data.csv", "r")
	reader = csv.reader(dataFile)
	next(reader)
	next(reader)
	
	numberWords = float(len(words))
	chosenWords = []
	values = []
	
	# Assign words to values
	for row in reader:
		try:
			values.append(row[7])
		except IndexError:
			pass
	values = values[::-1]		
	
	###Choose word-value mapping to be based on arbitrary values or min/max
	#Minimum and Maximum readings
	#minVal = float(min(values))
	#maxVal = float(max(values))
	#Arbitrary values
	minVal = float(0)
	maxVal = float(10)

	for i in values:
		currentVal = float(i) 
		if currentVal > maxVal:
			currentVal = 10
		chosenWords.append( words[ int(maprange( (minVal, maxVal), (0, numberWords), float(currentVal))) -1 ] )
	# Poem
	print poemTitle
	print ""
	print chosenWords[0 + (baseOffset * wordsOffset)]
	print chosenWords[1 + (baseOffset * wordsOffset)]
	print "	" + chosenWords[2 + (baseOffset * wordsOffset)]
	print "	" + chosenWords[3 + (baseOffset * wordsOffset)]
	print chosenWords[4 + (baseOffset * wordsOffset)]
	print chosenWords[5 + (baseOffset * wordsOffset)]
	print chosenWords[6 + (baseOffset * wordsOffset)]
	print chosenWords[7 + (baseOffset * wordsOffset)]
	print chosenWords[8 + (baseOffset * wordsOffset)]
	print "	" + chosenWords[9 + (baseOffset * wordsOffset)]
	print "	" + chosenWords[10 + (baseOffset * wordsOffset)]
	print chosenWords[11 + (baseOffset * wordsOffset)]
	print chosenWords[12 + (baseOffset * wordsOffset)]
	print chosenWords[13 + (baseOffset * wordsOffset)]
	print chosenWords[14 + (baseOffset * wordsOffset)]
	print "	" + chosenWords[15 + (baseOffset * wordsOffset)]
	print "	" + chosenWords[16 + (baseOffset * wordsOffset)]
	print ""
	print ""

	#Poem to txt
	poemFile = open("poems.txt","a") 
	
	poemFile.write(poemTitle + "\n")
	poemFile.write("\n")
	poemFile.write(chosenWords[0 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[1 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("	" + chosenWords[2 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("	" + chosenWords[3 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[4 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[5 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[6 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[7 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[8 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("	" + chosenWords[9 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("	" + chosenWords[10 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[11 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[12 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[13 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write(chosenWords[14 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("	" + chosenWords[15 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("	" + chosenWords[16 + (baseOffset * wordsOffset)] + "\n")
	poemFile.write("\n")
	poemFile.write("\n")
	poemFile.write("--------------------------------\n")
	poemFile.close()

	# Poem to HTML
	f = open('poem.html','w')
	doc, tag, text, line = Doc().ttl()

	with tag('html'):
		with tag('body'):
			with tag('ul', id='poem title'):
				with tag('font size =' + str(fontSizeTitle)):
					with tag('b'):
						line('pre class="tab"', poemTitle)
			with tag('ul', id='poem'):
				with tag('font size =' + str(fontSizePoem)):
					line('pre', chosenWords[0 + (baseOffset * wordsOffset)])
					line('pre', chosenWords[1 + (baseOffset * wordsOffset)])
					line('pre', "	" + chosenWords[2 + (baseOffset * wordsOffset)])
					line('pre', "	" + chosenWords[3 + (baseOffset * wordsOffset)])
					with tag("br"):
						line('pre', chosenWords[4 + (baseOffset * wordsOffset)])
						line('pre', chosenWords[5 + (baseOffset * wordsOffset)])
						line('pre', chosenWords[6 + (baseOffset * wordsOffset)])
						line('pre', chosenWords[7 + (baseOffset * wordsOffset)])
						line('pre', chosenWords[8 + (baseOffset * wordsOffset)])
						with tag("br"):
							line('pre', "	" + chosenWords[9 + (baseOffset * wordsOffset)])
							line('pre', "	" + chosenWords[10 + (baseOffset * wordsOffset)])
							line('pre', chosenWords[11 + (baseOffset * wordsOffset)])
							line('pre', chosenWords[12 + (baseOffset * wordsOffset)])
							with tag("br"):
								line('pre', chosenWords[13 + (baseOffset * wordsOffset)])
								line('pre', chosenWords[14 + (baseOffset * wordsOffset)])
								line('pre', "	" + chosenWords[15 + (baseOffset * wordsOffset)])
								line('pre', "	" + chosenWords[16 + (baseOffset * wordsOffset)])			
	f.write(doc.getvalue())
	f.close()

######################################
######################################

#Generate poems (infinite loop)
while True:
	current_time = time.localtime()
	formatted_time = time.strftime('%H%M%S', current_time)
	
	#Waiting and reset variables
	if waiting == False:
		print "Waiting..."
		print ""
		print ""
		print ""
		baseOffset = 16
		offsetMorning = 0
		offsetAfternoon1 = 1
		offsetAfternoon2 = 2
		offsetEvening = 3
		waiting = True
	
	#morning
	if formatted_time == morningTime and morning == False:
		print formatted_time + " morning poem"
		print ""
		generatePoem(wordsArray, morningTitle, 0, offsetMorning)
		morning, afternoon1, afternoon2, evening = True, False, False, False
		waiting = False
	#afternoon 1
	if formatted_time == afternoon1Time and afternoon1 == False:
		print formatted_time + " afternoon 1 poem"
		print ""
		try:
			generatePoem(wordsArray, afternoon1Title, baseOffset, offsetAfternoon1)
		except IndexError:
			baseOffset = baseOffset / 4
			generatePoem(wordsArray, afternoon1Title, baseOffset, offsetAfternoon1)
		morning, afternoon1, afternoon2, evening = False, True, False, False
		waiting = False
	#afternoon 2
	if formatted_time == afternoon2Time and afternoon2 == False:
		print formatted_time + " afternoon 2 poem"
		print ""
		try:
			generatePoem(wordsArray, afternoon2Title, baseOffset, offsetAfternoon2)
		except IndexError:
			baseOffset = baseOffset / 4
			generatePoem(wordsArray, afternoon2Title, baseOffset, offsetAfternoon2)
		morning, afternoon1, afternoon2, evening = False, False, True, False
		waiting = False
	#evening
	if formatted_time == eveningTime and evening == False:
		print formatted_time + " evening poem"
		print ""
		try:
			generatePoem(wordsArray, eveningTitle, baseOffset, offsetEvening)
		except IndexError:
			baseOffset = baseOffset / 4
			generatePoem(wordsArray, eveningTitle, baseOffset, offsetEvening)
		morning, afternoon1, afternoon2, evening = False, False, False, True
		waiting = False
