Message-ID: <4EB32945.6090001@domain.hid>
Date: Thu, 03 Nov 2011 17:52:37 -0600
From: Victor Alvidrez <v.alvidrez@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Question about the TSC and how it is used by Xenomai.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I have been doing a lot of research regarding time and how it is 
measured in Linux.

The book "Understanding the Linux Kernel" by Bovet and Cesati was 
essential in figuring out how time is handled at the kernel level.

Here is what I gather so far (that is relevant to my question):

The RTC is used by the system to initialize the 'struct timeval xtime' 
variable with a UTC time.  After this occurs the PIT is programmed so 
that it issues timer interrupts at a fixed frequency.  The book states 
that this defines a 'tick'.  At each tick occurrence, a interrupt is 
triggered and is handled by the TIMER_BH handler.  This handler adds 
1/HZ microseconds to the 'xtime.tv_usec' value (where HZ is the kernel 
configuration value).  If NTP is being used, the adjtimex() function 
adjusts the 1/HZ value to slowly synchronize the time with a reference 
time.

My issue is in understanding how the TSC (timer stamp counter register) 
is used.  I know that this register counts the number of clock ticks.  I 
am pretty sure that clock ticks refer to ticks produced by the CPU 
clock, which runs at completely different frequency than HZ.

This is where my confusion with Xenomai comes in.  The native skin lets 
me set the timer mode to be oneshot using TM_ONESHOT so that timer ticks 
are in nanoseconds and so that the timer is rescheduled every tick (not 
sure if rescheduled is the right word here).  This explanation makes me 
think that 'timer' refers to the PIT?

However, the native skin lets me set intervals (for alarms/timers) down 
to nanoseconds.  How can this be accomplished if the HZ value only goes 
up to 1000 in the kernel configuration?  Somehow I think the TSC must be 
used separately, independent of the PIT?

I realize this isn't really a Xenomai programming issue, but I thought I 
would go ahead and ask to see if you could provide some help.

Thanks

