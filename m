Message-ID: <44B497FE.9090207@domain.hid>
Date: Wed, 12 Jul 2006 08:34:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B218C5.9000804@domain.hid>	
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>	
	<44B2216A.1060904@domain.hid>	
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>	
	<44B341E2.9040506@domain.hid>	
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>	
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>	
	<44B35346.2070200@domain.hid>	
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>
	<4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>
In-Reply-To: <4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig265DAFAD022D89431B6B5F42"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig265DAFAD022D89431B6B5F42
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Hi Jan,
>=20
> You mentioned that:
>=20
> "You might prevent rescheduling by
> setting the scheduler lock of Xenomai, but this still doesn't protect
> from IRQs."
>=20
> If I don't want to stop Xenomai domain from receiving interrupt at all,=

> Just want to block certain Xenomai task.

Then take care of this in the IRQ handler: if some task shall not
receive any notification, do not deliver. Or disable the specific IRQ
(rtdm_irq_disable) as long as it is not shared and no other tasks are
waiting for it.

> Is there a specific set of functions/macros which disable/enable specif=
ic
> real-time event
> processing (for instance, real-time task execution).  In this scheme,
> the ADEOS scheduler still executes, but now checks whether a real-time

Adeos has no scheduler, it only maintains the IRQ/event pipepline.

> task has been "blocked" for execution.  If it is blocked, the scheduler=

> does not schedule the task. When the real-time task is "unblocked" by
> the Linux ROOT domain, it resumes real-time execution.

rt_task_suspend/resume of the native skin may help you. But, of course,
this will not prevent the IRQ handler from being executed. And there are
likely other ways, but this depends on your application design which I
don't know. In any case, nothing RT-specific here.

Jan


--------------enig265DAFAD022D89431B6B5F42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEtJgDniDOoMHTA+kRAkcYAJ4yplLNSO8A0SnlENGuYy1TQQnvCQCfcunB
d3aiUyifTPj+BQDmIllaAtY=
=HFjQ
-----END PGP SIGNATURE-----

--------------enig265DAFAD022D89431B6B5F42--

