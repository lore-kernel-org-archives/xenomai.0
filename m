Message-ID: <4461D331.8040906@domain.hid>
Date: Wed, 10 May 2006 13:49:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] zombie mutex owners
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid> <4461C5D9.3060705@domain.hid>
In-Reply-To: <4461C5D9.3060705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF8105D2768B6CEEE035AC1BA"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8105D2768B6CEEE035AC1BA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Dmitry Adamushko wrote:
>>
>> Indeed, this solves the issue more gracefully.
>>
>> Looking at this again from a different perspective and running the tes=
t
>> case with your patch in a slightly different way, I think I
>> misinterpreted the crash. If I modify task2 like this
>>
>> void task2_fnc(void *arg)
>> {
>>         printf("started task2\n");
>>         if (rt_mutex_lock(&mtx, 0) < 0) {
>>                 printf("lock failed in task2\n");
>>                 return;
>>         }
>> //        rt_mutex_unlock(&mtx);
>>
>>         printf("done task2\n");
>> }
>>
>> I'm also getting a crash. So the problem seems to be releasing a mutex=

>> ownership on task termination. Well, this needs further examination.
>>
>=20
> The native skin does not implement robust mutex, indeed.

Yeah, lunch opened my eyes: the skin data structure (RT_MUTEX) is not
updated appropriately on task cleanup. What about some callback hook in
xnsynch_t to invoke a per-skin cleanup handler when running
xnsynch_release_all_ownerships?

Jan


--------------enigF8105D2768B6CEEE035AC1BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYdMxniDOoMHTA+kRAlG7AJ9PKR2Bs34A2vmOe06vDp0n9TlNcQCfUts4
qt0TpgNirXJY1gjEeyy4qik=
=ix3v
-----END PGP SIGNATURE-----

--------------enigF8105D2768B6CEEE035AC1BA--

