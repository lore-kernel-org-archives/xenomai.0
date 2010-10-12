Message-ID: <4CB49A14.3050400@domain.hid>
Date: Tue, 12 Oct 2010 19:25:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<1286611432.13186.200.camel@domain.hid>	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>	<4CB2B98A.8010605@domain.hid>	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>	<4CB36116.8090507@domain.hid>	<4CB367AA.6020403@domain.hid>	<AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>	<AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>	<4CB4103E.80009@domain.hid>
	<AANLkTikwqboZGsSC99yMOQZTm48QoT8C6j+RPi3Wcs=k@domain.hid>
In-Reply-To: <AANLkTikwqboZGsSC99yMOQZTm48QoT8C6j+RPi3Wcs=k@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig602661220D243A3C1C74F66A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig602661220D243A3C1C74F66A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 12.10.2010 17:28, Peter Pastor wrote:
> Hey Jan, Wolfgang,
>=20
>> You can't change reality (physical wiring) this way.
> Well, I guess you are right !
>=20
>> If you do not need the USB interface, unbind the driver so that the
>> Linux IRQ usage ends:
>=20
> I might not need the USB interface. At least there are 6 USB ports on t=
he
> back, so I hope I do not disable all of them.
> However, besides the USB controller
>=20
> 00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)=
 USB
> UHCI Controller #4 [8086:3a37]
>=20
> the IRQ 16 is also shared by
>=20
> 05:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic SAS10=
68E
> PCI-Express Fusion-MPT SAS [1000:0058] (rev 08)

Then you might be lost if you can't live without that controller as well
or flip PCI slots (see FAQ link below).

>=20
> which I guess I cannot simply unbind from the PCI bus... (check lspci.t=
xt
> attached)
>=20
> Also, I did a
>=20
> # echo 0000:00:1a.0 > /sys/bus/pci/drivers/ehci_hcd/unbind
>=20
> but it does work for me... --> bash: echo: write error: No such device
> Do I have to have PCI hot-plugging enabled or some such ?

No. Check what /sys/bus/pci/devices contains, which directory points to
your USB controller.

>=20
> Also, I have seen in
> /usr/src/xenomai-2.5.5.1/doc/generated/html/life-with-adeos that there
> methods to share interrupts even between domains. So my question is, is=

> there an option that allows me to do so ? Is that recommended ?
> Unfortunately, I am stuck to use this particular motherboard.

Please see
http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_=
devices_share_the_same_IRQ.3F
and recent discussions on this list (or xenomai-devel, google will help).=


Jan


--------------enig602661220D243A3C1C74F66A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAky0mhQACgkQitSsb3rl5xQQmgCfc99gYycjrYtNRIw9N/H2wH26
T7AAoLcSsdtSRxOse01i3/5Du4fBNdyH
=5tq9
-----END PGP SIGNATURE-----

--------------enig602661220D243A3C1C74F66A--

