Message-ID: <2f7417810806110300p7699e3b5g66c70746758ec89@domain.hid>
Date: Wed, 11 Jun 2008 12:00:29 +0200
From: quinty <webquinty2@domain.hid>
In-Reply-To: <2ff1a98a0806110219w683064bdx789bfe785c1d496c@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16423_2588820.1213178430023"
References: <2f7417810806110043o4fbac699h318f33b7b7359d88@domain.hid>
	<2ff1a98a0806110219w683064bdx789bfe785c1d496c@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_16423_2588820.1213178430023
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/6/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:

> On Wed, Jun 11, 2008 at 9:43 AM, quinty quinty <webquinty2@domain.hid>
> wrote:
> > Hello,
> >
> > I have a MPX5200G develop board and I use xenomai to test real time task.
> > My problem is that I do not know how to configurate RT-Can driver in
> kernel
> > options.
> >
> > ======================================
> > U-Boot 1.3.0 (Feb 13 2008 -
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
> > ======================================
> >
> > An now, kernel options of RT-CAN:
> >
> > ======================================
> > [x]MSCAN driver for MPC52xx
> >      [x]Enable CAN 1
> >      [x]Enable CAN 2
> >      (132000000) Clock Frequency in Hz
> >      Pin Configuration
> >            [ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins
> >            [x]CAN 1 and 2 on PSC2 pins
> > ======================================
> >
> > Well, I have connected a can device, and I executed ./rtcanrecv rtcan1
> > --verbose, but I do not receive anything.
> > But, If I used can without rtcan, for example,
> > ifconfig can0 up
> > canconfig can0 --baudrate=500000 up
> > candump can0
> > I received messages from device, then I understand that problem is in
> > configuration of RT-CAN driver.
> >
> > Any advice???
>
> I do not know much about the RT-Can driver, however I would expect it
> to only work if the non real-time driver Can driver is not loaded.
>
> --
>  Gilles
>
Hello Gilles,

you are right, I have disabled Socket can and now RT-Socket-Can works fine.

Best regards

------=_Part_16423_2588820.1213178430023
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/6/11 Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Wed, Jun 11, 2008 at 9:43 AM, quinty quinty &lt;<a href="mailto:webquinty2@domain.hid">webquinty2@domain.hid</a>&gt; wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I have a MPX5200G develop board and I use xenomai to test real time task.<br>
&gt; My problem is that I do not know how to configurate RT-Can driver in kernel<br>
&gt; options.<br>
&gt;<br>
&gt; ======================================<br>
&gt; U-Boot 1.3.0 (Feb 13 2008 -<br>
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
&gt; ======================================<br>
&gt;<br>
&gt; An now, kernel options of RT-CAN:<br>
&gt;<br>
&gt; ======================================<br>
&gt; [x]MSCAN driver for MPC52xx<br>
&gt; &nbsp; &nbsp; &nbsp;[x]Enable CAN 1<br>
&gt; &nbsp; &nbsp; &nbsp;[x]Enable CAN 2<br>
&gt; &nbsp; &nbsp; &nbsp;(132000000) Clock Frequency in Hz<br>
</div><div class="Ih2E3d">&gt; &nbsp; &nbsp; &nbsp;Pin Configuration<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[x]CAN 1 and 2 on PSC2 pins<br>
&gt; ======================================<br>
&gt;<br>
&gt; Well, I have connected a can device, and I executed ./rtcanrecv rtcan1<br>
&gt; --verbose, but I do not receive anything.<br>
&gt; But, If I used can without rtcan, for example,<br>
&gt; ifconfig can0 up<br>
&gt; canconfig can0 --baudrate=500000 up<br>
&gt; candump can0<br>
&gt; I received messages from device, then I understand that problem is in<br>
&gt; configuration of RT-CAN driver.<br>
&gt;<br>
</div>&gt; Any advice???<br>
<br>
I do not know much about the RT-Can driver, however I would expect it<br>
to only work if the non real-time driver Can driver is not loaded.<br>
<br>
--<br>
<font color="#888888">&nbsp;Gilles<br>
</font></blockquote></div>Hello Gilles,<br><br>you are right, I have disabled Socket can and now RT-Socket-Can works fine.<br><br>Best regards<br><br>

------=_Part_16423_2588820.1213178430023--

