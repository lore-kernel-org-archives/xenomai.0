Message-ID: <45E4791B.6030304@domain.hid>
Date: Tue, 27 Feb 2007 19:31:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] task not being scheduled
References: <200702271214.01911.jweber@domain.hid> <45E478BB.40301@domain.hid>
In-Reply-To: <45E478BB.40301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4CABA232A82A56A832CC1FE"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4CABA232A82A56A832CC1FE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jeff Weber wrote:
>> I have system where a 100Hz periodic task is occasionally over running=
 it's
>> periodic task wakeup by 10s of msec.  To debug the problem, I froze an=
 ipipe
>> verbose trace upon an -ETIMEDOUT error return from rt_task_wait_period=
().
>> A filtered output of the trace appears below.  This trace includes eve=
ry
>> occurence of the task, which is pid 7380.
>=20
> Please post the unfiltered (but compressed) trace. It's not yet obvious=

> from the excerpt below what happens.
>=20

=2E..and include your .config as well, please.

Thanks,
Jan


--------------enigD4CABA232A82A56A832CC1FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5HkbniDOoMHTA+kRAssGAJ4xE+5dxgagHUVAspdTHjxtz7TVeACcDSsP
60LhhNLkuoZ4pJr1mb/kIg8=
=QJrn
-----END PGP SIGNATURE-----

--------------enigD4CABA232A82A56A832CC1FE--

