Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] Newbie Question  : Compile vxWorks test programm
Date: Thu, 23 Feb 2006 14:28:36 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3A6D@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
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

Just when you posted your recomendation for xenomai-2.1-rc3 I found the =
answer !
Nothing wrong with my configuration, just the =
src/skins/vxworks/Makefile.am from release xenomai-2.1-rc2 is wrong =
(does not create the symbolic links to ksrc-sources). Taking the same =
file from xenomai-2.1-rc3 and everything is fine !
Nevertheless : Thank you for your help !!!



> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von=20
> Roderik_Wildenburg@domain.hid
> Gesendet: Donnerstag, 23. Februar 2006 12:02
> An: xenomai@xenomai.org
> Betreff: [Xenomai-help] Newbie Question : Compile vxWorks=20
> test programm
>=20
> Gilles Chanteperdrix wrote :
> >=20
> > libvxworks is generated only when UVM are enabled. You need=20
> to enable=20
> > building the UVM skin as a kernel module using menuconfig,=20
> and build=20
> > user-space libraries for the UVM skin using the configure option=20
> > --enable-uvm.
> >=20
>=20
> Dear Gilles thank you for your support.
> Unfortunatelly libvxworks is not build, even when I act as=20
> you suggested.
> This is what I did :
>=20
> - make menuconfig with kernel
> =3D=3D> .config entries as follows :
>=20
> {
>=20
> #
> # Real-time sub-system
> #
> CONFIG_XENOMAI=3Dy
> CONFIG_XENO_OPT_NUCLEUS=3Dy
>=20
> #
> # Nucleus options
> #
> CONFIG_XENO_OPT_PERVASIVE=3Dy
> CONFIG_XENO_OPT_PIPE=3Dy
> CONFIG_XENO_OPT_PIPE_NRDEV=3D32
> CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
> # CONFIG_XENO_OPT_ISHIELD is not set
> # CONFIG_XENO_OPT_STATS is not set
> # CONFIG_XENO_OPT_DEBUG is not set
> # CONFIG_XENO_OPT_WATCHDOG is not set
>=20
> #
> # Scalability options
> #
> # CONFIG_XENO_OPT_SCALABLE_SCHED is not set
>=20
> #
> # LTT tracepoints filtering
> #
> # CONFIG_XENO_OPT_FILTER_EVIRQ is not set #=20
> CONFIG_XENO_OPT_FILTER_EVTHR is not set #=20
> CONFIG_XENO_OPT_FILTER_EVSYS is not set #=20
> CONFIG_XENO_OPT_FILTER_EVALL is not set
>=20
> #
> # Interfaces
> #
> CONFIG_XENO_SKIN_NATIVE=3Dy
>=20
> #
> # Native interface options
> #
> CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
> CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=3D512
> CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D4096
> CONFIG_XENO_OPT_NATIVE_SEM=3Dy
> CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
> CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
> CONFIG_XENO_OPT_NATIVE_COND=3Dy
> CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
> CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
> CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
> CONFIG_XENO_OPT_NATIVE_MPS=3Dy
> CONFIG_XENO_OPT_NATIVE_INTR=3Dy
> CONFIG_XENO_SKIN_POSIX=3Dm
> CONFIG_XENO_SKIN_RTDM=3Dy
> CONFIG_XENO_SKIN_UVM=3Dm
> CONFIG_XENO_SKIN_PSOS=3Dm
> CONFIG_XENO_SKIN_VXWORKS=3Dm
> # CONFIG_XENO_SKIN_VRTX is not set
> # CONFIG_XENO_SKIN_UITRON is not set
> CONFIG_XENO_SKIN_RTAI=3Dm
>=20
> #
> # RTAI interface options
> #
> CONFIG_XENO_OPT_RTAI_FIFO=3Dy
> CONFIG_XENO_OPT_RTAI_SEM=3Dy
> CONFIG_XENO_OPT_RTAI_SHM=3Dy
>=20
> #
> # Real-time drivers
> #
> # CONFIG_XENO_DRIVERS_16550A is not set
> CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
>=20
> #
> # Machine
> #
> CONFIG_XENO_HW_FPU=3Dy
> # CONFIG_XENO_HW_PERIODIC_TIMER is not set=20
> CONFIG_XENO_HW_TIMER_LATENCY=3D0 CONFIG_XENO_HW_SCHED_LATENCY=3D0=20
>=20
> }
>=20
> -- configure within xenomai-directory
> ./configure --enable-uvm --prefix=3D`pwd`  --host=3Dppc-linux =3D=3D>=20
> attached config.log
>=20
> -- make ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx-=20
>=20
> -- make install-nodev
>=20
> =3D=3D> no vxworks-Library
>=20
> could you please have a look on the config.log, whether you=20
> can find an obvious mistake.
>=20
> Thank you very(!) much for your help in advance Roderik
>=20

