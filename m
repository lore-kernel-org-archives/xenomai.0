Date: Sat, 27 Jun 2015 12:03:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150627100331.GB9756@hermes.click-hack.org>
References: <E1Z8UN2-0004n4-Gc@sd-51317.xenomai.org>
 <20150626160109.GA8276@hermes.click-hack.org>
 <558DB351.8090804@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <558DB351.8090804@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Fix locking
 for xnthread info manipulations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai-git@xenomai.org, xenomai@xenomai.org

On Fri, Jun 26, 2015 at 10:17:21PM +0200, Jan Kiszka wrote:
> On 2015-06-26 18:01, Gilles Chanteperdrix wrote:
> > On Fri, Jun 26, 2015 at 04:12:44PM +0200, git repository hosting wrote:
> >> Module: xenomai-jki
> >> Branch: for-forge
> >> Commit: 67a64e164b737759cc171d3b04b05770e1450cb6
> >> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=67a64e164b737759cc171d3b04b05770e1450cb6
> >>
> >> Author: Jan Kiszka <jan.kiszka@siemens.com>
> >> Date:   Fri Jun 26 15:11:42 2015 +0200
> >>
> >> cobalt/kernel: Fix locking for xnthread info manipulations
> >>
> >> nklock must be held when manipulating bits of xnthread::info. Not all
> >> callsites of xnthread_set/clear_info follow this rule so far, directly
> >> or indirectly, fix them (and possibly some other races along this).
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> ---
> >>
> >>  include/cobalt/kernel/rtdm/driver.h |    8 ++++----
> >>  kernel/cobalt/posix/syscall.c       |    5 +++++
> >>  kernel/cobalt/synch.c               |    2 ++
> >>  kernel/cobalt/thread.c              |    5 +++++
> >>  4 files changed, 16 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> >> index c14198b..de476ca 100644
> >> --- a/include/cobalt/kernel/rtdm/driver.h
> >> +++ b/include/cobalt/kernel/rtdm/driver.h
> >> @@ -553,7 +553,7 @@ static inline void rtdm_lock_get(rtdm_lock_t *lock)
> >>  {
> >>  	XENO_BUG_ON(COBALT, !spltest());
> >>  	spin_lock(lock);
> >> -	__xnsched_lock();
> >> +	xnsched_lock();
> >>  }
> >>  
> >>  /**
> >> @@ -566,7 +566,7 @@ static inline void rtdm_lock_get(rtdm_lock_t *lock)
> >>  static inline void rtdm_lock_put(rtdm_lock_t *lock)
> >>  {
> >>  	spin_unlock(lock);
> >> -	__xnsched_unlock();
> >> +	xnsched_unlock();
> >>  }
> >>  
> >>  /**
> >> @@ -584,7 +584,7 @@ static inline rtdm_lockctx_t __rtdm_lock_get_irqsave(rtdm_lock_t *lock)
> >>  
> >>  	context = ipipe_test_and_stall_head();
> >>  	spin_lock(lock);
> >> -	__xnsched_lock();
> >> +	xnsched_lock();
> >>  
> >>  	return context;
> >>  }
> >> @@ -603,7 +603,7 @@ static inline
> >>  void rtdm_lock_put_irqrestore(rtdm_lock_t *lock, rtdm_lockctx_t context)
> >>  {
> >>  	spin_unlock(lock);
> >> -	__xnsched_unlock();
> >> +	xnsched_unlock();
> >>  	ipipe_restore_head(context);
> >>  }
> > 
> > These changes are not without risk: is not there a risk of deadlock
> > if one thread calls rtdm_lock_get without holding the nklock and
> > another calls it while holding it?
> 
> That could happen, although the "normal" pattern does not involve
> explicit nklock acquisition if nesting is used, rather rtdm_lock before
> calling nklock-acquiring services. Not a reasonable ordering either, but
> common practice now.
> 
> We could also try to rework the whole scheduler lock so that it avoids
> unsafe thread fields, ideally converting it to something more
> lightweight as Linux' preempt_disable/enable().
> 
> BTW, xnsched has those two types of flags fields: status requires
> nklock, lflags must only be locally modified, thus are fine with
> interrupt disabling as protection.

the sched lock uses lflags. The only point where we need to know
that a thread had the scheduler lock, is when it is switched in
after having voluntarily suspended. So, maybe a solution would be to
set that state bit only when a thread with the scheduler lock
voluntarily suspends. That would make the scheduler lock quite
lightweight (refcount + scheduler lflags bit).

-- 
					    Gilles.
https://click-hack.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150627/a5c80cd2/attachment.sig>
