Message-ID: <2862c2c80707312153w1765ceaeo9d81a55db2ce6dea@domain.hid>
Date: Wed, 1 Aug 2007 12:53:23 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <18095.43878.759358.210266@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_56961_285876.1185944003656"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
	<2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
	<18095.41752.74240.393339@domain.hid>
	<18095.43878.759358.210266@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
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
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_56961_285876.1185944003656
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Did you figure out what is wrong with the I-PIPE patch?

My kernel hangs at this stage, not even until the mounting of NFS:
udc: at91_udc version 3 May 2006
mice: PS/2 mouse device common for all mice
AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17

I find out that the problem is not coming from "excessive" interrupts that I
faced last time.

Yes, when I-PIPE disabled, everything works fine.

regards,
chun yeow

On 8/1/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Gilles Chanteperdrix wrote:
> > Yeoh Chun Yeow wrote:
> >  > Dear Gilles,
> >  >
> >  > Thanks. After disabling the system timer interrupt at the starting of
> timer
> >  > init function, the problem is solved. Thanks again!
> >  >
> >  > By the way, I would like know if you ever try the 2.6.20-at91-patchin your
> >  > testing and find out the problem. Whenever I patch my kernel with
> this
> >  > 2.6.20-at91-patch, the system is stalled in a very early stage, not
> even
> >  > reaching the request_irq in atmel serial driver.
> >  >
> >  > Please advice. Thanks
> >
> > I tried applying this patch, the kernel boots fine until the point where
> > it tries to configure the network interface for mounting its root
> > filesystem through nfs. The usual messages:
> > eth0: Link now 100-FullDuplex
> > Sending DHCP requests ., OK
> > IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.20
> > IP-Config: Complete:
> >       device=eth0, addr=192.168.1.20, mask=255.255.255.0, gw=192.168.1.1
> ,
> >      host=192.168.1.20, domain=, nis-domain=(none),
> >      bootserver=192.168.1.1, rootserver=192.168.1.3, rootpath=
> > Looking up port of RPC 100003/2 on 192.168.1.3
> > Looking up port of RPC 100005/1 on 192.168.1.3
> >
> > never gets displayed.
> >
> > However, I observe no lockup at a very early stage, it would be
> > interesting if you could investigate this on your side.
> >
> > Now, anybody with more knowledge on the Atmel patch for AT91, could you
> > tell me what I am doing wrong ?
>
> It is an I-pipe patch bug, without I-pipe, the kernel finshes booting
> correctly.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_56961_285876.1185944003656
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Did you figure out what is wrong with the I-PIPE patch?<br><br>My kernel hangs at this stage, not even until the mounting of NFS:<br>udc: at91_udc version 3 May 2006<br>mice: PS/2 mouse device common for all mice
<br>AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire<br>TCP cubic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br><br>I find out that the problem is not coming from &quot;excessive&quot; interrupts that I faced last time.
<br><br>Yes, when I-PIPE disabled, everything works fine. <br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 8/1/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">
gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Gilles Chanteperdrix wrote:<br> &gt; Yeoh Chun Yeow wrote:
<br> &gt;&nbsp;&nbsp;&gt; Dear Gilles,<br> &gt;&nbsp;&nbsp;&gt;<br> &gt;&nbsp;&nbsp;&gt; Thanks. After disabling the system timer interrupt at the starting of timer<br> &gt;&nbsp;&nbsp;&gt; init function, the problem is solved. Thanks again!<br> &gt;&nbsp;&nbsp;&gt;<br> &gt;&nbsp;&nbsp;&gt; By the way, I would like know if you ever try the 
2.6.20-at91-patch in your<br> &gt;&nbsp;&nbsp;&gt; testing and find out the problem. Whenever I patch my kernel with this<br> &gt;&nbsp;&nbsp;&gt; 2.6.20-at91-patch, the system is stalled in a very early stage, not even<br> &gt;&nbsp;&nbsp;&gt; reaching the request_irq in atmel serial driver.
<br> &gt;&nbsp;&nbsp;&gt;<br> &gt;&nbsp;&nbsp;&gt; Please advice. Thanks<br> &gt;<br> &gt; I tried applying this patch, the kernel boots fine until the point where<br> &gt; it tries to configure the network interface for mounting its root<br>
 &gt; filesystem through nfs. The usual messages:<br> &gt; eth0: Link now 100-FullDuplex<br> &gt; Sending DHCP requests ., OK<br> &gt; IP-Config: Got DHCP answer from <a href="http://192.168.1.1">192.168.1.1</a>, my address is 
<a href="http://192.168.1.20">192.168.1.20</a><br> &gt; IP-Config: Complete:<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://192.168.1.20">192.168.1.20</a>, mask=<a href="http://255.255.255.0">255.255.255.0</a>, gw=<a href="http://192.168.1.1">
192.168.1.1</a>,<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;host=<a href="http://192.168.1.20">192.168.1.20</a>, domain=, nis-domain=(none),<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bootserver=<a href="http://192.168.1.1">192.168.1.1</a>, rootserver=<a href="http://192.168.1.3">
192.168.1.3</a>, rootpath=<br> &gt; Looking up port of RPC 100003/2 on <a href="http://192.168.1.3">192.168.1.3</a><br> &gt; Looking up port of RPC 100005/1 on <a href="http://192.168.1.3">192.168.1.3</a><br> &gt;<br> &gt; never gets displayed.
<br> &gt;<br> &gt; However, I observe no lockup at a very early stage, it would be<br> &gt; interesting if you could investigate this on your side.<br> &gt;<br> &gt; Now, anybody with more knowledge on the Atmel patch for AT91, could you
<br> &gt; tell me what I am doing wrong ?<br><br>It is an I-pipe patch bug, without I-pipe, the kernel finshes booting<br>correctly.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br>
</blockquote></div><br>

------=_Part_56961_285876.1185944003656--

