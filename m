Message-ID: <4A0D25D6.5090607@domain.hid>
Date: Fri, 15 May 2009 10:20:38 +0200
From: Pierre Antoine HALOPEAU <halopeau@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] help with driver 16550A
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

I' m trying to drive a card TEWS TCP460 that is compatible with 16550=20
with the driver 16550A. Before compile my kernel I chose the option=20
CONFIG_XENO_DRIVERS_16550A_ANY so I try to load the driver with the=20
command modprobe xeno_16550A mem=3D0xfebff000  irq=3D23. I found the=20
argument with the command dmesg. I have a mmio adress and an IRQ in the=20
list. When I load the driver I have not errors but when I watch in=20
/proc/xenomai/rtdm I did not see my ports. As anabody have information?=20
As anabody can help me ? Thank you in advance.

Best regards,

Pierre - Antoine HALOPEAU


__________ Information provenant d'ESET NOD32 Antivirus, version de la base=
 des signatures de virus 4077 (20090514) __________

Le message a =E9t=E9 v=E9rifi=E9 par ESET NOD32 Antivirus.

http://www.eset.com



