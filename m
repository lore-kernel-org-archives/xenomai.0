Message-ID: <4AE97F42.50602@domain.hid>
Date: Thu, 29 Oct 2009 12:40:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200910281314.00378.leo@domain.hid>	<200910291123.21542.leo@domain.hid>
	<4AE974A0.30509@domain.hid> <200910291225.27382.leo@domain.hid>
In-Reply-To: <200910291225.27382.leo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo-Avellaneda wrote:
> A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
>> Leopold Palomo-Avellaneda wrote:
>>> A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
>>>> Gilles Chanteperdrix wrote:
>>>>> Leopold Palomo-Avellaneda wrote:
>>>>>> OTOH, the debian package has a bug. I cannot compile xenomai, usin=
g
>>>>>> the debian way on kernels 2.6.28, 2.6.29 and 2.6.30 because the
>>>>>> package add something that fails with make menuconfig. I should wr=
ite
>>>>>> a bug. Just for information, it's not a xenomai upstream related
>>>>>> question. ;-)
>>>>> Please check xenomai-2.4.9.1. It may happen that the bug has been
>>>>> already solved.
>>>> 2.4.10
>>> nops, sorry again my fingers were so fast ...
>>>
>>> we are talking about the same? I got:
>>>
>>> cripts/kconfig/conf -o arch/x86/Kconfig
>>> arch/x86/Kconfig:74: unexpected option "select"
>>> arch/x86/Kconfig:75: unexpected option "select"
>>> make[3]: *** [oldconfig] Error 1
>>> make[2]: *** [oldconfig] Error 2
>> I am not talking about any specific bug. It was just a general advice.
>> In any case, we are not responsible for the Xenomai packages made by t=
he
>> Debian team, but if you find bugs in the debian directory which is par=
t
>> of the Xenomai package, we are interested in fixing them, of course.
>=20
> well, I have found two things:
>=20
> 1) the debian directory is very similar in both (upstream and debian=20
> official). The method to create the package is described in the xenomai=
 wiki=20
> and have been working so well till now (at least in my case). The scrip=
t or=20
> the patch applied in the versions of the kernel 2.6.28>=3D introduces s=
omething=20
> that make fail the make menuconfig step. If you apply the patch with th=
e=20
> script (scripts/prepare-kernel.sh) the make menuconfig works
>=20
> 2) after the step of preparing the kernel, (with xenomai 2.4.10) when I=
=20
> compile the kernel (2.6.30., it fails in:
>=20
>  CC      arch/x86/xenomai/hal-common.o
> arch/x86/xenomai/hal_32.c: In function =E2=80=98rthal_latency_above_max=
=E2=80=99:
> arch/x86/xenomai/hal_32.c:139: warning: passing argument 1 of =E2=80=98=
die_nmi=E2=80=99 from=20
> incompatible pointer type
> arch/x86/xenomai/hal_32.c:139: warning: passing argument 2 of =E2=80=98=
die_nmi=E2=80=99 from=20
> incompatible pointer type
> arch/x86/xenomai/hal_32.c:139: error: too few arguments to function =E2=
=80=98die_nmi=E2=80=99
> make[2]: *** [arch/x86/xenomai/hal_32.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
>   LD      arch/x86/oprofile/built-in.o
>   CC      net/socket.o

Just disable CONFIG_XENO_HW_NMI_DEBUG_LATENCY (it's widely broken in 2.4
for recent kernels).

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

