From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 17:21:16 +0100
Message-Id: <1136391676.5443.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTDM timerbench problems
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I'm trying to use the xeno_timerbench as a replacement to the old 2.0
klatency module and I encounter some problems.

This is on my in-progress ARM Xenomai port. User space latency and old
klatency work great (my board has some hardware latency problems though
- latencies can be as high as 500 us..). This in on a 2.6.14.5 kernel
using the latest ipipe patch and the latest SVN trunk xenomai.

Note that I never used the RTDM skin until now, so the problem could be
as well in the core RTDM code.

1) When compiled statically into the kernel, it does not work at all:
	# /usr/xenomai/testsuite/latency/latency -p 10000 -t 1
	== Sampling period: 10000 us
	== Test mode: in-kernel periodic task
	latency: failed to open benchmark device, code -19
	(modprobe xeno_timerbench?)

2) When loaded as a module, it does work in -t 2 mode (kernel timer
handler):
	# /usr/xenomai/testsuite/latency/latency -p 10000 -t 2
	== Sampling period: 10000 us
	== Test mode: in-kernel timer handler
	warming up...
	RTT|  00:00:01  (in-kernel timer handler, 10000 us period)
	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
	RTD|        6000|       14640|       72000|       0|        6000|       72000
	RTD|        7000|       15060|       65000|       0|        6000|       72000
	RTD|        7000|       15470|       72000|       0|        6000|       72000
	---|------------|------------|------------|--------|-------------------------
	RTS|        6000|       15056|       72000|       0|    00:00:03/00:00:03

But in -t 1 mode (kernel periodic task) it hangs hard just after the warming period:

	# /usr/xenomai/testsuite/latency/latency -p 10000 -t 1
	== Sampling period: 10000 us
	== Test mode: in-kernel periodic task
	warming up...

Before hanging, sometimes it just prints:
	Unable to handle kernel NULL pointer dereference at virtual address 0000004d

Sometimes the oops is more complete (note that sometimes it also hangs in the middle of
the printout):
	Unable to handle kernel NULL pointer dereference at virtual address 0000004d
	pgd = c0004000
	[0000004d] *pgd=00000000
	Internal error: Oops: 817 [#1]
	Modules linked in: xeno_timerbench
	CPU: 0
	PC is at xnpod_schedule+0x6b4/0x7f0
	LR is at xnpod_schedule+0x54c/0x7f0
	pc : [<c0056cc4>]    lr : [<c0056b5c>]    Not tainted
	sp : c7d41830  ip : c79e8044  fp : c7d41860
	r10: c0283c2c  r9 : c0282

Does this rings a bell to someone ? 

Thanks.

Stelian.
-- 
Stelian Pop <stelian.pop@domain.hid>


