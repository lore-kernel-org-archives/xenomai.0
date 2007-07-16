Message-ID: <2862c2c80707160044x2a9fbb7cu7c352787da33a814@domain.hid>
Date: Mon, 16 Jul 2007 15:44:43 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_41038_5642855.1184571883123"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
	<18075.3438.734938.482223@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
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
To: xenomai@xenomai.org

------=_Part_41038_5642855.1184571883123
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Dear Gilles,
>
> I have recompiled the kernel either with or without the 2.6.20-at91 patch,
> but the result remains the same. But this time with more kernel log
> messages:
>
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> eth0: Link now 100-FullDuplex
> eth0: Link now 100-FullDuplex
> IP-Config: Guessing netmask 255.255.0.0
> IP-Config: Complete:
>       device=eth0, addr= 172.16.6.203, mask=255.255.0.0, gw=
> 255.255.255.255,
>      host=172.16.6.203, domain=, nis-domain=(none),
>      bootserver= 255.255.255.255, rootserver=172.16.6.174, rootpath=
> Looking up port of RPC 100003/2 on 172.16.6.174
> Looking up port of RPC 100005/1 on 172.16.6.174
> VFS: Mounted root (nfs filesystem).
> Freeing init memory: 104K
> -- HANG
>
> Attach my config file. I check the 2.6.20-at91 patch and found out that it
> is simply adding USB gadget support and SPI device.
>
> Is that possible that the interrupts overflow? My master clock frequency
> is 60MHz. How to determine the delay in __ipipe_mach_set_dev?
>
> Please advice. Thanks
>
> regards,
> chun yeow
>
> On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> >
> > Yeoh Chun Yeow wrote:
> > > > Dear all,
> > > >
> > > > I have applied the adeos-ipipe-2.6.20-arm-1.7.03.patch for kernel
> > 2.6.20(patches with
> > > > 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.
> >
> > this patch is booting fine here on an AT91RM9200 board, booting with
> > NFS. But I had similar problems when enabling the I-pipe tracer, so be
> > sure that the tracer is disabled. Also, could you try without the
> > 2.6.20-at91 patch ? If it still does not boot without the I-pipe tracer
> > and without the 2.6.20-at91 patch, please send us your .config.
> >
> > > >
> > > > If I compile the kernel without IPIPE, mounting of nfs file system
> > or
> > > > jffs2 filesystem are both alright.
> > > >
> > > > Whenever I enable the IPIPE feature, the booting sequence will hang
> > and I
> > > > couldn't proceed to console login.
> > > >
> > > > -- mounting to jffs file system
> > > > mice: PS/2 mouse device common for all mice
> > > > AT91 MMC: 4 wire bus mode not supported by this driver - using 1
> > wire
> > > > TCP cubic registered
> > > > NET: Registered protocol family 1
> > > > NET: Registered protocol family 17
> > > > Empty flash at 0x00ee6080 ends at 0x00ee6200
> > > > Empty flash at 0x01d9d3f8 ends at 0x01d9d400
> > > > Empty flash at 0x01d9efdc ends at 0x01d9f000
> > > > VFS: Mounted root (jffs2 filesystem).
> > > > Freeing init memory: 112K
> > > > --> HANG
> > > >
> > > > -- mounting to NFS root file system
> > > > AT91 MMC: 4 wire bus mode not supported by this driver - using 1
> > wire
> > > > TCP cubic registered
> > > > NET: Registered protocol family 1
> > > > NET: Registered protocol family 17
> > > > --> HANG
> > > >
> > > > I have try to enble IPIPE Tracer for debugging, but couldn't see the
> > debug
> > > > messages.
> >
> > If you want to use the I-pipe tracer, see:
> > http://www.xenomai.org/index.php/I-pipe:Tracer
> > But as I said, enabling the tracer seems to be a problem on AT91RM9200.
> >
> > --
> >
> >
> >                                             Gilles Chanteperdrix.
> >
>
>
>

------=_Part_41038_5642855.1184571883123
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear Gilles,<br><br>I have recompiled the kernel either with or without the 
2.6.20-at91 patch, but the result remains the same. But this time with more kernel log messages:<span class="q"><br><br>NET: Registered protocol family 1<br>NET: Registered protocol family 17
<br></span>eth0: Link now 100-FullDuplex<br>eth0: Link now 100-FullDuplex<br>IP-Config: Guessing netmask <a href="http://255.255.0.0" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">255.255.0.0</a>
<br>IP-Config: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://172.16.6.203" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
172.16.6.203</a>, mask=<a href="http://255.255.0.0" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">255.255.0.0</a>, gw=<a href="http://255.255.255.255" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
255.255.255.255</a>,<br>&nbsp;&nbsp;&nbsp;&nbsp; host=<a href="http://172.16.6.203" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">172.16.6.203</a>, domain=, nis-domain=(none),<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=
<a href="http://255.255.255.255" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">255.255.255.255</a>, rootserver=<a href="http://172.16.6.174" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
172.16.6.174</a>, rootpath=<br>Looking up port of RPC 100003/2 on <a href="http://172.16.6.174" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">172.16.6.174</a><br>Looking up port of RPC 100005/1 on 
<a href="http://172.16.6.174" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">172.16.6.174</a><br>VFS: Mounted root (nfs filesystem).<br>Freeing init memory: 104K<br><span style="color: rgb(255, 0, 0);">
-- HANG<br><br><span style="color: rgb(0, 0, 0);">Attach my config file. I check the 
2.6.20-at91 patch and found out that it is simply adding USB gadget support and SPI device.<br><br></span></span><span style="color: rgb(255, 0, 0);"><span style="color: rgb(0, 0, 0);">Is that possible that the interrupts overflow? My master clock frequency is 60MHz. How to determine the delay in __ipipe_mach_set_dev?
</span></span><br><span style="color: rgb(255, 0, 0);"><span style="color: rgb(0, 0, 0);"><br>Please advice. Thanks<br><br>regards,<br><span class="sg">chun yeow<br></span></span></span><div><span class="e" id="q_113cdfbca95241b0_5">
<br><div><span class="gmail_quote">On 7/16/07, <b class="gmail_sendername">
Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Yeoh Chun Yeow wrote:<br> &gt; &gt; Dear all,<br> &gt; &gt;<br> &gt; &gt; I have applied the adeos-ipipe-2.6.20-arm-1.7.03.patch for kernel 2.6.20(patches with<br> &gt; &gt; 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.
<br><br>this patch is booting fine here on an AT91RM9200 board, booting with<br>NFS. But I had similar problems when enabling the I-pipe tracer, so be<br>sure that the tracer is disabled. Also, could you try without the<br>

2.6.20-at91 patch ? If it still does not boot without the I-pipe tracer<br>and without the 2.6.20-at91 patch, please send us your .config.<br><br> &gt; &gt;<br> &gt; &gt; If I compile the kernel without IPIPE, mounting of nfs file system or
<br> &gt; &gt; jffs2 filesystem are both alright.<br> &gt; &gt;<br> &gt; &gt; Whenever I enable the IPIPE feature, the booting sequence will hang and I<br> &gt; &gt; couldn&#39;t proceed to console login.<br> &gt; &gt;<br>

 &gt; &gt; -- mounting to jffs file system<br> &gt; &gt; mice: PS/2 mouse device common for all mice<br> &gt; &gt; AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire<br> &gt; &gt; TCP cubic registered<br>

 &gt; &gt; NET: Registered protocol family 1<br> &gt; &gt; NET: Registered protocol family 17<br> &gt; &gt; Empty flash at 0x00ee6080 ends at 0x00ee6200<br> &gt; &gt; Empty flash at 0x01d9d3f8 ends at 0x01d9d400<br> &gt; &gt; Empty flash at 0x01d9efdc ends at 0x01d9f000
<br> &gt; &gt; VFS: Mounted root (jffs2 filesystem).<br> &gt; &gt; Freeing init memory: 112K<br> &gt; &gt; --&gt; HANG<br> &gt; &gt;<br> &gt; &gt; -- mounting to NFS root file system<br> &gt; &gt; AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
<br> &gt; &gt; TCP cubic registered<br> &gt; &gt; NET: Registered protocol family 1<br> &gt; &gt; NET: Registered protocol family 17<br> &gt; &gt; --&gt; HANG<br> &gt; &gt;<br> &gt; &gt; I have try to enble IPIPE Tracer for debugging, but couldn&#39;t see the debug
<br> &gt; &gt; messages.<br><br>If you want to use the I-pipe tracer, see:<br><a href="http://www.xenomai.org/index.php/I-pipe:Tracer" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.xenomai.org/index.php/I-pipe:Tracer
</a><br>But as I said, enabling the tracer seems to be a problem on AT91RM9200.
<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></blockquote></div><br>
</span></div><br clear="all"></blockquote></div><br>

------=_Part_41038_5642855.1184571883123--

