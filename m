Message-ID: <44DC4BE2.2050104@domain.hid>
Date: Fri, 11 Aug 2006 11:20:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Announcement Realtime USB Stack
References: <E443EE6E95070D46896C24F5C44EA7F53A15B6@domain.hid>
In-Reply-To: <E443EE6E95070D46896C24F5C44EA7F53A15B6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE6242F49D135DAD7BCD1C98C"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Harkema, G.A." <G.A.Harkema@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6242F49D135DAD7BCD1C98C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Harkema, G.A. wrote:
> Hello,
>=20
> =20
>=20
> We are glad to present our new realtime USB stack based on Xenomai
> 2.2.0. You can find it at https://gna.org/projects/usb20rt/ as a
> downloadable file and svn.
>=20
> It is not bug free, but it's a start. Please try the core and feel free=

> to make comments.
>=20

Porting the Linux USB stack over was certainly a lot of work. Could you
elaborate a bit on the design principles?

I saw e.g. that you preallocate one USB per endpoint, correct? Is there
a chance to add more pending URBs? Looks to me like a network driver
that is prepared to receive a single frame and than first requires the
application to read out the data. But I might be wrong here.

How do you manage transfer descriptors? Are they preallocated as well?

Some remarks on the code after a first glance:

 o rthal_spinlock shouldn't be used in a RTDM driver, pick rtdm_lock
   instead.
 o At least in the EHCI code there is still a Linux timer in use from
   RTDM IRQ context (mod_timer in rtdm_ehci_irq). This will blow your
   box sooner or later.
 o The skeleton driver registers its read handler also for non-rt usage.
   If you don't do this, you could drop that context check in
   rtdm_skeleton_read, and you will gain auto-context-switching for the
   caller as well.

This is certainly a pragmatic approach to gain USB 2.0 support over
RTDM. But I would recommend you to carefully review all time-critical
code paths (URB reception and transmission) with all its corner cases
and dependencies (via spinlocks) to check for their RT-safeness.

Jan


--------------enigE6242F49D135DAD7BCD1C98C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE3EvmniDOoMHTA+kRAp4sAJ93nxLmMJv8Zdv5S45EzfsgxAM48gCeIhAC
TAr2mheuwledyHE/sTk2pAg=
=eJxJ
-----END PGP SIGNATURE-----

--------------enigE6242F49D135DAD7BCD1C98C--

