Message-ID: <COL122-W659C1B6386C63F74DEBCA2BDB40@domain.hid>
Content-Type: multipart/alternative;
	boundary="_65fe4037-d917-4687-b619-8327189a5081_"
From: krishna m <krishnamurthyjs@domain.hid>
Date: Tue, 22 Mar 2011 23:50:27 +0530
In-Reply-To: <4D88D66F.6020605@domain.hid>
References: <COL122-W1001B88CC08016B1C1774EBDCE0@domain.hid>
	<4D80BA8B.7050803@domain.hid>,<4D81C6AD.8050803@domain.hid>
	<COL122-W637BE46C7D8B2CB7F79760BDB50@domain.hid>,
	<4D88925C.3040609@domain.hid>
	<COL122-W1673FD60DDA60D713554EBDB40@domain.hid>
	<4D88D39D.907@domain.hid>,<4D88D66F.6020605@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MSI support in Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

--_65fe4037-d917-4687-b619-8327189a5081_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> Date: Tue=2C 22 Mar 2011 18:03:43 +0100
> From: gilles.chanteperdrix@xenomai.org
> To: jan.kiszka@domain.hid
> CC: krishnamurthyjs@domain.hid xenomai@xenomai.org
> Subject: Re: MSI support in Xenomai
>=20
> Jan Kiszka wrote:
> > On 2011-03-22 16:55=2C krishna m wrote:
>=20
> >> Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=
=3D0
> >> Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00.0: found PCI INT=
 A -> IRQ 10
> >=20
> > Here you get IRQ 10...
> >=20
> >> Mar 22 21:12:47 localhost kernel: pci_bar =3D 0xfe000000
> >> Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT open handler is de=
precated=2C=20
> >> driver requires update.
> >> Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT close handler is d=
eprecated=2C=20
> >> driver requires update.
> >=20
> > [ These messages also have a meaning=2C though unrelated to the crash. =
]
> >=20
> >> Mar 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assign=
ed to the=20
> >> device.
> >=20
> > ...but here IRQ 16 is assigned. Broken output or a real inconsistency?
> >=20
> > Also=2C where is the MSI? You should see log messages about MSI/MSI-X I=
RQ
> > number assignment when properly enabling the support at PCI level.
>=20
> Maybe pci_enable_msi was called after request_irq ?
>=20
>=20
> --=20
> Gilles.
=20
Just check my code:
i do enable MSI  (pci_enable_msi) before rtdm_irq_request pasted the code b=
elow part of my PCI probe function in the device driver:
=20
......
rtdm_dev =3D kmalloc(sizeof(struct rtdm_device)=2C GFP_KERNEL)=3B
  if(!rtdm_dev) {
   printk(KERN_WARNING "RUBICON: kmalloc failed\n")=3B
   ret =3D -ENOMEM=3B //Insufficient storage space is available.
   goto fail_pci=3B
  }

  //copy the structure to the new memory
  memcpy(rtdm_dev=2C &rubicon_rtdm_driver=2C sizeof(struct rtdm_device))=3B

  //create filename
  snprintf(rtdm_dev->device_name=2C
           RTDM_MAX_DEVNAME_LEN=2C "rtser%d"=2C 0 /*i*/)=3B
  rtdm_dev->device_id =3D 0=3B //i=3B

  //define two other members of the rtdm_device structure
  rtdm_dev->proc_name =3D rtdm_dev->device_name=3B
=20
  ret =3D rtdm_dev_register(rtdm_dev)=3B
  if(ret < 0) {
   printk(KERN_WARNING"RUBICON: cannot register device\n")=3B
   goto fail_pci=3B
  }
  g_rubicon_context.xen_device =3D rtdm_dev=3B
=20
  ret =3D pci_enable_msi(dev)=3B
  if(ret) {
   printk("RUBICON: Enabling MSI failed wuth error code: 0x%x\n"=2C ret)=3B
   goto fail_pci=3B
  }

  g_rubicon_context.irq =3D dev->irq=3B /* save the allocated IRQ */
  g_rubicon_context.dev =3D dev=3B /* Save the PCI queue h/w device ctx */
  dev_set_drvdata(dev=2C(void *) &(g_rubicon_context))=3B
  /* request the irq for the device */
  ret =3D rtdm_irq_request(&g_rubicon_context.irq_handle=2C
                         g_rubicon_context.irq=2C
                         rubicon_irq_handler=2C
                         RTDM_IRQTYPE_SHARED=2C
                         "rubicon"=2C
                         (void *)&g_rubicon_context)=3B
....
=20
>From IRQ number perspective:
Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00.0: found PCI INT A ->=
 IRQ 10  >>>> is the print from the Kernel PCI Probe and=20
Mar 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assigned >>=
>>>> is my Print after enabling MSI and registering for irq.
=20
I get the similar print with the Plain Linux kernel with the IRQ being assi=
gned MSI enabled is irq 20. [Below i have pasted the kernel log of plain li=
nux kernel]. I have tested the MSI interrupts and they work fine.=20
Mar 22 23:47:49 localhost kernel: test_dev: Probe for device function=3D0
Mar 22 23:47:49 localhost kernel: test_dev 0000:15:00.0: found PCI INT A ->=
 IRQ 10
Mar 22 23:47:49 localhost kernel: pci_bar =3D 0xfe000000=20
Mar 22 23:47:49 localhost kernel: test_dev: IRQ 20 successfully assigned to=
 the device.
Mar 22 23:47:49 localhost kernel: test_dev: Probe for device function=3D1
Mar 22 23:47:49 localhost kernel: test_dev: Successfully added test_dev Dev=
ice Driver.

thanks
-krishna=20
  		 	   		  =

--_65fe4037-d917-4687-b619-8327189a5081_
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
&gt=3B Date: Tue=2C 22 Mar 2011 18:03:43 +0100<BR>&gt=3B From: gilles.chant=
eperdrix@domain.hid<BR>&gt=3B To: jan.kiszka@domain.hid<BR>&gt=3B CC: kri=
shnamurthyjs@domain.hid xenomai@xenomai.org<BR>&gt=3B Subject: Re: MSI=
 support in Xenomai<BR>&gt=3B <BR>&gt=3B Jan Kiszka wrote:<BR>&gt=3B &gt=3B=
 On 2011-03-22 16:55=2C krishna m wrote:<BR>&gt=3B <BR>&gt=3B &gt=3B&gt=3B =
Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=3D0<B=
R>&gt=3B &gt=3B&gt=3B Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00=
.0: found PCI INT A -&gt=3B IRQ 10<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Here =
you get IRQ 10...<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B&gt=3B Mar 22 21:12:47 =
localhost kernel: pci_bar =3D 0xfe000000<BR>&gt=3B &gt=3B&gt=3B Mar 22 21:1=
2:47 localhost kernel: Xenomai: RTDM: RT open handler is deprecated=2C <BR>=
&gt=3B &gt=3B&gt=3B driver requires update.<BR>&gt=3B &gt=3B&gt=3B Mar 22 2=
1:12:47 localhost kernel: Xenomai: RTDM: RT close handler is deprecated=2C =
<BR>&gt=3B &gt=3B&gt=3B driver requires update.<BR>&gt=3B &gt=3B <BR>&gt=3B=
 &gt=3B [ These messages also have a meaning=2C though unrelated to the cra=
sh. ]<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B&gt=3B Mar 22 21:12:47 localhost ke=
rnel: test_dev: IRQ 16 successfully assigned to the <BR>&gt=3B &gt=3B&gt=3B=
 device.<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B ...but here IRQ 16 is assigned.=
 Broken output or a real inconsistency?<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B =
Also=2C where is the MSI? You should see log messages about MSI/MSI-X IRQ<B=
R>&gt=3B &gt=3B number assignment when properly enabling the support at PCI=
 level.<BR>&gt=3B <BR>&gt=3B Maybe pci_enable_msi was called after request_=
irq ?<BR>&gt=3B <BR>&gt=3B <BR>&gt=3B -- <BR>&gt=3B Gilles.<BR>
&nbsp=3B<BR>
Just check my code:<BR>
i do enable MSI&nbsp=3B (<FONT face=3D"Courier New">pci_enable_msi) </FONT>=
before <FONT face=3D"Courier New">rtdm_irq_request pasted the code below pa=
rt of my PCI probe function in the device driver:</FONT><BR>
&nbsp=3B<BR>
......<BR>
<FONT face=3D"Courier New">rtdm_dev =3D kmalloc(sizeof(struct rtdm_device)=
=2C GFP_KERNEL)=3B<BR>&nbsp=3B&nbsp=3Bif(!rtdm_dev) {<BR>&nbsp=3B&nbsp=3B&n=
bsp=3Bprintk(KERN_WARNING "RUBICON: kmalloc failed\n")=3B<BR>&nbsp=3B&nbsp=
=3B&nbsp=3Bret =3D -ENOMEM=3B //Insufficient storage space is available.<BR=
>&nbsp=3B&nbsp=3B&nbsp=3Bgoto fail_pci=3B<BR>&nbsp=3B&nbsp=3B}</FONT><BR><F=
ONT face=3D"Courier New">
<BR>&nbsp=3B&nbsp=3B//copy the structure to the new memory<BR>&nbsp=3B&nbsp=
=3Bmemcpy(rtdm_dev=2C &amp=3Brubicon_rtdm_driver=2C sizeof(struct rtdm_devi=
ce))=3B<BR><BR>
&nbsp=3B&nbsp=3B//create filename<BR>&nbsp=3B&nbsp=3Bsnprintf(rtdm_dev-&gt=
=3Bdevice_name=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B RTDM_MAX_DEVNAME_LEN=2C "rtser%d"=2C 0 /*i*/)=
=3B<BR>&nbsp=3B&nbsp=3Brtdm_dev-&gt=3Bdevice_id =3D 0=3B //i=3B<BR>
<BR>&nbsp=3B&nbsp=3B//define two other members of the rtdm_device structure=
<BR>&nbsp=3B&nbsp=3Brtdm_dev-&gt=3Bproc_name =3D rtdm_dev-&gt=3Bdevice_name=
=3B</FONT><BR>
<FONT face=3D"Courier New"></FONT>&nbsp=3B<BR>
<FONT face=3D"Courier New">&nbsp=3B&nbsp=3Bret =3D rtdm_dev_register(rtdm_d=
ev)=3B<BR>&nbsp=3B&nbsp=3Bif(ret &lt=3B 0) {<BR>&nbsp=3B&nbsp=3B&nbsp=3Bpri=
ntk(KERN_WARNING"RUBICON: cannot register device\n")=3B<BR>&nbsp=3B&nbsp=3B=
&nbsp=3Bgoto fail_pci=3B<BR>&nbsp=3B&nbsp=3B}</FONT><BR>
<FONT face=3D"Courier New">&nbsp=3B&nbsp=3Bg_rubicon_context.xen_device =3D=
 rtdm_dev=3B</FONT><BR>
<FONT face=3D"Courier New"></FONT>&nbsp=3B<BR>
<FONT face=3D"Courier New">&nbsp=3B&nbsp=3B<U>ret =3D pci_enable_msi(dev)=
=3B</U></FONT><BR>
<FONT face=3D"Courier New">&nbsp=3B&nbsp=3Bif(ret) {<BR>&nbsp=3B&nbsp=3B&nb=
sp=3Bprintk("RUBICON: Enabling MSI failed wuth error code: 0x%x\n"=2C ret)=
=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3Bgoto fail_pci=3B<BR>&nbsp=3B&nbsp=3B}</FONT>=
<BR>
<FONT face=3D"Courier New"><BR>&nbsp=3B&nbsp=3Bg_rubicon_context.irq =3D de=
v-&gt=3Birq=3B /* save the allocated IRQ */<BR>&nbsp=3B&nbsp=3Bg_rubicon_co=
ntext.dev =3D dev=3B /* Save the PCI queue h/w device ctx */</FONT><BR>
<FONT face=3D"Courier New">&nbsp=3B&nbsp=3Bdev_set_drvdata(dev=2C(void *) &=
amp=3B(g_rubicon_context))=3B</FONT><BR>
<FONT face=3D"Courier New">&nbsp=3B&nbsp=3B/* request the irq for the devic=
e */<BR>&nbsp=3B&nbsp=3B<U>ret =3D rtdm_irq_request</U>(&amp=3Bg_rubicon_co=
ntext.irq_handle=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B g_rubic=
on_context.irq=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B rubicon_ir=
q_handler=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B RTDM_IRQTYPE_SH=
ARED=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B "rubicon"=2C<BR>&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B (void *)&amp=3Bg_rubicon_context)=3B<=
/FONT><BR>
<FONT face=3D"Courier New">....</FONT><BR>
<FONT face=3D"Courier New"></FONT>&nbsp=3B<BR>
<FONT face=3D"Courier New"><FONT face=3DTahoma>From IRQ number perspective<=
/FONT>:</FONT><BR>
<FONT face=3D"Courier New">Mar 22 21:12:47 localhost kernel: test_dev 0000:=
15:00.0: found PCI INT A -&gt=3B IRQ 10&nbsp=3B &gt=3B&gt=3B&gt=3B&gt=3B <F=
ONT face=3DTahoma>is the print from the Kernel PCI Probe and </FONT><BR>
Mar 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assigned &g=
t=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B <FONT face=3DTahoma>is my Print after en=
abling MSI and registering for irq.</FONT><BR>
<FONT face=3DTahoma></FONT>&nbsp=3B<BR>
<FONT face=3DTahoma>I get the similar print with the Plain Linux kernel wit=
h the IRQ being assigned MSI enabled is irq 20. [Below i have pasted the ke=
rnel log of plain linux kernel]. I have tested the MSI interrupts and they =
work fine. </FONT><BR>
<FONT face=3DTahoma><FONT face=3D"Courier New">Mar 22 23:47:49 localhost ke=
rnel: test_dev: Probe for device function=3D0<BR>Mar 22 23:47:49 localhost =
kernel: test_dev 0000:15:00.0: found PCI INT A -&gt=3B IRQ 10<BR>Mar 22 23:=
47:49 localhost kernel: pci_bar =3D 0xfe000000 <BR>Mar 22 23:47:49 localhos=
t kernel: test_dev: IRQ 20 successfully assigned to the device.<BR>Mar 22 2=
3:47:49 localhost kernel: test_dev: Probe for device function=3D1<BR>Mar 22=
 23:47:49 localhost kernel: test_dev: Successfully added test_dev Device Dr=
iver.</FONT><BR></FONT><BR>
<FONT face=3DTahoma>thanks<BR></FONT>
<FONT face=3DTahoma>-krishna <BR></FONT></FONT>
<FONT face=3D"Courier New">&nbsp=3B<BR></FONT> 		 	   		  </body>
</html>=

--_65fe4037-d917-4687-b619-8327189a5081_--

