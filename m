Message-ID: <487BA305.6040401@domain.hid>
Date: Mon, 14 Jul 2008 21:03:33 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid> <487B91F6.3070909@domain.hid>
In-Reply-To: <487B91F6.3070909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig271DAA25FC90BCF1D97CAF31"
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig271DAA25FC90BCF1D97CAF31
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Philippe Gerum schrieb:
> Stefan Kisdaroczi wrote:
>> Hi all,
>>
>> If I call rt_task_bind() with a timeout value other than TM_NONBLOCK o=
r
>> TM_INFINITE
>> it works not as expected (by me).
>>
>> System: Debian Lenny with Xenomai 2.4.3 and Kernel 2.6.24.
>>
>> The attached example calls 3 times rt_task_bind() for a nonexistent ta=
sk:
>>
>> 1. dont wait: rt_task_bind(&task,"SomeTaskName",TM_NONBLOCK)
>>   -> returns -11 (EWOULDBLOCK) -> OK
>>
>> 2. wait 5 secs: rt_task_bind(&task,"SomeTaskName",5000000000LL);
>>   -> returns immediately -13 (EACCES) without waiting -> ?
>>   -> I expected ETIMEDOUT after 5 seconds
>>
>=20
> "SomeTaskName" was found in the registry, but suddenly disappeared whil=
e in the
> process of returning its handle (we do post-validation after binding). =
That task
> has probably exited prematurely.

There was and is no task with this name. This happens on a freshly reboot=
ed box
with any name i choose. Can someone please try my small example from the =
first
mail on his box. Thank you.

>> 3. wait forever: rt_task_bind(&task,"SomeTaskName",TM_INFINITE);
>>   -> blocks a expected -> OK
>>
>> I have the same problem with rt_queue_bind() calls.
>>
>> Do i expect something wrong?
>>
>> Thanks for your help!
>>
>> kisda
>>
>>
>> ----------------------------------------------------------------------=
--
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20



--------------enig271DAA25FC90BCF1D97CAF31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIe6MNIPTw9rIdn6oRAux2AJ9wHkMtdShRLxdPf3mJDdNsGIID9wCfeXAW
SNlRBKxswr6voMgnDT1wd8k=
=pQVC
-----END PGP SIGNATURE-----

--------------enig271DAA25FC90BCF1D97CAF31--

