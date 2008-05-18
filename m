MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18480.34204.426031.862047@domain.hid>
Date: Sun, 18 May 2008 21:38:04 +0200
In-Reply-To: <48307F0A.5040206@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<48305BE4.3040503@domain.hid>
	<18480.30551.499645.920690@domain.hid>
	<48307F0A.5040206@domain.hid>
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
 > > Philippe Gerum wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > > The two syscalls defined in the posix skin now moved to the sys skin, they are
 > >  > > used in user-space by include/asm-generic/bits/bind.h and the new header
 > >  > > include/asm-generic/bits/current.h. The global and process-specific shared heaps
 > >  > > are now part of this patch.
 > >  > >
 > >  > 
 > >  > Is there any reason why the nucleus should not implement a full-fledged "RT
 > >  > futex" support, instead of a toolbox to build them? I'm concerned by skins
 > >  > reinventing their own wheel uselessly to get to the same point at the end of the
 > >  > day; e.g. cb_lock ops seem to me fairly generic when it comes to handling
 > >  > futexes, so I would move them upstream one level more.
 > >  > 
 > >  > In that respect, talking about "semaphore heaps" at nucleus level looks a bit of
 > >  > a misnomer: if we mostly bring a service to map non-cacheable memory to
 > >  > user-space, then we don't actually provide semaphore support.
 > > 
 > > If I understand correctly, a futex is, in xenomai terms, a way to
 > > associate a user-space address, with an xnsynch object.
 > 
 > I would specialize it more actually so that it really resembles the vanilla
 > futex support, i.e. a basic object implementing the required operations to
 > provide mutually exclusive access, working on a pinned memory area shared
 > between kernel and userland. AFAICS, the current patchset implements the pinned
 > memory support in the nucleus, but not the operations, which remain a per-skin
 > issue.

As far as I understood, the user-space atomic operations, used to
acquire a free mutex in user-space, are not part of the futex API. In
our case, we are using xnarch_atomic_* operations to implement portably
this user-space locking stuff. I think that even setting the bit saying
that the mutex is currently owned is done in pthread_mutexes
implementation, not in the Futex API. Now, what remains is
sys_futex(FUTEX_WAIT) and sys_futex(FUTEX_WAKE), this terribly looks like
xnsync_sleep_on and xnsynch_wakeup_one_sleeper.

 > 
 >  I feel this
 > > would complicate things: currently, the way I implemented user-space
 > > mutexes for the posix skin kept the old association between the
 > > user-space mutex, and its kernel-space companion, also used by
 > > kernel-space operations.
 > > 
 > 
 > My concern boils down to: how much of the POSIX implementation, beyond the
 > cb_lock stuff, would have to be duplicated to get the same support ported to,
 > say the VxWorks semM services?

The initialization code, and the additional calls to
xnarch_atomic_cmpxchg in user-space. If xnarch_atomic_cmpxchg fails we
call kernel-space, which is mostly unchanged.

Because of the cb_lock stuff, I also needed to implement the
kernel-space syscalls in two versions: one if user-space has
xnarch_atomic_cmpxchg and could lock the mutex control block, the other
if the mutex control block needs to be locked by kernel-space.

-- 


					    Gilles.

