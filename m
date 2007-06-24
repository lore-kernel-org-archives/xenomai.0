Message-ID: <467E2E9C.90905@domain.hid>
Date: Sun, 24 Jun 2007 10:43:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>	
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
In-Reply-To: <1182623858.6000.139.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE0540A64D827A49B5F495D5C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0540A64D827A49B5F495D5C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2007-06-23 at 13:39 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sat, 2007-06-23 at 10:08 +0200, Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> [just to save this early-Saturday-morning insight]
>>>>
>>>> I think the xntimer interface is not yet ready to represent all requ=
ired
>>>> scenarios. What kind of timers are there? Let's start with POSIX:
>>>>
>>>> 1. Realtime timers	- use realtime clock as base, re-tune
>>>> 			  absolute(!) expiry dates if the realtime clock
>>>> 			  changes
>>>> 2. Monotonic timers	- use monotonic clock as base, don't re-adjust
>>>> 			  during runtime
>>>>
>>>> Now what we have in current trunk:
>>>>
>>>> 3a. Realtime xntimers	- use wallclock_offset to calculate absolute
>>>> 			  expiry dates, don't re-adjust during runtime
>>>> 4a. Monotonic xntimers	- use raw jiffies/TSC as base, don't re-adjus=
t
>>>> 			  during runtime
>>>>
>>>> And this is what we planed to introduce soon:
>>>>
>>>> 3b. Realtime xntimers	- use wallclock offset to calculate absolute
>>>> 			  expiry dates, re-adjust if the offset changes
>>>> 			  during runtime
>>> I merged this patch already, so this issue becomes top-ranked on the =
fix
>>> list.
>> Nope, you didn't. We only discussed 3b on Thursday, we still have 3a i=
n
>> place (i.e. no running timer is re-adjusted on xntbase_adjust_time). B=
ut
>> we will need this for POSIX compliance.
>>
>=20
> Sorry, my mistake. I was thinking about "timebase readjustment", which
> patch I did merge, while you were talking about "timer readjustement",
> which code is not there yet anyway.
>=20
>>>> 4b. Monotonic xntimers	- same as 4a
>>>>
>>>> 3b and 4b almost perfectly match POSIX, one only has to pass relativ=
e
>>>> realtime timers as monotonic ones (Linux does so too). But there are=
 a
>>>> lot of skins that potentially rely on 3a!
>>> They do, but not only on the timer issue, but this also has an impact=
 on
>>> the time unit used to return the current time. I must admit that this=
 is
>>> becoming a mess.
>> Leaving Native apart for a while (though this doesn't mean we should
>> break its API):
>=20
> No doubt about this. But the native skin is particular in the sense tha=
t
> it does not provide any service to change its own epoch, so one may
> assume that it directly depends on the global epoch defined by the
> nucleus, and as such, may be subject to immediate timer expiry in case
> the wallclock offset is globally updated. AFAICS, "only"
> rt_task_sleep_until() and rt_task_set_periodic() would be impacted.

Yes, looks like. So you think we could migrate Native over the POSIX
scheme just by clarifying the docs? Hmm, could work.

>=20
>>  Are there also legacy RTOS skins around that rely on a
>> timer property "set timeout according to current wallclock, but don't
>> touch it anymore once it was started"?
>>
>=20
> There are legacy RTOS which have both the notions of absolute timeouts
> and also define a mechanism to setup their own epoch: those would be
> impacted by the pending changes on the nucleus timer management. In tha=
t
> case, the virtual RTOS machine should be isolated from propagation of
> wallclock offset changes from other parts of the Xenomai system.
>=20
> E.g. VRTX's sc_adelay service which is currently emulated using a
> relative delay, but should in fact be using an absolute timeout since
> there is a service to change the epoch in this interface (sc_sclock).
> Actually, it looks like each and every skin should be inspected for
> conformance again wrt time management once the dust has settled on the
> timebase and timer related changes (pSOS would be next).
>=20
>> Actually, this wouldn't be a mess then, it would just derive from
>> Xenomai aiming at emulating all the available timer variants on the
>> market. And this may come at the price of slightly increase complexity=

>> (but not necessarily worse than the current code, ie. acceptable IMO).=

>>
>=20
> As illustrated by the VRTX code, what makes the situation messy in my
> eyes is that some skins used to work around the nucleus limitations in
> terms of time management (lack of built-in absolute timing support, no
> timebases, no strictly monotonic absolute timing), but those hacks tend=

> to bite us now that we do have / are in the process of having proper
> support at nucleus level.
>=20
> The other issue regarding legacy RTOS emulation, is that they should no=
t
> be impacted by the wallclock offset at all, when they deal with jiffies=
=2E
> E.g. in the VRTX case, we should always have something behaving like
> this:
>=20
> sc_stime(8129)
> ...
> ...(work for 11 VRTX ticks)
> ...
> ticks =3D sc_gtime(); /* ticks =3D=3D 8140 */
>=20
> If sc_stime() is not called to set the epoch for the VRTX timebase, the=
n
> 0 would be assumed for the epoch, and 11 returned by the sc_gtime()
> call.
> In any case, starting the timebase, or having another skin propagate a
> wallclock offset change in parallel should never impact the VRTX machin=
e
> time. The reason is that some application code might do some weird
> arithmetics on tick deltas, but also on the raw VRTX clock value for
> internal purpose, and touching the epoch under its feet would break suc=
h
> code.

This is a question how you define the other real-time applications. You
consider them unrelated and ideally isolated just because they use a
different skin. I wouldn't do so.

For me, it is rather the question what would be the expected behaviour
if those other applications were written for VRTX as well here? What is
the expect impact in some VRTX application if a second one changes the
epoch? _That_ is the effect that matters IMO.

OK, there might be vary rare scenarios where you put applications of
different skins together on the same box, but don't want them cooperate
in any way. In that case, and only then, it would be a valid requirement
to isolate the time bases.

>=20
>>>>  At least the whole native
>>>> skin, I would say. So we may actually need two knobs when starting a=
n
>>>> xntimer:
>>>>
>>>>  A) Take wallclock offset into account when calculating internal exp=
iry
>>>>     date?
>>>>  B) Re-tune the expiry date during runtime if the offset changes?
>>>>
>>>> Reasonable combinations are none of both ("POSIX monotonic"), A
>>>> ("Xenomai realtime"), and A+B ("POSIX realtime"). Am I right? Please=

>>>> comment.
>>> Sorry, -ENOPARSE. Which is the alternative here?
>> Forgetting about variant "A only", ie. potentially breaking existing
>> stuff for the sake of POSIX and only POSIX. But I don't think this is
>> acceptable, we need xntimer to support all three as soon as some skin
>> cries for variant "A only".
>=20
> Ok, let me rephrase the options, so that I'm sure we are talking about
> the same issues. We obviously need:
>=20
> * real-time: absolute trigger dates based on a variable epoch depending=

> on the global timeline (the Linux one actually), check for elapsed
> timers upon epoch changes, no resync of still outstanding ones. IOW, A
> +B, aka POSIX real-time.

(In fact, technically, Xenomai will have to resync because all timers
are internally based on the monotonic, non-adjustable TSC clock.)

> * monotonic, absolute trigger dates based on a fixed epoch depending on=

> a strictly monotonic timeline, neither immediate expiry check nor resyn=
c
> needed since the epoch cannot be changed (we are using some read-only
> free running CPU counter to get timestamps here). IOW, neither A nor B,=

> aka POSIX monotonic.
> * relative, which is a simple variant of monotonic, in the sense that
> trigger dates are expressed as delays instead of absolute dates on the
> monotonic timeline.
>=20
> The A-only option would accept absolute timeouts based on the timebase'=
s
> epoch, but would not do anything upon epoch change? This is where I fai=
l
> to find any useful application for this option: since this is an
> absolute timeout, we may not resync the expiry value anyway  - not
> because POSIX does it this way, but first and foremost because it's jus=
t
> logically correct -, but for the same reason, we ought to fire all
> timers of this kind which would have "suddently" elapsed due to the
> epoch change.

Again my questions: Are there RTOS APIs defining that some of their own
absolute timers/timeouts will _not_ be impacted by a change of their
_own_ epoch? Or do all RTOSes we want to emulate behave like POSIX here?

>=20
> Now, instead of the A-only option, I would rather seek a way to isolate=

> a given timebase from the propagation of wallclock offset changes, so
> that its epoch remains stable from its POV. We could then have legacy
> RTOS start absolute timers within their own "time space", while being
> able to apply the rules about absolute timing management common sense
> dictates.

Isolation is a valid feature, but it is the last resort for me, because
it really means isolation, ie. no more convenient interaction with other
skins.

>=20
> But then, the initial issue arises again: in which specific cases, do w=
e
> need to keep the timebase tied by a common epoch through the wallclock
> offset, so that we could keep this option open for those skins, if need=

> be, too?

Two applications or an application and a driver exchange data that is
tagged with time stamps, e.g. in order to synchronise their operations
on common trigger dates or to perform data fusion. If their time bases
are decoupled like before my patch, they would have to implement their
own clock offset estimation mechanism with all the potential errors
(because user code is interruptible e.g.).

I'm convinced that if you stick multiple apps of different skins
together on the same silicon, you are rather seeking for cooperation
than isolation. And in this case, having a common time base would simply
move the routine job of time synchronisation from the application into
the core -- where is belongs.

>=20
>>>> Moreover, it looks to me like the monotonic API I introduced is not =
very
>>>> handy (fortunately, there is no in-tree user yet). It has a sticky
>>>> property, i.e. you set a persistent flag in the xntimer object if it=

>>>> ought to be monotonic. As xntimer structures are typically also
>>>> persistent, you easily end up saving the current mode, setting your =
own,
>>>> and restoring the old one once the timer fired -- to keep other user=
s of
>>>> the timer happy. E.g., think of RTDM doing some monotonic timing wit=
h a
>>>> task while the owning skin may prefer realtime mode. I'm almost
>>>> convinced now that passing a non-sticky mode on each xntimer_start
>>>> (along with XN_ABSOLUTE/RELATIVE in the same parameter) will be more=
 useful.
>>>>
>>> This issue seems orthogonal to the more fundamental one: in which cas=
e
>>> does RTDM need to recycle and _change_ the behaviour of timers owned =
by
>>> other layers? A simple (code) illustration would help understanding t=
he
>>> issue, which is likely RTDM-specific, due to the transverse aspect of=

>>> this interface.
>> I can't tell for sure yet if there are _real_ scenarios where RTDM may=

>> want to switch the xnthread rtimer to monotonic while it is in some
>> realtime mode, I still need to meditate on this. It's just the strong
>> _feeling_ that it is cleaner to define the behaviour on start and not =
on
>> timer init or via a sticky flag.
>>
>=20
> Actually, my own strong feeling would say that fiddling with other
> layers timers would be definitely wrong. The point looks pretty simple
> here: whether you defined the xntimer object and you may do whatever
> change you want on it, or you did not, and only the API exported by the=

> owning layer should give you this opportunity, albeit indirectly.
>=20
> So this confirms your point that, would such change be needed, we would=

> need to make the monotonic flag a dynamic property of the start call.=20
>=20
>> Same goes for POSIX I think. You may call clock_nanosleep e.g. with
>> different clock IDs for the same thread. Currently, all timeouts are
>> converted before the timer is started. But if we put reasonable logic
>> into the generic code, those special treatment may be obsolete. Maybe
>> Gilles has some ideas on how the timer interface (which influences als=
o
>> xnpod_suspend_thread etc.) might optimally look like for this.
>>
>=20
> An orthogonal option would be to make the timer object to be used a
> parameter of the few timed nucleus calls.

That would open the option to move the thread's rtimer on the stack of
the waiter (like the kernel does). Someone (some skin) who wants to
suspend the current thread would create an xntimer of the desired
properties and pass it down to xnpod_suspend_thread (or callers of the
latter).

Practically, that would mean turning a single functions call as there is
now into two of them. One may need to code a simple prototype, but my
feeling is that this extends the code path length before suspension. The
question would be what we gain with this pattern. I think it really
takes some prototypes...

Jan


--------------enigE0540A64D827A49B5F495D5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGfi6xniDOoMHTA+kRAsHKAJ9o/y/vShqDVh5HmuhhGQBA+PdAKgCfXCqK
7HSNyuIeiStM4xmSh6vXQ6w=
=xMT9
-----END PGP SIGNATURE-----

--------------enigE0540A64D827A49B5F495D5C--

