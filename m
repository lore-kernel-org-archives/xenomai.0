From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87czseyzzm.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 23 Jul 2021 09:02:05 +0200
MIME-Version: 1.0
Message-ID: <10a7-60fa6980-b1-35a6e6c0@10117939>
Subject: =?utf-8?q?Re=3A?= Large gpio interrupt latency
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Julien Blanc <julien.blanc@sprinte.eu>, =?utf-8?q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Mardi, Juin 22, 2021 12:07 CEST, Philippe Gerum <rpm@xenomai.org> a =
=C3=A9crit: 
 
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
> > On 22.06.21 11:31, Philippe Gerum wrote:
> >> 
> >> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >> 
> >>> On 22.06.21 10:37, Philippe Gerum wrote:
> >>>>
> >>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >>>>
> >>>>> On 22.06.21 09:49, Julien Blanc via Xenomai wrote:
> >>>>>> Le mardi 22 juin 2021 =C3=A0 09:38 +0200, Philippe Gerum via X=
enomai a
> >>>>>> =C3=A9crit :
> >>>>>>>
> >>>>>>> With this in mind, assuming that we have previously sanitized=
 the
> >>>>>>> clock
> >>>>>>> identifier, doing this:
> >>>>>>>
> >>>>>>> #define get=5Ftimestamp(=5F=5Fclock) \
> >>>>>>> ({ (=5F=5Fclock) =3D=3D CLOCK=5FMONOTONIC ? rtdm=5Fclock=5Fre=
ad=5Fmonotonic() :
> >>>>>>> rtdm=5Fclock=5Fread(); })
> >>>>>>>
> >>>>>>> may end up being faster than:
> >>>>>>>
> >>>>>>> xnticks=5Ft (*=5F=5Fget=5Ftimestamp)(clockid=5Ft clock);
> >>>>>>> #define get=5Ftimestamp(=5F=5Fclock)	=5F=5Fget=5Ftimestamp(=5F=
=5Fclock)
> >>>>>>
> >>>>>> Is really a runtime switch necessary ? Since relying on the re=
altime
> >>>>>> clock is inherently broken, my understanding is that it should=
 be kept
> >>>>>> as compatibility purpose only.
> >>>>>
> >>>>> Again: The real-time clock is not a broken clock per se. It is =
the basis
> >>>>> of many services (POSIX...) and - if managed properly - it is a=
s sound
> >>>>> clock to build upon. If you need absolute timestamps to calcula=
te
> >>>>> absolute timeouts (like users of the existing code do), this is=
 the
> >>>>> clock to go, also in future versions.
> >>>>
> >>>> Definitely correct, for timeout specs.
> >>>>
> >>>>> Also if you want to use
> >>>>> PTP-sync'ed clocks across systems (TSN...), it is THE way to go=
. At that
> >>>>> point, monotonic timestamps will lose relevance in practice.
> >>>>>
> >>>>
> >>>> We are not there yet. So, let's all agree than we need both cloc=
k bases,
> >>>> and a flexible way to select the current one.
> >>>>
> >>>
> >>> What's still missing with Dovetail and a Linux-operated PTP sync =
for the
> >>> main clocksource? Hardending of software-based sync paths? Where =
it's
> >>> hw-based, that should already be fine (latest Intel SOCs).
> >>>
> >> 
> >> Again, we have two use cases: absolute timeouts based on a common =
epoch
> >> which may change, and delays. We do know PTP with hw-based support=
 is an
> >> efficient way to maintain consistency among users of the former,
> >> nevertheless we still need to express/measure strict delays in oth=
er
> >> cases. So, we do need both clocks.
> >> 
> >
> > If you need cross-system event stamping, the unsync'ed monotonic cl=
ock
> > is the wrong choice as well.
> >
> 
> As usual, it's a trade-off, a risk assessment between observing
> non-coherent SMP readings and warp jumps. This is a call an applicati=
on
> should be allowed to make, I see no reason to impose a solution
> arbitrarily without knowing what the app actually wants to do.
> 
> > Again: What is missing to use PTP-sync'ed clock-realtime under Dove=
tail
> > today?
> >
> 
> Nothing when it comes to reading timestamps, via the NMI-safe
> ktime=5Fget=5Freal=5Ffast=5Fns() service (updates will be non-preempt=
ible while
> holding the seqlock).
> 

Hi there,

to move this topic forward, I propose to create a patch to replace the =
call to rtdm=5Fclock=5Fread=5Fmonotonic by rtdm=5Fclock=5Fread in gpio=5F=
core.c,
plus another one that would introduce the possibility to switch between=
 those 2 different clocks.

Fran=C3=A7ois
> -- 
> Philippe.


