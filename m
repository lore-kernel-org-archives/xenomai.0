Message-ID: <46795F21.8040007@domain.hid>
Date: Wed, 20 Jun 2007 19:08:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467639BE.30504@domain.hid> <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>
In-Reply-To: <1182357772.6137.39.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96039D9EDC557EB4ADE601CE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
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
--------------enig96039D9EDC557EB4ADE601CE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-06-18 at 10:27 +0200, Jan Kiszka wrote:=20
>> Jan Kiszka wrote:
>>> ...
>>> The answer I found is to synchronise all time bases as good as possib=
le.
>>> That means if one base changes its wall clock offset, all others need=
 to
>>> be adjusted as well. At this chance, we would also implement
>>> synchronisation of the time bases on the system clock when they get
>>> started. Because skins may work with different type width to represen=
t
>>> time, relative changes have to be applied, i.e. the core API changes
>>> from xntbase_set_time(new_time) to xntbase_adjust_time(relative_chang=
e).
>>> The patch (global-wallclock.patch) finally touches more parts than I =
was
>>> first hoping. Here is the full list:
>>>
>>>  - synchronise slave time bases on the master on xntbase_start
>>>  - xntbase_set_time -> xntbase_adjust_time, fixing all time bases
>>>    currently registered
>>>  - make xnarch_start_timer return the nanos since the last host tick
>>>    (only ia64 affected, all others return 0 anyway, causing one tick
>>>    off when synchronising on system time -- but this fiddling becomes=

>>>    pointless on the long term due to better clocksourses on all archs=
)
>=20
> Support for 2.4 kernels will be still around for the Xenomai 2.x series=

> though, and those will likely never support clocksources. Support for
> Linux 2.4 will be discontinued starting from x3.

Again: As the code looks right now, only ia64 made use of this feature.
We have i386 and PPC for 2.4, and both did not bother to synchronise
that precisely so far (here, this interface is pointless).

And on x86 with recent 2.6 kernels, simply returning 0 on success of the
timer setup made the master clock deviate from the real timeofday by one
tick.

>=20
>>>  - adapt vrtx, vxworks, and psos+ skin to new scheme, fixing sc_scloc=
k
>>>    at this chance
>>>  - make xnarch_get_sys_time internal, no skin should (need to) touch
>>>    this anymore
>=20
> This interface has not been meant to be part of the skin building
> interface, but for internal support code that needs to get the host
> time. For instance, one may want this information for obscure data
> logging from within a module, independently of any wallclock offset
> fiddling Xenomai may do on its timebases (so nktbase is not an option
> here if timebases start being tighly coupled). And this should work in
> real execution mode, or in virtual simulation mode. IOW,
> xnarch_get_sys_time() has to remain part of the exported internal
> interface (even if as some inline routine, that's not the main issue
> here).

As I still haven't been able to see real code using it like this, I
can't comment on it.

>=20
>> Forgot to mention two further aspects:
>>
>>  - The semantic of XNTBSET was kept time base-local. But I wonder if
>>    this flag is still required. Unless it was introduced to emulated
>>    some special RTOS behaviour, we now have the time bases automatical=
ly
>>    set on startup. Comments welcome.
>>
>=20
> That might be a problem wrt pSOS for instance. In theory, tm_set() has
> to be issued to set the initial time, so there is indeed the notion of
> unset/invalid state for the pSOS wallclock time when the system starts.=

> This said, in the real world, such initialization better belongs to the=

> BSP rather than to the application itself, and in our case, the BSP is
> Linux/Xenomai's business, so this would still make sense to assume that=

> a timebase has no unset state from the application POV, and XNTBSET
> could therefore go away.

That was my first impression as well, but I cannot asses the impact as I
don't know real pSOS porting scenarios.

>=20
> The main concern I have right now regarding this patch is that it
> changes a key aspect of Xenomai's current time management scheme:
> timebases would be tighly coupled, whilst they aren't right now. For

Which already caused troubles when dealing with RTDM, you remember?

> instance, two timebases could have a very different idea of the Epoch i=
n
> the current implementation, and this patch is precisely made to kill
> that aspect. This is a key issue if one considers how Xenomai should
> deal with concurrent skins: either 1) as isolated virtual RTOS machines=

> with only a few bridges allowing very simple interfaces, or 2) as
> possibly cooperating interfaces. It's all a matter of design; actually,=

> user/customer experience I know of clearly proves that #2 makes a lot o=
f
> sense, but still, this point needs to be discussed if needed.
>=20
> So, two questions arise:
>=20
> - what's the short term impact on the common - or not that common - use=

> case involving multiple concurrent skins? I tend to think that not that=

> many people are actually leveraging the current decoupling between
> timebases. But, would some do, well, then they should definitely speak
> up NOW.
>=20
> - regarding the initial RTDM-related motivation now, why requiring all
> timebases to be in sync Epoch-wise, instead of asking the software
> wanting to exchange timestamps to always use the master timebase for
> that purpose? By definition, nktbase is the most accurate, always valid=

> and running, and passing the timebase id along with the jiffy value whe=
n
> exchanging timestamps would be no more needed.

No existing API (native, posix, driver profiles, not to speak of legacy
RTOSes) is prepare for this. Basically, this is the same reason why we
cannot simply declare we would be able to deal with unsynchronised TSC
time sources on SMP/multicore boxes. See my consideration in "Getting
the clock model right".

Well, what I can imaging as a compromise is to offer the user the option
to explicitly decouple some skin from the system time. "Do this if you
like to, but don't interact with others then!" This warning should be
included in that case. But before I suggested this, I first wanted to
wait for someone seriously screaming "I need this!"

Jan


--------------enig96039D9EDC557EB4ADE601CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGeV8hniDOoMHTA+kRAneZAKCE4JZkKkfUd8g8jWZfg2MdIJm4iwCfSc5h
mRNThbOFANf5Em0WGOjjlx4=
=VQxi
-----END PGP SIGNATURE-----

--------------enig96039D9EDC557EB4ADE601CE--

