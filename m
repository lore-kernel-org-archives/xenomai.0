From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 15:58:13 +0200
Message-ID: <1305813493.2118.112.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC] Getting rid of the NMI latency watchdog
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


The NMI latency watchdog is a feature Xenomai supports when proper
hardware is available, which triggers a stack backtrace dump, then
panics when a real-time timer tick is late by a given amount of time. We
used it in the early times to chase pathological latencies, particularly
when debugging the original SMP port.

We currently have two architectures supporting that watchdog, namely x86
and blackfin. x86-wise, the rebasing of the NMI support in mainline over
the perf sub-system just obsoleted our NMI hijacking badly, making it
unusable since 2.6.38.

As I was diving in our NMI support code to adapt it once again for
2.6.38 - with a vague feeling of seasickness coming - I felt maybe time
has come to question the very presence of that feature in our code base:

- NMI watchdog predated the latency tracer. AFAIC, I stopped using the
former long ago, preferring the latter for debugging latency issues.

- the non-maskable nature of the interrupt trigger does not help us
nowadays compared to using the I-pipe tracer: the mainline NMI support
would catch hard lockups with irqs off and panic the same way, and the
tracer would help spotting the issue with a much finer level of detail
in case the latency spot leaves the machine in a sane state, Ie. when
the board remains usable and allows for inspection of /proc/ipipe/trace
files.

- hijacking the mainline NMI code the way we do has always been a
massive pain on x86, prone to trigger conflicts with later kernel
releases.

For this reason, I'm considering issuing a patch for a complete removal
of the NMI latency watchdog code in Xenomai 2.6.x, disabling the feature
for 2.6.38 kernels and above in 2.5.x.

Comments welcome.

-- 
Philippe.



