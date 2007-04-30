Message-ID: <46359B2C.3000206@domain.hid>
Date: Mon, 30 Apr 2007 09:30:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] timing within a task and assessing the timing of CAN
	messages
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hello,

I have three questions I would like to pose here.

1-Is it possible to subdivide a task to control at what time a certain 
command is executed within the task? Example: I have a 1ms task. I send 
a CAN sync message at the beginning of the task but I would like to wait 
about 300us before performing a read to ensure that all the messages 
emitted as a result of this sync have come in. Now I will have an odd 
700us to use the data that has come in to calculate outputs. However I 
want the output to be put out as close as possible to the end of the 
task time. Is there an elegant manner to delay the read and the write to 
give me this kind of control within a taks. If not any suggestions as to 
how I should tackle this.


2-For development I am still using the PEAK CAN dongle. We have 
establisched that the ISR responding to an incoming message interrupt 
takes 200us to complete. Is anything known about how long it takes 
before a message that has been sent is put on the bus? How does this 
happen? Reason I ask is to know what kind of variance I can expect in 
time between the moment I send the output values and the moment it is on 
the bus. If there are routines between those to points that allow 
themselves to be pre-empted or for some other reason have varying 
execution times my control performance will be badly degraded.


3-How do I interpret the relative time stamps that can be made visible 
with rtcanrev ? IS the time indicated the time between each message and 
the last time the message was posted? Or between the message and its 
direct predecessor?

In short, I want to ensure that my sync message goes out EXACTLY (or as 
close as technically possible :) ) every ms so I get the input 
(position) values exactly every ms. Then I want those values ot be used 
in the task to calculate the output and I want to set the output EXACTLY 
1ms later.

To achieve this so far what I have done is:

Beginning of task

1-Write CAN message with outputs values
2-Send sync to get inputs
3-Read can messages (This might be too soon to get the values from the 
last sync)
4-do calcs for output with data from 3.


Any ideas of howto to control this as well as possible will help.

Thanks kindly.

Regards,

Roland.


