MIME-Version: 1.0
Date: Fri, 23 Jul 2010 10:56:45 -0500
Message-ID: <AANLkTimdQf_=R9dCwP1ootosGii+9zWzo=8FmJNN01Ku@domain.hid>
From: Patrick Roberts <pat1micom@domain.hid>
Content-Type: multipart/alternative; boundary=001485f1a0bcf181d5048c1014a6
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority
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

--001485f1a0bcf181d5048c1014a6
Content-Type: text/plain; charset=ISO-8859-1

>>>     Stephen Bryant wrote:

>>>     > I've had a look at dmesg, but cannot find any references to SMI -

>> what

>>>     > should I be looking for?

>>>

>>>     What is described in the TROUBLESHOOTING file.

>>>

>>>

>>> I have tried disabling the SMI workaround, ensuring that SMI detection

>>> is not disabled, and logging the kernel output (setting the kernel log

>>> level to 8 in grub and sending the output to the serial port to be

>>> picked up by another machine). The troubleshooting file states that I

>>> should see "Xenomai: Intel chipset found and SMI workaround not

>>> enabled, you may encounter high interrupt latencies." in this output,

>>> however this does not occur - I am using an Intel Core 2 Duo but with

>>> SMP disabled, if this has any relevance.

>> The SMI detection/workaround is based on the chipset you have. If your

>> chipset is an ICH10, Stefan posted a patch a few days ago. If it is

>> another one, then please send us the result of lspci -vv on your target.

>>

>
> It seems to be ICH8, so the result is attached,

 I appear to have a similar problem to Stephen except have a different chip
set.
The output of lspci -vv:
"Intel Corporation 5 Series/3400 Series Chipset"
Any suggestions?  I assume that it is the SMI interrupts that are causing my
high latency.

Patrick

--001485f1a0bcf181d5048c1014a6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;<span style=3D"mso-spacerun: yes">=A0=A0=A0=
=A0 </span>Stephen Bryant wrote:</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;<span style=3D"mso-spacerun: yes">=A0=A0=A0=
=A0 </span>&gt; I&#39;ve had a look at dmesg, but cannot find any reference=
s to SMI -</font></font></p>

<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt; what</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;<span style=3D"mso-spacerun: yes">=A0=A0=A0=
=A0 </span>&gt; should I be looking for?</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;=A0</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;<span style=3D"mso-spacerun: yes">=A0=A0=A0=
=A0 </span>What is described in the TROUBLESHOOTING file.</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;=A0</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt;=A0</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; I have tried disabling the SMI workaround, e=
nsuring that SMI detection</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; is not disabled, and logging the kernel outp=
ut (setting the kernel log</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; level to 8 in grub and sending the output to=
 the serial port to be</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; picked up by another machine). The troublesh=
ooting file states that I</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; should see &quot;Xenomai: Intel chipset foun=
d and SMI workaround not</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; enabled, you may encounter high interrupt la=
tencies.&quot; in this output,</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; however this does not occur - I am using an =
Intel Core 2 Duo but with</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;&gt; SMP disabled, if this has any relevance.</fo=
nt></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt; The SMI detection/workaround is based on the chi=
pset you have. If your</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt; chipset is an ICH10, Stefan posted a patch a few=
 days ago. If it is</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt; another one, then please send us the result of l=
spci -vv on your target.</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;&gt;=A0</font></font></p>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><font=
 face=3D"Calibri">&gt;=A0</font></font></p>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><fo=
nt face=3D"Calibri">&gt; It seems to be ICH8, so the result is attached,</f=
ont></font></div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3"><fo=
nt face=3D"Calibri"></font></font>=A0</div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3" fac=
e=3D"Calibri">=A0I appear to have a similar problem to Stephen except have =
a different chip set.</font></div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3" fac=
e=3D"Calibri">The output of lspci -vv:</font></div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3" fac=
e=3D"Calibri">&quot;Intel Corporation 5 Series/3400 Series Chipset&quot;</f=
ont></div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3" fac=
e=3D"Calibri">Any suggestions?=A0 I assume that it is the SMI interrupts th=
at are causing my high latency.</font></div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3" fac=
e=3D"Calibri"></font>=A0</div>
<div style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoNormal"><font size=3D"3" fac=
e=3D"Calibri">Patrick</font></div>

--001485f1a0bcf181d5048c1014a6--

