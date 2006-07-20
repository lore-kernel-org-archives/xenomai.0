Subject: Re: [Xenomai-help] Priority inversion
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E04F5518@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E04F5518@domain.hid>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 22:50:19 +0200
Message-Id: <1153428620.5071.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-07-20 at 15:14 +0200, ROSSIER Daniel wrote:
> 
> Hi all,
> 
> Attached, another tricky piece of code.
> 
> We actually try to exhibit a priority inversion by using the semaphore (which does not implement the priority inheritance protocol).
> 
> We have the three following tasks:
> 
> - meteoDataAcquisition: acquiring the mutex, spinning 10ms, releasing the mutex / priority 1 / delayed at 18ms, and then activated with a frequency of 1000 ms from its first activation (so normally, more or less activated at 1018, 2018, 3018, etc.)
> 
> - busManagement: acquiring the mutex, spinning 5 ms, releasing the mutex / priority 10 / period of 20 ms.
> - comHandling: just spinning 10ms, period of 20 ms.
> 
> So, the worst case would be when the meteoDataAcquisition acquired the mutex right before the busManagement, so we can say that the highest priority task will be delayed of 10ms at the worst; we put an alarm of 30ms, then no alarm will raise up; and indeed, it works like that.
> 
> Doing the same stuff with the semaphore - just change WITH_MUTEX to 0 - should theoretically lead to an alarm since the comHandling will take the hand, delaying the busManagement over 30ms. Here comes the problem: if we leave the alarm at 30ms, the alarm raises up, as expected. But, if we change the alarm to 31ms, there is no alarm anymore... and we do not understand why? Normally we should see some alarms for some values from 31 to 35ms, since comHandling spins during 10ms. Mytery...
> 
> Normally, the task meteoDataAcquisition is aperiodic, and activated on the basis of an IRQ. In order to simulate that, we put the task with a delay of 18ms (yes, that's the reason of 18 ;-)), activated each second (therefore causing the priority inversion systematically). But nothing happens! the system runs, but no alarm raises up with 

With some help from the simulator,
http://download.gna.org/xenomai/screenshots/simulator.png
here is the timeline of your example:

[sys_date*]	[task]	[alarm_setup*]
0		com
10		bus	15
18		mto
20		bus	35
loop:
20		com
40		bus	45
45		com
60		bus	65
65		com
80		bus	85
85		com
100		bus	105
105		com
118		mto
120		bus	135
jump loop

(*) system and alarm setup dates are expressed in relative ticks since
the application startup.

Given that there is never more than 30 ticks between two alarm setups in
this timeline (i.e. between ticks #105 and #135), the result you got
looks correct.

-- 
Philippe.



