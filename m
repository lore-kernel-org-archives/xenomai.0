Message-ID: <2ff1a98a0805190616v662c22ddgd63382221d721c8e@domain.hid>
Date: Mon, 19 May 2008 15:16:35 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <483178FC.1010300@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18459.38249.462320.715909@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<48305BE4.3040503@domain.hid>
	<18480.30551.499645.920690@domain.hid>
	<48307F0A.5040206@domain.hid>
	<18480.34204.426031.862047@domain.hid>
	<4830A50D.8040507@domain.hid>
	<18480.45872.449093.746718@domain.hid>
	<483178FC.1010300@domain.hid>
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

On Mon, May 19, 2008 at 2:56 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > Gilles Chanteperdrix wrote:
>>  > > As far as I understood, the user-space atomic operations, used to
>>  > > acquire a free mutex in user-space, are not part of the futex API. In
>>  > > our case, we are using xnarch_atomic_* operations to implement portably
>>  > > this user-space locking stuff. I think that even setting the bit saying
>>  > > that the mutex is currently owned is done in pthread_mutexes
>>  > > implementation, not in the Futex API.
>>  >
>>  > I would fully agree if the futex API did not define PI-based ops, which are
>>  > needed for proper real-time operations from userland. You will certainly agree
>>  > that PI implies that some kind of ownership exists; and because there can't be
>>  > more than a single owner in that case, you end up with an object that can't be
>>  > held by more than a single task. So you do have a mutex in disguise, whatever
>>  > the way to keep its state is (a bit, an integer, whatever). So there is stronger
>>  > semantics attached to that API than to simply manage an event notification scheme.
>>  >
>>  >  Now, what remains is
>>  > > sys_futex(FUTEX_WAIT) and sys_futex(FUTEX_WAKE), this terribly looks like
>>  > > xnsync_sleep_on and xnsynch_wakeup_one_sleeper.
>>  > >
>>  >
>>  > Yes, here again I partially agree, except for a significant issue: xnsynch is a
>>  > stateless object (that's why we can use it for different syncobjs which are
>>  > totally unrelated in their semantics - mutex, queue, region, counting sems,
>>  > whatever). I was just wondering if we could make the *tex thingy a bit more
>>  > stateful to ease the job for the skins, just in case we would use it for mutexes
>>  > only. I have no immediate answer to this question, just asking -- this is my
>>  > contribution as a senior member of the peanut gallery.
>>
>> We can certainly implement an abstraction managing xnarch_atomic_t +
>> xnsynch_t, however, it seems that we would have to re-factor all
>> mutex/semaphores implementations to use this new abstraction. The
>> current approach is to add an xnarch_atomic_cmpxchg in user-space, and
>> fall back to an almost unchanged kernel-space support when it fails.
>>
>
> Ok. Let's merge this as it is. Common code will emerge eventually if it happens
> to make sense when plugging the feature into the native and VxWorks mutex support.

Ok. I need a few more days though, to adapt it to other architectures than arm.

-- 
 Gilles

