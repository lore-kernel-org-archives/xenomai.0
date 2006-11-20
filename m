Message-ID: <456171E9.3040303@domain.hid>
Date: Mon, 20 Nov 2006 10:14:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
	<1163784779.4980.47.camel@domain.hid> <455E025B.5030906@domain.hid>
	<4561705B.9030002@domain.hid>
In-Reply-To: <4561705B.9030002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig80B0E5273056118898B85AA3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: XENO_OPT_DEBUG impact
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
--------------enig80B0E5273056118898B85AA3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> ...
>>> Disable CONFIG_XENO_OPT_DEBUG from your kernel configuration, this is=

>>> the source of the PTE misses you are seeing now on ppc. This is not t=
o
>>> say that those errors are normal, and this issue still remains to be
>>> fixed, but unless you want to debug the Xenomai nucleus, you don't ne=
ed
>>> this option on (additionally, it adds a large overhead which translat=
es
>>> in significantly augmented jitter).
>>
>> CONFIG_XENO_OPT_DEBUG should not add large jitters - that's what e.g.
>> CONFIG_XENO_OPT_DEBUG_QUEUES is now for.
>>
>> I'm currently seeing two potential "misuses" of the common switch:
>>
>>  - the posix skin (Gilles, how heavy-weighted are those checks?)
>>    =3D> CONFIG_XENO_OPT_DEBUG_POSIX
>=20
> The posix skin printks are issued by the root thread without holding th=
e
> nklock, so they should have no impact on the maximum latency.

Still I think that a separate switch (like we also have for RTDM) is
cleaner. You could then add more checks as well when ever you feel like
they could be useful.

>=20
>>  - CONFIG_XENO_SPINLOCK_DEBUG =3D> CONFIG_XENO_OPT_DEBUG_SPINLOCK
>>
>> Both should be explicitly controllable in Kconfig.
>>
>> Gilles, is CONFIG_XENO_OPT_DEBUG_BHEAP used in any way? Doesn't seem s=
o.
>=20
> What about using CONFIG_XENO_OPT_DEBUG_QUEUE instead ?
>=20

Either this way, or sort it to upcoming XENO_OPT_DEBUG_NUCLEUS. Hmm, the
queues may be even more fitting.

Jan


--------------enig80B0E5273056118898B85AA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYXHpniDOoMHTA+kRAveWAJ42u6JZM66cM60cRCQeaRhlLOCEbACffC1O
b5ZKg2kOA/nSr0cKqzF3cZY=
=D0hh
-----END PGP SIGNATURE-----

--------------enig80B0E5273056118898B85AA3--

