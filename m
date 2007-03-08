Message-ID: <45EFFE22.9060401@domain.hid>
Date: Thu, 08 Mar 2007 13:14:26 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN and tsc
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<17901.49981.701410.464219@domain.hid>
	<45EDD311.1060506@domain.hid> <E1HOs43-0008OG-Ki@domain.hid>
In-Reply-To: <E1HOs43-0008OG-Ki@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Hi

>> What does this mean? This is as good as it gets?
> 
> Hm. To be more verbose on what happens between the beginning of 
> rtcan_sja_interrupt and rtcan_rcv please remove the "inline" from the 
> functions rtcan_sja_err_interrupt in the file 
> ksrc/drivers/can/sja1000/rtcan_sja1000.c line 156 and from the function 
> rtcan_sja_rx_interrupt in the same file in line 87. Compile your 
> modules/kernel again and repeat the tracer/latency test.
> 
> I assume that most of the time is spent in the latter function where several 
> SJA HW regs are read out. A slow access to the regs could be the explanation 
> for the long time the interrupt handler has to spend.

Where are the registers located? On the dongle or are these in the PC? 
Just to know whether there might not be a problem with the PEAK device. 
Is there any way you could check what the access times are to 
rtcan_sja_interrupt on your systems when performing the same experiment 
and recieving messages (pref PDO with length 8) over the bus?

I am developing on a pretty high-end machine here, in fact every aspect 
almost as fast as is on the market at the moment so its would surprise 
me if there is a hardware shortcoming if the registers you speak of are 
on the PC.

In the mean time I will try doing as you suggest, I presume you want me 
to send the frozen trace to you again after that.


Is it worth while removing the virtual driver from the kernel build and 
running over rtcan0. Is there any chance that you have never encountered 
this problem

Roland.

> 

