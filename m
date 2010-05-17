Message-ID: <4BF1903C.50801@domain.hid>
Date: Mon, 17 May 2010 11:51:40 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>,
	<4BF1794A.6050207@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0C9F71BAFF@FW-SBS.fw.local>
In-Reply-To: <843773D242212C4882D4EDFFBF665F7F0C9F71BAFF@FW-SBS.fw.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Karch <JKarch@domain.hid>, Steve Deiters <SteveDeiters@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

>  If no ntp server updates are made to the Linux clock,  we have
>  noticed over a week's period a drift of ten or so seconds difference
>  between the Linux clock and the Xenomai get time function and often
>  have to reboot our machine to resynchronize the Xenomai and Linux
>  clocks back to less than a couple seconds difference.  I was
>  wondering if you might explain why that might happen?

Your clock oscillator on the x86 PC is drifting wrt NTP time (the 
oscillators are known to be bad time sources). We see the same effect 
here. With NTP running, try running a RT periodic thread and obtain both 
Linux system time and Xenomai RT time. You will see a sawtooth time 
difference reaching around 1msec in magnitude before NTP readjusts Linux 
system time back down to near zero. Then the clocks drift wrt one 
another until you have around a 1msec difference, and NTP adjusts the 
time again. I recall a periodicity of around 30-60sec per adjustment 
cycle (5-10 seconds per week) but it is dependent on the characteristics 
of your specific oscillator on the motherboard.

I have thought to cope with this by having a rate parameter on the code 
encapsulating my timing source (I have "drivers" for Linux system time, 
Xenomai time, and hardware timing sources). The NTP rate in the drift 
file is pretty constant, so one could presumably use that rate to adjust 
your timers.

hth

                                      - Tom


