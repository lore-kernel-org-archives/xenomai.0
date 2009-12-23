Message-ID: <4B320A30.8050904@domain.hid>
Date: Wed, 23 Dec 2009 13:16:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid>
	<4B30D2AC.5050101@domain.hid>
In-Reply-To: <4B30D2AC.5050101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrice Kadionik <kadionik@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Patrice Kadionik wrote:
> Gilles Chanteperdrix a =C3=A9crit :
>> Hi,
>>
>> Since I started talking about it, I have run build tests fixing a few
>> things here and there. The current status is this (still at the same
>> place: http://sisyphus.hd.free.fr/~gilles/bx):
>>  =20
> Hi,
>=20
> I've watched your log file for nios2
> (http://sisyphus.hd.free.fr/~gilles/bx/nios2/2.6.30-nios2-linux-uclibc-=
gcc-3.4.6/log.html#1).
> You have this error because you don't have generated before the HW
> design for the NIOS softcore processor: after synthesis with the Quartu=
s
> Altera tools, you finally have a file for programming the FPGA circuit
> and a .ptf file that gives ASCII informations on your SoPC design (in a=

> xml style...).
> The error:
> ./arch/nios2/Makefile:131: *** Run "make hwselect SYSPTF=3D<system.ptf>=
"
> first. Stop.
> is due to lack of this .ptf file.
> This command generates a .h (nios2.h) file that makes relation between
> hardware and the Linux kernel (peripheral base address, irq number,
> peripheral name...)
> Please find here: http://uuu.enseirb.fr/~kadionik/nios-xenomai/std_1s10=
=2Eptf
> a valid .ptf file for Xenomai port.
> Juste run :
> $ make hwselect SYSPTF=3Dpath_to_std_1s10.ptf
> for completing the kernel compilation...

Ok. Thanks, nios2 now compiles.

--=20
					    Gilles.


