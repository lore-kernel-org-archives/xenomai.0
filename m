Message-ID: <4C45539B.70204@domain.hid>
Date: Tue, 20 Jul 2010 09:43:23 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to boot on
 ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

I want to upgrade all our PC's from Ubuntu hardy to lucid and in the process
I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel 2.6.32.11
with Xenomai 2.5.3.

I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hardy system
and all went fine. But the problem is it just doesn't run on the lucid distro.
However the vanilla kernel runs fine. I also tried with a config based on the
ubuntu lucid config, with relevant modules compiled in (I don't use initrd).

It looks like the same problem as in this thread:
https://mail.gna.org/public/xenomai-help/2010-06/msg00008.html
Just a black screen after the boot loader. The keyboard leds responds to
capslock etc for a few seconds.

What could it be that with identical hardware the same kernel runs fine (with
decent latencies) under ubuntu hardy and not at all under ubuntu lucid? I
also tested another (older) system with a different mobo. Same result.

If there's anyone running a recent kernel with Xenomai 2.5.3 on an ubuntu lucid
system, could you please send me the kernel config?

Thanks,
Theo

