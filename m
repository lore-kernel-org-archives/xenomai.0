MIME-Version: 1.0
In-Reply-To: <49F5BDBA.5050200@domain.hid>
References: <37f89760904270553s1d862905l5c3c4df01ce0d984@domain.hid>
	<49F5B322.3040709@domain.hid>
	<37f89760904270652i6b8b1d6dq2ecef27d3e3a550@domain.hid>
	<49F5BDBA.5050200@domain.hid>
Date: Mon, 27 Apr 2009 16:37:07 +0200
Message-ID: <37f89760904270737u622ea8c7vcbddec702e2348c1@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d46a65e6a2e304688a473f
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

--0016e6d46a65e6a2e304688a473f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/4/27 Wolfgang Grandegger <wg@domain.hid>

> Marcel Soulot wrote:
> >
> >
> > 2009/4/27 Wolfgang Grandegger <wg@domain.hid <mailto:
> wg@domain.hid>>
> >
> >     Marcel Soulot wrote:
> >     > Hi,
> >     >
> >     > I try to receive data from CAN network. I got a PCI card with a
> FPGA
> >     > which emulates the SJA1000.
> >     > So I load the following modules :
> >     > insmod ./xeno_can.ko
> >     > insmod ./xeno_can_sja1000.ko
> >     > insmod ./xeno_can_mem.ko mem=0xe0000800 irq=5 can_clock=80000000
> >     cdr=0x8F
> >     >
> >     > then I configure with :
> >     > ./rtcanconfig rtcan0 -v --baudrate=125000 start
> >     >
> >     > and launch the receive test application :
> >     > ./rtcanrecv rtcan0 -v
> >     >
> >     > The task is running but nothing happen in reception.
> >     > I could just say that the transmitter was blocked before I load the
> >     > driver. After all the upon configuration, I can check that the
> >     > connection with transmitter is now enabled and the data are sent.
> >
> >     Do you get interrupts for out-going messages? What does
> "/proc/xeno/irq"
> >     report?.
> >
> >
> > I sent the data from another computer so I can check the flow data on my
> > CAN device (CANcaseXL). when the driver is unloaded I got the error led
> > and when I loaded and configured the driver the led transmit start to
> > blink and the error led is off.
>
> Well, I don't understand what that means. Is RT-Socket-CAN working on
> you PCI card. If not, what does not work? RX? TX?


yes RT-Socket-CAN works on my PCI card but I don't send any data with it,
just try to receive data.

>
>
> >     > First, my question is this procedure have any chance to work ? or I
> >     > missed something in the configuration ?
> >
> >     I think you need a PCI driver to support your card properly.
> >
> >
> > I also already manage a GPIO driver for the same card and it works fine.
>
> Does it use interrupts?


No, it doesn't use interrupts, why ?  Does the problem can come from the
interrupt management ? I Notice that nothing happen in interrupt task.

>
>
> > The driver xeno_can_mem.ko is not designed to access register with
> > memory address ? What are the risk espacially if I have to manage
> > several differents driver with the same card?
>
> The accesses from and to the device should not be a problem but
> interrupt handling might be.
>

Why the interrupt handling is not able to manage sharing between different
driver (all the driver are running with Xenomai)?

>
> Wolfgang.


Thanks,
Marcel.

--0016e6d46a65e6a2e304688a473f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/4/27 Wolfgang Grandegger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;=
</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px soli=
d rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Marcel Soulot wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2009/4/27 Wolfgang Grandegger &lt;<a href=3D"mailto:wg@domain.hid"=
>wg@domain.hid</a> &lt;mailto:<a href=3D"mailto:wg@domain.hid">wg@domain.hid=
randegger.com</a>&gt;&gt;<br>
<div class=3D"im">&gt;<br>
&gt; =A0 =A0 Marcel Soulot wrote:<br>
&gt; =A0 =A0 &gt; Hi,<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; I try to receive data from CAN network. I got a PCI card =
with a FPGA<br>
&gt; =A0 =A0 &gt; which emulates the SJA1000.<br>
&gt; =A0 =A0 &gt; So I load the following modules :<br>
&gt; =A0 =A0 &gt; insmod ./xeno_can.ko<br>
&gt; =A0 =A0 &gt; insmod ./xeno_can_sja1000.ko<br>
&gt; =A0 =A0 &gt; insmod ./xeno_can_mem.ko mem=3D0xe0000800 irq=3D5 can_clo=
ck=3D80000000<br>
&gt; =A0 =A0 cdr=3D0x8F<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; then I configure with :<br>
&gt; =A0 =A0 &gt; ./rtcanconfig rtcan0 -v --baudrate=3D125000 start<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; and launch the receive test application :<br>
&gt; =A0 =A0 &gt; ./rtcanrecv rtcan0 -v<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; The task is running but nothing happen in reception.<br>
&gt; =A0 =A0 &gt; I could just say that the transmitter was blocked before =
I load the<br>
&gt; =A0 =A0 &gt; driver. After all the upon configuration, I can check tha=
t the<br>
&gt; =A0 =A0 &gt; connection with transmitter is now enabled and the data a=
re sent.<br>
&gt;<br>
&gt; =A0 =A0 Do you get interrupts for out-going messages? What does &quot;=
/proc/xeno/irq&quot;<br>
&gt; =A0 =A0 report?.<br>
&gt;<br>
&gt;<br>
&gt; I sent the data from another computer so I can check the flow data on =
my<br>
&gt; CAN device (CANcaseXL). when the driver is unloaded I got the error le=
d<br>
&gt; and when I loaded and configured the driver the led transmit start to<=
br>
&gt; blink and the error led is off.<br>
<br>
</div>Well, I don&#39;t understand what that means. Is RT-Socket-CAN workin=
g on<br>
you PCI card. If not, what does not work? RX? TX?</blockquote><div><br><spa=
n style=3D"color: rgb(102, 51, 102);">yes RT-Socket-CAN works on my PCI car=
d but I don&#39;t send any data with it, just try to receive data.</span><b=
r>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class=3D"im"><br>
&gt; =A0 =A0 &gt; First, my question is this procedure have any chance to w=
ork ? or I<br>
&gt; =A0 =A0 &gt; missed something in the configuration ?<br>
&gt;<br>
&gt; =A0 =A0 I think you need a PCI driver to support your card properly.<b=
r>
&gt;<br>
&gt;<br>
&gt; I also already manage a GPIO driver for the same card and it works fin=
e.<br>
<br>
</div>Does it use interrupts?</blockquote><div><br><span style=3D"color: rg=
b(102, 51, 102);">No, it doesn&#39;t use interrupts, why ?=A0 Does the prob=
lem can come from the interrupt management ? I Notice that nothing happen i=
n interrupt task.</span><br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class=3D"im"><br>
&gt; The driver xeno_can_mem.ko is not designed to access register with<br>
&gt; memory address ? What are the risk espacially if I have to manage<br>
&gt; several differents driver with the same card?<br>
<br>
</div>The accesses from and to the device should not be a problem but<br>
interrupt handling might be.<br>
<font color=3D"#888888"></font></blockquote><div><br><span style=3D"color: =
rgb(102, 51, 102);">Why the interrupt handling is not able to manage sharin=
g between different driver (all the driver are running with Xenomai)?</span=
> <br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><font color=
=3D"#888888"><br>
Wolfgang.</font></blockquote><div><br><span style=3D"color: rgb(102, 51, 10=
2);">Thanks,</span><br style=3D"color: rgb(102, 51, 102);"><span style=3D"c=
olor: rgb(102, 51, 102);">Marcel.</span> <br></div></div><br>

--0016e6d46a65e6a2e304688a473f--

