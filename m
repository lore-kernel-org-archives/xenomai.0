Date: Thu, 15 May 2008 14:28:12 +0200
Message-Id: <1164479754@domain.hid>
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

With the CodeSourcery 2007q3 toolchain it works.
Thanks a lot!

Thomas

-----Urspr=FCngliche Nachricht-----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Gesendet: 15.05.08 11:48:43
An: Paradoxxa2001@domain.hid
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] at91sam9263 and user-space support compile fai=
ls

On Thu, May 15, 2008 at 11:21 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, May 15, 2008 at 10:36 AM,  <Paradoxxa2001@domain.hid> wrote:
>> It says me that the files memory.h and asm/param.h couldn't be found.
>> Im wondering why=3F I also tried it like the example in the README.INSTAL=
L 2.6 Building for ARM
>> but with the same result. Do anyone know how to fix this=3F
>
> It looks like a toolchain issue. Are you sure your toolchain is
> properly installed =3F Is there a memory.h or sys/mman.h in the
> toolchain include dir =3F

I routinely compile Xenomai with the two following toolchains for ARM:
- Snapgear 2005 toolchain:
http://ftp.snapgear.org/pub/snapgear/tools/arm-linux/arm-linux-tools-20051=
123.tar.gz
- CodeSourcery 2007q3 toolchain (no longer available, the current
toolchain is 2008q1):
http://www.codesourcery.com/gnu=5Ftoolchains/arm/download.html

--=20
 Gilles

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help



=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten!=20
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/=3Fmc=3D021114


