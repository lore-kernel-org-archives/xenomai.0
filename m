Message-ID: <49DCF4A7.807@domain.hid>
Date: Wed, 08 Apr 2009 12:01:59 -0700
From: John Wojnaroski <castle@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Excess getpid calls??
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

Hi

We're running several apps with scheduled realtime task using 
rt_task_spawn() in a flight simulator.  There are two apps each for a 
pilot and copilot and each app has 8 periodic tasks running at various 
duty cycles from 1Hz to 50Hz.

A concern was raised as to whether the calls to getpid() were 
excessive.  See trace ouput below....

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

[1006]$ ps augx | grep -i copilot
root      3561 24.7  5.6  51936 58108 ?        RLl  Apr01 2455:02 
Source/Main/copilot --file=glass.cfg --window=0 0 2400 1050
hcsl     20859  0.0  0.0   1820   532 pts/4    S+   09:55   0:00 grep -i 
copilot
(09:55) <hcsl on spire>: ~
[1007]$ sudo !!
sudo strace -p 3561 -c
Process 3561 attached - interrupt to quit
Process 3561 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
92.78    0.179969           2     90067           getpid
5.67    0.010999           5      2247           ioctl
1.55    0.003000           1      2247           gettimeofday
0.00    0.000000           0         9           poll
------ ----------- ----------- --------- --------- ----------------
100.00    0.193968                 94570           total

 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

We have not bored down into the xenomai source to see exactly what is 
going on or where or how the calls are made as we've been quite happy 
with the performance and stability.

Might someone shed a bit of light on the matter and should we be concerned?

Thanks
John W.




