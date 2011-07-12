Message-ID: <4E1C3672.1030104@domain.hid>
Date: Tue, 12 Jul 2011 13:56:34 +0200
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
	<4E1C3301.2030203@domain.hid>
In-Reply-To: <4E1C3301.2030203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE8CF225A5499A6BB2D030CD7"
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
--------------enigE8CF225A5499A6BB2D030CD7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-12 13:41, Gilles Chanteperdrix wrote:
> On 07/12/2011 01:29 PM, Jan Kiszka wrote:
>>> I find all this complicated for a very small corner-case, so, I keep
>>> looking for a simpler solution. Let us try something else.
>>
>> It's rather the contrary: this solution is straightforward IMHO.
>>
>>>
>>> If the thread is woken up for whatever reason before the gatekeeper,
>>> then we will hit the following "if" in xnshadow_harden, can we set th=
e
>>> target to NULL at this point if it is the current thread? With a cmpx=
chg
>>> perhaps?
>>
>> Gatekeeper and target task aren't synchronized, are they?
>=20
> That is another reason why the solution to synchronize using the
> semaphore may not work. If the thread hits the call to down before the

"thread" means do_taskexit_event here?

> gatekeeper is woken up, then the gatekeeper test may see the target
> thread as suspended, and we may return from the call to "down" in
> xenomai domain.

Good point, but fortunately not possible: If we block on down() in
do_taskexit_event, we enter TASK_UNINTERRUPTIBLE state. But the
gatekeeper checks for TASK_INTERRUPTIBLE.

However, this parallel unsynchronized execution of the gatekeeper and
its target thread leaves an increasingly bad feeling on my side. Did we
really catch all corner cases now? I wouldn't guarantee that yet.
Specifically as I still have an obscure crash of a Xenomai thread on
Linux schedule() on my table.

What if the target thread woke up due to a signal, continued much
further on a different CPU, blocked in TASK_INTERRUPTIBLE, and then the
gatekeeper continued? I wish we could already eliminate this complexity
and do the migration directly inside schedule()...

Jan


--------------enigE8CF225A5499A6BB2D030CD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4cNnIACgkQitSsb3rl5xTsigCeIjyz9zqEM7VWk15TopCaQFL4
wWsAoOrYZMMXgTMCZyDxI1aFRuI6B906
=tIOV
-----END PGP SIGNATURE-----

--------------enigE8CF225A5499A6BB2D030CD7--

