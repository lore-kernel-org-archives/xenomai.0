MIME-Version: 1.0
Date: Tue, 20 Jul 2010 15:16:39 -0500
Message-ID: <AANLkTing3lfuQYpjRtouACoAJs0Uk92G1x-8WQ-NGSJh@domain.hid>
From: Patrick Roberts <pat1micom@domain.hid>
Content-Type: multipart/alternative; boundary=0016e659f4f2e38b82048bd75cd1
Subject: [Xenomai-help] High latency on dell M6500
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

--0016e659f4f2e38b82048bd75cd1
Content-Type: text/plain; charset=ISO-8859-1

If this shows up multiple times I apolgize.  Unsucessful in posting.

I have installed Xenomai on two different machines, a netbook with a N450
processor (latency results ~2 us) and a Dell Precision M6500 (latency
results ~ 700 us).  I have tried several iterations and combinations of a)
SMI work around on/off b) BIOS legacy suport on/off c) power management and
cpu scaling on/off, etc.   My Setup is:



1) Dell Precision M6500 with Dual Core I7 processor.

2) Base Lunix, Ubuntu Lucid Lynx 10.04

3) kernel 2.6.32.16 from kernel.org

4) xenomai 2.5.3

5) adeos patch = adeos-ipipe-2.6.32.11-x86-2.6-03.patch

6)  make menuconfig

    a) Processor type->HPET Timer   turn it off

    b) drivers->Plug and Play -> Plug and Play BIOS   turn it off

    c) Device->input->misc->PC speaker  turn it off

    d) Power Management->Power Management Support  (Turn off all

    e) Power management Support->CPU Frequency scaling  turn off

    f) Processortype->processor family Core 2/ newer Xeon

    g) Processortype-> -fstack-protector buffer overflow (EXPERIMENT) turn
off

    h) realtime->machine->smiworkaround->enable SMI workaround  turn on

    i) devicedriver->Serial ATA (prod)->AHCI SATA Support  (ON not module)



7) Other options experimented with

    device-driver->USB support->OHCI HCD  <m>

    device-driver->usb support->UHCI HCD  <m>

    device-driver->usb support->ehci hcd  <m>

    device-driver->usb support->USB MASS  <m>

    processor types -> High Memory support, change from 4 to <off>

    processor types -> PAE (Phys...) to <off>

    processor types -> Premption Model  <Preemptible Kernel (Low Desktop)

    processor types -> Symmetric multi-processing support already <*>

    Real-time sub-system --> Xenomai->drivers->Testing driver->Contect
switch-> (enabled)



I never did see any mention of SMI work around in my kernel logs.  I did see
a mention of SMI interrupts are used for thermal throttling.



Any suggestions are appreciated.

Thanks,

Patrick M. Roberts

--0016e659f4f2e38b82048bd75cd1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" =
face=3D"Consolas">If this shows up multiple times I apolgize.=A0 Unsucessfu=
l in posting.</font></div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" =
face=3D"Consolas"></font>=A0</div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" =
face=3D"Consolas">I have installed Xenomai on two different machines, a net=
book with a N450 processor (latency results ~2 us) and a Dell Precision M65=
00 (latency results ~ 700 us).<span style=3D"mso-spacerun: yes">=A0 </span>=
I have tried several iterations and combinations of a) SMI work around on/o=
ff b) BIOS legacy suport on/off c) power management and cpu scaling on/off,=
 etc.<span style=3D"mso-spacerun: yes">=A0=A0 </span>My Setup is:</font></d=
iv>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">=A0</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">1) Dell Precision M6500 with Dual Core I7 processor.</font>=
</p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">2) Base Lunix, Ubuntu Lucid Lynx 10.04</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">3) kernel 2.6.32.16 from <a href=3D"http://kernel.org">kern=
el.org</a></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">4) xenomai 2.5.3</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">5) adeos patch =3D adeos-ipipe-2.6.32.11-x86-2.6-03.patch</=
font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">6)<span style=3D"mso-spacerun: yes">=A0 </span>make menucon=
fig</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>a)=
 Processor type-&gt;HPET Timer<span style=3D"mso-spacerun: yes">=A0 </span>=
<span style=3D"mso-spacerun: yes">=A0</span>turn it off</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>b)=
 drivers-&gt;Plug and Play -&gt; Plug and Play BIOS<span style=3D"mso-space=
run: yes">=A0=A0 </span>turn it off</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>c)=
 Device-&gt;input-&gt;misc-&gt;PC speaker<span style=3D"mso-spacerun: yes">=
=A0 </span>turn it off</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>d)=
 Power Management-&gt;Power Management Support<span style=3D"mso-spacerun: =
yes">=A0 </span>(Turn off all</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>e)=
 Power management Support-&gt;CPU Frequency scaling<span style=3D"mso-space=
run: yes">=A0 </span>turn off</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>f)=
 Processortype-&gt;processor family Core 2/ newer Xeon</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>g)=
 Processortype-&gt; -fstack-protector buffer overflow (EXPERIMENT) turn off=
</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>h)=
 realtime-&gt;machine-&gt;smiworkaround-&gt;enable SMI workaround<span styl=
e=3D"mso-spacerun: yes">=A0 </span>turn on</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>i)=
 devicedriver-&gt;Serial ATA (prod)-&gt;AHCI SATA Support<span style=3D"mso=
-spacerun: yes">=A0 </span>(ON not module)</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">=A0</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">7) Other options experimented with</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>de=
vice-driver-&gt;USB support-&gt;OHCI HCD<span style=3D"mso-spacerun: yes">=
=A0 </span>&lt;m&gt;</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>de=
vice-driver-&gt;usb support-&gt;UHCI HCD<span style=3D"mso-spacerun: yes">=
=A0 </span>&lt;m&gt;</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>de=
vice-driver-&gt;usb support-&gt;ehci hcd<span style=3D"mso-spacerun: yes">=
=A0 </span>&lt;m&gt;</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>de=
vice-driver-&gt;usb support-&gt;USB MASS<span style=3D"mso-spacerun: yes">=
=A0 </span>&lt;m&gt;</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0 </span><span=
 style=3D"mso-spacerun: yes">=A0</span>processor types -&gt; High Memory su=
pport, change from 4 to &lt;off&gt;</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>pr=
ocessor types -&gt; PAE (Phys...) to &lt;off&gt;</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>pr=
ocessor types -&gt; Premption Model<span style=3D"mso-spacerun: yes">=A0 </=
span>&lt;Preemptible Kernel (Low Desktop)</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0=A0=A0 </span>pr=
ocessor types -&gt; Symmetric multi-processing support already &lt;*&gt;</f=
ont></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><f=
ont face=3D"Consolas"><span style=3D"mso-spacerun: yes">=A0 </span><span st=
yle=3D"mso-spacerun: yes">=A0=A0</span>Real-time sub-system --&gt; Xenomai-=
&gt;drivers-&gt;Testing driver-&gt;Contect switch-&gt; (enabled)</font></fo=
nt></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">=A0</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">I never did see any mention of SMI work around in my kernel=
 logs.<span style=3D"mso-spacerun: yes">=A0 </span>I did see a mention of S=
MI interrupts are used for thermal throttling.</font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">=A0</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">Any suggestions are appreciated.</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">Thanks,</font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fa=
ce=3D"Consolas">Patrick M. Roberts</font></p>

--0016e659f4f2e38b82048bd75cd1--

