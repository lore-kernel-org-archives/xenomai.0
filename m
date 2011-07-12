Message-ID: <4E1C3A5D.3020700@domain.hid>
Date: Tue, 12 Jul 2011 14:13:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
	<4E1B542B.2010906@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
	<4E1C2912.9050605@domain.hid> <4E1C2959.8080004@domain.hid>
	<4E1C2A2D.9090602@domain.hid> <4E1C2AA5.6060208@domain.hid>
	<4E1C2B44.5060907@domain.hid> <4E1C2B8F.5080700@domain.hid>
	<4E1C2F56.8020103@domain.hid> <4E1C302A.8050309@domain.hid>
	<4E1C3301.2030203@domain.hid> <4E1C3672.1030104@domain.hid>
	<4E1C36EE.70803@domain.hid> <4E1C38CE.7090202@domain.hid>
In-Reply-To: <4E1C38CE.7090202@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCE66A0B69A8817B981FB0FFF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE66A0B69A8817B981FB0FFF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-12 14:06, Gilles Chanteperdrix wrote:
> On 07/12/2011 01:58 PM, Jan Kiszka wrote:
>> On 2011-07-12 13:56, Jan Kiszka wrote:
>>> However, this parallel unsynchronized execution of the gatekeeper and=

>>> its target thread leaves an increasingly bad feeling on my side. Did =
we
>>> really catch all corner cases now? I wouldn't guarantee that yet.
>>> Specifically as I still have an obscure crash of a Xenomai thread on
>>> Linux schedule() on my table.
>>>
>>> What if the target thread woke up due to a signal, continued much
>>> further on a different CPU, blocked in TASK_INTERRUPTIBLE, and then t=
he
>>> gatekeeper continued? I wish we could already eliminate this complexi=
ty
>>> and do the migration directly inside schedule()...
>>
>> BTW, we do we mask out TASK_ATOMICSWITCH when checking the task state =
in
>> the gatekeeper? What would happen if we included it (state =3D=3D
>> (TASK_ATOMICSWITCH | TASK_INTERRUPTIBLE))?
>=20
> I would tend to think that what we should check is
> xnthread_test_info(XNATOMIC). Or maybe check both, the interruptible
> state and the XNATOMIC info bit.

Actually, neither the info bits nor the task state is sufficiently
synchronized against the gatekeeper yet. We need to hold a shared lock
when testing and resetting the state. I'm not sure yet if that is
fixable given the gatekeeper architecture.

Jan


--------------enigCE66A0B69A8817B981FB0FFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4cOl0ACgkQitSsb3rl5xQFsQCfW2C00GBBmRBjTE+X94rLFv/b
OUIAoJ8EXPAQWd+ylUZ1YGfhcex4Aas4
=hycL
-----END PGP SIGNATURE-----

--------------enigCE66A0B69A8817B981FB0FFF--

