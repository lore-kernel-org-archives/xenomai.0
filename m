Message-ID: <450AD766.3000307@domain.hid>
Date: Fri, 15 Sep 2006 18:40:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
References: <1158337583.13530.20.camel@domain.hid>
In-Reply-To: <1158337583.13530.20.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D7C2EE931216DE16A537DFD"
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
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D7C2EE931216DE16A537DFD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> Hi,
>=20
> I need to be able to map an IO memory buffer to userspace from a RTDM
> driver.
>=20
> rtdm_mmap_to_user() seems to do what I need, but it doesn't work. Its
> code thinks that all virtual addresses between VMALLOC_START and
> VMALLOC_END are obtained through vmalloc() and tries to call
> xnarch_remap_vm_page() on them, which fails.

Ok, interesting (one never stops learning).

>=20
> Virtual addresses coming from ioremap() need to go through
> xnarch_remap_io_page_range(), and their physical address cannot be
> obtained with a simple virt_to_phys().
>=20
> A working patch is attached below, but there might (should ?) be a
> better way to do it. Some of the code may also belong to
> asm-generic/system.h instead of the RTDM skin.
>=20
> Note that you may also need to EXPORT_SYMBOL(vmlist and vmlist_lock) in=

> mm/vmalloc.c if you want to build the RTDM skin as a module.
>=20
> Comments ?

In case no one comes up with an easy, portable way to detect remapped
memory as well: What about some flags the caller of rtdm_mmap_to_user
has to pass, telling what kind of memory it is? Would simplify the RTDM
part, and the user normally knows quite well where the memory came from.
And I love to break APIs. :)

I'm CC'ing the first users of this service to ask for some feedback from
their POV. Hope gna does not -once again- mangles the CCs.

Jan


--------------enig2D7C2EE931216DE16A537DFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCtdmniDOoMHTA+kRAkZWAJ4me0ZjvyHa9ppPcpnqCpReteskQwCfbUfd
N9VcNy/cSv2tndT641z1mOw=
=mfT0
-----END PGP SIGNATURE-----

--------------enig2D7C2EE931216DE16A537DFD--

