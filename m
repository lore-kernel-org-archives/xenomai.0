From: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Subject: RE: FW: [Xenomai-help] insmod: error inserting
	'./xeno_posix.ko':-1	Unknown symbol in module
Date: Thu, 8 Dec 2005 15:24:06 +0100
Message-ID: <002001c5fc03$0c00d610$0200000a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <17304.11485.9921.915682@domain.hid>
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


Hi,

I have deselected the ACPI which is the power management stuff..

When I startup, in dmesg I see :

Local APIC disabled by bios. You can enable it with lapic Mapped apic to
ffffd000

This means that the APIC is turned off by bios... so far so good...

The only lines containing APIC in the .config of the kernel are :=20

CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy

I have no idea where these options are in the make menuconfig menu. When =
I
manually change the y to a n, recompile the kernel and check again, the
options are turned back to y.

Am I missing something here ?=20

Any help is much appreciated !

Best regards,

Martijn


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: donderdag 8 december 2005 13:54
To: Martijn Hazenberg (GOVA)
Cc: 'Heikki Lindholm'; xenomai@xenomai.org
Subject: RE: FW: [Xenomai-help] insmod: error inserting =
'./xeno_posix.ko':-1
Unknown symbol in module

It is hard to know why your system crashes. This may be due to some
kernel configuration options. According to your boot log, you enabled =
the
"processor" option in ACPI (CONFIG_ACPI_PROCESSOR), you should disable
it (you will have to disable thermal zone too). As mentioned by Heikki,
you may try disabling APIC too.

If you get an error message on the console (you have run latency in
text-mode for that), it will be of great help.

--=20


					    Gilles Chanteperdrix.


