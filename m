Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 19 Oct 2009 23:24:09 +0200
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<96eea0c80910161648l1991b124w20ea9949e70f5ae0@domain.hid>
	<200910171600.16265.berlemont.hauw@domain.hid>
In-Reply-To: <200910171600.16265.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200910192324.09986.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] national instruments card and comedi-rtdm-dev
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Saturday 17 October 2009 16:00:15 Alexis Berlemont wrote:
> Hi,
>=20
> On Saturday 17 October 2009 01:48:47 Peter Pastor wrote:
> > Hey Alexis,
> >
> > >> That's because you did not retrieve the "comedi" branch, you are
> > >> working
> >
> > the
> >
> > >> master branch which is left unused.
> > >> You should create a branch on your local repository with the remote
> >
> > comedi
> >
> > >> branch as reference.
> >
> > Sorry... I managed to do it :) (I am new to git) However, I could not
> > compile the kernel :(
> >
> > drivers/xenomai/comedi/intel/8255.c:50:47: error: macro
> > "subdev_8255_interrupt" requires 2 arguments, but only 1 given
> > drivers/xenomai/comedi/intel/8255.c:51: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99,
> >  =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=
=98{=E2=80=99 token
> > drivers/xenomai/comedi/intel/8255.c: In function =E2=80=98do_config=E2=
=80=99:
> > drivers/xenomai/comedi/intel/8255.c:85: error: =E2=80=98CR_CW=E2=80=99 =
undeclared (first
> >  use in this function)
> > drivers/xenomai/comedi/intel/8255.c:85: error: (Each undeclared
> > identifier is reported only once
> > drivers/xenomai/comedi/intel/8255.c:85: error: for each function it
> > appears in.)
> > drivers/xenomai/comedi/intel/8255.c:88: error: =E2=80=98CR_A_IO=E2=80=
=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c:90: error: =E2=80=98CR_B_IO=E2=80=
=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c:92: error: =E2=80=98CR_C_LO_IO=E2=
=80=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c:94: error: =E2=80=98CR_C_HI_IO=E2=
=80=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c:95: error: =E2=80=98_8255_CR=E2=80=
=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c: In function =E2=80=98subd_8255_ins=
n_bits=E2=80=99:
> > drivers/xenomai/comedi/intel/8255.c:146: error: =E2=80=98_8255_DATA=E2=
=80=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c:204:42: error: macro
> > "subdev_8255_init" requires 2 arguments, but only 1 given
> > drivers/xenomai/comedi/intel/8255.c: At top level:
> > drivers/xenomai/comedi/intel/8255.c:205: error: expected =E2=80=98=3D=
=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99,
> > =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=
=98{=E2=80=99 token
> > drivers/xenomai/comedi/intel/8255.c: In function =E2=80=98dev_8255_atta=
ch=E2=80=99:
> > drivers/xenomai/comedi/intel/8255.c:274: error: =E2=80=98_8255_SIZE=E2=
=80=99 undeclared
> > (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c:282:25: error: macro
> > "subdev_8255_init" requires 2 arguments, but only 1 given
> > drivers/xenomai/comedi/intel/8255.c:282: error: =E2=80=98subdev_8255_in=
it=E2=80=99
> > undeclared (first use in this function)
> > drivers/xenomai/comedi/intel/8255.c: In function =E2=80=98dev_8255_deta=
ch=E2=80=99:
> > drivers/xenomai/comedi/intel/8255.c:306: error: =E2=80=98_8255_SIZE=E2=
=80=99 undeclared
> > (first use in this function)
> > make[4]: *** [drivers/xenomai/comedi/intel/8255.o] Error 1
> > make[3]: *** [drivers/xenomai/comedi/intel] Error 2
> > make[2]: *** [drivers/xenomai/comedi] Error 2
> > make[1]: *** [drivers/xenomai] Error 2
> > make: *** [drivers] Error 2
>=20
> My fault. I forgot to handle some pre-compilation constants when the
>  drivers are compiled as modules.
>=20
> I will update my git repository; meanwhile, you can statically link all t=
he
> comedi drivers into the kernel. That is a temporary solution until the fix
>  is available.

I updated the git repository a few hours after my answer to your last mail.=
=20
Did you have any opportunity to test it ? Or did you test a statical=20
configuration ?

Many thanks.

> > When I reconfigure the kernel to not compile 8255 and friends it does n=
ot
> > compile either...
> >
> > ... snip ...
> >   AS      arch/x86/boot/header.o
> >   LD      arch/x86/boot/setup.elf
> >   OBJCOPY arch/x86/boot/setup.bin
> >   BUILD   arch/x86/boot/bzImage
> > Root device is (8, 1)
> > Setup is 11692 bytes (padded to 11776 bytes).
> > System is 2347 kB
> > CRC 84c0200
> > Kernel: arch/x86/boot/bzImage is ready  (#1)
> > ERROR: "comedi_alloc_subd"
> > [drivers/xenomai/comedi/testing/comedi_loop.ko] undefined!
> > ERROR: "comedi_alloc_subd"
> > [drivers/xenomai/comedi/testing/comedi_fake.ko] undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
> >
> > I tried 2.6.31 and 2.6.30.5.
>=20
> Another bug of mine. The EXPORT_SYMBOL was missing.
>=20
> Once more, with a kernel in which the drivers are statically included, you
> won't face this issue anymore.
>=20
> > I really appreciate your help !
> >
> > Thanks,
> >  peter
>=20
Alexis.
=20

