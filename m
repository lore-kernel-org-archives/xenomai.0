Message-ID: <44C5B7B5.3080505@domain.hid>
Date: Tue, 25 Jul 2006 08:18:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] dma in rtdm
References: <E443EE6E95070D46896C24F5C44EA7F53A1547@domain.hid>
In-Reply-To: <E443EE6E95070D46896C24F5C44EA7F53A1547@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6895C0D8B8CAF213D260C809"
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
To: "Harkema, G.A." <G.A.Harkema@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6895C0D8B8CAF213D260C809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Harkema, G.A. wrote:
> Hallo,
>=20
> =20
>=20
> We are currently trying to develop a realtime usb2.0 stack based on
> xenomai rtdm. In non-realtime mode we use first the kmalloc() function
> to allocate a dma buffer and use the dma_map_single() function to get
> the bus address for the dma engine of the ehci hostcontroller. This
> works fine. For use in a realtime context we replaced the kmalloc()
> function by the rtdm_malloc() function. In our logs we see that the dat=
a

rtdm_malloc does not return memory guaranteed to be usable for DMA (we
should document this somewhere). Depending on the size of your system
heap, the memory /may/ come from a pre-allocated kmalloc'ed (heap <=3D
128K) or from a vmalloc'ed block.

> transfer take place, but the dma buffer was not filled with the
> (received)data. We don't know where the data in the memory is stored. I=
s
> this the right way for using dma in realtime context ? I guess not., bu=
t
> what is the right way. Who can help us with this problem.

I'm convinced that ahead-of-time allocation of URBs, transfer
descriptors, and other buffers is the way to go. The application /
high-level driver requesting some service from the UHCI controller
should take care of providing them. That way you will gain full
determinism, because even rtdm_malloc is not guaranteed to work always.
Low memory or fragmentation caused by other users of this service may
bite you in complex scenarios.

Jan


PS: Is your design now based on usb4rt or do you work on a separate
solution? I haven't heard any news from you on this.


--------------enig6895C0D8B8CAF213D260C809
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFExbe4niDOoMHTA+kRAmtfAJ4gVRgFS19DBC2reeF7EoWy0LyGWACfRnH3
uT8qztdP4kTGdl9bsv6wl0k=
=/hr1
-----END PGP SIGNATURE-----

--------------enig6895C0D8B8CAF213D260C809--

