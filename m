Message-ID: <46607BF5.2@domain.hid>
Date: Fri, 01 Jun 2007 22:05:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18016.24172.608531.418407@domain.hid>
In-Reply-To: <18016.24172.608531.418407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39C48DE71D9EB9FDE6FBE071"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Problem with RTDM descriptors with only rt close
 handler.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39C48DE71D9EB9FDE6FBE071
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> I had a problem with an RTDM driver: /proc/xenomai/rtdm/open_fildes
> could not close its descriptors. So, I tried with trunk which has
> auto-cleanup of RTDM descriptors, to see if descriptors would be closed=
,
> the descriptors were not auto-closed when killing my application
> either. After a little investigation, it appears that the problem is
> that my drivers had a real-time close handler but no non-realtime
> handler, so when close was invoked from a non real-time context (either=

> /proc/xenomai/rtdm/open_fildes, or the auto-cleanup routine), the
> default close handler installed by RTDM simply returned -38 and close
> aborted.
>=20
> The way to fix this issue was rather simple: implement a non real-time
> close handler, but I find this behaviour a bit disturbing, maybe
> implementing a non real-time close handler could be mandatory ?
>=20

It is, read the fine manual :). Moreover, if you had validated your
driver via CONFIG_XENO_OPT_DEBUG_RTDM, you would have got an error on
registration. But given the now even more required close_nrt handler, I
think decoupling this particular check from the debug switch is
appropriate. Will fix.

Jan


--------------enig39C48DE71D9EB9FDE6FBE071
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGYHv1niDOoMHTA+kRAvJpAJ0U1R7GXvPQuhwz4gJcdtJgp35GnQCeLYJo
823cKyAMRDKiPmiUMjV6oz0=
=1NY+
-----END PGP SIGNATURE-----

--------------enig39C48DE71D9EB9FDE6FBE071--

