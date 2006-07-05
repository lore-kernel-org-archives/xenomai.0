Message-Id: <1152123076.10814.265353853@domain.hid>
From: "Alessandro Pittaluga" <xpit@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI multiple serial port card
In-Reply-To: <AD78122AD7C05B4B936EBAD7F49738C0AB2B4F@square.bfh.ch>
Date: Wed, 05 Jul 2006 20:11:16 +0200
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B4F@square.bfh.ch>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lauener Nathan <Nathan.Lauener@domain.hid>, xenomai@xenomai.org

Hi,
I'm currently using PCMCIA serial cards up to 4 ports each.
They works really fine with xenomai & rtdm!
I think that things should be even more straightforward with PCI
multiports.

The only essential check to be done selecting the hardware is that the
UART belons to the 16550 family.

Hoping to have been useful
Alessandro

On Wed, 5 Jul 2006 11:26:26 +0200, "Lauener Nathan"
<Nathan.Lauener@domain.hid> said:
> Hi,
>=20
> because my hardware has only one serial port and no ISA bus anymore I am
> looking for a PCI card with at least two serial ports that has a driver
> for Xenomai. Has anyone heard of or used such a device? Any info is
> welcome.
>=20
> Thanks,
>=20
> Nathan
--=20
  Alessandro Pittaluga
  al.pittaluga@domain.hid

--=20
http://www.fastmail.fm - And now for something completely different=85


