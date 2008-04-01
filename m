Message-ID: <47F2C02D.6090607@domain.hid>
Date: Wed, 02 Apr 2008 01:07:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001a01c88a0d$5365af40$9601a8c0@domain.hid>
	<47E2BB0F.9050704@domain.hid>
	<001001c88b63$df59b300$9601a8c0@domain.hid>
	<47E41609.2090107@domain.hid>
	<005d01c89343$15f9e650$9601a8c0@domain.hid>
In-Reply-To: <005d01c89343$15f9e650$9601a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C8B3D8C1FB2B547417C9900"
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
--------------enig6C8B3D8C1FB2B547417C9900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Robert McCullough wrote:
> Hi Jan,
>=20
>   --> -----Original Message-----
>   --> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>   --> Sent: Friday, March 21, 2008 4:10 PM
>   --> To: rob@domain.hid
>   --> Cc: xenomai@xenomai.org
>   --> Subject: Re: [Xenomai-help] Non-Real-Time Asynchronous Notificati=
on
>   -->=20
>   --> Robert McCullough wrote:
>   --> > Hi Jan,
>   --> >
>   --> >   --> -----Original Message-----
>   --> >   --> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>   --> >   --> Sent: Thursday, March 20, 2008 3:29 PM
>   --> >   --> To: rob@domain.hid
>   --> >   --> Cc: xenomai@xenomai.org
>   --> >   --> Subject: Re: [Xenomai-help] Non-Real-Time Asynchronous
>   --> Notification
>   --> >   -->
>   --> >   --> Robert McCullough wrote:
>   --> >   --> > Hi,
>   --> >   --> >
>   --> >   --> > How do I signal an asynchronous notification from a RTD=
M
>   --> real-time
>   --> >   --> task to a
>   --> >   --> > non-real-time user-space Linux thread?
>   --> >   --> > Do I use Non-Real-Time Signaling Services
>   --> (rtdm_nrtsig_init,..)?
>   --> >   --> > If so, how?
>   --> >   --> >
>   --> >   --> > Here is the current code that I am trying to port to RT=
DM.
>   --> >   --> >
>   --> >   --> > Current driver code to signal non-real-time Linux threa=
d:
>   --> >   --> >
>   --> >   --> > 	// If event
>   --> >   --> > 	if(event){
>   --> >   --> > 		// and signal asynchronous readers
>   --> >   --> > 		if (kmdpr_device->async_queue)
>   --> >   --> >
> kill_fasync(&kmdpr_device->async_queue,
>   --> > SIGIO,
>   --> >   --> > POLL_IN);
>   --> >   --> > 	}
>   --> >   -->
>   --> >   --> Just push this code in the rtdm_nrtsig handler and trigge=
r the
>   --> handler
>   --> >   --> execution from RT context.
>   --> >   -->
>   --> >   --> Jan
>   --> >
>   --> > [Robert McCullough]
>   --> > Ok, I understand that but how do I specify the file operation f=
async
>   --> in my
>   --> > rtdm_device?  How do I replace or update the code marked TODO?
>   -->=20
>   --> In fact, there is no fasync support available with RTDM, specific=
ally
>   --> as
>   --> using signals under real-time constraints is a bad idea (not only=

>   --> because Xenomai has no hard-RT signal support).
>   -->=20
>   --> But before suggesting any alternative pattern: What does your
>   --> application actually require to work? How does asynchronous
>   --> driver/application interaction currently look like?
>   -->=20
>   --> Jan
>=20
> [Robert McCullough]
> Here is a little background on how my driver works.
> The driver is the interface/control for an AC servo drive which control=
s an
> AC motor.  The interface to the drive is done through a dual-ported RAM=
=2E
> The I/O from the servo drive is updated and an IRQ is triggered from th=
e
> servo drive through the DP RAM to our MPC5200 at a 4 kHz rate.  In my I=
RQ
> handler I read, process, and update the I/O in the RAM.  Some of the da=
ta
> from the servo drive contains status bits that represent asynchronous
> events/faults from the drive that needs to be passed up to the user
> application.  In my current non-real-time driver I used fasync to send =
a
> SIGIO signal to the user application whenever one of these events/fault=
s
> changed and then the application would read the status bits with an ioc=
tl
> call and process them.
>=20
> I hope this clarifies the requirements a little.
> How would you suggest I solve this in my RTDM driver?

Well, a classic pattern is to encapsulate the async event handling in=20
one or more dedicated threads that block-wait on those events. Check the =

RTDM profile for serial devices for such a channel. This has the=20
advantage that you can cleanly specify the handling priority,=20
specifically compared to "normal" operations.

HTH,
Jan


--------------enig6C8B3D8C1FB2B547417C9900
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH8sAtniDOoMHTA+kRAtOEAJ9KEB4lG7ACPwDCz5gCRIVjQw7tyACfXHxt
cfZoZilP6eaVg1lkHzGGYy4=
=Eeg2
-----END PGP SIGNATURE-----

--------------enig6C8B3D8C1FB2B547417C9900--

