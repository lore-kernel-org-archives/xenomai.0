Message-ID: <2862c2c80707160238g15576d2dm8d96634af5a0a8ec@domain.hid>
Date: Mon, 16 Jul 2007 17:38:39 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_41802_21665794.1184578719506"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
	<18075.3438.734938.482223@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
	<2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
	<2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
	<2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
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

------=_Part_41802_21665794.1184578719506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

I have tried to disable the IPIPE-interrupt and mounted the file system via
NFS without any problem. I have only exported
/home/yeow/kwikbyte/KB9202/target_fs directory but not the entire whole file
system in the server. I don't think that the problem is coming from the NFS
since I can mount the file system without IPIPE enabled. By the way, I am
using u-boot bootloader.

Please advice. Thanks

regards,
chun yeow


On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/16/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> >  On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> wrote:
> > > Thanks for the .config, could you also send us the full logs ?
> >
> > Dear Gilles,
> >
> > Here the full log messages:
> > (...)
> >
> > Kernel command line: console=ttyS0,115200 root=/dev/nfs
> > nfsroot=172.16.6.174:/home/yeow/kwikbyte/KB9202B/target_fs
> > (...)
> > IP-Config: Guessing netmask 255.255.0.0
> > IP-Config: Complete:
> >       device=eth0, addr=172.16.6.203, mask=255.255.0.0 , gw=
> 255.255.255.255,
> >      host=172.16.6.203, domain=, nis-domain=(none),
> >      bootserver=255.255.255.255 , rootserver=172.16.6.174, rootpath=
> > (...)
> > Any ideas? What's going wrong?
>
> This looks suspicious: you specifed nfsroot to be
> /home/yeow/kwikbyte/KB9202B/target_fs and it seems that Linux does
> not take it into account. On the server side did you export your whole
> filesystem or only this directory ? If you exported your whole filesystem,
> maybe linux is trying to execute your host /sbin/init and fails.
>
> You also selected floating-point emulation, whereas I do not. I do not use
> floating point emulation, it is very inefficient, instead, I compile
> user-space applications with -msoft-float. I will try to enable it in
> order to see if I get
> the same behaviour as you.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_41802_21665794.1184578719506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>I have tried to disable the IPIPE-interrupt and mounted the file system via NFS without any problem. I have only exported /home/yeow/kwikbyte/KB9202/target_fs directory but not the entire whole file system in the server. I don&#39;t think that the problem is coming from the NFS since I can mount the file system without IPIPE enabled. By the way, I am using u-boot bootloader.
<br><br>Please advice. Thanks<br><br>regards,<br>chun yeow<br><br><br><div><span class="gmail_quote">On 7/16/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 7/16/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">
yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;On 7/16/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>&gt; &gt; Thanks for the .config, could you also send us the full logs ?
<br>&gt;<br>&gt; Dear Gilles,<br>&gt;<br>&gt; Here the full log messages:<br>&gt; (...)<br>&gt;<br>&gt; Kernel command line: console=ttyS0,115200 root=/dev/nfs<br>&gt; nfsroot=172.16.6.174:/home/yeow/kwikbyte/KB9202B/target_fs
<br>&gt; (...)<br>&gt; IP-Config: Guessing netmask <a href="http://255.255.0.0">255.255.0.0</a><br>&gt; IP-Config: Complete:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://172.16.6.203">172.16.6.203</a>, mask=<a href="http://255.255.0.0">
255.255.0.0</a> , gw=<a href="http://255.255.255.255">255.255.255.255</a>,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;host=<a href="http://172.16.6.203">172.16.6.203</a>, domain=, nis-domain=(none),<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bootserver=<a href="http://255.255.255.255">
255.255.255.255</a> , rootserver=<a href="http://172.16.6.174">172.16.6.174</a>, rootpath=<br>&gt; (...)<br>&gt; Any ideas? What&#39;s going wrong?<br><br>This looks suspicious: you specifed nfsroot to be<br>/home/yeow/kwikbyte/KB9202B/target_fs and it seems that Linux does
<br>not take it into account. On the server side did you export your whole<br>filesystem or only this directory ? If you exported your whole filesystem,<br>maybe linux is trying to execute your host /sbin/init and fails.<br>
<br>You also selected floating-point emulation, whereas I do not. I do not use<br>floating point emulation, it is very inefficient, instead, I compile<br>user-space applications with -msoft-float. I will try to enable it in
<br>order to see if I get<br>the same behaviour as you.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_41802_21665794.1184578719506--

