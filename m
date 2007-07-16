Message-ID: <2862c2c80707160301i786f94abn6ca72ac76b1b1631@domain.hid>
Date: Mon, 16 Jul 2007 18:01:56 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707160256w36d61f52nbdd8cb8c091ee97d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_42030_22420921.1184580116857"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
	<18075.3438.734938.482223@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
	<2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
	<2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
	<2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
	<2862c2c80707160238g15576d2dm8d96634af5a0a8ec@domain.hid>
	<2ff1a98a0707160256w36d61f52nbdd8cb8c091ee97d@domain.hid>
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

------=_Part_42030_22420921.1184580116857
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Did you mean that disable the "NetWinder Floating Point Emulator" in Kernel
setting?

regards,
chun yeow

On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/16/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org >
> wrote:
> > >
> > > You also selected floating-point emulation, whereas I do not. I do not
> use
> > > floating point emulation, it is very inefficient, instead, I compile
> > > user-space applications with -msoft-float. I will try to enable it in
> > > order to see if I get
> > > the same behaviour as you.
> > >
> > Dear Gilles,
> >
> > I have tried to disable the IPIPE-interrupt and mounted the file system
> via
> > NFS without any problem. I have only exported
> > /home/yeow/kwikbyte/KB9202/target_fs directory but not the
> > entire whole file system in the server. I don't think that the problem
> is
> > coming from the NFS since I can mount the file system without IPIPE
> enabled.
> > By the way, I am using u-boot bootloader.
> >
> > Please advice. Thanks
>
> I will not be able to test the floating point issue before tonight.
> So, if you are
> in a hurry, my next advice is to recompile your whole user-space support
> with -msoft-float and disable hardware floating-point emulation in kernel
> configuration. It is better for the performance of your applications
> anyway.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_42030_22420921.1184580116857
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Did you mean that disable the &quot;NetWinder Floating Point Emulator&quot; in Kernel setting?<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 7/16/07, <b class="gmail_sendername">
Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 7/16/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; On 7/16/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org
</a> &gt; wrote:<br>&gt; &gt;<br>&gt; &gt; You also selected floating-point emulation, whereas I do not. I do not use<br>&gt; &gt; floating point emulation, it is very inefficient, instead, I compile<br>&gt; &gt; user-space applications with -msoft-float. I will try to enable it in
<br>&gt; &gt; order to see if I get<br>&gt; &gt; the same behaviour as you.<br>&gt; &gt;<br>&gt; Dear Gilles,<br>&gt;<br>&gt; I have tried to disable the IPIPE-interrupt and mounted the file system via<br>&gt; NFS without any problem. I have only exported
<br>&gt; /home/yeow/kwikbyte/KB9202/target_fs directory but not the<br>&gt; entire whole file system in the server. I don&#39;t think that the problem is<br>&gt; coming from the NFS since I can mount the file system without IPIPE enabled.
<br>&gt; By the way, I am using u-boot bootloader.<br>&gt;<br>&gt; Please advice. Thanks<br><br>I will not be able to test the floating point issue before tonight.<br>So, if you are<br>in a hurry, my next advice is to recompile your whole user-space support
<br>with -msoft-float and disable hardware floating-point emulation in kernel<br>configuration. It is better for the performance of your applications anyway.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix
<br></blockquote></div><br>

------=_Part_42030_22420921.1184580116857--

