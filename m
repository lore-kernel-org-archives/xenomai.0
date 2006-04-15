MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17473.2836.45267.504758@domain.hid>
Date: Sat, 15 Apr 2006 17:02:44 +0200
Subject: Re: [Xenomai-core] T_FPU without effect
In-Reply-To: <4440C19C.2000302@domain.hid>
References: <443F5DD7.40306@domain.hid>
	<17471.42250.270559.782396@domain.hid>
	<4440C19C.2000302@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > > thread in primary mode uses FPU for the first time on x86, the FPU
 > > hardware is initialized in the fault handler, this is the expected
 > > behaviour. This allow the nucleus to not switch FPU context for
 > > user-space threads that never use the FPU.
 > 
 > But doesn't this lazy scheme introduce the risk of unexpected latencies
 > for the first FPU usage of a RT task?

It does.

 > I mean, there is already the
 > information available if a task is going to use the FPU (via the flag),
 > then why not make use of it?

In the current situation, all user-space tasks have the XNFPU bit set,
because non real-time user-space tasks (including user-space real-time
tasks in secondary mode) may be preempted at a point where their FPU
context was used, so it must be switched when switching to another task
that has the XNFPU bit set. At nucleus level, FPU is switched
eagerly. At the lower, architecture dependent, level, where the XNFPU
bit is not available, switches for the user-space tasks that never used
FPU are avoided, at least for the x86 architecture.

What we could imagine, is to allow shadows to set or not the XNFPU bit,
meaning that the task would be allowed to use the FPU in primary mode,
whereas in secondary mode, it would always be allowed to use it. The
initialization of the FPU context would take place in xnshadow_map if
the XNFPU bit is set. But is it really meaningful for a task that is
always allowed to use FPU in secondary mode to be forbidden to use it in
primary mode ?

Besides, before such a change, I think we should improve the testsuite
by adding some context switching test, with an optional FPU switching
test. This is something I would like to do, once I get latency -t 1 to
work on SMP, I mean.

 > 
 > > 
 > > In case of an abnormal FPU fault, the message "invalid use of FPU" is
 > > printed on console.
 > > 
 > 
 > Yeah, I got this unfortunately only once: full alarm, both via kernel
 > message and SIGXCPU. So far I failed to reproduce it. I tested that
 > "normal" FPU usage for the first time does not trigger that warnings.
 > What may have caused this?

If a kernel task use the FPU without the XNFPU bit set, this error is
triggered. Every time this error was triggered in other cases, as of
today, there was a real bug.

-- 


					    Gilles Chanteperdrix.

