References: <006f01d35237$eedce810$cc96b830$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b10550b6-327a-73da-03e6-f5f88507feb4@xenomai.org>
Date: Wed, 1 Nov 2017 21:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <006f01d35237$eedce810$cc96b830$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] ipipe + preempt_rt : spinlock issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Perles?= <cperles@sepro-group.com>, xenomai@xenomai.org

On 10/31/2017 12:03 PM, Cédric Perles wrote:
> Hi,
> 
> 
> 
> I’m working on an iMX6 based board with NXP kernel 4.1.15.
> 
> I made a Xenomai 3.0.5/ipipe bsp that works well and I also made a
> preempt-rt bsp that works well too.
> 
> 
> 
> However, now I would like to make a Xenomai/ipipe + preempt_rt bsp.
> 
> 
> 
> I adapted preempt_rt patch to fit to ipipe patched kernel but during
> compilation I’m facing issues concerning spinlocks:
> 
> 
> 
> drivers/gpio/gpio-generic.c:496:2: note: in expansion of macro
> 'spin_lock_init'
> 
>   spin_lock_init(&bgc->lock);
> 
>   ^
> 
> include/linux/spinlock_rt.h:17:24: error: '__ipipe_spinlock_t {aka struct
> <anonymous>}' has no member named 'lock'
> 
>   rt_mutex_init(&(slock)->lock);   \
> 
> 

gpio-generic should use raw spinlock accessors (e.g. spin_lock_init ->
raw_spin_lock_init()).

> 
> 
> 
> Searching some help on internet, I realized that only a few people tried
> to use both Xenomai and Preempt-rt.
> 
> => Is it an heresy ? if so, Why ?
> 

Not particularly.

> I thought it was the best way to limit preemption for the tasks that
> switched temporarily to secondary mode.
> 
>

That may not be the best reason to use such combo, i.e. if this is about
papering over issues caused by dual kernel's rt threads escaping the
proper runtime mode. Those threads should not do that in the first place.

A legitimate reason to use such combo is rather to have different
classes of rt requirements in a single application, which are best
served by combined approaches.

> 
> => If it is not a stupid idea, did somebody already resolve this kind of
> conflict ?

Yes, this may seem daunting at first, but there are usually only a few
of them, almost only in include/spinlock*. Conflicts in sched/core may
be a bit trickier to address though, but they don't appear frequently.

> and how ?
> 
> 
Well, just as you are doing: making sense of the changes, and figuring
out how to fix the few conflicts.

-- 
Philippe.

