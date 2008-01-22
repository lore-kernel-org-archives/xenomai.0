MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18326.27253.195417.564986@domain.hid>
Date: Tue, 22 Jan 2008 23:13:09 +0100
In-Reply-To: <4796643D.7010208@domain.hid>
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
	<18326.21459.333811.155772@domain.hid>
	<4796643D.7010208@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Gilles Chanteperdrix wrote:
 > >  > Hi,
 > >  > 
 > >  > after some (unsuccessful) time trying to instrument the code in a way
 > >  > that does not change the latency results completely, I found the
 > >  > reason for the high latency with latency -t 1 and latency -t 2 on ARM.
 > >  > So, here comes an update on this issue. The culprit is the user-space
 > >  > context switch, which flushes the processor cache with the nklock
 > >  > locked, irqs off.
 > >  > 
 > >  > There are two things we could do:
 > >  > - arrange for the ARM cache flush to happen with the nklock unlocked
 > >  > and irqs enabled. This will improve interrupt latency (latency -t 2)
 > >  > but obviously not scheduling latency (latency -t 1). If we go that
 > >  > way, there are several problems we should solve:
 > >  > 
 > >  > we do not want interrupt handlers to reenter xnpod_schedule(), for
 > >  > this we can use the XNLOCK bit, set on whatever is
 > >  > xnpod_current_thread() when the cache flush occurs
 > >  > 
 > >  > since the interrupt handler may modify the rescheduling bits, we need
 > >  > to test these bits in xnpod_schedule() epilogue and restart
 > >  > xnpod_schedule() if need be
 > >  > 
 > >  > we do not want xnpod_delete_thread() to delete one of the two threads
 > >  > involved in the context switch, for this the only solution I found is
 > >  > to add a bit to the thread mask meaning that the thread is currently
 > >  > switching, and to (re)test the XNZOMBIE bit in xnpod_schedule epilogue
 > >  > to delete whatever thread was marked for deletion
 > >  > 
 > >  > in case of migration with xnpod_migrate_thread, we do not want
 > >  > xnpod_schedule() on the target CPU to switch to the migrated thread
 > >  > before the context switch on the source CPU is finished, for this we
 > >  > can avoid setting the resched bit in xnpod_migrate_thread(), detect
 > >  > the condition in xnpod_schedule() epilogue and set the rescheduling
 > >  > bits so that xnpod_schedule is restarted and send the IPI to the
 > >  > target CPU.
 > > 
 > > Please find attached a patch implementing these ideas. This adds some
 > > clutter, which I would be happy to reduce. Better ideas are welcome.
 > > 
 > 
 > I tried to cross-read the patch (-p would have been nice) but failed - 
 > this needs to be applied on some tree. Does the patch improve ARM 
 > latencies already?

I split the patch in two parts in another post, this should make it
easier to read.

 > 
 > > 
 > >  > 
 > >  > - avoid using user-space real-time tasks when running latency
 > >  > kernel-space benches, i.e. at least in the latency -t 1 and latency -t
 > >  > 2 case. This means that we should change the timerbench driver. There
 > >  > are at least two ways of doing this:
 > >  > use an rt_pipe
 > >  >  modify the timerbench driver to implement only the nrt ioctl, using
 > >  > vanilla linux services such as wait_event and wake_up.
 > >  > 
 > >  > What do you think ?
 > > 
 > > So, what do you thing is the best way to change the timerbench driver,
 > > * use an rt_pipe ? Pros: allows to run latency -t 1 and latency -t 2 even
 > >  if Xenomai is compiled with CONFIG_XENO_OPT_PERVASIVE off; cons: make
 > >  the timerbench non portable on other implementations of rtdm, eg. rtdm
 > >  over rtai or the version of rtdm which runs over vanilla linux
 > > * modify the timerbecn driver to implement only nrt ioctls ? Pros:
 > >   better driver portability; cons: latency would still need
 > >   CONFIG_XENO_OPT_PERVASIVE to run latency -t 1 and latency -t 2.
 > 
 > I'm still voting for my third approach:
 > 
 >   -> Write latency as kernel application (klatency) against the
 >      timerbench device
 >   -> Call NRT IOCTLs of timerbench during module init/cleanup
 >   -> Use module parameters for customization
 >   -> Setup a low-prio kernel-based RT task to issue the RT IOCTLs
 >   -> Format the results nicely (similar to userland latency) in that RT
 >      task and stuff them into some rtpipe
 >   -> Use "cat /dev/rtpipeX" to display the results

Sorry this mail is older than your last reply to my question. I had
problems with my MTA, so I resent all the mail which were not sent, I
hoped they would be sent with their original date preserved, but
unfortunately, this is not the case.

Now, to answer your suggestion, I think that formating the results
belongs to user-space, not to kernel-space. Besides, emitting NRT ioctls
from module initialization and cleanup routines make this klatency
module quite inflexible. I was rather thinking about implementing the RT
versions of the IOCTLS so that they could be called from a kernel space
real-time task.

-- 


					    Gilles Chanteperdrix.

