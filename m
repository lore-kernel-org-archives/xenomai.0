Message-ID: <4BF17464.5090100@domain.hid>
Date: Mon, 17 May 2010 18:52:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460EBD6239@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

Steve Deiters wrote:
>>> Hi,
>>>
>>> We had a similar problem. We solved it by compiling the 
>> native skin as 
>>> a module and loading it _after_ the kernel has been 
>> syncronized with 
>>> the real-time clock chip.
>> Yes, that works too. There is also an option in the kernel 
>> for the kernel to synchronize with the RTC clock directly, 
>> without requiring hwclock. I do not know if it is run before 
>> starting Xenomai though.
> 
> I have a similar requirement, except I want to keep the Xenomai clock
> synchronized with Linux services that use adjtime/adjtimex, e.g. NTP.
> It is not sufficient in this case to delay the startup of Xenomai.  I
> suppose as a workaround I could create a low priority periodic thread
> that reads the Linux clock with gettimeofday and sets the Xenomai one
> with clock_settime.

Periodically setting the time is risky if timed jobs depend on Xenomai's
real-time clock - it may jump in all directions...

> 
> Any other suggestions for providing timestamps to real time tasks in
> this case?

Do you just need precise timestamps from with real-time tasks, or do you
have to synchronize timer events of the Xenomai core on an external clock?

For the former case (precisely our scenario), we laid the ground to
extend Xenomai 2.5 with RT-safe syscalls to obtain Linux's view on
gettimeofday. It "just" needs some polishing to post this for upstream.
Wolfgang (CC'ed) is working on this.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

