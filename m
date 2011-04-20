Message-ID: <4DAE99F2.7030002@domain.hid>
Date: Wed, 20 Apr 2011 10:31:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL104-W8B4D8E6C75C99ECA28042E9930@domain.hid>
In-Reply-To: <COL104-W8B4D8E6C75C99ECA28042E9930@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai and framebuffer-ipu on target iMx35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVmb3J0?= <francois.beaufort@domain.hid>
Cc: xenomai@xenomai.org

Fran=C3=A7ois Beaufort wrote:
> Hello,
>=20
> I have to port Linux-xenomai on target Phytec PhyCARD-M iMx35 (ARM 11 c=
ore) and I need your help.
>=20
> I reconfigured the kernel from the configuration provided by Phytec :
>=20
>     - CONFIG_PREEMPT =3D y
>     - CONFIG_VGA_CONSOLE =3D n
>     - CONFIG_MX3_IPU =3D n
>     - CONFIG_FB_MX3 =3D n
>     - CONFIG_USB_ISP1760 =3D n
>=20
> So, Linux-xenomai runs on the target, but I can't have pictures on the =
display (the configuration of the framebuffer is not set : CONFIG_MX3_IPU=
 and CONFIG_FB_MX3).
>=20
> I would like to enable xenomai and the framebuffer.
>=20
> When I patch Linux with adeos-ipipe, disable xenomai and enable ipu (im=
age processing unit), the kernel doesn't start :
>=20
>         booting kernel of type uimage from /dev/ram0.kernel
>            Verifying Checksum ... OK
>            Image Name:   Linux-2.6.35.9
>            Created:      2011-04-20   7:14:44 UTC
>            Image Type:   ARM Linux Kernel Image (uncompressed)
>            Data Size:    2446512 Bytes =3D  2.3 MB
>            Load Address: 80008000
>            Entry Point:  80008000
>         OK
>         commandline: console=3Dttymxc0,115200 video=3Dmx3fb:Primeview-P=
D050VL1 ip=3D192.168.0.195::192.168.0.1:255.255.255.0::: root=3D/dev/nfs =
  nfsroot=3D192.168.0.84:/opt/francois/nfs_imx35_xenom;
>         arch_number: 2595
>=20
>         Starting kernel ...
>=20
>         Linux version 2.6.35.9 (francois@domain.hid) (gcc version=
 4.3.2 (OSELAS.Toolchain-1.99.3) ) #2 PREEMPT Wed Apr 20 09:14:32 CEST 20=
11
>         CPU: ARMv6-compatible processor [4117b363] revision 3 (ARMv6TEJ=
), cr=3D00c5387f
>         CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction =
c
>=20
>=20
> I think there is a conflict between ipipe and ipu but I don't know why.=

>=20
> IPU depends on dma engine.
>=20
> When I read the /proc files, I can't see IRQ conflicts nor memory confl=
icts.
>=20
> The ipu driver consists of two C files : ipu_idmac.c and ipu_irq.c.=20
> When I disable ipu_idma.c, I have 4 more IRQs (CONFIG_MX3_IPU_IRQS =3D =
4) and Linux-ipipe (and xenomai) starts but I can't have pictures on the =
display.
>=20
> I can't debug with printk because the printk calls modify the behaviour=
=2E

How so?

>=20
> Do you have any idea ?

First thing to confirm: does the same configuration which does not work
with I-pipe enabled work with I-pipe disable. I mean, the exact same
configuration except for CONFIG_IPIPE?

Second thing: if the IPU dma engine, whatever, uses an interrupt, can
you compare the counters in /proc/interrupts for this interrupt with and
without CONFIG_IPIPE enabled?


--=20
					    Gilles.


