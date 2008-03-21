Message-ID: <47E41609.2090107@domain.hid>
Date: Fri, 21 Mar 2008 21:09:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001a01c88a0d$5365af40$9601a8c0@domain.hid>
	<47E2BB0F.9050704@domain.hid>
	<001001c88b63$df59b300$9601a8c0@domain.hid>
In-Reply-To: <001001c88b63$df59b300$9601a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE4489773D0F009B7D57CEE72"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Non-Real-Time Asynchronous Notification
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4489773D0F009B7D57CEE72
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Robert McCullough wrote:
> Hi Jan,
>=20
>   --> -----Original Message-----
>   --> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>   --> Sent: Thursday, March 20, 2008 3:29 PM
>   --> To: rob@domain.hid
>   --> Cc: xenomai@xenomai.org
>   --> Subject: Re: [Xenomai-help] Non-Real-Time Asynchronous Notificati=
on
>   -->=20
>   --> Robert McCullough wrote:
>   --> > Hi,
>   --> >
>   --> > How do I signal an asynchronous notification from a RTDM real-t=
ime
>   --> task to a
>   --> > non-real-time user-space Linux thread?
>   --> > Do I use Non-Real-Time Signaling Services (rtdm_nrtsig_init,..)=
?
>   --> > If so, how?
>   --> >
>   --> > Here is the current code that I am trying to port to RTDM.
>   --> >
>   --> > Current driver code to signal non-real-time Linux thread:
>   --> >
>   --> > 	// If event
>   --> > 	if(event){
>   --> > 		// and signal asynchronous readers
>   --> > 		if (kmdpr_device->async_queue)
>   --> > 			kill_fasync(&kmdpr_device->async_queue,
> SIGIO,
>   --> > POLL_IN);
>   --> > 	}
>   -->=20
>   --> Just push this code in the rtdm_nrtsig handler and trigger the ha=
ndler
>   --> execution from RT context.
>   -->=20
>   --> Jan
>=20
> [Robert McCullough]=20
> Ok, I understand that but how do I specify the file operation fasync in=
 my
> rtdm_device?  How do I replace or update the code marked TODO?

In fact, there is no fasync support available with RTDM, specifically as =

using signals under real-time constraints is a bad idea (not only=20
because Xenomai has no hard-RT signal support).

But before suggesting any alternative pattern: What does your=20
application actually require to work? How does asynchronous=20
driver/application interaction currently look like?

Jan


--------------enigE4489773D0F009B7D57CEE72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH5BYLniDOoMHTA+kRAvMrAJ9jnxhw5+1i/5OgJYumjrxu3J/A+wCeL88U
8xYLr9k06gLapn+hfXohRQ8=
=ZZ8n
-----END PGP SIGNATURE-----

--------------enigE4489773D0F009B7D57CEE72--

