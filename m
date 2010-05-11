Message-ID: <4BE97F42.4050808@domain.hid>
Date: Tue, 11 May 2010 18:01:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0BE@srv-dc.ona-electroerosion.com>
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C0BE@srv-dc.ona-electroerosion.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and/or PREEMPT_RT patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Asier Tamayo <asier.tamayo@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Asier Tamayo wrote:
> Hello Jan:
> 
> Thanks for your help.
> 
>> There are many factors of your scenario that influence a comparison. So
>> you should sketch your requirements and variables first. To name a few:
>>  - CPU architecture
>>  - overview on your critical loop(s)
>>  - their timing requirements
>>  - portability of your applications (to decide about application
>>    adaption vs. legacy OS emulation)
>>
> 
> My new CPU has an Intel Atom N270 @1.6 GHz processor. At the moment (during the porting it might be optimized), I have 5 drivers requering hard real-time (no loop can be skipped) and being called every 2 to 10 ms. In fact, at the beginning I was using 1 ms, but I had some problems with the hard real-time and changed the timing to 2 ms. I do not consider using a legacy OS emulation.

Given a sane hardware and a feasible task schedule, 1 KHz is no big deal
for any approach.

The fact that you only associate real-time with your drivers make me
wonder about the system architecture (split between actual hardware
access and application implementing the control logic). You will notice
that both approaches strongly encourage this split - in contrast to many
legacy RTOSes.

> 
> Knowing my scenario, can you give some new advice?
> 
> Besides, the drivers and programs (GUI, parser, ...) in my system use shared memory to communicate between them. Which solution (Xenomai or PREEMPT_RT) allows me more easily to keep on using the shared memory both in real-time and not real-time proccesses?

Shared memory is naturally available inside the same process (in case
you organize all your RT tasks this way), there is no problem using
POSIX shm between processes (if set up ahead of use), and drivers can
map/lock the memory for the application that is using it. Before
considering inter-driver communication (unless drivers are stacked), you
should think about the software architecture (see above).

All general statements, and they apply to any approach.

>From the brief description, I tend to say you are free to choose what
works best for you as-is. Both approaches do not require excessive
setups, so you can simply give them a try on your target.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

