Message-ID: <4E1B4C19.2070205@domain.hid>
Date: Mon, 11 Jul 2011 21:16:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid>
In-Reply-To: <4E1B4AC0.80506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1090E115C2927F49ADD86657"
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
--------------enig1090E115C2927F49ADD86657
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-11 21:10, Jan Kiszka wrote:
> On 2011-07-11 20:53, Gilles Chanteperdrix wrote:
>> On 07/08/2011 06:29 PM, GIT version control wrote:
>>> @@ -2528,6 +2534,22 @@ static inline void do_taskexit_event(struct ta=
sk_struct *p)
>>>  	magic =3D xnthread_get_magic(thread);
>>> =20
>>>  	xnlock_get_irqsave(&nklock, s);
>>> +
>>> +	gksched =3D thread->gksched;
>>> +	if (gksched) {
>>> +		xnlock_put_irqrestore(&nklock, s);
>>
>> Are we sure irqs are on here? Are you sure that what is needed is not =
an
>> xnlock_clear_irqon?
>=20
> We are in the context of do_exit. Not only IRQs are on, also preemption=
=2E
> And surely no nklock is held.
>=20
>> Furthermore, I do not understand how we
>> "synchronize" with the gatekeeper, how is the gatekeeper garanteed to
>> wait for this assignment?
>=20
> The gatekeeper holds the gksync token while it's active. We request it,=

> thus we wait for the gatekeeper to become idle again. While it is idle,=

> we reset the queued reference - but I just realized that this may tramp=

> on other tasks' values. I need to add a check that the value to be
> null'ified is actually still ours.

Thinking again, that's actually not a problem: gktarget is only needed
while gksync is zero - but then we won't get hold of it anyway and,
thus, can't cause any damage.

Jan


--------------enig1090E115C2927F49ADD86657
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4bTBkACgkQitSsb3rl5xSUuwCff9UFNwMF1acytfx6PfTmyOET
7QUAoMF79B8iJCzQ3fCIcpbU60BSjldW
=j5dd
-----END PGP SIGNATURE-----

--------------enig1090E115C2927F49ADD86657--

