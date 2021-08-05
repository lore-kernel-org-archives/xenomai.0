From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <09505192-a4ae-6339-e0f3-c339d92948e4@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 05 Aug 2021 17:11:29 +0200
MIME-Version: 1.0
Message-ID: <10a7-610bff80-123-35a6e6c0@10227334>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Julien Blanc <julien.blanc@sprinte.eu>, =?utf-8?q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Lundi, Ao=C3=BBt 02, 2021 14:24 CEST, Jan Kiszka <jan.kiszka@siemens=
.com> a =C3=A9crit: 
 
> On 23.07.21 10:04, Philippe Gerum wrote:
> > 
> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > 
> >> Le Mardi, Juin 22, 2021 12:07 CEST, Philippe Gerum <rpm@xenomai.or=
g> a =C3=A9crit: 
> >>  
> >>>
> >>> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >>>
> >>>> On 22.06.21 11:31, Philippe Gerum wrote:
> >>>>>
> >>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >>>>>
> >>>>>> On 22.06.21 10:37, Philippe Gerum wrote:
> >>>>>>>
> >>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >>>>>>>
> >>>>>>>> On 22.06.21 09:49, Julien Blanc via Xenomai wrote:
> >>>>>>>>> Le mardi 22 juin 2021 =C3=A0 09:38 +0200, Philippe Gerum vi=
a Xenomai a
> >>>>>>>>> =C3=A9crit :
> >>>>>>>>>>
> >>>>>>>>>> With this in mind, assuming that we have previously saniti=
zed the
> >>>>>>>>>> clock
> >>>>>>>>>> identifier, doing this:
> >>>>>>>>>>
> >>>>>>>>>> #define get=5Ftimestamp(=5F=5Fclock) \
> >>>>>>>>>> ({ (=5F=5Fclock) =3D=3D CLOCK=5FMONOTONIC ? rtdm=5Fclock=5F=
read=5Fmonotonic() :
> >>>>>>>>>> rtdm=5Fclock=5Fread(); })
> >>>>>>>>>>
> >>>>>>>>>> may end up being faster than:
> >>>>>>>>>>
> >>>>>>>>>> xnticks=5Ft (*=5F=5Fget=5Ftimestamp)(clockid=5Ft clock);
> >>>>>>>>>> #define get=5Ftimestamp(=5F=5Fclock)	=5F=5Fget=5Ftimestamp=
(=5F=5Fclock)
> >>>>>>>>>
> >>>>>>>>> Is really a runtime switch necessary ? Since relying on the=
 realtime
> >>>>>>>>> clock is inherently broken, my understanding is that it sho=
uld be kept
> >>>>>>>>> as compatibility purpose only.
> >>>>>>>>
> >>>>>>>> Again: The real-time clock is not a broken clock per se. It =
is the basis
> >>>>>>>> of many services (POSIX...) and - if managed properly - it i=
s as sound
> >>>>>>>> clock to build upon. If you need absolute timestamps to calc=
ulate
> >>>>>>>> absolute timeouts (like users of the existing code do), this=
 is the
> >>>>>>>> clock to go, also in future versions.
> >>>>>>>
> >>>>>>> Definitely correct, for timeout specs.
> >>>>>>>
> >>>>>>>> Also if you want to use
> >>>>>>>> PTP-sync'ed clocks across systems (TSN...), it is THE way to=
 go. At that
> >>>>>>>> point, monotonic timestamps will lose relevance in practice.=

> >>>>>>>>
> >>>>>>>
> >>>>>>> We are not there yet. So, let's all agree than we need both c=
lock bases,
> >>>>>>> and a flexible way to select the current one.
> >>>>>>>
> >>>>>>
> >>>>>> What's still missing with Dovetail and a Linux-operated PTP sy=
nc for the
> >>>>>> main clocksource? Hardending of software-based sync paths? Whe=
re it's
> >>>>>> hw-based, that should already be fine (latest Intel SOCs).
> >>>>>>
> >>>>>
> >>>>> Again, we have two use cases: absolute timeouts based on a comm=
on epoch
> >>>>> which may change, and delays. We do know PTP with hw-based supp=
ort is an
> >>>>> efficient way to maintain consistency among users of the former=
,
> >>>>> nevertheless we still need to express/measure strict delays in =
other
> >>>>> cases. So, we do need both clocks.
> >>>>>
> >>>>
> >>>> If you need cross-system event stamping, the unsync'ed monotonic=
 clock
> >>>> is the wrong choice as well.
> >>>>
> >>>
> >>> As usual, it's a trade-off, a risk assessment between observing
> >>> non-coherent SMP readings and warp jumps. This is a call an appli=
cation
> >>> should be allowed to make, I see no reason to impose a solution
> >>> arbitrarily without knowing what the app actually wants to do.
> >>>
> >>>> Again: What is missing to use PTP-sync'ed clock-realtime under D=
ovetail
> >>>> today?
> >>>>
> >>>
> >>> Nothing when it comes to reading timestamps, via the NMI-safe
> >>> ktime=5Fget=5Freal=5Ffast=5Fns() service (updates will be non-pre=
emptible while
> >>> holding the seqlock).
> >>>
> >>
> >> Hi there,
> >>
> >> to move this topic forward, I propose to create a patch to replace=
 the call to rtdm=5Fclock=5Fread=5Fmonotonic by rtdm=5Fclock=5Fread in =
gpio=5Fcore.c,
> >> plus another one that would introduce the possibility to switch be=
tween those 2 different clocks.
> >>
> > 
> > There is no timed wait calls in this driver which might benefit fro=
m a
> > general "clock switch" feature, is it?  So what about either of the=
se
> > options instead:
> > 
> > - adding GPIO=5FRTIOC=5FTS=5FREAL only for the purpose of retrievin=
g
> >   timestamps. That would leave the existing client code unaffected,=
 and
> >   =5Fmight=5F be backported to the stable tree since this is a mere=

> >   extension of the ABI.
> > 
> > - renaming the current ioctl request to GPIO=5FRTIOC=5FGET=5FTS=5FM=
ONO, and
> >   provide GPIO=5FRTIOC=5FGET=5FTS[=5FREAL] based on rtdm=5Fclock=5F=
read() in the
> >   same move. That would force the existing client code to revisit t=
heir
> >   implementation wrt retrieving a timestamp, providing the desired
> >   alternative between mono/real too. That sort of change would have=
 to
> >   wait for 3.2 though.
> > 
> 
> How is the status here? This topic should really be address before th=
e
> 3.2 release.
> 

Yes, sorry, I left for holydays.
I'm sending the patch right now.

> Thanks,
> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


