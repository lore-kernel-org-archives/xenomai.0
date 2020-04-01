Date: Wed, 1 Apr 2020 08:49:23 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: ipipe kernel image compile error
Message-ID: <20200401084923.0b8290bc@md1za8fc.ad001.siemens.net>
In-Reply-To: <CA+K1mPH9u0FPKHO1gDFAn+Oz42MZe5Aw_j1GcZWd1LAWx6-QTQ@mail.gmail.com>
References: <CA+K1mPH9u0FPKHO1gDFAn+Oz42MZe5Aw_j1GcZWd1LAWx6-QTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith via Xenomai <xenomai@xenomai.org>

Hi,

i do not know what that timer is or whether it is wise to choose it for
an ipipe kernel.

You can probably work around the issue by not setting CONFIG_APB_TIMER
in your kernel configuration. And my guess is that you will not be
missing any features. In order to reproduce the issue, your config
would be useful.

Henning

On Tue, 31 Mar 2020 14:42:45 -0700
C Smith via Xenomai <xenomai@xenomai.org> wrote:

> Hi,
>=20
> I'm having a problem compiling Kernel 4.19.109 with
> ipipe-core-4.19.109-cip22-x86-11.patch using Xenomai-3.1.
>=20
> $ scripts/prepare-kernel.sh --linux=3D../linux/
> --ipipe=3D../ipipe-core-4.19.109-cip22-x86-11.patch --arch=3Dx86
>=20
> I'm compiling with:
> $ m -j4 bzImage
>=20
> I'm getting following error:
>=20
> arch/x86/kernel/apb_timer.c: In function =E2=80=98apbt_set_mapping=E2=80=
=99:
> arch/x86/kernel/apb_timer.c:122:21: error: too few arguments to
> function =E2=80=98dw_apb_clocksource_init=E2=80=99
>   clocksource_apbt =3D dw_apb_clocksource_init(APBT_CLOCKSOURCE_RATING,
>                      ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from arch/x86/kernel/apb_timer.c:31:
> ./include/linux/dw_apb_timer.h:50:1: note: declared here
>  dw_apb_clocksource_init(unsigned rating, const char *name, void
> __iomem *base,
>  ^~~~~~~~~~~~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:303: arch/x86/kernel/apb_timer.o]
> Error 1
> make[1]: *** [scripts/Makefile.build:544: arch/x86/kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
>=20
>=20
>  config_20200331
> <https://drive.google.com/file/d/1n3gdgMogUUKjleWzEgAEGu_330mYX_io/view?u=
sp=3Ddrive_web>
>=20
>=20
> Thank you
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config_20200331
> Type: application/octet-stream
> Size: 208519 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20200331/ed753c3a/attac=
hment.obj>


