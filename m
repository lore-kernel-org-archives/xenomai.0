Message-ID: <2f7417810806110119o1c360611gabafb2279347e1a5@domain.hid>
Date: Wed, 11 Jun 2008 10:19:28 +0200
From: quinty <webquinty2@domain.hid>
In-Reply-To: <484F88CB.4090902@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16234_26641226.1213172368976"
References: <2f7417810806110043o4fbac699h318f33b7b7359d88@domain.hid>
	<484F88CB.4090902@domain.hid>
Subject: Re: [Xenomai-help] Help rtcan and MCP5200...
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
Cc: xenomai@xenomai.org

------=_Part_16234_26641226.1213172368976
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/6/11 Wolfgang Grandegger <wg@domain.hid>:

> quinty quinty wrote:
> > Hello,
> >
> > I have a MPX5200G develop board and I use xenomai to test real time task.
> > My problem is that I do not know how to configurate RT-Can driver in
> > kernel options.
> >
> > ======================================
> > *U-Boot 1.3.0 (Feb 13 2008 -
> > 10:14:17)
> > CPU:   MPC5200B v2.2, Core v1.4 at 396 Mhz
> > Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
> > Board: MicroSys
> > MPX5200R3/CRX02
> > I2C:   85 kHz,
> > ready
> > DRAM:  128
> > MB
> > FLASH: 16
> > MB
> > *======================================
> >
> > An now, kernel options of RT-CAN:
> >
> > ======================================
> > *[x]MSCAN driver for MPC52xx
> >      [x]Enable CAN 1
> >      [x]Enable CAN 2
> >      (132000000) Clock Frequency in Hz
>
> Most probably, you need 33000000 here. Please read the help for thins
> option.
>
> >      Pin Configuration
> >            [ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins
> >            [x]CAN 1 and 2 on PSC2 pins*
> > ======================================
> >
> > Well, I have connected a can device, and I executed ./rtcanrecv rtcan1
> > --verbose, but I do not receive anything.
> > But, If I used can without rtcan, for example,
> > *ifconfig can0 up
> > canconfig can0 --baudrate=500000 up
> > candump can0
> > *I received messages from device, then I understand that problem is in
> > configuration of RT-CAN driver.
>
> Oops, you can not use both, Socket-CAN and RT-Socket-CAN on the same CAN
> device. Please disable Socket-CAN in you kernel configuration if you
> want to use RT-Socket-CAN. What kernel version do you use?
>
> Wolfgang.
>
Hello Wolfgang,

Thanks from Spain.

I use 2.6.23.14. I am going to try disable Socket-Can in my kernel.

Best regards.

------=_Part_16234_26641226.1213172368976
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/6/11 Wolfgang Grandegger &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
quinty quinty wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I have a MPX5200G develop board and I use xenomai to test real time task.<br>
&gt; My problem is that I do not know how to configurate RT-Can driver in<br>
&gt; kernel options.<br>
&gt;<br>
&gt; ======================================<br>
&gt; *U-Boot 1.3.0 (Feb 13 2008 -<br>
&gt; 10:14:17)<br>
&gt; CPU: &nbsp; MPC5200B v2.2, Core v1.4 at 396 Mhz<br>
&gt; Bus 132 MHz, IPB 132 MHz, PCI 66 MHz<br>
&gt; Board: MicroSys<br>
&gt; MPX5200R3/CRX02<br>
&gt; I2C: &nbsp; 85 kHz,<br>
&gt; ready<br>
&gt; DRAM: &nbsp;128<br>
&gt; MB<br>
&gt; FLASH: 16<br>
&gt; MB<br>
&gt; *======================================<br>
&gt;<br>
&gt; An now, kernel options of RT-CAN:<br>
&gt;<br>
&gt; ======================================<br>
&gt; *[x]MSCAN driver for MPC52xx<br>
&gt; &nbsp; &nbsp; &nbsp;[x]Enable CAN 1<br>
&gt; &nbsp; &nbsp; &nbsp;[x]Enable CAN 2<br>
&gt; &nbsp; &nbsp; &nbsp;(132000000) Clock Frequency in Hz<br>
<br>
Most probably, you need 33000000 here. Please read the help for thins<br>
option.<br>
<br>
&gt; &nbsp; &nbsp; &nbsp;Pin Configuration<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[x]CAN 1 and 2 on PSC2 pins*<br>
&gt; ======================================<br>
&gt;<br>
&gt; Well, I have connected a can device, and I executed ./rtcanrecv rtcan1<br>
&gt; --verbose, but I do not receive anything.<br>
&gt; But, If I used can without rtcan, for example,<br>
&gt; *ifconfig can0 up<br>
&gt; canconfig can0 --baudrate=500000 up<br>
&gt; candump can0<br>
&gt; *I received messages from device, then I understand that problem is in<br>
&gt; configuration of RT-CAN driver.<br>
<br>
Oops, you can not use both, Socket-CAN and RT-Socket-CAN on the same CAN<br>
device. Please disable Socket-CAN in you kernel configuration if you<br>
want to use RT-Socket-CAN. What kernel version do you use?<br>
<font color="#888888"><br>
Wolfgang.<br>
</font></blockquote></div>Hello Wolfgang,<br><br>Thanks from Spain.<br><br>I use <a href="http://2.6.23.14">2.6.23.14</a>. I am going to try disable Socket-Can in my kernel.<br><br>Best regards.<br>&nbsp;<br>

------=_Part_16234_26641226.1213172368976--

