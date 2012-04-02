MIME-Version: 1.0
Date: Mon, 2 Apr 2012 16:12:09 +0200
Message-ID: <CAGq8jPjvtxSjKW+RpiUX5u02mnXv7q2K2PLgfF2E6CT1Eaw6Mg@domain.hid>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=14dae93403dba340a204bcb2c6e2
Subject: [Xenomai-help] analogy - serial port
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--14dae93403dba340a204bcb2c6e2
Content-Type: text/plain; charset=ISO-8859-1

Hello everybody,

Do the Analogy driver support the serial port. I can attach the serial
port(ttyS0) to rtser0 with xeno_16550A.ko as mentionned in Xenomai
Documentation

modprobe xeno_16550A io=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
                     [baud_base=<base1>[,<base2>...]]
                     [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]


How can i tell to  the Analogy driver to recognize the serial port in order
to use the Analogy API. i have seen the command

/xeno_install/sbin/analogy_config analogy0 analogy_ni_pcimio

i think that analogy_ni_pcimio is the drivers suppors of National
Instruments PCI / PXI cards. But i don't have the DAQ card yet, currently i
test with two serial ports on my computer while connecting them by one
cable. the first aim is to test the api analogy.

Thanks,



when i try to add the analogy_ni_pcimio module over terminal linux. i get
one message error

insmod analogy_ni_pcimio.ko

analogy_ni_pcimio.ko : -1 Unknown symbol in module

--14dae93403dba340a204bcb2c6e2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style>Hello everybody,</div><div style><br></div><div style>Do the Ana=
logy driver support the serial port. I can attach the serial port(ttyS0) to=
 rtser0 with xeno_16550A.ko as mentionned in Xenomai Documentation</div>
<div style><pre style=3D"white-space:pre-wrap;padding-top:1em;padding-right=
:1em;padding-bottom:1em;padding-left:1em;border-top-width:1px;border-right-=
width:1px;border-bottom-width:1px;border-left-width:1px;border-top-style:da=
shed;border-right-style:dashed;border-bottom-style:dashed;border-left-style=
:dashed;border-top-color:rgb(47,111,171);border-right-color:rgb(47,111,171)=
;border-bottom-color:rgb(47,111,171);border-left-color:rgb(47,111,171);back=
ground-color:rgb(249,249,249);line-height:1.1em">
modprobe xeno_16550A io=3D&lt;io1&gt;[,&lt;io2&gt;...] irq=3D&lt;irq1&gt;[,=
&lt;irq2&gt;...]
                     [baud_base=3D&lt;base1&gt;[,&lt;base2&gt;...]]
                     [tx_fifo=3D&lt;len1&gt;[,&lt;len2&gt;...]] [start_inde=
x=3D&lt;index&gt;]</pre></div><div style><br></div><div style>How can i tel=
l to =A0the Analogy=A0driver=A0to recognize the serial port in order to use=
 the Analogy API. i have seen the command</div>
<div style><pre style=3D"padding-top:1em;padding-right:1em;padding-bottom:1=
em;padding-left:1em;border-top-width:1px;border-right-width:1px;border-bott=
om-width:1px;border-left-width:1px;border-top-style:dashed;border-right-sty=
le:dashed;border-bottom-style:dashed;border-left-style:dashed;border-top-co=
lor:rgb(47,111,171);border-right-color:rgb(47,111,171);border-bottom-color:=
rgb(47,111,171);border-left-color:rgb(47,111,171);color:rgb(0,0,0);backgrou=
nd-color:rgb(249,249,249);line-height:1.1em">
/xeno_install/sbin/analogy_config analogy0 analogy_ni_pcimio </pre></div><d=
iv style><span style=3D"background-color:rgb(249,249,249)">i think that ana=
logy_ni_pcimio is the</span><span style=3D"background-color:rgb(255,255,255=
);font-family:sans-serif;line-height:19px">=A0drivers suppors of National I=
nstruments PCI / PXI cards. B</span>ut i don&#39;t have the DAQ card yet, c=
urrently i test with two serial ports on my computer while connecting them =
by one cable. the first aim is to test the api analogy.</div>
<div style><br></div><div style>Thanks,</div><div style><br></div><div styl=
e><br></div><div style><br></div><div style>when i try to add the=A0<span s=
tyle=3D"background-color:rgb(249,249,249);line-height:1.1em">analogy_ni_pci=
mio module over terminal linux. i get one message error</span></div>
<div style><span style=3D"background-color:rgb(249,249,249);line-height:1.1=
em"><br></span></div><div style><pre style=3D"padding-top:1em;padding-right=
:1em;padding-bottom:1em;padding-left:1em;border-top-width:1px;border-right-=
width:1px;border-bottom-width:1px;border-left-width:1px;border-top-style:da=
shed;border-right-style:dashed;border-bottom-style:dashed;border-left-style=
:dashed;border-top-color:rgb(47,111,171);border-right-color:rgb(47,111,171)=
;border-bottom-color:rgb(47,111,171);border-left-color:rgb(47,111,171);colo=
r:rgb(0,0,0);background-color:rgb(249,249,249);line-height:1.1em">
insmod <span style=3D"line-height:1.1em;font-family:arial,sans-serif">analo=
gy_ni_pcimio.ko</span></pre><pre style=3D"padding-top:1em;padding-right:1em=
;padding-bottom:1em;padding-left:1em;border-top-width:1px;border-right-widt=
h:1px;border-bottom-width:1px;border-left-width:1px;border-top-style:dashed=
;border-right-style:dashed;border-bottom-style:dashed;border-left-style:das=
hed;border-top-color:rgb(47,111,171);border-right-color:rgb(47,111,171);bor=
der-bottom-color:rgb(47,111,171);border-left-color:rgb(47,111,171);color:rg=
b(0,0,0);background-color:rgb(249,249,249);line-height:1.1em">
analogy_ni_pcimio.ko : -1 Unknown symbol in module</pre></div><div style><b=
r></div><br class=3D"Apple-interchange-newline">

--14dae93403dba340a204bcb2c6e2--

