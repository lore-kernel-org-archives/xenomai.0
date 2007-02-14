Message-ID: <45D25145.3000407@domain.hid>
Date: Wed, 14 Feb 2007 01:01:09 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] CONFIG_PREEMPT & irqbench
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Dear all,

I am running some latency tests with irqbench/irqloop. I am wondering
whether it would be possible to achieve better results when activating
CONFIG_PREEMPT and CONFIG_PREEMPT_VOLUNTARILY during the kernel
configuration and running irqloop in User Mode over this kernel? Does it
make any sense? I think in theory it should give better results because
this irqloop runs in secondary(linux) domain when started, right? An
increasing preemptibility of the linux kernel should be better for the
irqloop-task.
All tests were made under heavy I/O and CPU load by means of "dd",
"pingflood" and "cpuburn". Nevertheless, I can only achieve worse
results when activating CONFIG_PREEMPT.


Thanks in advance and regards,

Markus Franke

