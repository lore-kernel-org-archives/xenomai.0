Message-ID: <4D79E43D.2040807@domain.hid>
Date: Fri, 11 Mar 2011 09:58:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid> <4D79E28B.3090004@domain.hid>
In-Reply-To: <4D79E28B.3090004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4F101819F445385773CEE1F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_delete trouble
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4F101819F445385773CEE1F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-03-11 09:51, Gilles Chanteperdrix wrote:
> Johann Obermayr wrote:
>> void task_waiter_do(void *data)
>> {
>>      rt_printf("task_waiter_do started\n");
>>      while(task_waiter_flag =3D=3D 0)
>>          ; // rt_task_sleep( DELAYMS(1) );
>>      rt_printf("task_waiter_do finished\n");
>> }
>=20
> What happens if you uncomment the rt_task_sleep here ?
>=20

Given how often users make this mistake, should we enable the watchdog
by default?

Jan


--------------enigA4F101819F445385773CEE1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk155EEACgkQitSsb3rl5xSR3gCguuMS7rnCWY0vFrgjWxSfOmyr
Cy0An2XLZY6thx3PLrthrh8d5l1qqy1L
=22fk
-----END PGP SIGNATURE-----

--------------enigA4F101819F445385773CEE1F--

