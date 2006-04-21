From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17480.63623.600656.828303@domain.hid>
Date: Fri, 21 Apr 2006 17:21:43 +0200
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
In-Reply-To: <4448B81E.3090605@domain.hid>
References: <4446B348.10403@domain.hid>
	<4448B81E.3090605@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > Jan Kiszka wrote:
 > > Hi,
 > > 
 > > this is an experimental hack to open the non-rt priority levels of Linux
 > > to Xenomai shadow threads, i.e. allow shadows to be scheduled under
 > > SCHED_NORMAL when in secondary mode. The scenario are typical borderline
 > > threads between RT and non-RT: they share a critical code path with RT
 > > threads, maybe mutex protected, but they are mostly time-sharing threads
 > > which do not need SCHED_FIFO for this.
 > > 
 > > The patch (be careful, quick-hack!) addresses the prio level 0 in the
 > > ipipe patch, the nucleus/shadow subsystem, and the native skin. A quick
 > > test with the attached demo showed the expected behaviour so far: no
 > > lock-up during busy-waiting in secondary mode, prio-boost when holding
 > > the lock (visible via /proc/xenomai/sched), no obvious side effects.
 > > 
 > > Any comments? Does this break other things in a subtle way?
 > 
 > An initial comment on the general usage of this extension: since the 
 > threads running in SCHED_OTHER/SCHED_NORMAL mode are expected to run 
 > non-RT workloads while still being able to use the RT infrastructure for 
 >   communicating with the rest of the RT system, I think that the best 
 > places for creating such hybrids are in the rt_task_shadow (native skin) 
 > and pthread_setschedparam (POSIX skin) calls, which would make it clear 
 > that a regular Linux thread is involved [and as such needs to be created 
 > by a normal call to pthread_create()], which also happens to benefit 
 > from the RT infrastructure mainly for communication/sychronization purpose.

What about keeping SCHED_RR as the default scheduling policy and
requiring users to manually select SCHED_NORMAL in thread creation
attributes in order to create hybrid threads with pthread_create ?

-- 


					    Gilles Chanteperdrix.

