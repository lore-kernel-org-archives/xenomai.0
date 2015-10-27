From: Vasudev Kamath <vasudev@copyninja.info>
Date: Tue, 27 Oct 2015 16:37:31 +0530
Message-ID: <87si4wvabw.fsf@copyninja.info>
References: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>
 <53832095.10901@xenomai.org> <loom.20151027T063128-689@post.gmane.org>
 <877fm8x2e4.fsf@copyninja.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
>
> Err correction, it looks like there are still errors but compilation
> didn't stop on errors. Currently I saw following error.
>
> kernel/locking/rtmutex.c: In function _rt_mutex_adjust_prio_chain_:
> kernel/locking/rtmutex.c:459:969: error: _spinlock_t_ has no member named _rlock_
> kernel/locking/rtmutex.c: In function _rt_spin_lock_slowunlock_hirq_:
> kernel/locking/rtmutex.c:1081:971: error: _spinlock_t_ has no member named _rlock_
> kernel/locking/rtmutex.c: In function _rt_mutex_slowtrylock_:
> kernel/locking/rtmutex.c:1473:969: error: _spinlock_t_ has no member named _rlock_
>
> Will be looking at code now. But it looks like fixing this might be
> beyond my expertise. I wonder if Christoph managed to compile kernel
> from his side.

OK I did manage to get the compilation fixed, of course with my naive
approach. I'm attaching updated patch with this email.

I tried booting into resulting kernel, but ended up having kernel panic,
attaching screen shot for reference.

So it clearly means I've done something wrong when patching
ipipe_lock.h. I would be thankful to any one who can help me with
getting this patch working.

Thanks in Advance,

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe_lock_rtpreempt.patch
Type: text/x-diff
Size: 4343 bytes
Desc: ipipe_lock patch to work with rt_preempt
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151027/632cb155/attachment.patch>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 20151027_001.jpg
Type: image/jpeg
Size: 917100 bytes
Desc: kernel panic with rt_preempt xenomai patch
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151027/632cb155/attachment.jpg>
