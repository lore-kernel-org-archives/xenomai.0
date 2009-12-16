Message-ID: <4B28CA44.2080304@domain.hid>
Date: Wed, 16 Dec 2009 12:53:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B240D0B.50603@domain.hid>	
	<1260723757.2216.2.camel@domain.hid>
	<4B252909.9090304@domain.hid>	
	<1260727502.2216.19.camel@domain.hid>
	<4B253028.10607@domain.hid>
	<1260962769.2216.203.camel@domain.hid>
In-Reply-To: <1260962769.2216.203.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0AC95B128CD1D7DC870A915"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [pull request] x86: critical fix for
	native_safe_halt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0AC95B128CD1D7DC870A915
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2009-12-13 at 19:19 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2009-12-13 at 18:48 +0100, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
>>>>>> Recent moving of ipipe_suspend_domain finally exposed a deeper fla=
w in
>>>>>> cpu_idle on x86: We failed to check the pipeline log before issuin=
g the
>>>>>> real hlt. This caused IRQ latencies or even drops for Linux,
>>>>>> specifically on SMP. Credits go to plain QEMU whose slow SMP mode =
caused
>>>>>> ipipe_critical_enter to deadlock frequently enough.
>>>>>>
>>>>>> The first patch of this series fixes this (see below), the second =
one
>>>>>> simply removes the two useless ipipe_suspend_domain calls.
>>>>>>
>>>>> What your patch does as well, is killing the ability to run low pri=
ority
>>>>> domains below the root level.
>>>> Yes, I'm killing the dream.
>>>>
>>>> I heavily doubt that the functions I removed in the second patch eve=
r
>>>> contributed something good to this. It's always the job of the lowes=
t
>>>> domain to issue hardware halt, not of some arbitrary mid-prio domain=
=2E
>=20
> Actually, no it's not. You may use a low-priority domain to run idle
> level jobs outside of the linux infrastructure for that purpose (e.g.
> RCU). A high priority domain may want to post events for a low priority=

> domain to act upon when a mid priority domain is about to enter the CPU=

> idle state.

Even if all the related bugs were fixed: When you pass down control to
the lower domain on cpu_idle via ipipe_suspend_domain, you won't get a
Linux reschedule (without CONFIG_PREEMPT) until the low-prio domain
finally returns from its event handler - likely not what "low-prio"
suggests.

>=20
>>>> Moreover, what would be the practical use for such model in the cont=
ext
>>>> of Linux?
>>> That is _not_ the point. The point is, when submitting a patch, pleas=
e
>>> make sure to raise all the concerns it might introduce wrt to changin=
g
>>> the base features. I'm not opposed to make the feature set evolve, bu=
t I
>>> don't want this to happen "by mistake".
>> Just pushed
>>
>> "x86: Drop redundant ipipe_suspend_domain from cpu_idle
>>
>> Allowing domains below root always required more than these calls (Lin=
ux
>> would have to give up idle management). And syncing the root domain no=
w
>> takes place in __ipipe_halt_root. So remove these suspension calls."
>>
>> as commit message for the second patch. Is that what you are looking f=
or?
>>
>=20
> Not exactly, because your comment states that what was removed was
> intrinsically useless, it was not, and has been used, even if only in a=

> couple of occasions, mainly to enable a debugging hack. This is why I
> choked on removing a feature silently. But at the same time, we are in =
a
> simplification trend of the I-pipe toward X3, so I agree on the final
> goal you are pursuing with that patch.
>=20
> In short, let's move on, I'll merge that as well, now that everything i=
s
> on the table, and there is no objection anyway.

I couldn't agree more. :)

Jan


--------------enigF0AC95B128CD1D7DC870A915
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksoykgACgkQitSsb3rl5xRm9QCfaWfvql2suffaHqRSHdrfWnEE
d9wAn0fGlaV+ukF8TW+yKa4jRI/cBjom
=WICX
-----END PGP SIGNATURE-----

--------------enigF0AC95B128CD1D7DC870A915--

