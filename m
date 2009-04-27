MIME-Version: 1.0
In-Reply-To: <49F5B322.3040709@domain.hid>
References: <37f89760904270553s1d862905l5c3c4df01ce0d984@domain.hid>
	<49F5B322.3040709@domain.hid>
Date: Mon, 27 Apr 2009 15:52:59 +0200
Message-ID: <37f89760904270652i6b8b1d6dq2ecef27d3e3a550@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=00504502dc420449c6046889aa56
Subject: Re: [Xenomai-help] Try to get recption on driver CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

--00504502dc420449c6046889aa56
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/4/27 Wolfgang Grandegger <wg@domain.hid>

> Marcel Soulot wrote:
> > Hi,
> >
> > I try to receive data from CAN network. I got a PCI card with a FPGA
> > which emulates the SJA1000.
> > So I load the following modules :
> > insmod ./xeno_can.ko
> > insmod ./xeno_can_sja1000.ko
> > insmod ./xeno_can_mem.ko mem=0xe0000800 irq=5 can_clock=80000000 cdr=0x8F
> >
> > then I configure with :
> > ./rtcanconfig rtcan0 -v --baudrate=125000 start
> >
> > and launch the receive test application :
> > ./rtcanrecv rtcan0 -v
> >
> > The task is running but nothing happen in reception.
> > I could just say that the transmitter was blocked before I load the
> > driver. After all the upon configuration, I can check that the
> > connection with transmitter is now enabled and the data are sent.
>
> Do you get interrupts for out-going messages? What does "/proc/xeno/irq"
> report?.
>

I sent the data from another computer so I can check the flow data on my CAN
device (CANcaseXL). when the driver is unloaded I got the error led and when
I loaded and configured the driver the led transmit start to blink and the
error led is off.

>
> > First, my question is this procedure have any chance to work ? or I
> > missed something in the configuration ?
>
> I think you need a PCI driver to support your card properly.
>

I also already manage a GPIO driver for the same card and it works fine. The
driver xeno_can_mem.ko is not designed to access register with memory
address ? What are the risk espacially if I have to manage several
differents driver with the same card?

>
> Wolfgang.
>

thanks,
Marcel.

--00504502dc420449c6046889aa56
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/4/27 Wolfgang Grandegger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;=
</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px soli=
d rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Marcel Soulot wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I try to receive data from CAN network. I got a PCI card with a FPGA<b=
r>
&gt; which emulates the SJA1000.<br>
&gt; So I load the following modules :<br>
&gt; insmod ./xeno_can.ko<br>
&gt; insmod ./xeno_can_sja1000.ko<br>
&gt; insmod ./xeno_can_mem.ko mem=3D0xe0000800 irq=3D5 can_clock=3D80000000=
 cdr=3D0x8F<br>
&gt;<br>
&gt; then I configure with :<br>
&gt; ./rtcanconfig rtcan0 -v --baudrate=3D125000 start<br>
&gt;<br>
&gt; and launch the receive test application :<br>
&gt; ./rtcanrecv rtcan0 -v<br>
&gt;<br>
&gt; The task is running but nothing happen in reception.<br>
&gt; I could just say that the transmitter was blocked before I load the<br=
>
&gt; driver. After all the upon configuration, I can check that the<br>
&gt; connection with transmitter is now enabled and the data are sent.<br>
<br>
</div>Do you get interrupts for out-going messages? What does &quot;/proc/x=
eno/irq&quot;<br>
report?.<br>
<div class=3D"im"></div></blockquote><div><br><font color=3D"#000099">I sen=
t the data from another computer so I can check the flow data on my CAN dev=
ice (CANcaseXL). when the driver is unloaded I got the error led and when I=
 loaded and configured the driver the led transmit start to blink and the e=
rror led is off.</font> <br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=
=3D"im"><br>
&gt; First, my question is this procedure have any chance to work ? or I<br=
>
&gt; missed something in the configuration ?<br>
<br>
</div>I think you need a PCI driver to support your card properly.<br>
<font color=3D"#888888"></font></blockquote><div><span style=3D"color: rgb(=
0, 0, 153);"><br>I also </span><font color=3D"#000099">already manage a GPI=
O driver for the same card and it works fine. The driver xeno_can_</font><s=
pan style=3D"color: rgb(0, 0, 153);">mem.ko</span> <font color=3D"#000099">=
is not designed to access register with memory address ?</font><span style=
=3D"color: rgb(0, 0, 153);"> What are the risk espacially if I have to mana=
ge several differents driver with the same card?</span><br style=3D"color: =
rgb(0, 0, 153);">
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><font color=
=3D"#888888"><br>
Wolfgang.<br>
</font></blockquote></div><br>thanks,<br>Marcel.<br>

--00504502dc420449c6046889aa56--

