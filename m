MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <96eea0c80910160325v208ff0c7rd5d669a2bfdc86e6@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<96eea0c80910160325v208ff0c7rd5d669a2bfdc86e6@domain.hid>
Date: Fri, 16 Oct 2009 12:49:49 +0200
Message-ID: <72cf3fb0910160349p73e1e7c8l27605521b1736b21@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Fwd: national instruments card and
	comedi-rtdm-dev
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

On Fri, Oct 16, 2009 at 12:25 PM, Peter Pastor <peter.pastor@domain.hid> wro=
te:
> Hey,
>
> After thinking about what I was doing :) I moved on an only compiled the
> drivers I needed (ni_pcimio.ko and ni_mite.ko) and loaded them
> successfully... first ni_mite.ko and then ni_pcimio.ko
>
> root@domain.hid# lsmod |
> grep ni
> ni_pcimio =A0 =A0 =A0 =A0 =A0 =A0 =A034280 =A00
> ni_mite =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6664 =A01 ni_pcimio
> xeno_comedi =A0 =A0 =A0 =A0 =A0 =A036084 =A01 ni_pcimio
>
> From what I understand, I now need to use comedi_config to create the dev=
ice
> file=A0 which is not necessarily in /dev/comedi0 but (maybe) somehow rema=
pped
> into...
>
> xenomai:/proc/xenomai/rtdm> ls
> comedi0 =A0comedi1 =A0comedi2 =A0comedi3 =A0comedi4 =A0comedi5 =A0comedi6
> comedi7 comedi8 =A0comedi9 =A0fildes =A0named_devices =A0open_fildes
> protocol_devices
>
> However, I get
>
> root@domain.hid# ./comedi_config -v comedi0 ni_pcimio
> comedi_config: comedi_snd_attach failed ret=3D-5
>
> dmesg shows then...
>
> [56710.390012] no device found
> [56710.390014] Available NI device IDs: 0x717f
> [56710.390017] Comedi: comedi_assign_driver: call(drv->attach) failed
> (ret=3D-5)

the driver name is comedi_pcimio instead of ni_pcimio. So you should type
comedi_config comedi0 comedi_pcimio.

The drivers' names are confusing. That point will be cleaned soonly.

> The test modules (comedi_fake and comedi_loop) which are provided by xeno=
mai
> did work, but I couldn't make sense out of it.
>
> What am I missing, what should I try out ??
>
> THANKS a lot,
> =A0peter
>
>
> ---------- Forwarded message ----------
> From: Peter Pastor <peter.pastor@domain.hid>
> Date: Thu, Oct 15, 2009 at 6:13 PM
> Subject: national instruments card and comedi-rtdm-dev
> To: xenomai@xenomai.org
>
>
> Hey,
>
> I am trying to get a national instrument data acquisition pci card workin=
g
> under linux 2.6.30.5 xenomai 2.5-rc3 using comedi. I successfully install=
ed
> the regular comedi drivers and I got data from the card, however, I also =
got
> mode switches. Therefore, I moved to the latest xenomai release which
> includes the comedi interface. The installation worked out and I got a
> xeno_comedi.ko module that I can load and a /usr/xenomai/lib/libcomedi.so=
.0.
> However, my program returns with...
>
> xenomai:~/xenomai_test> ./rt_comedi_test
> ./rt_comedi_test: /usr/xenomai/lib/libcomedi.so.0: no version information
> available (required by ./rt_comedi_test)
> Xenomai: incompatible ABI revision level
> (needed=3D1, current=3D2).
>
> I figured, that I need a national instrument driver (ni_pcimio) to get th=
e
> /dev/comedi0 up and running since there is no kernel module associated wi=
th
> the NI card...
>
> xenomai:~/xenomai_test> lspci -v
>
> ...
>
> 06:00.0 Class ff00: National Instruments Device 717f
> =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 11
> =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]
> =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]
>
> ...
>
> I "svn co http://svn.gna.org/svn/xenomai/branches/comedi-rtdm-dev" since =
it
> seems to contain the NI drivers... however, I got a compiler error that I
> think relates to the fact that the system I am using has 4GB of ram
> (highmem). I am using revision: 4727.
>
> root@domain.hid# make
> make=A0 all-recursive
> make[1]: Entering directory `/usr/src/comedi-rtdm-dev'
> Making all in comedi_kcore
> make[2]: Entering directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
> make[3]: Entering directory `/usr/src/comedi-rtdm-dev'
> make[3]: Leaving directory `/usr/src/comedi-rtdm-dev'
> make[3]: Entering directory `/usr/src/linux-2.6.30.5'
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_os_facilities.=
o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_command.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_instruction.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_driver.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_subdevice.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o
> /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c: In function
> =91comedi_free_buffer=92:
> /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c:52: error: implicit
> declaration of function =91__va_to_kva=92
> make[4]: *** [/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o] Erro=
r 1
> make[3]: *** [_module_/usr/src/comedi-rtdm-dev/comedi_kcore] Error 2
> make[3]: Leaving directory `/usr/src/linux-2.6.30.5'
> make[2]: *** [comedi.ko] Error 2
> make[2]: Leaving directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/comedi-rtdm-dev'
> make: *** [all] Error 2
>
> I would be really happy if someone could give me some hints/advice on how=
 to
> get things working. What do I need to do ??
>
> Thanks a lot,
> =A0peter
>

Alexis.

