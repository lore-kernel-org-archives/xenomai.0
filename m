Message-ID: <478F30FB.8060501@domain.hid>
Date: Thu, 17 Jan 2008 11:42:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
In-Reply-To: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] High latencies on ARM.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> after some (unsuccessful) time trying to instrument the code in a way
> that does not change the latency results completely, I found the
> reason for the high latency with latency -t 1 and latency -t 2 on ARM.
> So, here comes an update on this issue. The culprit is the user-space
> context switch, which flushes the processor cache with the nklock
> locked, irqs off.
> 
> There are two things we could do:
> - arrange for the ARM cache flush to happen with the nklock unlocked
> and irqs enabled. This will improve interrupt latency (latency -t 2)
> but obviously not scheduling latency (latency -t 1). If we go that
> way, there are several problems we should solve:
> 
> we do not want interrupt handlers to reenter xnpod_schedule(), for
> this we can use the XNLOCK bit, set on whatever is
> xnpod_current_thread() when the cache flush occurs
> 
> since the interrupt handler may modify the rescheduling bits, we need
> to test these bits in xnpod_schedule() epilogue and restart
> xnpod_schedule() if need be
> 
> we do not want xnpod_delete_thread() to delete one of the two threads
> involved in the context switch, for this the only solution I found is
> to add a bit to the thread mask meaning that the thread is currently
> switching, and to (re)test the XNZOMBIE bit in xnpod_schedule epilogue
> to delete whatever thread was marked for deletion
> 
> in case of migration with xnpod_migrate_thread, we do not want
> xnpod_schedule() on the target CPU to switch to the migrated thread
> before the context switch on the source CPU is finished, for this we
> can avoid setting the resched bit in xnpod_migrate_thread(), detect
> the condition in xnpod_schedule() epilogue and set the rescheduling
> bits so that xnpod_schedule is restarted and send the IPI to the
> target CPU.
> 
> - avoid using user-space real-time tasks when running latency
> kernel-space benches, i.e. at least in the latency -t 1 and latency -t
> 2 case. This means that we should change the timerbench driver. There
> are at least two ways of doing this:
> use an rt_pipe
>  modify the timerbench driver to implement only the nrt ioctl, using
> vanilla linux services such as wait_event and wake_up.

[As you reminded me of this unanswered question:]
One may consider adding further modes _besides_ current kernel tests
that do not rely on RTDM & native userland support (e.g. when
CONFIG_XENO_OPT_PERVASIVE is disabled). But the current tests are valid
scenarios as well that must not be killed by such a change.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

