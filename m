Message-ID: <467D0684.7030604@domain.hid>
Date: Sat, 23 Jun 2007 13:39:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
In-Reply-To: <1182594345.6000.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig089A070721B4C9D4C4ECF700"
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
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig089A070721B4C9D4C4ECF700
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2007-06-23 at 10:08 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> [just to save this early-Saturday-morning insight]
>>
>> I think the xntimer interface is not yet ready to represent all requir=
ed
>> scenarios. What kind of timers are there? Let's start with POSIX:
>>
>> 1. Realtime timers	- use realtime clock as base, re-tune
>> 			  absolute(!) expiry dates if the realtime clock
>> 			  changes
>> 2. Monotonic timers	- use monotonic clock as base, don't re-adjust
>> 			  during runtime
>>
>> Now what we have in current trunk:
>>
>> 3a. Realtime xntimers	- use wallclock_offset to calculate absolute
>> 			  expiry dates, don't re-adjust during runtime
>> 4a. Monotonic xntimers	- use raw jiffies/TSC as base, don't re-adjust
>> 			  during runtime
>>
>> And this is what we planed to introduce soon:
>>
>> 3b. Realtime xntimers	- use wallclock offset to calculate absolute
>> 			  expiry dates, re-adjust if the offset changes
>> 			  during runtime
>=20
> I merged this patch already, so this issue becomes top-ranked on the fi=
x
> list.

Nope, you didn't. We only discussed 3b on Thursday, we still have 3a in
place (i.e. no running timer is re-adjusted on xntbase_adjust_time). But
we will need this for POSIX compliance.

>=20
>> 4b. Monotonic xntimers	- same as 4a
>>
>> 3b and 4b almost perfectly match POSIX, one only has to pass relative
>> realtime timers as monotonic ones (Linux does so too). But there are a=

>> lot of skins that potentially rely on 3a!
>=20
> They do, but not only on the timer issue, but this also has an impact o=
n
> the time unit used to return the current time. I must admit that this i=
s
> becoming a mess.

Leaving Native apart for a while (though this doesn't mean we should
break its API): Are there also legacy RTOS skins around that rely on a
timer property "set timeout according to current wallclock, but don't
touch it anymore once it was started"?

Actually, this wouldn't be a mess then, it would just derive from
Xenomai aiming at emulating all the available timer variants on the
market. And this may come at the price of slightly increase complexity
(but not necessarily worse than the current code, ie. acceptable IMO).

>=20
>>  At least the whole native
>> skin, I would say. So we may actually need two knobs when starting an
>> xntimer:
>>
>>  A) Take wallclock offset into account when calculating internal expir=
y
>>     date?
>>  B) Re-tune the expiry date during runtime if the offset changes?
>>
>> Reasonable combinations are none of both ("POSIX monotonic"), A
>> ("Xenomai realtime"), and A+B ("POSIX realtime"). Am I right? Please
>> comment.
>=20
> Sorry, -ENOPARSE. Which is the alternative here?

Forgetting about variant "A only", ie. potentially breaking existing
stuff for the sake of POSIX and only POSIX. But I don't think this is
acceptable, we need xntimer to support all three as soon as some skin
cries for variant "A only".

>=20
>> Moreover, it looks to me like the monotonic API I introduced is not ve=
ry
>> handy (fortunately, there is no in-tree user yet). It has a sticky
>> property, i.e. you set a persistent flag in the xntimer object if it
>> ought to be monotonic. As xntimer structures are typically also
>> persistent, you easily end up saving the current mode, setting your ow=
n,
>> and restoring the old one once the timer fired -- to keep other users =
of
>> the timer happy. E.g., think of RTDM doing some monotonic timing with =
a
>> task while the owning skin may prefer realtime mode. I'm almost
>> convinced now that passing a non-sticky mode on each xntimer_start
>> (along with XN_ABSOLUTE/RELATIVE in the same parameter) will be more u=
seful.
>>
>=20
> This issue seems orthogonal to the more fundamental one: in which case
> does RTDM need to recycle and _change_ the behaviour of timers owned by=

> other layers? A simple (code) illustration would help understanding the=

> issue, which is likely RTDM-specific, due to the transverse aspect of
> this interface.

I can't tell for sure yet if there are _real_ scenarios where RTDM may
want to switch the xnthread rtimer to monotonic while it is in some
realtime mode, I still need to meditate on this. It's just the strong
_feeling_ that it is cleaner to define the behaviour on start and not on
timer init or via a sticky flag.

Same goes for POSIX I think. You may call clock_nanosleep e.g. with
different clock IDs for the same thread. Currently, all timeouts are
converted before the timer is started. But if we put reasonable logic
into the generic code, those special treatment may be obsolete. Maybe
Gilles has some ideas on how the timer interface (which influences also
xnpod_suspend_thread etc.) might optimally look like for this.

Jan


--------------enig089A070721B4C9D4C4ECF700
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGfQaFniDOoMHTA+kRAob4AJ9pET44lCzwP8H7zc/TMIEKnro9oACdGQ8D
crssicfgPPj4wKONKKseyyw=
=A1eG
-----END PGP SIGNATURE-----

--------------enig089A070721B4C9D4C4ECF700--

