MIME-Version: 1.0
In-Reply-To: <4C3EFB0B.7050801@domain.hid>
References: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>
	<4C3EFB0B.7050801@domain.hid>
Date: Thu, 15 Jul 2010 16:10:58 +0200
Message-ID: <AANLkTinH0vj7gAxa8LscV_-Hvmggo9LigQkp30nIUcz6@domain.hid>
From: Cyril Wallois <walloiscyril@domain.hid>
Content-Type: multipart/alternative; boundary=0015174be8c8e6eb62048b6daba0
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
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

--0015174be8c8e6eb62048b6daba0
Content-Type: text/plain; charset=ISO-8859-1

Hi Gilles,

Sorry, I don't mention that my problem has ever been evoqued on xenomai-help
one month ago :

2010/6/8 Cyril Wallois wrote:
> Hi Gilles,
>
> Thanks for your help
>
>     Still on ARM, right? Do you have the same issue if you use an I-pipe
>     patch for a more recent kernel versions (anything more recent than
>     2.6.28).
>
>
> Yes on ARM with PXA270 (toradex colibri), I try to use a newer kernel
> but I have a problem of file system and can't use NFS (ethernet driver
> as module for rtnet).
> On an other embedded system, with kernel 2.6.29, I haven't any problem.
>
>     Other than that, you do not give us enough information to help solving
>     your issue. What about the last issue you had? What was the value of
the
>     r3 register at the time of the alignment fault?
>
>
> I don't solve the last issue, I focus on try with newer version of
> kernel and xenomai.
> Probably my problem should be solve with a more recent kernel , I think
> I will try 2.6.29 (and try to solve fs problem).

I do not understand why choosing such an old kernel when starting a new
project. Why not 2.6.33? 2.6.29 is more than one year old.

As for the unaligned access, it looks like a problem in rtnet. So, I
doubt it could be solved by a more recent version of Xenomai. For the
record, I have been using Xenomai and rtnet for a long time on ARM, and
had no issues, so, there is definitely no bug fixed recently in Xenomai
to get rtnet working on ARM, they have been working together for a long
time. But Ok, it will avoid bugs that we already know.

--
                                            Gilles.

2010/7/15 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Cyril Wallois wrote:
> > Hi everybody,
> >
> > I have try to solve my problem by using a newer kernel (2.6.30) without
> > success, I have always the same issue with rtnet when I try rtping :
> >
> > #./rtping 127.0.0.1
> > Xenomai: suspending kernel thread bf009310 ('rtnet-rtpc') at 0xc002d3c8
> > after exception #0
>
> Why simply not disassembling the kernel and looking at what is at
> 0xc002d3c8 and looking at the values of the registers? It is entirely
> possible that the RTnet IP stack requires unaligned accesses (the
> vanilla kernel does it, notably for handling of IP options), and as you
> may know it, unaligned accesses may require software emulation on some
> platforms. However, I am not sure you would get an exception #0 in that
> case. Your post does not even tell us on what platform you get this
> issue, though I suspect this is ARM.
>
> --
>                                             Gilles.
>
0xc002d3c8 correspond to do_page_fault in /proc/kallsyms

I will looking at the value of the register.

Best regards,

WALLOIS Cyril

--0015174be8c8e6eb62048b6daba0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,<br><br>Sorry, I don&#39;t mention that my problem has ever been =
evoqued on xenomai-help one month ago :<br><br><div class=3D"im">2010/6/8 C=
yril Wallois wrote:<br>
&gt; Hi Gilles,<br>
&gt;<br>
&gt; Thanks for your help<br>
&gt;<br>
&gt; =A0 =A0 Still on ARM, right? Do you have the same issue if you use an=
=20
I-pipe<br>
&gt; =A0 =A0 patch for a more recent kernel versions (anything more recent=
=20
than<br>
&gt; =A0 =A0 2.6.28).<br>
&gt;<br>
&gt;<br>
&gt; Yes on ARM with PXA270 (toradex colibri), I try to use a newer=20
kernel<br>
&gt; but I have a problem of file system and can&#39;t use NFS (ethernet=20
driver<br>
&gt; as module for rtnet).<br>
&gt; On an other embedded system, with kernel 2.6.29, I haven&#39;t any=20
problem.<br>
&gt;<br>
&gt; =A0 =A0 Other than that, you do not give us enough information to help=
=20
solving<br>
&gt; =A0 =A0 your issue. What about the last issue you had? What was the=20
value of the<br>
&gt; =A0 =A0 r3 register at the time of the alignment fault?<br>
&gt;<br>
&gt;<br>
&gt; I don&#39;t solve the last issue, I focus on try with newer version of=
<br>
&gt; kernel and xenomai.<br>
&gt; Probably my problem should be solve with a more recent kernel , I=20
think<br>
&gt; I will try 2.6.29 (and try to solve fs problem).<br>
<br>
</div>I do not understand why choosing such an old kernel when=20
starting a new<br>
project. Why not 2.6.33? 2.6.29 is more than one year old.<br>
<br>
As for the unaligned access, it looks like a problem in rtnet. So, I<br>
doubt it could be solved by a more recent version of Xenomai. For the<br>
record, I have been using Xenomai and rtnet for a long time on ARM, and<br>
had no issues, so, there is definitely no bug fixed recently in Xenomai<br>
to get rtnet working on ARM, they have been working together for a long<br>
time. But Ok, it will avoid bugs that we already know.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
=A0Gilles.</font><br><br><div class=3D"gmail_quote">2010/7/15 Gilles Chante=
perdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
i.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">Cyril Wallois wrote:<br>
&gt; Hi everybody,<br>
&gt;<br>
&gt; I have try to solve my problem by using a newer kernel (2.6.30) withou=
t<br>
&gt; success, I have always the same issue with rtnet when I try rtping :<b=
r>
&gt;<br>
&gt; #./rtping 127.0.0.1<br>
&gt; Xenomai: suspending kernel thread bf009310 (&#39;rtnet-rtpc&#39;) at 0=
xc002d3c8<br>
&gt; after exception #0<br>
<br>
</div>Why simply not disassembling the kernel and looking at what is at<br>
0xc002d3c8 and looking at the values of the registers? It is entirely<br>
possible that the RTnet IP stack requires unaligned accesses (the<br>
vanilla kernel does it, notably for handling of IP options), and as you<br>
may know it, unaligned accesses may require software emulation on some<br>
platforms. However, I am not sure you would get an exception #0 in that<br>
case. Your post does not even tell us on what platform you get this<br>
issue, though I suspect this is ARM.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div>0xc002d3c8 correspond to do_page_fault in /proc/k=
allsyms<br><br>I will looking at the value of the register.<br><br>Best reg=
ards,<br><br>WALLOIS Cyril<br>

--0015174be8c8e6eb62048b6daba0--

