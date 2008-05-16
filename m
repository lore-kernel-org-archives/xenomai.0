Date: Fri, 16 May 2008 14:40:02 +0200
Message-Id: <1165867616@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?at91sam9263_and_user-space_support?=
 =?iso-8859-15?q?_compile_fails?=
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

The manual of my starterkit says i should do this with the vmlinux:

arm-elf-objcopy -O binary -S vmImage vmlinux.bin
gzip -f9 vmlinux.bin
mkimage -A arm -O linux -T kernel -C gzip -a 0x20008000 -e 0x20008000 -n "=
Linux Kernel Image" -d vmlinux.bin.gz vmImage

When im take the ./arch/arm/boot/compressed/vmlinux it won't work.
If i take the ./vmlinux it is to big.




-----Urspr=FCngliche Nachricht-----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Gesendet: 16.05.08 14:18:30
An: Paradoxxa2001@domain.hid
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] at91sam9263 and user-space support compile fai=
ls

On Fri, May 16, 2008 at 1:07 PM,  <Paradoxxa2001@domain.hid> wrote:
> I have found some debug flags.
> Now the vmlinux is smaller but still to big
>
> -rwxr-xr-x 1 paradoxxa paradoxxa 4,8M 16. Mai 12:36 vmlinux
> -rwxr-xr-x 1 paradoxxa paradoxxa 1,7M 16. Mai 12:36 arch/arm/boot/compre=
ssed/vmlinux

A 1.7M vmlinux is Ok. I do not understand what you mean.

--=20
 Gilles



=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/=3Fmc=3D100071&distributionid=3D000000000066


