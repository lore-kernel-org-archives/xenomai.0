Message-ID: <4374A5D4.3070006@domain.hid>
Date: Fri, 11 Nov 2005 15:08:20 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Creation of a rt-queue from the user space
References: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAB4075697F55BC3F447B2F78"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB4075697F55BC3F447B2F78
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
> Hello everyone,
>=20
> I've recently posted a message in this mailing list about an issue rega=
rding the use of realtime queue in xenomai from the user space.=20
>=20
> I didn't make any significant progress regarding this issue. I've upgra=
ded to linux 2.6.12; everything works in the user/kernel space except the=
 queue. If I correctly understood, it's necessary to have a /dev/rtheap i=
n order to set up a shared memory segment between user and kernel space. =

> If this entry does not exist, we get an error at the queue creation tim=
e.=20
>=20
> I've observed that if I'm creating manually the entry in /dev, I get th=
e same error and the entry disappears from /dev. Then, I've transfered th=
e udev/rtheap.rules located in the xenomai/nucleus directory into /etc/ud=
ev/rules.d. But the system totally freezes after xeno-load.
>=20
> I've put the segment of code (very simple) for the creation of a simple=
 rt-queue.
>=20
> ----------------
>=20
> int main(int argc, char *argv[]) {
>=20
>   printf("Now starting: %s\n", argv[0]);
>=20
>   /* Timer initialization */
>   err =3D rt_timer_start(1000000);   /* So, one tick will be equal to 1=
 ms */
>   if (err !=3D 0) {
>     printf("Error timer: %d\n", err);
>     clean_exit(0);
>   }
>=20
>   /* Create the mailbox */
>   err =3D rt_queue_create(&mailbox, "MAILBOX", 80, 1, Q_FIFO);
>   if (err !=3D 0) {
>     printf("mbox creation failed: %d\n", err);
>     clean_exit(0);
>   }
>=20
> ------------
>=20
> Thanks for any support.
>=20
> Regards
> Daniel
>=20

Everything's fine here with your test on 2.6.13.4-ipipe-1.0.09 + Xenomai
SVN + /dev/rtheap. Moreover, I don't see a reason why your manually
created device node should disappear. Maybe your build is inconsistent
in some subtle way.

Jan


--------------enigAB4075697F55BC3F447B2F78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDdKXUncNeS9Q0k+IRApfLAJ923OWuRzQQzU/KnoaqHfSKtjY9yQCfcJzQ
CVtMyL6MmFqkZVBkJeFW8UU=
=NKPO
-----END PGP SIGNATURE-----

--------------enigAB4075697F55BC3F447B2F78--

