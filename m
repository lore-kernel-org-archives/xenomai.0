Message-ID: <4BF1794A.6050207@domain.hid>
Date: Mon, 17 May 2010 19:13:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460EBD62C8@domain.hid>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

Steve Deiters wrote:
>> Periodically setting the time is risky if timed jobs depend 
>> on Xenomai's real-time clock - it may jump in all directions...
>>
>>> Any other suggestions for providing timestamps to real time 
>> tasks in 
>>> this case?
>> Do you just need precise timestamps from with real-time 
>> tasks, or do you have to synchronize timer events of the 
>> Xenomai core on an external clock?
>>
>> For the former case (precisely our scenario), we laid the 
>> ground to extend Xenomai 2.5 with RT-safe syscalls to obtain 
>> Linux's view on gettimeofday. It "just" needs some polishing 
>> to post this for upstream.
>> Wolfgang (CC'ed) is working on this.
> 
> I'm just looking to get timestamps in the real time task.  At least in
> my case being able to call gettimeofday from the real time thread would
> be exactly what I need.
> 
> By the way, calling gettimeofday currently within a real time thread
> seems to occasionally freeze up my whole system.  I was going to make
> another post for this after I got a chance to verify some details.  Has
> anyone noticed anything similar to this?
> 

Yes, that's expected: If gettimeofday runs syscall-less, it tries to
read the time offset from a page which the Linux kernel updates
regularly. When user-space detects an ongoing update, it spins until
that has completed. But as Xenomai runs the task with higher priority
than the Linux update handler, you just ran into a live-lock.

Switching on the Xenomai watchdog will confirm this: It will shoot that
task, and the system will recover.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

