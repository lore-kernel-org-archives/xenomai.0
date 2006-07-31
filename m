Message-ID: <44CDEF6D.3030403@domain.hid>
Date: Mon, 31 Jul 2006 13:54:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] two questions about using rtdm
References: <02AA386EB831044F8537A696BA785C78A668C0@domain.hid>
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668C0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig65DE128C0B36707D592D2ABB"
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
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65DE128C0B36707D592D2ABB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Landau, Bracha wrote:
>=20
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid Behalf Of
> xenomai-help-request@domain.hid

<snip>

Could you please avoid re-using posted mails for new threads? Thanks.

> Two questions regarding rtdm:
>=20
> 1) I would like to use the real-time system calls (bind,socket,send,rec=
v, etc) that are included in the API (i.e., rt_dev_socket, rt_dev_bind...=
).
> I tried to replace the calls to their rt equivalents (e.g., socket beco=
mes rt_dev_socket). But apparently that is not enough, because when I do =
a call to rt_dev_socket, I get an error.
> Are there any examples of how to use the r/t sockets?

RTnet for real-time networking over Ethernet, Firewire (eth1394 together
with the RT-FireWire package), or WLAN (experimental rt2x00). Soon to
come: RT-CAN via socket interface (patch is working, Wolfgang is
currently cleaning up). Ah, and the special-purpose protocol driver TiMS
(Tiny Messaging Service) that comes with RACK
(developer.berlios.de/projects/rack).

If you are missing something, feel free to write and register your own
RTDM protocol driver. ;)

>=20
> 2) I am running on an MPC8247 with two CPM serial ports. Can I use the =
16650A driver provided by xenomai to "impersonate" the CPM serial driver?=
 If not, can you instruct me how to do this?

That's one for the PPC experts, but I bet the UART is not compatible
with the 16550A controller, is it?

Jan


--------------enig65DE128C0B36707D592D2ABB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEze9xniDOoMHTA+kRApppAKCDZnvDHulAbvfkfMyeadpKSviKewCfRB68
GViwH1TQwveF4CWPHaxebms=
=hSeR
-----END PGP SIGNATURE-----

--------------enig65DE128C0B36707D592D2ABB--

