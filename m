Date: Sat, 11 Apr 2009 19:02:36 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E0F887.40805@domain.hid>
Message-ID: <Pine.LNX.4.64.0904111820330.6444@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Sat, 11 Apr 2009, Gilles Chanteperdrix wrote:
> We have just discovered that FPU handling on x86 had a few bugs, one of
> them involving CPUs without fxsr (check /proc/cpuinfo).

The AMD Athlon that I am using, does have fxsr, according to
/proc/cpuinfo. Regardless, now that I have seen lockups during the
latency tests as well, I don't think that the problem can be related
to floating point. It looks more like an interrupt problem.

Xeno-test sporadically locks up the computer during both the latency
tests and the switching tests. It just happens more often during the
switching test. When the computer is in the locked-up state, the clock
stops updating, any ssh sessions to the computer hang, and I can't
either start a new ssh session, or ping the computer from an external
computer. This persists indefinitely. However all that I have to do to
unhang the computer, is move the mouse, or hit any keyboard key on the
offending PC. Then xeno-test resumes, pings get through etc, until the
next hang. Also, occasionally, moving the mouse or hitting any key
when xeno-test is running, will cause xeno-test to freeze for a
moment, and then report a multi-millisecond latency when I resume it
by moving the mouse.

My guess is that when it hangs, it is waiting for a timer interrupt
that for some reason never arives, and that moving the mouse or
hitting a key on the keyboard generates an interrupt that wakes it
up. Both the keyboard and mouse are PS/2 devices, which presumably go
through the i8042 driver. The contents of /proc/interrupts, shown
below, don't indicate anything attempting to share interrupts with
this.
 	    CPU0
    0:    2545784    XT-PIC-XT        timer
    1:       9149    XT-PIC-XT        i8042
    2:          0    XT-PIC-XT        cascade
    3:          3    XT-PIC-XT
    4:          3    XT-PIC-XT
    5:       2755    XT-PIC-XT        VIA686A
    7:          1    XT-PIC-XT        parport0
    8:          1    XT-PIC-XT        rtc0
    9:          0    XT-PIC-XT        acpi, uhci_hcd:usb1, uhci_hcd:usb2
   11:    8410900    XT-PIC-XT        eth0, radeon@domain.hid
   12:      70922    XT-PIC-XT        i8042
   14:     847875    XT-PIC-XT        pata_via
   15:          0    XT-PIC-XT        pata_via
  NMI:          0   Non-maskable interrupts
  ERR:          0

Any ideas?

Thanks for the help,

Martin

