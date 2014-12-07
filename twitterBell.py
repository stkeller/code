import twitter, OSC
import time as tt

# Serial
ser = serial.Serial('/dev/tty.usbserial-DA00SSHA', 9600, timeout=0)
# OSC
client = OSC.OSCClient()
msg1 = OSC.OSCMessage()
msg2 = OSC.OSCMessage()
msg1.setAddress("/twitterMood")
msg2.setAddress("/twitter123")

#Setup Twitter API
api = twitter.Api(
 consumer_key='E2w45rhbrqTRl2CDnox3yhgZF',
 consumer_secret='HRsIfkvqMvx0cqaDT7sNCLoy22FAq7rIdqc2eEvBfyTLlthNFs',
 access_token_key='52897427-UpH5Hqwk4UH2GPR9P0li199fg84UzQUgAs3QTIAhe',
 access_token_secret='uZXntodQQYZuRhq8YIs8WywPNmVAkLWavUiX5J4z2CGBm'
 )

def tweetSearch():

  time = []
  time123 = []
 
  searchSad = api.GetSearch(term='toronto :(', lang='en', result_type='recent', count=1, max_id='')
  searchHappy = api.GetSearch(term='toronto :)', lang='en', result_type='recent', count=1, max_id='')

  searchOne = api.GetSearch(term='dog', lang='en', result_type='recent', count=1, max_id='')
  searchTwo = api.GetSearch(term='cat', lang='en', result_type='recent', count=1, max_id='')
  searchThree = api.GetSearch(term='elephant', lang='en', result_type='recent', count=1, max_id='')

# Happy Sad Tweets
  for t in searchSad:
   print "Sad =", t.created_at
   strSad = t.created_at
   intSad = int(strSad[11:13] + strSad[14:16] + strSad[17:19])
   time.append(intSad)
 
  for t in searchHappy:
   print "Happy =", t.created_at
   strHappy = t.created_at
   intHappy = int(strHappy[11:13] + strHappy[14:16] + strHappy[17:19])
   time.append(intHappy)

# One Two Three Tweets 
  for t in searchOne:
   print "One =", t.created_at
   strOne = t.created_at
   intOne = int(strOne[11:13] + strOne[14:16] + strOne[17:19])
   time123.append(intOne)
 
  for t in searchTwo:
   print "Two =", t.created_at
   strTwo = t.created_at
   intTwo = int(strTwo[11:13] + strTwo[14:16] + strTwo[17:19])
   time123.append(intTwo)
 
  for t in searchThree:
   print "Three =", t.created_at
   strThree= t.created_at
   intThree = int(strThree[11:13] + strThree[14:16] + strThree[17:19])
   time123.append(intThree)
 
# Happy Sad OSC/Serial
  print time
  try:
    if time[0] < time[1]:
      print 0
      print "H"
      ser.write("H")
      msg1.append(0)
      client.sendto(msg1, ('127.0.0.1', 9000))
    else:
      print 1
      print "L"
      ser.write("L")
      msg1.append(1)
client.sendto(msg1, ('127.0.0.1', 9000))
  except IndexError:
   print "Error. Sending default value"
   msg1.append(0)
   client.sendto(msg1, ('127.0.0.1', 9000))
  
# One Two Three OSC
  print time123
  try:
    if time123[0] < time123[1] and time123[2]:
      print 0
      msg2.append(0)
      client.sendto(msg2, ('127.0.0.1', 9001))

    elif time123[1] < time123[0] and time123[2]:
      print 1
      msg2.append(1)
      client.sendto(msg2, ('127.0.0.1', 9001))
  
    elif time123[2] < time123[0] and time123[1]:
      print 2
      msg2.append(2)
      client.sendto(msg2, ('127.0.0.1', 9001))
  except IndexError:
    print "Error. Sending default value"
    msg1.append(0)
    client.sendto(msg2, ('127.0.0.1', 9000))
  tt.sleep(30)

# Call Function
while True:
  tweetSearch()
