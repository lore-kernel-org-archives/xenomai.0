MIME-Version: 1.0
In-Reply-To: <4F4920DE.40600@domain.hid>
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
	<CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
	<4F4920DE.40600@domain.hid>
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Wed, 29 Feb 2012 17:34:44 -0600
Message-ID: <CAHOEnGcVoRVtfL0Fgz-zx-==2YkM7QH3abtSLDaZdyVo0gk60Q@mail.gmail.com>
Content-Type: multipart/alternative; boundary=f46d04446c57fdd86d04ba22caf3
Subject: Re: [Xenomai-help] Freeze while running examples
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
Cc: xenomai@xenomai.org

--f46d04446c57fdd86d04ba22caf3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/2/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/24/2012 11:55 PM, Oscar D=E1vila wrote:
> > 2012/2/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:
> >>> 2012/2/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>>
> >>>> On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:
> >>>>> I compiled Xenomai succesfully, but when i try to run an example it
> >>>> freezes
> >>>>> / machine look up, any help will be apreciated, thanks.
> >>>>>
> >>>>> Here is some info about the system, its a Debian 6.0 with a
> >>>>> kernel 2.6.35.9, xenomai-2.6.0, the adeos
> >>>>> patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
> >>>>> nmi_watchdog=3D2 in the boot kernel options.
> >>>>
> >>>> Please reproduce the bug:
> >>>> - in text mode, so as to have the full bug trace;
> >>>> - with frame pointers enabled;
> >>>> - with highest kernel verbosity for BUGs and backtraces.
> >>>>
> >>>
> >>> How do i do this last point? i mean, i already compile kernel with
> frame
> >>> pointers enabled, also i already ran it in text mode, and i active al=
l
> >> the
> >>> xenomai debug kernel options. i saw some other debug options in kerne=
l
> >>> hacking, do i have to active those ones too?
> >>
> >> The stack trace looks fine. Could you show us the disassembly of the
> >> __ipipe_sync_stage function?
> >>
> >>
> > Here is what i think is the disassembly of the __ipipe_sync_stage
> function,
> > the full disassembly of the core.c file is in
> > http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage
>
> Please obtain the disassembly with objdump -d vmlinx, so that we get the
> addresses corresponding with the instructions. Without the addresses, we
> do not know where to look.
>

I need some help here, i've already dump the vmlinux image, but i get the
asm with addresses but without the source so i don't know how to get the
__ipipe_sync_stage function, y tried objdump -S vmlinux but didnt worked,
do i have to check an option in the .config of the kernel to be able to get
the source?


Thanks again.



 --
>                                                                Gilles.
>
>


--=20
Atentamente:
Oscar D=E1vila Ram=EDrez

--f46d04446c57fdd86d04ba22caf3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2012/2/25 Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div><div></div><div class=3D"h5">On 02/24/2012 11:55 PM, Oscar D=E1vila wr=
ote:<br>
&gt; 2012/2/23 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:<br>
&gt;&gt;&gt; 2012/2/14 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:<br>
&gt;&gt;&gt;&gt;&gt; I compiled Xenomai succesfully, but when i try to run =
an example it<br>
&gt;&gt;&gt;&gt; freezes<br>
&gt;&gt;&gt;&gt;&gt; / machine look up, any help will be apreciated, thanks=
.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Here is some info about the system, its a Debian 6.0 w=
ith a<br>
&gt;&gt;&gt;&gt;&gt; kernel 2.6.35.9, xenomai-2.6.0, the adeos<br>
&gt;&gt;&gt;&gt;&gt; patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im als=
o using the<br>
&gt;&gt;&gt;&gt;&gt; nmi_watchdog=3D2 in the boot kernel options.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please reproduce the bug:<br>
&gt;&gt;&gt;&gt; - in text mode, so as to have the full bug trace;<br>
&gt;&gt;&gt;&gt; - with frame pointers enabled;<br>
&gt;&gt;&gt;&gt; - with highest kernel verbosity for BUGs and backtraces.<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; How do i do this last point? i mean, i already compile kernel =
with frame<br>
&gt;&gt;&gt; pointers enabled, also i already ran it in text mode, and i ac=
tive all<br>
&gt;&gt; the<br>
&gt;&gt;&gt; xenomai debug kernel options. i saw some other debug options i=
n kernel<br>
&gt;&gt;&gt; hacking, do i have to active those ones too?<br>
&gt;&gt;<br>
&gt;&gt; The stack trace looks fine. Could you show us the disassembly of t=
he<br>
&gt;&gt; __ipipe_sync_stage function?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Here is what i think is the disassembly of the __ipipe_sync_stage func=
tion,<br>
&gt; the full disassembly of the core.c file is in<br>
&gt; <a href=3D"http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage" tar=
get=3D"_blank">http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage</a><b=
r>
<br>
</div></div>Please obtain the disassembly with objdump -d vmlinx, so that w=
e get the<br>
addresses corresponding with the instructions. Without the addresses, we<br=
>
do not know where to look.<br></blockquote><div><br></div><div>I need some =
help here, i&#39;ve already dump the vmlinux image, but i get the asm with =
addresses but without the source so i don&#39;t know how to get the __ipipe=
_sync_stage function, y tried objdump -S vmlinux but didnt worked, do i hav=
e to check an option in the .config of the kernel to be able to get the sou=
rce?</div>

<div><br></div><div><br></div><div>Thanks again.</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">=A0</blockquote><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<font color=3D"#888888">
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>=
Atentamente:<br>Oscar D=E1vila Ram=EDrez<br></div><br>

--f46d04446c57fdd86d04ba22caf3--

