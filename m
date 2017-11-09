From: =?utf-8?Q?C=C3=A9dric_Perles?= <cperles@sepro-group.com>
References: <006f01d35237$eedce810$cc96b830$@sepro-group.com>
 <b10550b6-327a-73da-03e6-f5f88507feb4@xenomai.org>
In-Reply-To: <b10550b6-327a-73da-03e6-f5f88507feb4@xenomai.org>
Date: Thu, 9 Nov 2017 10:53:49 +0100 (CET)
Message-ID: <02fe01d35940$a499acb0$edcd0610$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe + preempt_rt : spinlock issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Hi Philippe,

Thank's for your answere.
Replacing spin lock calls by equivalent raw spin lock in gpio_generic did=
=20
the trick.

Thank's a lot.

C=C3=A9dric


-----Message d'origine-----
De : Philippe Gerum [mailto:rpm@xenomai.org]
Envoy=C3=A9 : mercredi 1 novembre 2017 21:57
=C3=80 : C=C3=A9dric Perles; xenomai@xenomai.org
Objet : Re: [Xenomai] ipipe + preempt_rt : spinlock issue

On 10/31/2017 12:03 PM, C=C3=A9dric Perles wrote:
> Hi,
>
>
>
> I=E2=80=99m working on an iMX6 based board with NXP kernel 4.1.15.
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
> compilation I=E2=80=99m facing issues concerning spinlocks:
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
> include/linux/spinlock_rt.h:17:24: error: '__ipipe_spinlock_t {aka
> struct <anonymous>}' has no member named 'lock'
>
>   rt_mutex_init(&(slock)->lock);   \
>
>

gpio-generic should use raw spinlock accessors (e.g. spin_lock_init ->=20
raw_spin_lock_init()).

>
>
>
> Searching some help on internet, I realized that only a few people
> tried to use both Xenomai and Preempt-rt.
>
> =3D> Is it an heresy ? if so, Why ?
>

Not particularly.

> I thought it was the best way to limit preemption for the tasks that
> switched temporarily to secondary mode.
>
>

That may not be the best reason to use such combo, i.e. if this is about=20
papering over issues caused by dual kernel's rt threads escaping the prop=
er=20
runtime mode. Those threads should not do that in the first place.

A legitimate reason to use such combo is rather to have different classes=
 of=20
rt requirements in a single application, which are best served by combine=
d=20
approaches.

>
> =3D> If it is not a stupid idea, did somebody already resolve this kind
> of conflict ?

Yes, this may seem daunting at first, but there are usually only a few of=
=20
them, almost only in include/spinlock*. Conflicts in sched/core may be a =
bit=20
trickier to address though, but they don't appear frequently.

> and how ?
>
>
Well, just as you are doing: making sense of the changes, and figuring ou=
t=20
how to fix the few conflicts.

--
Philippe.

