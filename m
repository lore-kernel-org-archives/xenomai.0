Message-ID: <49EF6591.7000802@domain.hid>
Date: Wed, 22 Apr 2009 20:44:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] An answer to Steven's questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>


Hi Steven,

what matters in an RTOS, Xenomai being no exception, is the latency.
Actually, there are three latencies, the interrupt latency, the
kernel-space scheduling latency, and the user-space scheduling latency.

The true nature of these latencies for Xenomai is complex. It is
probably a mix between the longest interrupt masking section in both
Xenomai and Linux code and the indirect effect of cache, spin-locking on
SMP, TLB, BTB and of other hardware effects. Trying to compute this
latency mathematically is hopeless.

For this reason, Xenomai comes with a tool called "latency", which
allows you to measure these latencies given a load applied on the
system. For this tool to give meaningful results, you should apply a
realistic load on the system, to be sure that most paths in Xenomai and
Linux code are taken so that their masking section time, or their effect
on cache, TLB, BTB, etc... if any, is taken into account.

So, you should not focus on whether this or that part of Xenomai or
Linux code is preemptible or not, you would miss the big picture. What
you have to do, is run the latency test given a proper load applied on
the system. Then you will get a number, and you can rely on this number
(maybe adding some safety margin) as being the latency of Xenomai on
your system. Needless to say, Xenomai syscalls and process migrations
are already done by the printing thread in the latency test, so, there
is no need to try them in a separate load program.

Regards.

-- 
					    Gilles.

