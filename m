Date: Mon, 27 Apr 2009 15:30:45 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <1240487288.6990.71.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0904271229410.719@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<1240487288.6990.71.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Lockups on a new Celeron-430 system detected and
	resolved.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

I have just installed Xenomai 2.5-rc1 on a new computer that has a new
Celeron-430 1.8GHz processor on a Foxconn G31AX motherboard.
Initially I experienced similar lockup problems with this setup as I
previously reported for an ancient 850MHz AMD Athlon computer. As with
the AMD Athlon, fixing the lockup problem required me to turn off both
HPET_TIMER and X86_PM_TIMER.

I initially left both HPET_TIMER and X86_PM_TIMER enabled, because I'd
guessed that the problem that I'd previously experienced was specific
to the older system.  However on trying out kernel 2.6.29.1, patched
with Xenomai 2.5-rc1, and ipipe 2.6.29.1-x86-2.3-01, on the new
system, I found that when running dd if=/dev/zero of=/dev/null, it
behaved almost identically to the older system. The only apparent
difference was that the clock on the new system didn't appear to lose
any time during the lockup periods. Since that initial test, I have
tried all 4 possible combinations of HPET_TIMER and X86_PM_TIMER, and
have thus verified that both of these options must be turned off to
prevent the lockups.

I'm wondering why nobody else appears to have encountered this
problem. I wonder if this could be related to turning off "Symmetric
multi-processing support", and turning on both "Local APIC support on
uniprocessors", and "IO-APIC support on uniprocessors".

For the sake of anybody else who does come across this thread on
encountering similar problems, note that in order to turn off
X86_PM_TIMER, one has to first go to the "General setup" kernel
configuration page, enable the "Configure standard kernel features
(for small systems)" option, then go to the "Power management and ACPI
options" page, and under its "ACPI (Advanced Configration and Power
Interface) Support)" page, disable "Power Management Timer
Support". To turn off the HPET timer as well, go to the "Processor
type and features" page, and disable the "HPET Timer Support" option.

As with the old Athlon system, when either of the above timer options
was enabled, the new Celeron system reliably locked up within about 30
seconds of starting to run dd if=/dev/zero of=/dev/null. In the
periods before it locked up, top always showed that dd was getting
only a few percent CPU time, with no other processes running, even
though top also indicated that the CPU was 100% utilized. When it then
locked up, top froze, the system was unresponsive to any other input,
and pings from other computers failed to elicit replies from the
computer. However, during the lockups, dd apparently continued to run,
because when it was bounded with the count= option, although it
blocked out all other processes, it always finished in the expected
amount of time, and then the system returned to normal. Curiously,
when dd was run during the latency phase of xeno-test, the system
didn't lock up at all, and top showed dd getting 98% of the CPU
time. However the latency program displayed bogus values of between
-1.0 and 1.0 micro-seconds. When dd was not running, the latency
measurements showed more believable values of around 20 usec, although
as shown below, these were much higher than this system is capable of
with the problematic timer options turned off. When the switch test
part of xeno-test was running, the system did lock up. In this case, I
ran xeno-test with a background load that consisted of a script that
ran dd bounded to about 35 seconds, then slept for 5 seconds, then ran
dd for another 35 seconds etc. During the 5 second pauses, the switch
test went fine. After each pause, when dd was running, the number of
context switches that were reported, climbed until reaching around
28000 per second. At that point the system would lock up until the
next 5 second pause, at which point the results would again be around
28000 per second for a few seconds, then quickly decrease until dd
started again, then again rise towards that figure before locking up.

With both of the problematic timer options turned off, the dd workload
caused no problems. In this case, xeno-test reported a maximum latency
of 6.5us for the periodic user-mode task, 4.0us for the in-kernel
periodic task, and 1.6us for the in-kernel timer handler. During the
switchtest phase, there were between 7400 and 8944 context switches
per second. So if I understand this correctly, it looks as though it
should be possible for a Xenomai task running in user-space, to always
start responding to an interrupt within about 140us. I will verify
this as soon as I've written a driver for the digital I/O cards that I
have here.

Martin

