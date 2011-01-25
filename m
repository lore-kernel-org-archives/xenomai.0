MIME-Version: 1.0
In-Reply-To: <4D3E576B.7060208@domain.hid>
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
Date: Mon, 24 Jan 2011 23:00:44 -0600
Message-ID: <AANLkTinAKRXB8jYJ-dMN0miqM37bT1O=oHa-uYaQQ-yo@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e70021b5188b3049aa499fe
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

--e0cb4e70021b5188b3049aa499fe
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 24, 2011 at 10:54 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> at91_enthus wrote:
> >>> On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix <
> >>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>
> >>>> at91_enthus wrote:
> >>>>> On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix <
> >>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>
> >>>>>> at91_enthus wrote:
> >>>>>>> On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
> >>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>
> >>>>>>>> at91_enthus wrote:
> >>>>>>>>> Hi.
> >>>>>>>>>
> >>>>>>>>> I  was testing Xenomai on my AT91SAM9G20-based board and tried to
> >>>> adapt
> >>>>>>>> the
> >>>>>>>>> code found here:
> >>>>>>>>>
> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs.
> >>>>>>>> By the way, this code is ridiculous. It creates a real-time task
> to
> >>>>>>>> write to some non real-time device, which makes the real-time task
> >>>>>> useless.
> >>>>>>> I know.
> >>>>>> Yes, but this example is bad in many ways:
> >>>>>> - first it uses xenomai api to create a real-time task, and uses
> write
> >>>>>> which causes the real-time task to switch to secondary domain;
> >>>>>> - the Makefile does not use xeno-config, which have been the
> >> recommended
> >>>>>> way of getting the compiler flags since day 1;
> >>>>>> - it nullifies SIGTERM and SIGINT, which is a dubious decision, and
> >>>>>> could lead people to believe that they should do the same when using
> >>>>>> Xenomai, whereas there is no such requirement.
> >>>>>> - the pointers point to outdated version of the documentation.
> >>>>>> - it uses runinfo/xeno-load, which are kind of outdated too, make
> >> things
> >>>>>> uselessly complicated, and in any case, tell you to type Ctrl-C to
> >>>>>> interrupt the program, which is bound to fail if anything goes
> wrong,
> >>>>>> since SIGINT is neutralized in the program.
> >>>>>>
> >>>>>>> That's why I went to mmap().
> >>>>>> That is not really the right solution either. I admit that for
> driving
> >>>>>> leds, it may be a bit overkill, but anyway, what you should do is
> >> write
> >>>>>> an RTDM driver for driving the leds. Keeping the driver separated
> from
> >>>>>> the application will allow the same program to run on other
> platforms
> >>>>>> where driving the LEDS is done differently without changing much of
> >> the
> >>>>>> application code. In other word, the application/driver separation
> is
> >> a
> >>>>>> sane one.
> >>>>>>
> >>>>>> Anyway, mmap should work.
> >>>>>>
> >>>>>>  (I chose that sample code because, for
> >>>>>>> now, I am only learning to use basic functions)
> >>>>>>>> Wrong test here. Should be "if (aic_base == MAP_FAILED)"
> >>>>>>> Indeed, my program fails miserably when I check the mapping of AIC,
> >> not
> >>>>>>> PIOB's. And yet, I just can't figure why in the non-Xenomai code,
> AIC
> >>>>>>> mmap-ing works  fine.
> >>>>>> Well errno might give you a clue. Do you have FCSE enabled?
> >>>>>>
> >>>>>> Regards.
> >>>>>>
> >>>>>> --
> >>>>>>
> >> Gilles.
> >>>>> FCSE is enabled. errno returns  22 (invalid argument).
> >>>> best effort or guaranteed?
> >>>
> >>> Best effort
> >>>
> >>>
> >>>> Please activate FCSE messages.
> >>>
> >>> ... compiling new kernel
> >>>
> >>>
> >>>> How big is
> >>>> MAP_SIZE?
> >>>>
> >>>>
> >>> 4096
> >> Ok. Could you post your full kernel configuration, as well as the full
> >> program?
> >>
> >
> > I put the .config and the code in the attachments.
>
>

> If you remove all the native skin stuff, only keep main and
> open_controller, do not link with the native library, you can confirm
> that this same program runs without trouble?
>

 Without  Xenomai related stuff, it runs  OK.

--e0cb4e70021b5188b3049aa499fe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 24, 2011 at 10:54 PM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">at91_enthus wrote:<br>
&gt; On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt; On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix &lt;<br=
>
&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix =
&lt;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gi=
lles.chanteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chante=
perdrix &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =A0was testing Xenomai on my AT91SAM=
9G20-based board and tried to<br>
&gt;&gt;&gt;&gt; adapt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; code found here:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://www.armadeus.com/wik=
i/index.php?title=3DXenomai:Blinking_LEDs" target=3D"_blank">http://www.arm=
adeus.com/wiki/index.php?title=3DXenomai:Blinking_LEDs</a>.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; By the way, this code is ridiculous. It cr=
eates a real-time task to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; write to some non real-time device, which =
makes the real-time task<br>
&gt;&gt;&gt;&gt;&gt;&gt; useless.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I know.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Yes, but this example is bad in many ways:<br>
&gt;&gt;&gt;&gt;&gt;&gt; - first it uses xenomai api to create a real-time =
task, and uses write<br>
&gt;&gt;&gt;&gt;&gt;&gt; which causes the real-time task to switch to secon=
dary domain;<br>
&gt;&gt;&gt;&gt;&gt;&gt; - the Makefile does not use xeno-config, which hav=
e been the<br>
&gt;&gt; recommended<br>
&gt;&gt;&gt;&gt;&gt;&gt; way of getting the compiler flags since day 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt; - it nullifies SIGTERM and SIGINT, which is a dubi=
ous decision, and<br>
&gt;&gt;&gt;&gt;&gt;&gt; could lead people to believe that they should do t=
he same when using<br>
&gt;&gt;&gt;&gt;&gt;&gt; Xenomai, whereas there is no such requirement.<br>
&gt;&gt;&gt;&gt;&gt;&gt; - the pointers point to outdated version of the do=
cumentation.<br>
&gt;&gt;&gt;&gt;&gt;&gt; - it uses runinfo/xeno-load, which are kind of out=
dated too, make<br>
&gt;&gt; things<br>
&gt;&gt;&gt;&gt;&gt;&gt; uselessly complicated, and in any case, tell you t=
o type Ctrl-C to<br>
&gt;&gt;&gt;&gt;&gt;&gt; interrupt the program, which is bound to fail if a=
nything goes wrong,<br>
&gt;&gt;&gt;&gt;&gt;&gt; since SIGINT is neutralized in the program.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s why I went to mmap().<br>
&gt;&gt;&gt;&gt;&gt;&gt; That is not really the right solution either. I ad=
mit that for driving<br>
&gt;&gt;&gt;&gt;&gt;&gt; leds, it may be a bit overkill, but anyway, what y=
ou should do is<br>
&gt;&gt; write<br>
&gt;&gt;&gt;&gt;&gt;&gt; an RTDM driver for driving the leds. Keeping the d=
river separated from<br>
&gt;&gt;&gt;&gt;&gt;&gt; the application will allow the same program to run=
 on other platforms<br>
&gt;&gt;&gt;&gt;&gt;&gt; where driving the LEDS is done differently without=
 changing much of<br>
&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt; application code. In other word, the application/d=
river separation is<br>
&gt;&gt; a<br>
&gt;&gt;&gt;&gt;&gt;&gt; sane one.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Anyway, mmap should work.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0(I chose that sample code because, for<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; now, I am only learning to use basic functions=
)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Wrong test here. Should be &quot;if (aic_b=
ase =3D=3D MAP_FAILED)&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Indeed, my program fails miserably when I chec=
k the mapping of AIC,<br>
&gt;&gt; not<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; PIOB&#39;s. And yet, I just can&#39;t figure w=
hy in the non-Xenomai code, AIC<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; mmap-ing works =A0fine.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Well errno might give you a clue. Do you have FCSE=
 enabled?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Regards.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; Gilles.<br>
&gt;&gt;&gt;&gt;&gt; FCSE is enabled. errno returns =A022 (invalid argument=
).<br>
&gt;&gt;&gt;&gt; best effort or guaranteed?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Best effort<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please activate FCSE messages.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ... compiling new kernel<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; How big is<br>
&gt;&gt;&gt;&gt; MAP_SIZE?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; 4096<br>
&gt;&gt; Ok. Could you post your full kernel configuration, as well as the =
full<br>
&gt;&gt; program?<br>
&gt;&gt;<br>
&gt;<br>
&gt; I put the .config and the code in the attachments.<br>
<br></div></div></blockquote><div>=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, =
204); padding-left: 1ex;"><div><div class=3D"h5">
</div></div>If you remove all the native skin stuff, only keep main and<br>
open_controller, do not link with the native library, you can confirm<br>
that this same program runs without trouble?<br></blockquote><div><br>=A0Wi=
thout=A0 Xenomai related stuff, it runs=A0 OK.<br></div></div>

--e0cb4e70021b5188b3049aa499fe--

