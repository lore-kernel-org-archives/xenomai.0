Message-Id: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:16 +0200
From: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/6] Various refactoring and new IRQ test
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

this series of patches motivated me to dive deeper into the quilt usage. So, if anything pops up brokenly on the list, blame it on my inability to use this nice tool. But let's go to business:

I've refactored the I-pipe tracer interface (i.e reworked my previous xn_sys_ipipe_trace.patch), and also tried to cleanup and restructure the RTDM testing device profile. Along this way, a few smaller improvements (at least as I see them) were added, check the patch headers. And, finally, I would like to introduce a new benchmarking tool, irqbench, for analysing external IRQ latencies.

Some remarks on irqbench: it's "version 2" of Fu's irLat test which he used for comparisons between Xenomai and preempt-rt. "Version 2" means I picked up his good ideas but went for a re-write in order to integrate it cleanly in the RTDM concept, to improve its convenience (pure user-space measurement tool), and to add I-pipe tracer support =8). [Fu, porting the kernel driver to preempt-rt should be straightforward, and all user-mode tools should be directly reusable...]

The test works over null modem (RS232) or parallel port link. Ok, the latter only works in theory; it's absolutely untested and badly hacked together. If anyone is interested in soldering some parallel cable together (maybe a laplink cable could be reused as well, haven't thought about this), let me know. Even more welcome would be patches to make the parallel test work as well!

The output of irqbench is fairly primitive so far. The reason is that I would rather like to motivate a discussion about and development of a generic latency measuring and evaluation library (or interface+tools). Also, now that the funny part is hacked, I prefer to leave the real work to others. :)

My consideration: we have the timer benchmark (latency), the switch test, and now also this IRQ latency test. All tests consist of measuring some interval, analysing its minimum, maximum, and average, generating histograms, maybe one day even writing logs to disk or plotting some diagrams, and so forth. There is so much in common that we should unify this, also to simplify the automated tests evaluation. I'm specifically counting on our test team here ;), but any contribution is welcome.

Jan

--

