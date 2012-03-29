MIME-Version: 1.0
Date: Thu, 29 Mar 2012 17:26:41 +0200
Message-ID: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e700597cb6ba004bc63598b
Subject: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--e0cb4e700597cb6ba004bc63598b
Content-Type: text/plain; charset=ISO-8859-1

i want to revive the topic over the problem RTSER_RTIOC_WAIT_EVENT
while compiling cross-link.c program. I cann't resolve my problem
after doing some solution given by the others

Loading module:

insmod ./xeno_16550A.ko io=0x3f8,0x2f8 irq=4,3 tx_fifo=10,20
start_index=0 (i have two serial ports on my pc)

running crosslink test:

main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
 Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out

...



running test:

cat /proc/xenomai/irq

IRQ         CPU0
  3:        1089         rtser1
  4:        5155         rtser0
33033:           0         [IPI0]
33036:     1484080         [timer]
33037:           0         [critical sync]
33090:    11882308         [virtual]

the values increased with time.


thanks,


configuration :  linux 2.6.38 and xenomai 2.6

--e0cb4e700597cb6ba004bc63598b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<pre style=3D"margin-right:0em;text-align:justify;margin-left:0em;margin-bo=
ttom:0em;margin-top:0em"><div style=3D"text-align:-webkit-auto"><span style=
=3D"font-size:medium;text-align:justify">i want to revive the topic over th=
e problem </span><span style=3D"text-align:justify"><font size=3D"3">RTSER_=
RTIOC_WAIT_EVENT while compiling cross-link.c program. I cann&#39;t resolve=
 my problem after doing some solution given by the others</font></span></di=
v>
<div style=3D"text-align:justify"><font size=3D"3"><br></font></div><div st=
yle=3D"text-align:-webkit-auto">
<span style=3D"font-size:medium;text-align:justify">Loading module:</span><=
/div></pre><pre style=3D"margin-right:0em;text-align:justify;font-size:medi=
um;margin-left:0em;margin-bottom:0em;margin-top:0em">insmod ./xeno_16550A.k=
o io=3D0x3f8,0x2f8 irq=3D4,3 tx_fifo=3D10,20 start_index=3D0 (i have two se=
rial ports on my pc)

running crosslink test:</pre><pre style=3D"margin-right:0em;text-align:just=
ify;font-size:medium;margin-left:0em;margin-bottom:0em;margin-top:0em">main=
 : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
 Nr |   write-&gt;irq    |    irq-&gt;read    |   write-&gt;read   |
-----------------------------------------------------------
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out</pre><pre =
style=3D"margin-right:0em;text-align:justify;font-size:medium;margin-left:0=
em;margin-bottom:0em;margin-top:0em">...</pre>
<pre style=3D"margin-right:0em;text-align:justify;font-size:medium;margin-l=
eft:0em;margin-bottom:0em;margin-top:0em"><br></pre><pre style=3D"margin-ri=
ght:0em;text-align:justify;font-size:medium;margin-left:0em;margin-bottom:0=
em;margin-top:0em">
<br></pre><pre style=3D"margin-right:0em;text-align:justify;font-size:mediu=
m;margin-left:0em;margin-bottom:0em;margin-top:0em">running test:</pre><pre=
 style=3D"margin-right:0em;text-align:justify;font-size:medium;margin-left:=
0em;margin-bottom:0em;margin-top:0em">
cat /proc/xenomai/irq</pre><pre style=3D"margin-right:0em;text-align:justif=
y;margin-left:0em;margin-bottom:0em;margin-top:0em"><font size=3D"3">IRQ   =
      CPU0
  3:        1089         rtser1
  4:        5155         rtser0
33033:           0         [IPI0]
33036:     1484080         [timer]
33037:           0         [critical sync]
33090:    11882308         [virtual]</font></pre><pre style=3D"margin-right=
:0em;text-align:justify;font-size:medium;margin-left:0em;margin-bottom:0em;=
margin-top:0em"></pre><pre style=3D"margin-right:0em;text-align:justify;fon=
t-size:medium;margin-left:0em;margin-bottom:0em;margin-top:0em">
the values increased with time. </pre><pre style=3D"margin-right:0em;text-a=
lign:justify;font-size:medium;margin-left:0em;margin-bottom:0em;margin-top:=
0em"><br></pre><pre style=3D"margin-right:0em;text-align:justify;font-size:=
medium;margin-left:0em;margin-bottom:0em;margin-top:0em">
thanks,</pre><pre style=3D"margin-right:0em;text-align:justify;font-size:me=
dium;margin-left:0em;margin-bottom:0em;margin-top:0em"><br></pre><pre style=
=3D"margin-right:0em;text-align:justify;font-size:medium;margin-left:0em;ma=
rgin-bottom:0em;margin-top:0em">
configuration :  linux 2.6.38 and xenomai 2.6 </pre><pre style=3D"margin-ri=
ght:0em;text-align:justify;font-size:medium;margin-left:0em;margin-bottom:0=
em;margin-top:0em"><br></pre><pre style=3D"margin-right:0em;text-align:just=
ify;font-size:medium;margin-left:0em;margin-bottom:0em;margin-top:0em">
<br></pre><pre style=3D"margin-right:0em;text-align:justify;font-size:mediu=
m;margin-left:0em;margin-bottom:0em;margin-top:0em"><br></pre>

--e0cb4e700597cb6ba004bc63598b--

