Message-ID: <47E2BB0F.9050704@domain.hid>
Date: Thu, 20 Mar 2008 20:29:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001a01c88a0d$5365af40$9601a8c0@domain.hid>
In-Reply-To: <001a01c88a0d$5365af40$9601a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31EC78CD231963B0BC92A55C"
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
--------------enig31EC78CD231963B0BC92A55C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Robert McCullough wrote:
> Hi,
>=20
> How do I signal an asynchronous notification from a RTDM real-time task=
 to a
> non-real-time user-space Linux thread?
> Do I use Non-Real-Time Signaling Services (rtdm_nrtsig_init,..)?
> If so, how?
>=20
> Here is the current code that I am trying to port to RTDM.
>=20
> Current driver code to signal non-real-time Linux thread:
>=20
> 	// If event
> 	if(event){
> 		// and signal asynchronous readers=20
> 		if (kmdpr_device->async_queue)
> 			kill_fasync(&kmdpr_device->async_queue, SIGIO,
> POLL_IN);
> 	}

Just push this code in the rtdm_nrtsig handler and trigger the handler=20
execution from RT context.

Jan


--------------enig31EC78CD231963B0BC92A55C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH4rsWniDOoMHTA+kRAt5BAJ0dzjOXH/QhRz6bhuIfG8XrvqGD3QCeJpJO
Vimcg7Vqjme/v67Nz2DG3zo=
=kUxf
-----END PGP SIGNATURE-----

--------------enig31EC78CD231963B0BC92A55C--

