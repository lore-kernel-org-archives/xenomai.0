Message-ID: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
Date: Sat, 3 Mar 2007 14:09:14 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] CAN errors and real-time behaviour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

HI,

I thought I would put this in a separate thread.

The experiment works as follows. I have a 1ms and a 2 ms rt periodic task.

In the real-time periodic task I am only reading out the message
buffer (only work done in the task). In the 2ms task I am doing
nothing.

I always read-out the measured period times. This is done by writing
the measured value into a variable which is displayed in a separate
thread outside the rt tasks so the display does not influence the
measurement. (Unlike  printf is said to do).

There is nothing connected to the rtcan2 device (Peak dongle). The
applicaiton runs fine the tasktimes relatively well maintained
(fluctuatin about 0.003ms) around 1ms and 2ms.

The moment I write to the device using rtcansend eg:
./rtcansend rtcan2 -i 0x700 0x03 0x02

the buserror comes up and the protocol error. from that moment onwards
the messagebuffer gets flooded and does not stop being flooded forever
after.

The period times then fluctuate badly up to 0.2ms around their nominal values.

This is not desirable behavior. Firstly its not necessary to have the
message buffer flooded all the time I would think. How do I change
that so that I will only pick up an error once in response to a failed
send?
Secondly what am I doing wrong that breaks the real-time behaviour? If
the bus gives an error on one part of the process I don;t want other
processes that may have nothing to do with the CAN bus to misbehave.?

I do suspect that if I can prevent the message buffer flooding forever
and manage to clean it out that the behaviour will be better because
if its flooded then messages get sent to dmesg well wherever dmesg
reads from that is) and this may explain the behavior?

Can anyone comment on this please?

Regards,

Roland.

