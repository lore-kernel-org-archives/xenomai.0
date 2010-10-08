MIME-Version: 1.0
Date: Thu, 7 Oct 2010 18:44:22 -0700
Message-ID: <AANLkTi=6tAnApCNw9hzQUEYR7BcsgDSU3YA5N+xn-uN2@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=00c09f89956857f542049211267a
Subject: [Xenomai-help] latency spike when starting opengl windows
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

--00c09f89956857f542049211267a
Content-Type: text/plain; charset=ISO-8859-1

Hey there,

I noticed a spike in the latency over around 600-800microseconds when
starting an opengl window.

I have the SMI workaround enabled and also included my device id in the

/usr/src/xenomai/ksrc/arch/x86/smi.c

file

lspci -vvv -nn shows a

Intel Corporation 82801JIR (ICH10R) LPC Interface Controller [8086:3a16]

so I added

{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},

After recompiling the kernel I finally saw

[    2.443949] Xenomai: SMI-enabled chipset found

( I did not see that line before )
but unfortunately I also saw

[    2.443957] Xenomai: SMI workaround failed!

Well, the latency test still showed spikes of about 600-800microsends when
for example starting or closing glxgears. I am using a nvidia FxQuadro FX
4800 and I am using the latest nvidia driver which I downloaded from the
nvidia homepage (256.53).

I am running
Linux xeno_machine 2.6.31.4-ipipe #1 SMP Thu Oct 7 18:13:54 PDT 2010 x86_64
GNU/Linux
and Xenomai version is 2.5.2

Thanks for any help,
 Peter

--00c09f89956857f542049211267a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey there,<br><br>I noticed a spike in the latency over around 600-800micro=
seconds when starting an opengl window.<br><br>I have the SMI workaround en=
abled and al<font size=3D"2">so included my device id in the </font><pre cl=
ass=3D"wiki">
<font size=3D"2">/usr/src/xenomai/ksrc/arch/x86/smi.c <br></font></pre><fon=
t size=3D"2">file<br><br></font>lspci -vvv -nn shows a <br><br>Intel Corpor=
ation 82801JIR (ICH10R) LPC Interface Controller [8086:3a16]<br><br>so I ad=
ded <br>
<pre class=3D"wiki">{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IC=
H10_1)},</pre>
After recompiling the kernel I finally saw<br><br>[=A0=A0=A0 2.443949] Xeno=
mai: SMI-enabled chipset found<br><br>( I did not see that line before )<br=
>but unfortunately I also saw<br><br>[=A0=A0=A0 2.443957] Xenomai: SMI work=
around failed!<br>
<br>Well, the latency test still showed spikes of about 600-800microsends w=
hen for example starting or closing glxgears. I am using a nvidia FxQuadro =
FX 4800 and I am using the latest nvidia driver which I downloaded from the=
 nvidia homepage (256.53).<br>
<br>I am running<br>Linux xeno_machine 2.6.31.4-ipipe #1 SMP Thu Oct 7 18:1=
3:54 PDT 2010 x86_64 GNU/Linux<br>and Xenomai version is 2.5.2<br><br>Thank=
s for any help,<br>=A0Peter<br><br><br>

--00c09f89956857f542049211267a--

