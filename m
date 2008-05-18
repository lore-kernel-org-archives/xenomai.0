MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18480.45872.449093.746718@domain.hid>
Date: Mon, 19 May 2008 00:52:32 +0200
In-Reply-To: <4830A50D.8040507@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<48305BE4.3040503@domain.hid>
	<18480.30551.499645.920690@domain.hid>
	<48307F0A.5040206@domain.hid>
	<18480.34204.426031.862047@domain.hid>
	<4830A50D.8040507@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Patch 5/7] Define new syscalls for the system
 skin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > As far as I understood, the user-space atomic operations, used to
 > > acquire a free mutex in user-space, are not part of the futex API. In
 > > our case, we are using xnarch_atomic_* operations to implement portably
 > > this user-space locking stuff. I think that even setting the bit saying
 > > that the mutex is currently owned is done in pthread_mutexes
 > > implementation, not in the Futex API.
 > 
 > I would fully agree if the futex API did not define PI-based ops, which are
 > needed for proper real-time operations from userland. You will certainly agree
 > that PI implies that some kind of ownership exists; and because there can't be
 > more than a single owner in that case, you end up with an object that can't be
 > held by more than a single task. So you do have a mutex in disguise, whatever
 > the way to keep its state is (a bit, an integer, whatever). So there is stronger
 > semantics attached to that API than to simply manage an event notification scheme.
 > 
 >  Now, what remains is
 > > sys_futex(FUTEX_WAIT) and sys_futex(FUTEX_WAKE), this terribly looks like
 > > xnsync_sleep_on and xnsynch_wakeup_one_sleeper.
 > > 
 > 
 > Yes, here again I partially agree, except for a significant issue: xnsynch is a
 > stateless object (that's why we can use it for different syncobjs which are
 > totally unrelated in their semantics - mutex, queue, region, counting sems,
 > whatever). I was just wondering if we could make the *tex thingy a bit more
 > stateful to ease the job for the skins, just in case we would use it for mutexes
 > only. I have no immediate answer to this question, just asking -- this is my
 > contribution as a senior member of the peanut gallery.

We can certainly implement an abstraction managing xnarch_atomic_t +
xnsynch_t, however, it seems that we would have to re-factor all
mutex/semaphores implementations to use this new abstraction. The
current approach is to add an xnarch_atomic_cmpxchg in user-space, and
fall back to an almost unchanged kernel-space support when it fails.

 > 
 > >  > 
 > >  >  I feel this
 > >  > > would complicate things: currently, the way I implemented user-space
 > >  > > mutexes for the posix skin kept the old association between the
 > >  > > user-space mutex, and its kernel-space companion, also used by
 > >  > > kernel-space operations.
 > >  > > 
 > >  > 
 > >  > My concern boils down to: how much of the POSIX implementation, beyond the
 > >  > cb_lock stuff, would have to be duplicated to get the same support ported to,
 > >  > say the VxWorks semM services?
 > > 
 > > The initialization code, and the additional calls to
 > > xnarch_atomic_cmpxchg in user-space. If xnarch_atomic_cmpxchg fails we
 > > call kernel-space, which is mostly unchanged.
 > > 
 > > Because of the cb_lock stuff, I also needed to implement the
 > > kernel-space syscalls in two versions: one if user-space has
 > > xnarch_atomic_cmpxchg and could lock the mutex control block, the other
 > > if the mutex control block needs to be locked by kernel-space.
 > > 
 > 
 > This is the part my laziness would very much like to factor as much as possible.
 > If ever possible.

The current implementation is more or less:

/* Common generic function */
pse51_mutex_thing_inner(mutex)
{
    /*... Assume mutex cb is locked ... */
}

/* Kernel-space operation */
pthread_mutex_thing(mutex)
{
     cb_trylock(mutex->lock);
  
     pse51_mutex_thing_inner(mutex);

     cb_unlock(mutex->lock);
}

/* syscall wrapper */
#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
__pthread_mutex_thing()
{
     copy_from_user();

     pse51_mutex_thing_inner(mutex)

     copy_to_user();
}
#else
__pthread_mutex_thing()
{
     copy_from_user();

     pthread_mutex_thing(mutex)

     copy_to_user();
}
#endif


-- 


					    Gilles.

