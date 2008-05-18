MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18480.26021.866039.215082@domain.hid>
Date: Sun, 18 May 2008 19:21:41 +0200
In-Reply-To: <48305BE4.3040503@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<48305BE4.3040503@domain.hid>
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
 > > The two syscalls defined in the posix skin now moved to the sys skin, they are
 > > used in user-space by include/asm-generic/bits/bind.h and the new header
 > > include/asm-generic/bits/current.h. The global and process-specific shared heaps
 > > are now part of this patch.
 > >
 > 
 > Is there any reason why the nucleus should not implement a full-fledged "RT
 > futex" support, instead of a toolbox to build them? I'm concerned by skins
 > reinventing their own wheel uselessly to get to the same point at the end of the
 > day; e.g. cb_lock ops seem to me fairly generic when it comes to handling
 > futexes, so I would move them upstream one level more.
 > 

First of all, because I do not know much what a futex is, but from my
point of view it has very much to do with making threads wait in
kernel-space for a user-space change. By using kernel/user shared heaps,
we seem to be far from these considerations.

Now for the implementation of user-space mutexes per-se, apart from the
xnarch_atomic_ operations, I think every skin will have its own
tradeoffs. For instance, the "cb_lock" thing is itself a tradeoff, it
sacrifices a bit of performance by making a mutex lock operation use
three atomic operations instead of only one for the sake of safely
getting a correct value of the mapped memory pointer. Besides, it works
well with the posix skin, because the posix specification allows
pthread_mutex_destroy to return an error if a mutex is currently in
use. Currently, the native skin mutex destruction operation is
successful even if the mutex is currently in use (the owner does not get
any notification, simply its unlock operation will fail, and waiters
receive an -EIDRM error). So, I would guess the native skin will have to
use something else than cb_lock.

 > In that respect, talking about "semaphore heaps" at nucleus level looks a bit of
 > a misnomer: if we mostly bring a service to map non-cacheable memory to
 > user-space, then we don't actually provide semaphore support.

It was only a name making clear to the user what the heaps will be used
for... I imagine people having to configure yet another heap size in
kernel configuration and wondering what this heap will be used for.

-- 


					    Gilles.

