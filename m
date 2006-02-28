Message-ID: <44045C75.30107@domain.hid>
Date: Tue, 28 Feb 2006 15:21:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C0299936.2566%steve@domain.hid>
In-Reply-To: <C0299936.2566%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDCB26F6D05F6A7F41EE181D8"
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCB26F6D05F6A7F41EE181D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> My "opinion" is that if a task is forcibly suspended, it should not acc=
rue
> overruns. This should only occur when a task is delayed or ready.

Just imagine that your task is attached to a continuously running timer
as soon as you request this via rt_task_set_periodic. So, if you feel
like suspending the task for a while, detach it from that timer again
(infinite period). Putting this functionality into the RTOS is a bit
overkill in my eyes.

This is a corner use-case, so not everyone should pay for implementing
it in a generic way, only the user who really wants it (by having to
write a few extra lines).

Jan


--------------enigDCB26F6D05F6A7F41EE181D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBFx1niDOoMHTA+kRAiaNAJsEVpo7fcG2DBATzYbDJ7RQL7RwQwCeMwsW
Glc4VZqPFt37ViA45mfIiJE=
=x3aq
-----END PGP SIGNATURE-----

--------------enigDCB26F6D05F6A7F41EE181D8--

