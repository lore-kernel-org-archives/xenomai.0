Date: Wed, 13 May 2009 18:15:29 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
Message-ID: <Pine.LNX.4.64.0905131634150.7706@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Encouraging Xenomai test results
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

Just in case it's of interest to anybody, here are some results of
testing a custom RTDM device driver and Xenomai on a computer with a
Celeron 430 (1.8GHz) processor. As discussed in other threads, I have
to turn off X86_PM_TIMER and HPET_TIMER to get Xenomai working
properly on this system. So the test was performed with these timers
turned off in the kernel configuration.

My custom RTDM device driver works with PCI-DIO-72/96/120 digital I/O
cards from Acces I/O. This family of cards include from three to five
8255-5 parallel peripheral interface chips, providing from 72 to 120
bits of digital I/O, along with optional interrupt generation. I have
the 96-bit version. Using this, I connected a wire from an I/O pin
that my program configured to generate an interrupt on rising edges,
to a pin that I configured as a digital output. This allowed the test
program to trigger an interrupt by writing to said digital output bit,
and then measure how much time elapsed before the driver notified it
of the resulting interrupt. My test program ran under Xenomai in user
mode, and used one ioctl to write to the output pin, and another to
wait for the driver to indicate that it had received an interrupt from
the card. It read the time before asserting the output pin, and read
the time again, after being notified of the resulting interrupt. It
then used the difference between these two times as an estimate of the
roundtrip latency. This was done in a loop, rate-limited by sleeping
for 1ms after each measurement. This thus generated interrupts at
1KHz. After every 10000 measurements, the program printed out the min
and max latencies that it had seen so far.

In order to sample not only the interrupt latency, but also task
switching latency, I also ran a second realtime Xenomai task at
slightly lower priority. This executed an iterative double precision
recurrence algorithm (with no function calls) continually for about 3
seconds at a time, pausing for 1.2s between each run to give some time
to Linux itself.

After an hour of running the program (ie. 3600000 measurements), the
range of roundtrip latencies that the program measured, were from 9us
to 29us. This seems pretty good to me.

While performing these measurements, I tried running various Linux
loads, such as dd if=/dev/zero of=/dev/null, lots of "find" commands
to hammer the disk, etc, but nothing that I did in Linux seemed to
have any effect on the Xenomai timings.

One thing that I don't understand is why whenever I ran my Xenomai
test program, the Linux clock ran slow, losing about half an hour
during the hour-long test. My realtime floating-point load task was
designed to preempt the Linux kernel for about 3 seconds, then go to
sleep for about 1.2 seconds, to give Adeos time to replay pending
interrupts to the Linux kernel. Although the realtime interrupt
strobing task was still running during the 1.2s pauses in the load
task, it only ran for 30us every 1ms.  So I am wondering why so many
timer interrupts appear not to have been played back by Adeos? I
didn't seen any evidence of non-timer interrupts getting lost. Is this
perhaps a side effect of turning off X86_PM_TIMER and HPET_TIMER, and
leaving both Linux and Xenomai sharing the sole remaining timer?

Martin

