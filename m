Message-ID: <4A0C0E20.30200@domain.hid>
Date: Thu, 14 May 2009 14:27:12 +0200
From: Pierre Antoine HALOPEAU <halopeau@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] help with drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,
=20
I'm trying to make a RT driver for a TEWS TCP-460 serial card . I got=20
the driver for Linux and I am searching for some tutorials that explain=20
the difference between a rtdm driver and Linux driver. I already read=20
the driver for the 16550 UART. I try to use it with the tutorial in=20
order to install it but when I make setserial /dev/ttySTRV002_0 the=20
response has for io adress is 0x0000 and IRQ is 230. Actually I use the=20
HAL drivers of TEWS in order to make recognize my card by Linux because=20
Linux doesn't recognize it when I just plug in it. I think I will try to=20
add a PCI serial controller visable to the 16550A driver in order to use=20
it directly with my card. If you have some examples, could it be=20
possible for you to send them to me. Thank you in advance.
=20
best regards,
=20
Pierre Antoine HALOPEAU


__________ Information provenant d'ESET NOD32 Antivirus, version de la base=
 des signatures de virus 4074 (20090514) __________

Le message a =E9t=E9 v=E9rifi=E9 par ESET NOD32 Antivirus.

http://www.eset.com



