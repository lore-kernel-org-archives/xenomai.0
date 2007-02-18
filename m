Message-ID: <45D8B8EF.3020204@domain.hid>
Date: Sun, 18 Feb 2007 21:37:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-CAN tx_sem
References: <45D35545.20100@domain.hid>
	<45D45F63.5050009@domain.hid>	<45D461DC.20303@domain.hid>
	<45D4661D.7010506@domain.hid>	<45D46E55.7020907@domain.hid>
	<45D48E27.1090200@domain.hid> <45D6D6CB.4030602@domain.hid>
	<45D89B66.6050907@domain.hid> <45D8AEB3.4020909@domain.hid>
In-Reply-To: <45D8AEB3.4020909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77B9898BC5283BB7F65971AD"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77B9898BC5283BB7F65971AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> I thought about this issue again and found the reason for my vague ba=
d
>>> feeling: re-init is not atomic, thus racy. But also the test+sem_init=

>>> pattern I suggested is not save.
>>>
>>> I guess we need to enhance rtdm_XXX_init in this regard to make the
>>> RT-CAN use case an officially allowed one. /me is planning to spend m=
ore
>>> thoughts on this the next days.
>>
>> OK, done, rtdm_{event,sem,mutex}_init are now protected by the nklock =
in
>> trunk. This should make the in-place re-initialisation of RTDM IPC
>> objects race-free and allow to use them in RT-CAN as originally
>> intended. I think I will back-port that pieces also to v2.3.x later.
>>
>> What patch should now go in to avoid double init/destroy and fix
>> rtcan_virt?
>=20
> Attached. Thanks.
>=20

Just applied to trunk.

To avoid lock nesting where possible, I reordered some code in
rtcan_raw_sendmsg. Please re-check if I messed anything up. Then I could
commit to stable, too.

Jan


--------------enig77B9898BC5283BB7F65971AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2LjvniDOoMHTA+kRAgNIAJ0fgkzS2LmbJgaU3zcZsGAFQdtOHACfR6b+
GJGTfWRACK11CHfNQWl8c4U=
=lvJt
-----END PGP SIGNATURE-----

--------------enig77B9898BC5283BB7F65971AD--

