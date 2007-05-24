Message-ID: <4655475F.7040002@domain.hid>
Date: Thu, 24 May 2007 10:05:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <C0662F7F2A8A974FAA140822A2336BF0F173EC@deimsg10.de.net.world>
In-Reply-To: <C0662F7F2A8A974FAA140822A2336BF0F173EC@deimsg10.de.net.world>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig111FC3601C9F9FF811CA3DFB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] scheduling of rtdm-handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Stolz, Stefan, PGR2" <Stefan.Stolz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig111FC3601C9F9FF811CA3DFB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stolz, Stefan, PGR2 wrote:
> Hello,
>=20
> i'm developing a rt-driver for the rtdm with Xenomai and i've got one
> question.
> how are the handler-functions (like rtdm_read_handler,
> rtdm_write_handler, ...) scheduled if there are other rt-tasks?
> e.g. i've got the rtdm-driver which handles read and write (read and
> write have to do some i/o-operations) and a two other rt-tasks. What
> happens if the task with the lower priority uses the rtdm-driver to rea=
d
> and write data and the task with the higher priority want's to run. Are=

> the i/o-operations peempted by the high priority task? If it is so, is
> it possible to give the driver a higher priority or do i have to create=

> a task with a higher priority in the driver?

RTDM device handlers run in the context of the caller, i.e. some RT (or
also non-RT) task. Thus, they are schedule like the caller - unless you
apply locking mechanisms like spinlocks which block preemption for a
while or mutexes which may cause priority boosts if contention with
tasks of higher priority occur.

Additionally, there are IRQ handlers which run at highes priority and
RTDM kernel tasks which can be set to custom RT priorities.

No black magic here, it's all standard OS design.

Jan


--------------enig111FC3601C9F9FF811CA3DFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVUdfniDOoMHTA+kRAlNaAJ9qR/aKLEywawdo4efDq9nE2xwTvwCeLI0M
rQ4SbhXnc3hQWeetrYj9D8o=
=x0E7
-----END PGP SIGNATURE-----

--------------enig111FC3601C9F9FF811CA3DFB--

