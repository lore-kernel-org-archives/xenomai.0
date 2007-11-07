From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Wed, 7 Nov 2007 16:12:10 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200711061102.13154.lepalom@domain.hid> <4731D205.9020004@domain.hid>
In-Reply-To: <4731D205.9020004@domain.hid>
MIME-Version: 1.0
Message-Id: <200711071612.11444.lepalom@domain.hid>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

A Dimecres 07 Novembre 2007, Jan Kiszka va escriure:
> Leopold Palomo-Avellaneda wrote:
> > A Dimarts 06 Novembre 2007, Alexis Berlemont va escriure:
> >> Hi
> >>
> >>> And after, the jr3 driver, but I got with dmesg:
> >>>
> >>> jr3pci: module license 'unspecified' taints kernel.
> >>> jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> >>> jr3pci: Unknown symbol device_unregister
> >>> jr3pci: Unknown symbol device_register
> >>>
> >>>
> >>> so, I cannot load the driver. What I'm doing grong?
> >>
> >> Oops. My fault. Fixed in subversion.
> >>
> >> Please update.
> >
> > done, but when I do:
> > sudo insmod comedi_drivers/misc_drivers/jr3pci.ko
> >
> > I got a console hangs, with no response and the dmesg says:
> > jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> > comedi_add_drv: name=3Djr3_pci
> > comedi_lct_drv: name=3Djr3_pci
> >
> >
> > Now, I'm still blocked ....
>
> Are you sure the (re-)build was clean? I haven't checked the comedi
> branch recently for changes and/or problems with the build system, but
> this used to work fine for me - once. :)
>
make distclean;
svn uptade;
svn status;
=2E/configure -with-xeno-install-path=3D/usr --with-linux-dir=3D/usr/src/li=
nux-headers-2.6.22-xenomai-2.4-rc5

make

all normal but:

=2E....
 CC [M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_kcore/comedi_transfer.o
/usr/src/xenomai-comedi-rtdm-dev/comedi_kcore/comedi_transfer.c: In=20
function =E2=80=98comedi_ioctl_poll=E2=80=99:
/usr/src/xenomai-comedi-rtdm-dev/comedi_kcore/comedi_transfer.c:834: warnin=
g:=20
cast from pointer to integer of different size

=2E.....
make[4]: Entering directory `/usr/src/linux-headers-2.6.22-xenomai-2.4-rc5'
  CC=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_te=
st_fake.o
  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_te=
stfake.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "comedi_rm_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_cleanup_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_drv_evt_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_drv_get_cmd"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_drv_memcpy_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_get_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_check_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_drv_add_subd"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_init_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!
WARNING: "comedi_add_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testfa=
ke.ko]=20
undefined!

make[4]: Entering directory `/usr/src/linux-headers-2.6.22-xenomai-2.4-rc5'
  CC=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_te=
st_loop.o
  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_te=
stloop.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "comedi_drv_evt_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_rm_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_cleanup_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_drv_evt_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_drv_memcpy_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_get_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_drv_memcpy_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_check_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_drv_add_subd"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_init_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
WARNING: "comedi_add_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_testlo=
op.ko]=20
undefined!
 =20
CC      /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi=
_testloop.mod.o
  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers/comedi_te=
stloop.ko
make[4]: Leaving directory `/usr/src/linux-headers-2.6.22-xenomai-2.4-rc5'
make[3]: Leaving directory=20
`/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/test_drivers'
Making all in ni_drivers

=2E.......


make[4]: Entering directory `/usr/src/linux-headers-2.6.22-xenomai-2.4-rc5'
  CC [M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/pcimio=
=2Eo
/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/pcimio.c: In=20
function =E2=80=98pcimio_attach=E2=80=99:
/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/pcimio.c:780:=20
warning: =E2=80=98deprecated_irq_flag=E2=80=99 is deprecated (declared at=20
include/linux/interrupt.h:66)


=2E...........................

  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "comedi_drv_global_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_free_irq"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_evt_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_get_irq"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "range_bipolar10"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_set_irq"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_rm_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_cleanup_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_error_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_check_global_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_stop_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_error_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_global_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_evt_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_get_cmd"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_memcpy_put"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_check_global_get"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_get_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_request_irq"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_check_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_add_subd"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_init_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_drv_get_nbchan"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
WARNING: "comedi_add_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko]=20
undefined!
 =20
CC      /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimi=
o.mod.o
  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers/ni_pcimio.ko
make[4]: Leaving directory `/usr/src/linux-headers-2.6.22-xenomai-2.4-rc5'
make[3]: Leaving directory=20
`/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/ni_drivers'
Making all in misc_drivers
make[3]: Entering directory=20
`/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers'
make[4]: Entering directory `/usr/src/xenomai-comedi-rtdm-dev'
make[4]: Leaving directory `/usr/src/xenomai-comedi-rtdm-dev'
make[4]: Entering directory `/usr/src/linux-headers-2.6.22-xenomai-2.4-rc5'
  CC=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3_pci.o
/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3_pci.c: In=
=20
function =E2=80=98jr3_pci_attach=E2=80=99:
/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3_pci.c:778:=
=20
warning: format =E2=80=98%x=E2=80=99 expects type =E2=80=98unsigned int=E2=
=80=99, but argument 2 has=20
type =E2=80=98long unsigned int=E2=80=99
/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3_pci.c:858:=
=20
warning: cast from pointer to integer of different size
/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3_pci.c:858:=
=20
warning: cast from pointer to integer of different size
  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "comedi_rm_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko]=20
undefined!
WARNING: "comedi_cleanup_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko]=20
undefined!
WARNING: "comedi_get_time"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko]=20
undefined!
WARNING: "comedi_get_dev"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko]=20
undefined!
WARNING: "comedi_init_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko]=20
undefined!
WARNING: "comedi_add_drv"=20
[/usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko]=20
undefined!
 =20
CC      /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci=
=2Emod.o
  LD=20
[M]  /usr/src/xenomai-comedi-rtdm-dev/comedi_drivers/misc_drivers/jr3pci.ko



=2E..........................................


sudo insmod comedi_kcore/comedi.ko  =20

ok
sudo modprobe firmware_class

ok

sudo insmod comedi_drivers/misc_drivers/jr3pci.ko
=2E.....
jr3pci: no version for "comedi_add_drv" found: kernel tainted.
comedi_add_drv: name=3Djr3_pci
comedi_lct_drv: name=3Djr3_pci

console blocked ....

Regards,

Leo

