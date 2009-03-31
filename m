MIME-Version: 1.0
Date: Tue, 31 Mar 2009 11:17:56 +0200
Message-ID: <37f89760903310217o29fe3435j286d5fa10dd6aa82@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d99befad6924046666aceb
Subject: [Xenomai-help] Test xen_16500A.ko on different serial port
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

--0016e6d99befad6924046666aceb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I start with xenomai so I patch the kernel 2.6.26.7 with the version 2.4.6.

So I try to test the xeno_16550A.ko driver generated instead of the standard
16550A on serial port ttyS0 ioaddr=0x3f8 irq=4 (standard one) and also on
serial port in PCI card ttyS6 ioaddr=0xe0000400 irq=10.

I used the following command to substitute the 16550A driver used by the
xeno_16550A.ko:

> setserial /dev/ttyS0 uart none
> insmod ./xeno_16550.ko ioaddr=0x3f8 irq=4

I got the error message :

xeno_16550A: Unkonwn parameter 'ioaddr'
insmod: error inserting './xeno_16550A.ko': -1 Unknown symbol in module

and I got the same thing with the other port.

Can you explain me how I can load correctly the xeno_16550A.ko

Thanks for your help.

Marcel.

--0016e6d99befad6924046666aceb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi <br><br>I start with xenomai so I patch the kernel 2.6.26.7 with the ver=
sion 2.4.6.<br><br>So I try to test the xeno_16550A.ko driver generated ins=
tead of the standard 16550A on serial port ttyS0 ioaddr=3D0x3f8 irq=3D4 (st=
andard one) and also on serial port in PCI card ttyS6 ioaddr=3D0xe0000400 i=
rq=3D10.<br>
<br>I used the following command to substitute the 16550A driver used by th=
e xeno_16550A.ko:<br><br>&gt; setserial /dev/ttyS0 uart none<br>&gt; insmod=
 ./xeno_16550.ko ioaddr=3D0x3f8 irq=3D4<br><br><span class=3D"mcon"><pre></=
pre>
</span>I got the error message : <br><br>xeno_16550A: Unkonwn parameter &#3=
9;ioaddr&#39;<br>insmod: error inserting &#39;./xeno_16550A.ko&#39;: -1 Unk=
nown symbol in module<br><br>and I got the same thing with the other port.<=
br>
<br>Can you explain me how I can load correctly the xeno_16550A.ko<br><br>T=
hanks for your help.<br><br>Marcel.<br>

--0016e6d99befad6924046666aceb--

