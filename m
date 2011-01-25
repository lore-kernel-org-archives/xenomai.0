MIME-Version: 1.0
In-Reply-To: <4D3E72F3.6040400@domain.hid>
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
	<4D3E385A.5010209@domain.hid>
	<AANLkTikk=xBwB2JzxgyC08=nZY8gAHeXht+_cfZBMGK7@domain.hid>
	<4D3E42BA.4000601@domain.hid>
	<AANLkTi=E=4mSZ_QwD5wNXQMZ2dQJO6kG8vMLGnD52cy0@domain.hid>
	<4D3E4EBA.6050806@domain.hid>
	<AANLkTike9rXOKAuGy3Pi+ot8-753pzNAEK=xjhsgzU3O@mail.gmail.com>
	<4D3E5169.8050103@domain.hid>
	<AANLkTimxTLpGR6KvVBuermWiaqwkuod7QQxNVBXrmtyd@domain.hid>
	<4D3E576B.7060208@domain.hid>
	<AANLkTinAKRXB8jYJ-dMN0miqM37bT1O=oHa-uYaQQ-yo@domain.hid>
	<4D3E5959.9090205@domain.hid>
	<AANLkTimPA6yhFEYjQ-jpJtjQOx-2179HKNs3HTTwjY0T@mail.gmail.com>
	<4D3E5BC2.6070700@domain.hid>
	<AANLkTikzrOHi8caNdYg_FOY4NdhjWsh5qZZGYvD1URJ2@domain.hid>
	<4D3E6B94.5060302@domain.hid>
	<AANLkTimcpzTWvYyEfdVVqEqO_-hb-jb1p7kLLDaVrzrV@mail.gmail.com>
	<4D3E72F3.6040400@domain.hid>
Date: Tue, 25 Jan 2011 03:38:56 -0600
Message-ID: <AANLkTikwjhg_uAuZ9Y3ptEargN8AGaUtStZX-xurE8r=@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba1819da43188c049aa87c5d
Subject: Re: [Xenomai-help] Segmentation Fault when writing in registers
 (AT91SAM - ARM9)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

--90e6ba1819da43188c049aa87c5d
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 25, 2011 at 12:51 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Tue, Jan 25, 2011 at 12:20 AM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> at91_enthus wrote:
> >>>>> Oh. I assumed without mlockall (it wasn't part of my original code).
> >>>>> Now, I placed mlockall in my original code (right before
> >>>> open_controller())
> >>>>> and the pin gets toggled according to my scope.
> >>>> Ok. Show me the Makefile then.
> >>> And the code which works.
> >>>
> >>>
> >>>  see attachment
> >>>
> >>>
> >>>> Including the
> >>>> value of the defines please (not all of them, only those the program
> >>>> uses for open_controller).
> >>>>
> >>>>
> >>>>
> >>> #define AT91C_BASE_AIC          0xFFFFF000 // (AIC) Base Address
> >>> #define AT91C_BASE_PIOB        0xFFFFF600 // (PIOB) Base Address
> >>> #define PIO_PER             0x00000000 // (PIO_PER) PIO Enable Register
> >>> #define PIO_PDR             0x00000004 // (PIO_PDR) PIO Disable
> Register
> >>> #define PIO_PSR             0x00000008 // (PIO_PSR) PIO Status Register
> >>> #define PIO_OER             0x00000010 // (PIO_OER) Output Enable
> >> Register
> >>> #define PIO_SODR           0x00000030 // (PIO_SODR) Set Output Data
> >> Register
> >>> #define PIO_CODR           0x00000034 // (PIO_CODR) Clear Output Data
> >>> Register
> >>> #define PIO_PPUDR         0x00000060 // (PIO_PPUDR) Pull-up Disable
> >> Register
> >>> #define PIO_MDDR           0x00000054 // (PIO_MDDR) Multi-driver
> Disable
> >>> Register
> >>>
> >>>
> >> I am unable to reproduce your issue. That said, I am using standard
> >> Makefiles, that is:
> >>
> >> XENO_CONFIG = DESTDIR="$(staging)" $(staging)/bin/xeno-config
> >>
> >> XENO_NATIVE_CPPFLAGS = $(shell $(XENO_CONFIG) --skin=native --cflags)
> >> XENO_NATIVE_LIBS = $(shell $(XENO_CONFIG) --skin=native --ldflags)
> >>
> >> Where staging would be "/" in your case.
> >>
> >> If I want static libraries, I prepend -static to XENO_NATIVE_LIBS, I do
> >> not try to link both with static and dynamic libraries. I suspect this
> >> is the cause of your problem, either that or the fact that you have some
> >> ulimit.
> >>
> >> Note that my toolchain does not even allow mixing static and dynamic
> >> libraries. I get this warning when linking:
> >>
> >>
> /usr/local/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/../../../../arm-none-linux-gnueabi/bin/ld:
> >>
> >>
> /usr/local/arm-2010q1/bin/../arm-none-linux-gnueabi/libc/armv4t/usr/lib/libc.a(dl-tsd.o)(.text+0x18):
> >> R_ARM_TLS_LE32 relocation not permitted in shared object
> >>
> >> And a segmentation fault when running (though I do not even access the
> >> mmapped area).
> >>
> >> --
> >>                                                                 Gilles.
> >>
> >
> >
> > I'll try to fix this issue later today. Thanks a lot for taking the time
> to
> > help me.
>
> Yes, note that I wasted a lot of time: I knew from the beginning that
> the Makefile was broken, and this should have been the first thing I
> verified.
>
> Anyway, the "first-hand" examples we provide are those documented here:
> http://www.xenomai.org/index.php/Examples
>
> They come with working Makefiles, which you are encouraged to re-use.
>
> Also, xeno-config lacks support for getting the RTDM skin flags, but I
> am going to add it to 2.5.6.
>
> --
>                                                                 Gilles.
>


An out of the box Makefile (from Examples) with minor modifications did the
trick.

Regards,
R.

--90e6ba1819da43188c049aa87c5d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Jan 25, 2011 at 12:51 AM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">at91_enthus wrote:<br>
&gt; On Tue, Jan 25, 2011 at 12:20 AM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt; Oh. I assumed without mlockall (it wasn&#39;t part of =
my original code).<br>
&gt;&gt;&gt;&gt;&gt; Now, I placed mlockall in my original code (right befo=
re<br>
&gt;&gt;&gt;&gt; open_controller())<br>
&gt;&gt;&gt;&gt;&gt; and the pin gets toggled according to my scope.<br>
&gt;&gt;&gt;&gt; Ok. Show me the Makefile then.<br>
&gt;&gt;&gt; And the code which works.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =A0see attachment<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Including the<br>
&gt;&gt;&gt;&gt; value of the defines please (not all of them, only those t=
he program<br>
&gt;&gt;&gt;&gt; uses for open_controller).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; #define AT91C_BASE_AIC =A0 =A0 =A0 =A0 =A00xFFFFF000 // (AIC) =
Base Address<br>
&gt;&gt;&gt; #define AT91C_BASE_PIOB =A0 =A0 =A0 =A00xFFFFF600 // (PIOB) Ba=
se Address<br>
&gt;&gt;&gt; #define PIO_PER =A0 =A0 =A0 =A0 =A0 =A0 0x00000000 // (PIO_PER=
) PIO Enable Register<br>
&gt;&gt;&gt; #define PIO_PDR =A0 =A0 =A0 =A0 =A0 =A0 0x00000004 // (PIO_PDR=
) PIO Disable Register<br>
&gt;&gt;&gt; #define PIO_PSR =A0 =A0 =A0 =A0 =A0 =A0 0x00000008 // (PIO_PSR=
) PIO Status Register<br>
&gt;&gt;&gt; #define PIO_OER =A0 =A0 =A0 =A0 =A0 =A0 0x00000010 // (PIO_OER=
) Output Enable<br>
&gt;&gt; Register<br>
&gt;&gt;&gt; #define PIO_SODR =A0 =A0 =A0 =A0 =A0 0x00000030 // (PIO_SODR) =
Set Output Data<br>
&gt;&gt; Register<br>
&gt;&gt;&gt; #define PIO_CODR =A0 =A0 =A0 =A0 =A0 0x00000034 // (PIO_CODR) =
Clear Output Data<br>
&gt;&gt;&gt; Register<br>
&gt;&gt;&gt; #define PIO_PPUDR =A0 =A0 =A0 =A0 0x00000060 // (PIO_PPUDR) Pu=
ll-up Disable<br>
&gt;&gt; Register<br>
&gt;&gt;&gt; #define PIO_MDDR =A0 =A0 =A0 =A0 =A0 0x00000054 // (PIO_MDDR) =
Multi-driver Disable<br>
&gt;&gt;&gt; Register<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt; I am unable to reproduce your issue. That said, I am using standar=
d<br>
&gt;&gt; Makefiles, that is:<br>
&gt;&gt;<br>
&gt;&gt; XENO_CONFIG =3D DESTDIR=3D&quot;$(staging)&quot; $(staging)/bin/xe=
no-config<br>
&gt;&gt;<br>
&gt;&gt; XENO_NATIVE_CPPFLAGS =3D $(shell $(XENO_CONFIG) --skin=3Dnative --=
cflags)<br>
&gt;&gt; XENO_NATIVE_LIBS =3D $(shell $(XENO_CONFIG) --skin=3Dnative --ldfl=
ags)<br>
&gt;&gt;<br>
&gt;&gt; Where staging would be &quot;/&quot; in your case.<br>
&gt;&gt;<br>
&gt;&gt; If I want static libraries, I prepend -static to XENO_NATIVE_LIBS,=
 I do<br>
&gt;&gt; not try to link both with static and dynamic libraries. I suspect =
this<br>
&gt;&gt; is the cause of your problem, either that or the fact that you hav=
e some<br>
&gt;&gt; ulimit.<br>
&gt;&gt;<br>
&gt;&gt; Note that my toolchain does not even allow mixing static and dynam=
ic<br>
&gt;&gt; libraries. I get this warning when linking:<br>
&gt;&gt;<br>
&gt;&gt; /usr/local/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/=
../../../../arm-none-linux-gnueabi/bin/ld:<br>
&gt;&gt;<br>
&gt;&gt; /usr/local/arm-2010q1/bin/../arm-none-linux-gnueabi/libc/armv4t/us=
r/lib/libc.a(dl-tsd.o)(.text+0x18):<br>
&gt;&gt; R_ARM_TLS_LE32 relocation not permitted in shared object<br>
&gt;&gt;<br>
&gt;&gt; And a segmentation fault when running (though I do not even access=
 the<br>
&gt;&gt; mmapped area).<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ll try to fix this issue later today. Thanks a lot for taking th=
e time to<br>
&gt; help me.<br>
<br>
</div></div>Yes, note that I wasted a lot of time: I knew from the beginnin=
g that<br>
the Makefile was broken, and this should have been the first thing I<br>
verified.<br>
<br>
Anyway, the &quot;first-hand&quot; examples we provide are those documented=
 here:<br>
<a href=3D"http://www.xenomai.org/index.php/Examples" target=3D"_blank">htt=
p://www.xenomai.org/index.php/Examples</a><br>
<br>
They come with working Makefiles, which you are encouraged to re-use.<br>
<br>
Also, xeno-config lacks support for getting the RTDM skin flags, but I<br>
am going to add it to 2.5.6.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br><br>An out of the box Makefile (from Examples=
) with minor modifications did the trick. <br><br>Regards,<br>R.<br>

--90e6ba1819da43188c049aa87c5d--

