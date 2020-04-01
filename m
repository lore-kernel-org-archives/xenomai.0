Subject: Re: ipipe kernel image compile error
References: <CA+K1mPH9u0FPKHO1gDFAn+Oz42MZe5Aw_j1GcZWd1LAWx6-QTQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <28b4efd1-1013-02f1-e3e3-6ee0871e58c2@web.de>
Date: Wed, 1 Apr 2020 09:06:24 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPH9u0FPKHO1gDFAn+Oz42MZe5Aw_j1GcZWd1LAWx6-QTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 31.03.20 23:42, C Smith via Xenomai wrote:
> Hi,
>
> I'm having a problem compiling Kernel 4.19.109 with
> ipipe-core-4.19.109-cip22-x86-11.patch using Xenomai-3.1.
>
> $ scripts/prepare-kernel.sh --linux=3D../linux/
> --ipipe=3D../ipipe-core-4.19.109-cip22-x86-11.patch --arch=3Dx86
>
> I'm compiling with:
> $ m -j4 bzImage
>
> I'm getting following error:
>
> arch/x86/kernel/apb_timer.c: In function =E2=80=98apbt_set_mapping=E2=80=
=99:
> arch/x86/kernel/apb_timer.c:122:21: error: too few arguments to function
> =E2=80=98dw_apb_clocksource_init=E2=80=99
>    clocksource_apbt =3D dw_apb_clocksource_init(APBT_CLOCKSOURCE_RATING,
>                       ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from arch/x86/kernel/apb_timer.c:31:
> ./include/linux/dw_apb_timer.h:50:1: note: declared here
>   dw_apb_clocksource_init(unsigned rating, const char *name, void __iome=
m
> *base,
>   ^~~~~~~~~~~~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:303: arch/x86/kernel/apb_timer.o]
> Error 1
> make[1]: *** [scripts/Makefile.build:544: arch/x86/kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
>
>   config_20200331
> <https://drive.google.com/file/d/1n3gdgMogUUKjleWzEgAEGu_330mYX_io/view?=
usp=3Ddrive_web>
>

I thought we came across this already and fixed it but... no:

https://gitlab.denx.de/Xenomai/ipipe-noarch/-/commit/a1cfa77db06c3967fc8c7=
90eefa656562f0fba5d
is broken as it is not arch-agnostic. I'll rip that off from the x86
tree for the next release.

Meanwhile, you can work around that by disabling CONFIG_X86_INTEL_MID -
unless you are on an Intel MID platform. Are you?

Jan

