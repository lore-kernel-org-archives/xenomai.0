Message-ID: <4B30C544.2020202@domain.hid>
Date: Tue, 22 Dec 2009 14:10:28 +0100
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid>
In-Reply-To: <4B309A29.6030405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

Hi Gilles,

Gilles Chanteperdrix a =E9crit :
> Hi,
>
> Since I started talking about it, I have run build tests fixing a few
> things here and there. The current status is this (still at the same
> place: http://sisyphus.hd.free.fr/~gilles/bx):
>
> * analogy: I have tried to disable some parts of analogy when compiling
> on machines without CONFIG_PCI, as compiling parts using PCI on a
> machine without PCI support, give various levels of warning and even
> errors depending on the architecture. Doing this, I stumbled across thi=
s
> compilation error:
> http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnue=
abi-gcc-4.3.3/log.html#1
> this is with CONFIG_NI_MIO, but without CONFIG_NI_MITE.
>
> So, Alex, could you:
> - fix that error, if this combination is supposed to make sense
> - fix the Kconfig/Makefile so that no PCI code is compiled if CONFIG_PC=
I
> is not set (I tried and do this myself, but better one who knows than
> 100 who have to search...). As I said, doing this result in various
> levels of success depending on the architecture.
>
> * blackfin: I finally compiled blackfin! had to build a toolchain for
> that as the binary-only toolchain from analog.com uses glibc 2.8 and
> mine is 2.7. However, blackfin does not compile very well, as can be
> seen by the log:
> http://sisyphus.hd.free.fr/~gilles/bx/bf537-stamp/2.6.30-bfin-uclinux-g=
cc-4.1.2/log.html#1
> It may happen that my toolchain is buggy or outdated though.
>
> * rtcan: on blackfin we seem to have a conflict with rtcan.
> The warning is about CAN_ERR_MASK, sure blackfin is a bit strange to
> define this in core headers which are included everywhere. This said,
> not prefixing a Xenomai symbol with something like XN seems to be askin=
g
> for trouble. Wolfgang, do you think it would be possible to rename the
> symbols with such prefix? Or do you share some code with socket-can tha=
t
> you do not want to touch?
>
> * nios2: I am lacking some important file needed to even start to compi=
le.
>
>  =20
You may use this tutorial on how to use Xenomai on NIOS 2 softcore=20
processor:=20
http://uuu.enseirb.fr/~kadionik/nios-xenomai/Xenomai%20on%20NIOS%20II%20S=
oftcore%20Processor.%20A%20step%20by%20step%20Guide.pdf

Regards,

Pat.
> Thanks in advance for your efforts.
> Regards.
>
>  =20


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb.fr/~kadionik         +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB                      http://www.enseirb.fr                   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+



