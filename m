Message-ID: <4E1B4AC0.80506@domain.hid>
Date: Mon, 11 Jul 2011 21:10:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
In-Reply-To: <4E1B469A.8000703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4585E1EF09D4A33A4FB84294"
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
--------------enig4585E1EF09D4A33A4FB84294
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-11 20:53, Gilles Chanteperdrix wrote:
> On 07/08/2011 06:29 PM, GIT version control wrote:
>> @@ -2528,6 +2534,22 @@ static inline void do_taskexit_event(struct tas=
k_struct *p)
>>  	magic =3D xnthread_get_magic(thread);
>> =20
>>  	xnlock_get_irqsave(&nklock, s);
>> +
>> +	gksched =3D thread->gksched;
>> +	if (gksched) {
>> +		xnlock_put_irqrestore(&nklock, s);
>=20
> Are we sure irqs are on here? Are you sure that what is needed is not a=
n
> xnlock_clear_irqon?

We are in the context of do_exit. Not only IRQs are on, also preemption.
And surely no nklock is held.

> Furthermore, I do not understand how we
> "synchronize" with the gatekeeper, how is the gatekeeper garanteed to
> wait for this assignment?

The gatekeeper holds the gksync token while it's active. We request it,
thus we wait for the gatekeeper to become idle again. While it is idle,
we reset the queued reference - but I just realized that this may tramp
on other tasks' values. I need to add a check that the value to be
null'ified is actually still ours.

Jan


--------------enig4585E1EF09D4A33A4FB84294
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4bSsAACgkQitSsb3rl5xR5GQCfcxbwZoXAMFluAPDpM3qRk0Gn
DswAn1uMlGrzilsyQYTDlC8ELbckVCX6
=kDlI
-----END PGP SIGNATURE-----

--------------enig4585E1EF09D4A33A4FB84294--

