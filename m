Message-ID: <460031B4.1030906@domain.hid>
Date: Tue, 20 Mar 2007 20:10:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid>
In-Reply-To: <46002EE0.9040406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31257FBF4557E0F5DB2BE3B5"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: socketcan-core@domain.hid, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31257FBF4557E0F5DB2BE3B5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> on the Xenomai mailing list the topic "bus error flooding" popped up
> again. Various users reported trouble due to high bus error rates and
> bad impact on latencies. Some discussion is going on on how to avoid
> such flooding. I have already implemented "on-demand" bus error
> interrupts. Bus error interrupts are then only enabled when at least on=
e
> socket is listening on bus errors. But flooding can still occur and we
> are thinking about a better way of downscaling or temporarily disabling=

> them. Socket-CAN currently restarts the controller after 200 bus errors=
=2E
> My preferred solution for RT-Socket-CAN currently is to stop the CAN
> controller after a kernel configurable amount of successive bus errors.=

> More clever ideas and comments are welcome?
>=20
> To have some input, I have measured the bus error rate with the PEAK
> PCAN PCI card on my Icecube MPC5200 eval-board doing rtcansend without
> cable connected. Here are the results for the various baud-rates:
>=20
>    125 KB/s  1926 BEI/s
>    250 KB/s  3925 BEI/s
>    500 KB/s  7856 BEI/s
>   1000 KB/s 15700 BEI/s

So bus errors come in at a rate comparable to shortest possible frames
at maximum speed, right? That's an IRQ load you can live with - if you
plan to load your CAN bus at 100% anyway. But if you don't...

>=20
> The latency measured with "latency" from the testsuite reported an
> increase of the latency with load from 67 to 95us almost independently
> of the baud-rate. Sending messages with 8 byte payload from MSCAN to
> SJA1000 on the same node as fast as possible increased the latency up t=
o
> 103us. This measurement did not include delivery of messages to sockets=

> (actually no socket was listening).
>=20

Some dump of /proc/xenomai/stat would be interesting (system load in
both cases).

Jan


--------------enig31257FBF4557E0F5DB2BE3B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGADG0niDOoMHTA+kRAu6XAJ93+Kzz0BkLhT16ARP9iaxm9Sd4nACeIBo2
G92IGtTQX14Lv7HXj3yfi6w=
=Xjtq
-----END PGP SIGNATURE-----

--------------enig31257FBF4557E0F5DB2BE3B5--

