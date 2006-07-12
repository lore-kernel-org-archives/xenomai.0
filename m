Message-ID: <44B4AA17.2050708@domain.hid>
Date: Wed, 12 Jul 2006 09:51:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B2216A.1060904@domain.hid>	
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>	
	<44B341E2.9040506@domain.hid>	
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>	
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>	
	<44B35346.2070200@domain.hid>	
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>	
	<4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>	
	<44B497FE.9090207@domain.hid>
	<4546494d0607120034l3635fb89yda1c79bcbd6c196b@domain.hid>
In-Reply-To: <4546494d0607120034l3635fb89yda1c79bcbd6c196b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig115F1D5CE860D452F99057CA"
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
--------------enig115F1D5CE860D452F99057CA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Thanks Jan.
>=20
> If I understand correctly, a normal Linux task (in kernel or user space=
)
> may
> call rt_task_suspend()/rt_task_resume()
> to suspend/resume the execution of a RT task -- Originally I am thinkin=
g
> only RT tasks can use such APIs - Looks I am wrong here.

Hmm, in theory it should be no problem to call rt_task_suspend(task)
with task !=3D NULL from arbitrary contexts. But the native skin prevents=

this. I must confess I do not know the reason behind this right now. The
point is that you do not need to block for remote-suspending some other
task, thus the caller's context should not matter. Anyone else any idea?

rt_task_resume() in contrast is fine from any context again.

Jan


--------------enig115F1D5CE860D452F99057CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtKoaniDOoMHTA+kRAsm9AJ4g+o8l+MlQjV2KAN/BE07Az1izogCdEmf+
hitbCpUZwb9tf8MHl5JNE1c=
=xuIZ
-----END PGP SIGNATURE-----

--------------enig115F1D5CE860D452F99057CA--

