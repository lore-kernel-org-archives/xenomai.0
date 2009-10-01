From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC2448B.1080500@domain.hid>
References: <4AC2448B.1080500@domain.hid>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 13:32:45 +0200
Message-Id: <1254396765.2703.234.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2009-09-29 at 19:31 +0200, Gilles Chanteperdrix wrote:
> Hi guys,
> 
> full of energy after this tremendous first XUM,

Agreed, thanks to the DENX folks for having thought of it in the first
place, and organized it nicely.

>  I would like to start a
> discussion about what people would like to see in the 2.5 branch.
> 

Jan has described the situation quite accurately already, regarding the
trade-off between getting everything we want into 2.5 so that no 2.6 is
required, and releasing the too long-awaited 2.5 asap.

As you mentioned already, the key issue is ABI stability.
Any change we want before 3.0 that breaks the ABI should preferably go
to 2.5, so that we don't end up maintaining 2.5.x, 2.6.x and 3.x. At any
rate, we could not afford the latter anyway. This is a different matter
than API issues; we already allowed API extensions during a stable
cycle, provided they do not break existing application code (except in
emergency cases), so I see no problem in pushing a few more services to
2.5.1 and beyond, provided that condition is met.

> Here is a first list, please feel free to criticize it:
> - signals in primary domain (something that we almost forgot)

Yes, this one must be in. At least, we should break the ABI one more
time for this before releasing 2.5.0. This item has priority #1 for
me, since providing that infrastructure will enable a series of
additional services to be implemented properly. In fact, this is more a
matter of allowing nucleus callouts to user-space than anything else;
POSIX RT signals in full primary mode being an application of them.

> - xnsynch_acquire using atomic_cmpxchg unconditionally (no #ifdefs)

This may wait for 2.5.1 and beyond. This is mainly a cosmetic fix for
developers and has no impact on the ABI; we can live with some #ifdef
hell a few months more.

> - statistics of all mapped named heaps in /proc/xenomai/heap

This can wait as well, albeit this is indeed a desirable feature. I
would even export all kind of heaps, since some RTDM drivers like RTIPC
create local heaps, and being able to get their status is very helpful.
It all depends on whether some of us has too much free time in the
coming weeks to make this available in 2.5.0 or later.

> - unwapped access to user-space posix skin methods

I guess that you want to allow people to write/port regular POSIX apps
mostly based on libpthread, and explicitely using libpthread_rt calls
when needed, without any wrapping, which is fair enough, since this may
be easier for merging Xenomai support into hairy legacy code. However,
this can definitely wait after 2.5.0 is out, since this should be a pure
add-on.

> - fast semaphores in user-space

I would rather wait for 3.0, definitely. To do that properly, we would
likely need to share code with the fast mutexes, and I don't think it
would be wise to risk any regression for the latter at that point in the
release cycle. Additionally, I see no absolute urge in terms of
performances to make this feature available; fast mutexes were much more
critical in this respect.

> - syscall-less select ?
> 

Do we really need this? Normally, the typical usage pattern is likely to
be:

for (;;) {
	[rtdm_]select(...);
	<process all pending requests on all active fildes>
}

Which means that once we have fully processed a select() event, we
should not have any pending events anymore, unless in very, very rare
cases where a new notification arrives before the end of processing, and
the point where rtdm_select() puts us to sleep if it sees no active
fildes for us.

I don't see such situation happening that often, otherwise we would
likely have a CPU bandwidth issue down the road, spending most of our
time in a busy loop in primary mode.

So, basically, we would most likely block at least once to get the first
event in a series, then process all reasons for that event to be pending
directly from user-space, hence clearing the reason to be notified
entirely. Testing whether there is a pending event directly from
user-space does not seem that urgent in that case.

> Actually, there are already a lot of things.
> So, what do you think?
> 

I think that we should focus on rolling out 2.5.0 asap.

-- 
Philippe.



