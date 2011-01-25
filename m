MIME-Version: 1.0
In-Reply-To: <4D3E6B94.5060302@domain.hid>
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
Date: Tue, 25 Jan 2011 00:45:21 -0600
Message-ID: <AANLkTimcpzTWvYyEfdVVqEqO_-hb-jb1p7kLLDaVrzrV@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=0016367fadcf794b8b049aa60f90
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

--0016367fadcf794b8b049aa60f90
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 25, 2011 at 12:20 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> >>> Oh. I assumed without mlockall (it wasn't part of my original code).
> >>> Now, I placed mlockall in my original code (right before
> >> open_controller())
> >>> and the pin gets toggled according to my scope.
> >> Ok. Show me the Makefile then.
> >
> > And the code which works.
> >
> >
> >  see attachment
> >
> >
> >> Including the
> >> value of the defines please (not all of them, only those the program
> >> uses for open_controller).
> >>
> >>
> >>
> > #define AT91C_BASE_AIC          0xFFFFF000 // (AIC) Base Address
> > #define AT91C_BASE_PIOB        0xFFFFF600 // (PIOB) Base Address
> > #define PIO_PER             0x00000000 // (PIO_PER) PIO Enable Register
> > #define PIO_PDR             0x00000004 // (PIO_PDR) PIO Disable Register
> > #define PIO_PSR             0x00000008 // (PIO_PSR) PIO Status Register
> > #define PIO_OER             0x00000010 // (PIO_OER) Output Enable
> Register
> > #define PIO_SODR           0x00000030 // (PIO_SODR) Set Output Data
> Register
> > #define PIO_CODR           0x00000034 // (PIO_CODR) Clear Output Data
> > Register
> > #define PIO_PPUDR         0x00000060 // (PIO_PPUDR) Pull-up Disable
> Register
> > #define PIO_MDDR           0x00000054 // (PIO_MDDR) Multi-driver Disable
> > Register
> >
> >
>
> I am unable to reproduce your issue. That said, I am using standard
> Makefiles, that is:
>
> XENO_CONFIG = DESTDIR="$(staging)" $(staging)/bin/xeno-config
>
> XENO_NATIVE_CPPFLAGS = $(shell $(XENO_CONFIG) --skin=native --cflags)
> XENO_NATIVE_LIBS = $(shell $(XENO_CONFIG) --skin=native --ldflags)
>
> Where staging would be "/" in your case.
>
> If I want static libraries, I prepend -static to XENO_NATIVE_LIBS, I do
> not try to link both with static and dynamic libraries. I suspect this
> is the cause of your problem, either that or the fact that you have some
> ulimit.
>
> Note that my toolchain does not even allow mixing static and dynamic
> libraries. I get this warning when linking:
>
> /usr/local/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/../../../../arm-none-linux-gnueabi/bin/ld:
>
> /usr/local/arm-2010q1/bin/../arm-none-linux-gnueabi/libc/armv4t/usr/lib/libc.a(dl-tsd.o)(.text+0x18):
> R_ARM_TLS_LE32 relocation not permitted in shared object
>
> And a segmentation fault when running (though I do not even access the
> mmapped area).
>
> --
>                                                                 Gilles.
>


I'll try to fix this issue later today. Thanks a lot for taking the time to
help me.

R.

--0016367fadcf794b8b049aa60f90
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Jan 25, 2011 at 12:20 AM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt;&gt;&gt; Oh. I assumed without mlockall (it wasn&#39;t part of my origi=
nal code).<br>
&gt;&gt;&gt; Now, I placed mlockall in my original code (right before<br>
&gt;&gt; open_controller())<br>
&gt;&gt;&gt; and the pin gets toggled according to my scope.<br>
&gt;&gt; Ok. Show me the Makefile then.<br>
&gt;<br>
&gt; And the code which works.<br>
&gt;<br>
&gt;<br>
&gt; =A0see attachment<br>
&gt;<br>
&gt;<br>
&gt;&gt; Including the<br>
&gt;&gt; value of the defines please (not all of them, only those the progr=
am<br>
&gt;&gt; uses for open_controller).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; #define AT91C_BASE_AIC =A0 =A0 =A0 =A0 =A00xFFFFF000 // (AIC) Base Add=
ress<br>
&gt; #define AT91C_BASE_PIOB =A0 =A0 =A0 =A00xFFFFF600 // (PIOB) Base Addre=
ss<br>
&gt; #define PIO_PER =A0 =A0 =A0 =A0 =A0 =A0 0x00000000 // (PIO_PER) PIO En=
able Register<br>
&gt; #define PIO_PDR =A0 =A0 =A0 =A0 =A0 =A0 0x00000004 // (PIO_PDR) PIO Di=
sable Register<br>
&gt; #define PIO_PSR =A0 =A0 =A0 =A0 =A0 =A0 0x00000008 // (PIO_PSR) PIO St=
atus Register<br>
&gt; #define PIO_OER =A0 =A0 =A0 =A0 =A0 =A0 0x00000010 // (PIO_OER) Output=
 Enable Register<br>
&gt; #define PIO_SODR =A0 =A0 =A0 =A0 =A0 0x00000030 // (PIO_SODR) Set Outp=
ut Data Register<br>
&gt; #define PIO_CODR =A0 =A0 =A0 =A0 =A0 0x00000034 // (PIO_CODR) Clear Ou=
tput Data<br>
&gt; Register<br>
&gt; #define PIO_PPUDR =A0 =A0 =A0 =A0 0x00000060 // (PIO_PPUDR) Pull-up Di=
sable Register<br>
&gt; #define PIO_MDDR =A0 =A0 =A0 =A0 =A0 0x00000054 // (PIO_MDDR) Multi-dr=
iver Disable<br>
&gt; Register<br>
&gt;<br>
&gt;<br>
<br>
</div>I am unable to reproduce your issue. That said, I am using standard<b=
r>
Makefiles, that is:<br>
<br>
XENO_CONFIG =3D DESTDIR=3D&quot;$(staging)&quot; $(staging)/bin/xeno-config=
<br>
<br>
XENO_NATIVE_CPPFLAGS =3D $(shell $(XENO_CONFIG) --skin=3Dnative --cflags)<b=
r>
XENO_NATIVE_LIBS =3D $(shell $(XENO_CONFIG) --skin=3Dnative --ldflags)<br>
<br>
Where staging would be &quot;/&quot; in your case.<br>
<br>
If I want static libraries, I prepend -static to XENO_NATIVE_LIBS, I do<br>
not try to link both with static and dynamic libraries. I suspect this<br>
is the cause of your problem, either that or the fact that you have some<br=
>
ulimit.<br>
<br>
Note that my toolchain does not even allow mixing static and dynamic<br>
libraries. I get this warning when linking:<br>
/usr/local/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/../../../=
../arm-none-linux-gnueabi/bin/ld:<br>
/usr/local/arm-2010q1/bin/../arm-none-linux-gnueabi/libc/armv4t/usr/lib/lib=
c.a(dl-tsd.o)(.text+0x18):<br>
R_ARM_TLS_LE32 relocation not permitted in shared object<br>
<br>
And a segmentation fault when running (though I do not even access the<br>
mmapped area).<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br><br>I&#39;ll try to fix this issue later toda=
y. Thanks a lot for taking the time to help me.<br><br>R.<br>

--0016367fadcf794b8b049aa60f90--

