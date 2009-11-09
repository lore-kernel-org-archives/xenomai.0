From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Mon, 9 Nov 2009 13:54:53 -0700
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310B0104@domain.hid>
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
	<4AA95F97.6010802@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDBCD@midas.usurf.usu.edu>
	<4AA96689.3010502@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDC03@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03248BDC03@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Installation and Makefile Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan Haws <Jonathan.Haws@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > >> Use DESTDIR, that is what it was made for. The makefiles use it
> > >> when running "make install", and xeno-config prepends it to the
> > >> directories it returns.
> > >>
> > >> So, in a makefile, you woud do:
> > >>
> > >> XENO_DESTDIR:=3D~/eldk/ppc_4xx
> > >> XENO_CONFIG:=3D$(XENO_DESTDIR)/usr/local/xenomai/bin/xeno-config
> > >> XENO_CPPFLAGS:=3D$(shell DESTDIR=3D$(XENO_DESTDIR) $(XENO_CONFIG) -
> -
> > >> xeno-cflags) XENO_LIBS:=3D$(shell DESTDIR=3D$(XENO_DESTDIR)
> > >> $(XENO_CONFIG) --xeno- ldflags)
> > >
> > > Ah, that makes sense.  Thanks, Gilles.
> > >
> > >
> > >> Note that to ease working in a cross-compile embedded
> > environnement
> > >>  you may want to avoid copying header files, documentation,
> > etc...
> > >> in the directory that will be used to generate the root
> > filesystem.
> > >> In this case pass a different --prefix and --exec-prefix
> options
> > to
> > >>  xenomai configure script.
> > >
> > > So, in that case I would do something like the following:
> > >
> > > ./configure --exec-prefix=3D~/eldk/ppc_4xx/usr/local/xenomai \
> > > --prefix=3D/usr/local/xenomai --host=3Dppc-linux
> > >
> > > That would put headers, documentation, and other development
> files
> > in
> > > a usable location on the host and the libraries and executables
> in
> > > ~/eldk/ppc_4xx.
> >
> > Well no, unfortunately not. To get things working properly, you
> have
> > to
> > pass ~/eldk/ppc_4xx as the DESTDIR when running "make install". At
> > least
> > that is the way the makefiles coming from automake are supposed to
> > be
> > used.
> >
> > So, what you would do is rather:
> > ./configure --exec-prefix=3D/usr/local/xenomai --prefix=3D/xenomai-
> host
> > --host=3Dppc-linux
> >
> > And then in the script generating the rootfs, prune the
> > ~/eldk/ppc_4xx/xenomai-host directory.
>=20
> Ah, yes.  I can see that now that I tried exactly what I just
> mentioned.  This make sense.


Follow up question:

I am trying to get a kernel module to build correctly and I am running into=
 problems passing the Xenomai information to the kbuild system.  Here is wh=
at I am seeing:

rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions *.order \
                        *.symvers main
echo -I/home/jhaws/eldk/ppc_4xx/xenomai-host/include -D_GNU_SOURCE -D_REENT=
RANT -D__XENO__
-I/home/jhaws/eldk/ppc_4xx/xenomai-host/include -D_GNU_SOURCE -D_REENTRANT =
-D__XENO__
make -C ~/embedded-linux/linux-2.6-xenomai M=3D/home/jhaws/workspace/benchF=
PGA modules
make[1]: Entering directory `/home/jhaws/embedded-linux/linux-2.6-xenomai'
  CC [M]  /home/jhaws/workspace/benchFPGA/fpgaDriver.o
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:34:24: error: native/sem.h: No=
 such file or directory
In file included from /home/jhaws/workspace/benchFPGA/fpgaDriver.c:37:
/home/jhaws/workspace/benchFPGA/fpga.h:248: error: expected specifier-quali=
fier-list before 'RT_SEM'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_isr':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:126: error: implicit declarati=
on of function 'rt_sem_v'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:126: error: 'fpga_dev' has no =
member named 'sarSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_init':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:164: error: 'fpga_dev' has no =
member named 'openCount'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:166: error: 'fpga_dev' has no =
member named 'cdev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:167: error: 'fpga_dev' has no =
member named 'cdev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:168: error: 'fpga_dev' has no =
member named 'cdev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:169: error: 'fpga_dev' has no =
member named 'cdev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_exit':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:199: error: 'fpga_dev' has no =
member named 'cdev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_probe':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:232: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:330: error: implicit declarati=
on of function 'rt_sem_create'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:330: error: 'fpga_dev' has no =
member named 'sarSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:330: error: 'S_FIFO' undeclare=
d (first use in this function)
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:330: error: (Each undeclared i=
dentifier is reported only once
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:330: error: for each function =
it appears in.)
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:335: error: 'fpga_dev' has no =
member named 'igsSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:340: error: 'fpga_dev' has no =
member named 'novaSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:347: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:351: error: implicit declarati=
on of function 'rt_sem_delete'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:351: error: 'fpga_dev' has no =
member named 'novaSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:352: error: 'fpga_dev' has no =
member named 'igsSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:353: error: 'fpga_dev' has no =
member named 'sarSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_remove':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:385: error: 'fpga_dev' has no =
member named 'novaSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:386: error: 'fpga_dev' has no =
member named 'igsSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:387: error: 'fpga_dev' has no =
member named 'sarSem'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:390: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_open':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:408: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:414: error: 'fpga_dev' has no =
member named 'openCount'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:416: error: 'fpga_dev' has no =
member named 'openCount'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:422: error: 'fpga_dev' has no =
member named 'openCount'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:425: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:428: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:429: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:432: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c: In function 'fpga_release':
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:455: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:455: error: 'fpga_dev' has no =
member named 'pcidev'
/home/jhaws/workspace/benchFPGA/fpgaDriver.c:458: error: 'fpga_dev' has no =
member named 'openCount'
make[2]: *** [/home/jhaws/workspace/benchFPGA/fpgaDriver.o] Error 1
make[1]: *** [_module_/home/jhaws/workspace/benchFPGA] Error 2
make[1]: Leaving directory `/home/jhaws/embedded-linux/linux-2.6-xenomai'
make: *** [modules] Error 2

That is when I run a make clean all.

Here is the Makefile:

###########################################################################=
####
#
# Makefile for FPGA Driver
#
###########################################################################=
####
#
# This makefile is a generic makefile which will compile a module outside t=
he
# kernel source tree.  KERNELDIR specifies where the location of the kernel=
=20
# source tree is and is passed on to the subsequent make call for the targe=
t.
#

# Comment / uncomment the following line to disable / enable debugging flag=
s
# DEBUG =3D y

ifeq ($(DEBUG),y)
	DFLAGS =3D -O -g -DFPGA_DEBUG
else
	DFLAGS =3D -O2
endif=20

###########################################################################=
####
# Definitions
#
# To build Xenomai enabled programs, access to xeno-config is needed.  It i=
s
# typically located in <ELDK-PATH>/ppc_4xx/usr/local/xenomai/bin.
# xeno-config is used to get the necessary flags for the compiler and linke=
r
# to be able to link the correct libraries in.  However, xeno-config return=
s
# the location of the libraries on the target, which is /usr/local/xenomai,=
=20
# typically.  To work around this use DESTDIR.  DESTDIR will be prepended t=
o
# the paths coming out of the call to xeno-config.
#
#		e.g. -I/usr/local/xenomai would become -I$(DESTDIR)/usr/local/xenomai
#
# See the definitions below for examples of usage of DESTDIR.
###########################################################################=
####
ELDK_ROOTPATH =3D ~/eldk/ppc_4xx
XENOMAI =3D $(ELDK_ROOTPATH)/usr/local/xenomai
XENO_CONFIG =3D $(XENOMAI)/bin/xeno-config
XENO_CFLAGS =3D $(shell DESTDIR=3D$(ELDK_ROOTPATH) $(XENO_CONFIG) --xeno-cf=
lags)
XENO_LIBS =3D $(shell DESTDIR=3D$(ELDK_ROOTPATH) $(XENO_CONFIG) --xeno-ldfl=
ags)

CC =3D ppc_4xx-gcc
OBJCOPY =3D ppc_4xx-objcopy
READELF =3D ppc_4xx-readelf
LD =3D ppc_4xx-ld
KCFLAGS =3D -Wall $(XENO_CFLAGS) $(DFLAGS)
KAFLAGS =3D -mregnames
LDFLAGS =3D $(XENO_LIBS) -static
LIBS =3D -lnative -lpthread cacheFuncs.o


###########################################################################=
####
# Targets
###########################################################################=
####=20

# Get Kernel Information
ifeq ($(KERNELRELEASE),)

	KERNELDIR :=3D ~/embedded-linux/linux-2.6-xenomai
	PWD :=3D $(shell pwd)

all: modules main
=09
modules:
	echo $(XENO_CFLAGS)
	$(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules
=09
main:
	ppc_4xx-gcc $(EXTRA_CFLAGS) $(LDFLAGS) -o main main.c $(LIBS)
=09
cacheFuncs.o:
	ppc_4xx-gcc -mregnames -c cacheFuncs.S
=09
modules_install:
	$(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules_install
=09
clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions *.order \
			*.symvers main
=09
.PHONY: modules modules_install clean

else

#	We are calling make from the kernel build system, therefore we simply def=
ine
#	what the modules are.
=09
	obj-m :=3D fpgaDriver.o

endif


It seems like the kbuild system is not seeing the native/sem.h file, and th=
us is causing all the subsequent errors.  However, I have the KCFLAGS set t=
o what they need to be, so what am I missing?

Thanks!

