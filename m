Message-ID: <48AB1EE6.8070003@domain.hid>
Date: Tue, 19 Aug 2008 21:28:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AAF7DB.1080603@domain.hid> <48AB1B29.4040001@domain.hid>
In-Reply-To: <48AB1B29.4040001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF1B6005D952ABAB7A76447CB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] Lock stealing is borken
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1B6005D952ABAB7A76447CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> bad news, everyone :(. According to the result of some lengthy debug
>> session with a customer and several ad-hoc lttng instrumentations, we
>> have a fatal bug in the nucleus' implementation of the lock stealing
>> algorithm. Consider this scenario:
>>
>> 1. Thread A acquires Mutex X successfully, ie. it leaves the (in this
>>    case) rt_mutex_acquire service, and its XNWAKEN flag is therefore
>>    cleared.
>>
>> 2. Thread A blocks on some further Mutex Y (in our case it was a
>>    semaphore, but that doesn't matter).
>>
>> 3. Thread B signals the availability of Mutex Y to Thread A, thus it
>>    also set XNWAKEN in Thread A. But Thread A is not yet scheduled on
>>    its CPU.
>>
>> 4. Thread C tries to acquire Mutex X, finds it assigned to Thread A, b=
ut
>>    also notices that the XNWAKEN flag of Thread A is set. Thus it stea=
ls
>>    the mutex although Thread A already entered the critical section -
>>    and hell breaks loose...
>>
>=20
> See commit #3795, and change log entry from 2008-05-15. Unless I misund=
erstood
> your description, this bug was fixed in 2.4.4.

Oh, fatally missed that fix.

Anyway, the patch looks a bit unclean to me. Either you are lacking
wwake =3D NULL in xnpod_suspend_thread, or the whole information encoded
in XNWAKEN can already be covered by wwake directly.

Jan


--------------enigF1B6005D952ABAB7A76447CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkirHuwACgkQniDOoMHTA+meyQCbB3E240kW6AtduvNX7FuPQkkm
OokAnRnrxGY+IJjYXeXs9SwtmoDT6MNn
=Zvem
-----END PGP SIGNATURE-----

--------------enigF1B6005D952ABAB7A76447CB--

