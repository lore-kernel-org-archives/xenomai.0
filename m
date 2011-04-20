Message-ID: <COL104-W8B4D8E6C75C99ECA28042E9930@domain.hid>
Content-Type: multipart/alternative;
	boundary="_405ccecf-7761-433a-804d-02f95027215b_"
From: =?iso-8859-1?B?RnJhbudvaXMgQmVhdWZvcnQ=?= <francois.beaufort@domain.hid>
Date: Wed, 20 Apr 2011 09:55:42 +0200
MIME-Version: 1.0
Subject: [Xenomai-core] xenomai and framebuffer-ipu on target iMx35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_405ccecf-7761-433a-804d-02f95027215b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C

I have to port Linux-xenomai on target Phytec PhyCARD-M iMx35 (ARM 11 core)=
 and I need your help.

I reconfigured the kernel from the configuration provided by Phytec :

    - CONFIG_PREEMPT =3D y
    - CONFIG_VGA_CONSOLE =3D n
    - CONFIG_MX3_IPU =3D n
    - CONFIG_FB_MX3 =3D n
    - CONFIG_USB_ISP1760 =3D n

So=2C Linux-xenomai runs on the target=2C but I can't have pictures on the =
display (the configuration of the framebuffer is not set : CONFIG_MX3_IPU a=
nd CONFIG_FB_MX3).

I would like to enable xenomai and the framebuffer.

When I patch Linux with adeos-ipipe=2C disable xenomai and enable ipu (imag=
e processing unit)=2C the kernel doesn't start :

        booting kernel of type uimage from /dev/ram0.kernel
           Verifying Checksum ... OK
           Image Name:   Linux-2.6.35.9
           Created:      2011-04-20   7:14:44 UTC
           Image Type:   ARM Linux Kernel Image (uncompressed)
           Data Size:    2446512 Bytes =3D  2.3 MB
           Load Address: 80008000
           Entry Point:  80008000
        OK
        commandline: console=3Dttymxc0=2C115200 video=3Dmx3fb:Primeview-PD0=
50VL1 ip=3D192.168.0.195::192.168.0.1:255.255.255.0::: root=3D/dev/nfs   nf=
sroot=3D192.168.0.84:/opt/francois/nfs_imx35_xenom=3B
        arch_number: 2595

        Starting kernel ...

        Linux version 2.6.35.9 (francois@domain.hid) (gcc version 4.3=
.2 (OSELAS.Toolchain-1.99.3) ) #2 PREEMPT Wed Apr 20 09:14:32 CEST 2011
        CPU: ARMv6-compatible processor [4117b363] revision 3 (ARMv6TEJ)=2C=
 cr=3D00c5387f
        CPU: VIPT nonaliasing data cache=2C VIPT nonaliasing instruction c


I think there is a conflict between ipipe and ipu but I don't know why.

IPU depends on dma engine.

When I read the /proc files=2C I can't see IRQ conflicts nor memory conflic=
ts.

The ipu driver consists of two C files : ipu_idmac.c and ipu_irq.c.=20
When I disable ipu_idma.c=2C I have 4 more IRQs (CONFIG_MX3_IPU_IRQS =3D 4)=
 and Linux-ipipe (and xenomai) starts but I can't have pictures on the disp=
lay.

I can't debug with printk because the printk calls modify the behaviour.

Do you have any idea ?

Thank you. 		 	   		  =

--_405ccecf-7761-433a-804d-02f95027215b_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
Hello=2C<br><br>I have to port Linux-xenomai on target Phytec PhyCARD-M iMx=
35 (ARM 11 core) and I need your help.<br><br>I reconfigured the kernel fro=
m the configuration provided by Phytec :<br><br>&nbsp=3B&nbsp=3B &nbsp=3B- =
CONFIG_PREEMPT =3D y<br>&nbsp=3B&nbsp=3B &nbsp=3B- CONFIG_VGA_CONSOLE =3D n=
<br>&nbsp=3B&nbsp=3B &nbsp=3B- CONFIG_MX3_IPU =3D n<br>&nbsp=3B&nbsp=3B &nb=
sp=3B- CONFIG_FB_MX3 =3D n<br>&nbsp=3B&nbsp=3B &nbsp=3B- CONFIG_USB_ISP1760=
 =3D n<br><br>So=2C Linux-xenomai runs on the target=2C but I can't have pi=
ctures on the display (the configuration of the framebuffer is not set : CO=
NFIG_MX3_IPU and CONFIG_FB_MX3).<br><br>I would like to enable xenomai and =
the framebuffer.<br><br>When I patch Linux with adeos-ipipe=2C disable xeno=
mai and enable ipu (image processing unit)=2C the kernel doesn't start :<br=
><br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3Bbooting kernel of ty=
pe uimage from /dev/ram0.kernel<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3B&nbsp=3B&nbsp=3B Verifying Checksum ... OK<br>&nbsp=3B&nbsp=3B =
&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B Image Name:&nbsp=3B&nbsp=
=3B Linux-2.6.35.9<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nb=
sp=3B&nbsp=3B Created:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 2011-04-20&n=
bsp=3B&nbsp=3B 7:14:44 UTC<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nb=
sp=3B&nbsp=3B&nbsp=3B Image Type:&nbsp=3B&nbsp=3B ARM Linux Kernel Image (u=
ncompressed)<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&=
nbsp=3B Data Size:&nbsp=3B&nbsp=3B&nbsp=3B 2446512 Bytes =3D&nbsp=3B 2.3 MB=
<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B Load=
 Address: 80008000<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nb=
sp=3B&nbsp=3B Entry Point:&nbsp=3B 80008000<br>&nbsp=3B&nbsp=3B &nbsp=3B&nb=
sp=3B&nbsp=3B &nbsp=3BOK<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=
=3Bcommandline: console=3Dttymxc0=2C115200 video=3Dmx3fb:Primeview-PD050VL1=
 ip=3D192.168.0.195::192.168.0.1:255.255.255.0::: root=3D/dev/nfs&nbsp=3B&n=
bsp=3B nfsroot=3D192.168.0.84:/opt/francois/nfs_imx35_xenom=3B<br>&nbsp=3B&=
nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3Barch_number: 2595<br><br>&nbsp=3B&=
nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3BStarting kernel ...<br><br>&nbsp=
=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3BLinux version 2.6.35.9 (franco=
is@domain.hid) (gcc version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #2 PREE=
MPT Wed Apr 20 09:14:32 CEST 2011<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3BCPU: ARMv6-compatible processor [4117b363] revision 3 (ARMv6TEJ=
)=2C cr=3D00c5387f<br>&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3BCPU=
: VIPT nonaliasing data cache=2C VIPT nonaliasing instruction c<br><br><br>=
I think there is a conflict between ipipe and ipu but I don't know why.<br>=
<br>IPU depends on dma engine.<br><br>When I read the /proc files=2C I can'=
t see IRQ conflicts nor memory conflicts.<br><br>The ipu driver consists of=
 two C files : ipu_idmac.c and ipu_irq.c. <br>When I disable ipu_idma.c=2C =
I have 4 more IRQs (CONFIG_MX3_IPU_IRQS =3D 4) and Linux-ipipe (and xenomai=
) starts but I can't have pictures on the display.<br><br>I can't debug wit=
h printk because the printk calls modify the behaviour.<br><br>Do you have =
any idea ?<br><br>Thank you. 		 	   		  </body>
</html>=

--_405ccecf-7761-433a-804d-02f95027215b_--

