Date: Mon, 13 Nov 2006 10:17:28 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
In-Reply-To: <45583080.705@domain.hid>
Message-ID: <Pine.GSO.4.64.0611131001500.3023@domain.hid>
References: <1162810995.5144.20.camel@domain.hid>
	<200611111945.10309.Sebastian.Smolorz@domain.hid>
	<17750.14872.480581.403298@domain.hid>
	<200611121951.37050.Sebastian.Smolorz@domain.hid>
	<45583080.705@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1163409448=:3023"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-959030623-1163409448=:3023
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	studserv.stud.uni-hannover.de id kAD9HTBw003999

On Mon, 13 Nov 2006, Gilles Chanteperdrix wrote:

> Sebastian Smolorz wrote:
>> Gilles Chanteperdrix wrote:
>>=20
>>> Sebastian Smolorz wrote:
>>> > Gilles Chanteperdrix wrote:
>>> > > Sebastian Smolorz wrote:
>>> > >  > Sebastian Smolorz wrote:
>>> > >  > > Gilles Chanteperdrix wrote:
>>> > >  > > > Schl=E4gl "Manfred jun." wrote:
>>> > >  > > >  > Hi again!
>>> > >  > > >  >
>>> > >  > > >  > I've the presumption, there is something wrong with my
>>> > >  > > >  > timer-handling. Could you please take a look at my hand=
ling.
>>> > >  > > >  >
>>> > >  > > >  > Thanks in advance!
>>> > >  > > >
>>> > >  > > > The problem I see with your code is that you are updating
>>> > >  > > > ns_timer_lxlost in __ipipe_mach_acktimer, the integrator
>>> > >  > > > architecture code, which also uses a decrementer does not =
do
>>> > >  > > > that. Apart from that, I see nothing wrong.
>>> > >  > >
>>> > >  > > I see another one which has to do with the fact that
>>> > >  > > __ipipe_mach_tsc is updated both in __ipipe_mach_get_tsc and
>>> > >  > > __ipipe_mach_set_dec. This leads to double-added ticks becau=
se
>>> > >  > > the latter funcion is called only once a period and the form=
er
>>> > >  > > even more than once. So Xenomai counts jiffies in
>>> > >  > > /proc/xenomai/timer to fast. Manfred, can you confirm this?
>>> > >  >
>>> > >  > Forget this, my eyes weren't open this morning ... In
>>> > >  > __ipipe_mach_get_tsc there is no update of __ipipe_mach_tsc, o=
f
>>> > >  > course.
>>> > >
>>> > > Right, but __ipipe_mach_tsc and ns_timer_lxlost get also updated =
in
>>> > > __ipipe_mach_acktimer, this looks wrong, in the integrator
>>> > > implementation, they are updated in the timer interrupt, only if =
the
>>> > > timer is not stolen.
>>> >
>>> > OK, let's speculate a little bit. (Maybe all of the following turns=
 out
>>> > to be completely wrong, but it wouldn't be the first time for me to=
day.
>>> > ;-) Hopefully Manfred can give some comments which pieces of my
>>> > speculation are right.)
>>> >
>>> > The timer counts down to zero, causes an interrupt and then reloads
>>> > automatically with ns_timer_reload. So, when __ipipe_mach_acktimer =
is
>>> > called ns_timer_reload ticks have passed and can be added to
>>> > __ipipe_mach_tsc and ns_timer_lxlost. Some ticks later,
>>> > __ipipe_mach_set_dec is executed, the passed ticks are added to
>>> > __ipipe_mach_tsc and ns_timer_lxlost and the timer is reprogrammed =
to
>>> > the new value.
>>>=20
>>> The problem is that when Xenomai manages the timer, it get reloaded w=
ith
>>> values distinct from ns_timer_reload,
>>=20
>>=20
>> But the reload value is assigned to ns_timer_reload in set_dec. So eve=
ry=20
>> time __ipipe_mach_acktimer is executed it adds the last set reload val=
ue=20
>> which is the right one, isn't it?
>
> Manfred sent its code in two versions: one inlined in the mail, the
> other as an attachment. In the inlined version, ns_timer_reload is not
> set in set_dec.

Ok, I was talking about the attachment because set_dec was not there in=20
the inlined code.

>
>>=20
>>=20
>>> it is even not reloaded at all when the system is a bit late,
>>=20
>>=20
>> Are you referring to the discussed ipipe_trigger_irq call when the del=
ay is=20
>> zero?
>
> Yes. And in this case set_dec is not called before acktimer,

Agreed. So the adding of ticks must be removed from __ipipe_mach_acktimer=
.=20
Additionally, when the timer has reloaded itself these ticks must not be=20
"forgotten". The integrator implementation takes care of it in=20
integrator_getticksoffset(), see [1].

[1]=20
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/arm/patches/a=
deos-ipipe-2.6.15-arm-1.5-02.patch?v=3DSVN-trunk;a=3Darm#L5609

--
Sebastian
---559023410-959030623-1163409448=:3023--

