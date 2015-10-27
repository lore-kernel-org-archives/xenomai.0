From: Vasudev Kamath <vasudev@copyninja.info>
Date: Tue, 27 Oct 2015 11:46:03 +0530
Message-ID: <877fm8x2e4.fsf@copyninja.info>
References: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>
 <53832095.10901@xenomai.org> <loom.20151027T063128-689@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Using Preempt RT with I-Pipe/Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Vasudev Kamath <vasudev@copyninja.info> writes:

> After the patch Kernel did compile, though I've not tested the compiled
> kernel yet. Since I've no idea if what I've done is correct or not I would
> be happy to get some review on this patch from you or fellow Xenomai folks.
>

Err correction, it looks like there are still errors but compilation
didn't stop on errors. Currently I saw following error.

kernel/locking/rtmutex.c: In function _rt_mutex_adjust_prio_chain_:
kernel/locking/rtmutex.c:459:969: error: _spinlock_t_ has no member named _rlock_
kernel/locking/rtmutex.c: In function _rt_spin_lock_slowunlock_hirq_:
kernel/locking/rtmutex.c:1081:971: error: _spinlock_t_ has no member named _rlock_
kernel/locking/rtmutex.c: In function _rt_mutex_slowtrylock_:
kernel/locking/rtmutex.c:1473:969: error: _spinlock_t_ has no member named _rlock_

Will be looking at code now. But it looks like fixing this might be
beyond my expertise. I wonder if Christoph managed to compile kernel
from his side.

Cheers,


