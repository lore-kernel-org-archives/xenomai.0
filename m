Message-ID: <466EDF1F.5050103@domain.hid>
Date: Tue, 12 Jun 2007 19:59:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <30228710.1181630552942.JavaMail.ngmail@domain.hid>
	<1181630207.7354.20.camel@domain.hid> <466ED96E.4050806@domain.hid>
	<466EDC2C.3020200@domain.hid>
In-Reply-To: <466EDC2C.3020200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig66552645E1168E4D49A1E5A2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] CONFIG_SMP in switchtest
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66552645E1168E4D49A1E5A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> On Tue, 2007-06-12 at 08:42 +0200, M. Koehrer wrote:
>>>
>>>> Hi everybody,
>>>>
>>>> I want to know why the --enable-smp option for "configure" of Xenoma=
i is used when there
>>>> is already the corresponding option selected with the kernel configu=
ration?
>>> --enable-smp is only used when you want the user-space side to _requi=
re_
>>> SMP support to be present into the running kernel; i.e. for some (wei=
rd)
>>> reason, your application really needs this. Xenomai libraries don't c=
are
>>> whether SMP support is enabled or not, they are not sensitive to that=

>>> issue (see the "weak" status of this option in README.INSTALL)
>>
>> Switchtest bases some compile-time decisions on CONFIG_SMP. Nitpicking=
,
>> OK, but I wonder if this is required. Gilles?
>=20
> If you do not enable the smp option, switchtest will only use one cpu.
> The reason why I made this is that, on some UP machine, (probably arm,
> but I do no longer remember) sysconf(_SC_NPROCESSORS_ONLN) did not work=
=2E

Welcome to embedded hell :-/. What was the effect precisely? Can we
detect this during runtime? The point is I see people trying this test
on SMP without providing the right switch to configure. Would be a pity
IMHO.

At this chance: I also noticed problems with our sched_setscheduler
detection and bfin's uClibc. Compilations works, linking fails - they
provide headers, but lack implementations. Patch suggestion will follow.

And my pthread_spin_lock detection got nicely vaporised on bfin once
again. I'm considering to switch back to the original configure-based
detection.

Enough of the moaning.

Jan


--------------enig66552645E1168E4D49A1E5A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbt8fniDOoMHTA+kRAsCoAJ9Rr+F9rDCspRNwQZzZPpoVtbnbWQCeOTpn
Um5KEeVm9gKSriflh0e5AyA=
=ezrC
-----END PGP SIGNATURE-----

--------------enig66552645E1168E4D49A1E5A2--

