MIME-Version: 1.0
References: <CAFc1U0sBsAvi3Spz6+9ExCr1gpkB81BTjVC31G84WKyfbwPBmg@mail.gmail.com>
 <15646031-7d6c-2e9b-2ed7-0cee06a2d149@siemens.com>
 <CAFc1U0t6ggrybDhz1BpHNXq5iJC9nemDL4cxv+eqswyzC3zoJw@mail.gmail.com>
 <f8cb47b5-bfd1-cc7e-9d42-0243d31caf0a@siemens.com>
 <CAFc1U0sU1ZjGi5eFR-gjCdSbGGNqNOTpO5HVDNY8iNs+pa627Q@mail.gmail.com>
 <fad7d3e1-5958-54ec-6bf9-c069a23379cb@siemens.com>
In-Reply-To: <fad7d3e1-5958-54ec-6bf9-c069a23379cb@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 30 Sep 2019 17:12:58 +0200
Message-ID: <CAFc1U0v1WUTsPQP9xDPT9gkgU-p+ALQV64aPzOqhsAADqCsVbw@mail.gmail.com>
Subject: Re: Problem with _rt / _nrt functions in Xeno 3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

How can I think of read/write as ioctl? very different parameters...

Le lun. 30 sept. 2019 =C3=A0 16:44, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :

> On 30.09.19 16:15, Pierre FICHEUX wrote:
> > Hi Jan,
> >
> > Actually it was  "clear" for me after reading some examples such
> > as kernel/drivers/testing/rtdmtest.c.
>
> OK, that's good to hear.
>
> >
> > Btw examples deal only with ioctl and I don't understand how it could
> work for
> > read/write (any example around??).
> >
>
> Other handlers are actually a simple case of IOCTLs: Think of them as an
> IOCTL
> handler which only accepts a single code, identical on both entry paths.
>
> Jan
>
> > regards
> >
> >
> >
> > Le lun. 23 sept. 2019 =C3=A0 15:10, Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> a =C3=A9crit :
> >
> >     On 20.09.19 16:23, Pierre FICHEUX wrote:
> >      > Thx for the answer bu I don't understand the first sentence
> (because of
> >     my  bad
> >      > english :))
> >      >
> >      > What dou you mean with "Xenomai 3 prefers the RT patch of a RTDM
> callback
> >     over
> >      > the NRT if the caller is
> >      > a real-time task." ? What is a "patch of RTDM callback" ??
> >
> >     I actually have to correct myself: Since "cobalt/syscalls: allow fo=
r
> handing
> >     over mode selection to syscall handlers" (predates v3.0.3), RTDM
> entry points
> >     are supposed to have to original behavior again (call driver handle=
r
> >     corresponding to current caller mode first, then switch if handler
> returns
> >     -ENOSYS).
> >
> >     Maybe we need to look into your concrete case again if something
> else changes
> >     the migration pattern.
> >
> >     Jan
> >
> >      >
> >      > Le ven. 20 sept. 2019 =C3=A0 15:45, Jan Kiszka <jan.kiszka@sieme=
ns.com
> >     <mailto:jan.kiszka@siemens.com>
> >      > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>>
> a =C3=A9crit :
> >      >
> >      >     On 20.09.19 15:34, Pierre FICHEUX via Xenomai wrote:
> >      >      > Hi all,
> >      >      >
> >      >      > I've been using RTDM _rt / _nrt functions for a long time
> with Xenomai
> >      >      > 2.6.x but it seems not to work (the same way ?) with
> Xenomai 3
> >     (tested with
> >      >      > several versions up to 3.0.8). Actually the _nrt driver
> function
> >     is never
> >      >      > called (_rt is always called...). I wrote a simple exampl=
e
> for
> >     Xeno 2 and
> >      >      > Xeno 3 available here:
> >      >      >
> >      >      > https://github.com/pficheux/xenomai_examples.git
> >      >      >
> >      >      > Here is the test on Raspberry Pi 3 (Xeno 3).
> >      >      >
> >      >      > # insmod rtdm_test.ko
> >      >      >
> >      >      > # ./xenomai_test
> >      >      >
> >      >      > [   47.661245] RTDM open:.
> >      >      >
> >      >      > [   47.667473] ioctl: RT
> >      >      >
> >      >      > [   47.672674] ioctl: RT
> >      >      >
> >      >      > [   48.667479] ioctl: RT
> >      >      >
> >      >      > [   48.678078] ioctl: RT
> >      >      >
> >      >      > [   49.667463] ioctl: RT
> >      >      >
> >      >      > [   49.683076] ioctl: RT
> >      >      >
> >      >      > [   50.667463] ioctl: RT
> >      >      >
> >      >      > [   50.687868] ioctl: RT
> >      >      >
> >      >      >
> >      >      > Of course it works fine with Xenomai 2 (on Pi B+) :
> >      >      >
> >      >      > # insmod rtdm_test.ko
> >      >      >
> >      >      > # ./xenomai_test
> >      >      >
> >      >      > [  753.614275] RTDM open
> >      >      >
> >      >      > [  753.632852] ioctl: RT
> >      >      >
> >      >      > [  753.636779] ioctl: NRT
> >      >      >
> >      >      > [  755.632839] ioctl: RT
> >      >      >
> >      >      > [  755.640252] ioctl: NRT
> >      >      >
> >      >      > [  756.632841] ioctl: RT
> >      >      >
> >      >      > [  757.632838] ioctl: RT
> >      >      >
> >      >      > [  757.643779] ioctl: NRT
> >      >      >
> >      >      > [  758.632836] ioctl: RT
> >      >      >
> >      >      > Thx by advance for your help
> >      >      >
> >      >
> >      >     Xenomai 3 prefers the RT patch of a RTDM callback over the
> NRT if the
> >     caller is
> >      >     a real-time task. Xenomai 2 had an adaptive behavior where t=
he
> >     current state of
> >      >     the caller defined that. This is a problem I also ran into
> before and
> >     proposed
> >      >     to revert to the old behavior (in fact, we do that in one
> internal
> >     deployment).
> >      >     But there is also the point that preferring RT over NRT make=
s
> sense
> >     for many
> >      >     scenarios.
> >      >
> >      >     Discussing this with Philippe back then on the list (I do no=
t
> find the
> >      >     reference
> >      >     ATM), we came to the conclusion that the better answer is to
> allow the
> >      >     driver to
> >      >     declare which particular behavior a callback should have - i=
n
> >     contrast to doing
> >      >     that in one way or the other at the top level, ie. on syscal=
l
> entry
> >     of ioctl
> >      >     etc. But I do not have a design for that yet, and I didn't
> want to
> >     delay the
> >      >     3.1
> >      >     release further to finish that first.
> >      >
> >      >     What we could consider for 3.1 is adding a compile-time
> configurable to
> >      >     re-enable the old behavior at syscall level when a user need=
s
> it.
> >     Then we could
> >      >     later on (3.2) push that properly to the driver level and
> remove the
> >     control
> >      >     again.
> >      >
> >      >     Jan
> >      >
> >      >     --
> >      >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >      >     Corporate Competence Center Embedded Linux
> >      >
> >      >
> >      >
> >      > --
> >      >
> >      > Pierre FICHEUX -/- CTO Smile ECS, France -\-
> pierre.ficheux@smile.fr
> >     <mailto:pierre.ficheux@smile.fr>  <mailto:pierre.ficheux@smile.fr
> >     <mailto:pierre.ficheux@smile.fr>>
> >      > http://www.smile.fr  <http://www.smile.fr/>
> >      > https://smile.eu/fr/offres/embarque-iot
> >      > I would love to change the world, but they won't give me the
> source code
> >      >
> >
> >     --
> >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >     Corporate Competence Center Embedded Linux
> >
> >
> >
> > --
> >
> > Pierre FICHEUX -/- CTO Smile ECS, France -\-pierre.ficheux@smile.fr
> <mailto:pierre.ficheux@smile.fr>
> >                               http://www.smile.fr  <http://www.smile.fr=
/
> >
> >                               https://smile.eu/fr/offres/embarque-iot
> > I would love to change the world, but they won't give me the source cod=
e
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
