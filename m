MIME-Version: 1.0
In-Reply-To: <4D3E5959.9090205@domain.hid>
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
Date: Mon, 24 Jan 2011 23:08:52 -0600
Message-ID: <AANLkTimPA6yhFEYjQ-jpJtjQOx-2179HKNs3HTTwjY0T@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba6150dc644c4e049aa4b680
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

--90e6ba6150dc644c4e049aa4b680
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 24, 2011 at 11:02 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Mon, Jan 24, 2011 at 10:54 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> at91_enthus wrote:
> >>> On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix <
> >>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>
> >>>> at91_enthus wrote:
> >>>>> On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix <
> >>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>
> >>>>>> at91_enthus wrote:
> >>>>>>> On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix <
> >>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>
> >>>>>>>> at91_enthus wrote:
> >>>>>>>>> On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
> >>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>
> >>>>>>>>>> at91_enthus wrote:
> >>>>>>>>>>> Hi.
> >>>>>>>>>>>
> >>>>>>>>>>> I  was testing Xenomai on my AT91SAM9G20-based board and tried
> to
> >>>>>> adapt
> >>>>>>>>>> the
> >>>>>>>>>>> code found here:
> >>>>>>>>>>>
> >> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs.
> >>>>>>>>>> By the way, this code is ridiculous. It creates a real-time task
> >> to
> >>>>>>>>>> write to some non real-time device, which makes the real-time
> task
> >>>>>>>> useless.
> >>>>>>>>> I know.
> >>>>>>>> Yes, but this example is bad in many ways:
> >>>>>>>> - first it uses xenomai api to create a real-time task, and uses
> >> write
> >>>>>>>> which causes the real-time task to switch to secondary domain;
> >>>>>>>> - the Makefile does not use xeno-config, which have been the
> >>>> recommended
> >>>>>>>> way of getting the compiler flags since day 1;
> >>>>>>>> - it nullifies SIGTERM and SIGINT, which is a dubious decision,
> and
> >>>>>>>> could lead people to believe that they should do the same when
> using
> >>>>>>>> Xenomai, whereas there is no such requirement.
> >>>>>>>> - the pointers point to outdated version of the documentation.
> >>>>>>>> - it uses runinfo/xeno-load, which are kind of outdated too, make
> >>>> things
> >>>>>>>> uselessly complicated, and in any case, tell you to type Ctrl-C to
> >>>>>>>> interrupt the program, which is bound to fail if anything goes
> >> wrong,
> >>>>>>>> since SIGINT is neutralized in the program.
> >>>>>>>>
> >>>>>>>>> That's why I went to mmap().
> >>>>>>>> That is not really the right solution either. I admit that for
> >> driving
> >>>>>>>> leds, it may be a bit overkill, but anyway, what you should do is
> >>>> write
> >>>>>>>> an RTDM driver for driving the leds. Keeping the driver separated
> >> from
> >>>>>>>> the application will allow the same program to run on other
> >> platforms
> >>>>>>>> where driving the LEDS is done differently without changing much
> of
> >>>> the
> >>>>>>>> application code. In other word, the application/driver separation
> >> is
> >>>> a
> >>>>>>>> sane one.
> >>>>>>>>
> >>>>>>>> Anyway, mmap should work.
> >>>>>>>>
> >>>>>>>>  (I chose that sample code because, for
> >>>>>>>>> now, I am only learning to use basic functions)
> >>>>>>>>>> Wrong test here. Should be "if (aic_base == MAP_FAILED)"
> >>>>>>>>> Indeed, my program fails miserably when I check the mapping of
> AIC,
> >>>> not
> >>>>>>>>> PIOB's. And yet, I just can't figure why in the non-Xenomai code,
> >> AIC
> >>>>>>>>> mmap-ing works  fine.
> >>>>>>>> Well errno might give you a clue. Do you have FCSE enabled?
> >>>>>>>>
> >>>>>>>> Regards.
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>>
> >>>> Gilles.
> >>>>>>> FCSE is enabled. errno returns  22 (invalid argument).
> >>>>>> best effort or guaranteed?
> >>>>> Best effort
> >>>>>
> >>>>>
> >>>>>> Please activate FCSE messages.
> >>>>> ... compiling new kernel
> >>>>>
> >>>>>
> >>>>>> How big is
> >>>>>> MAP_SIZE?
> >>>>>>
> >>>>>>
> >>>>> 4096
> >>>> Ok. Could you post your full kernel configuration, as well as the full
> >>>> program?
> >>>>
> >>> I put the .config and the code in the attachments.
> >>
> >
> >> If you remove all the native skin stuff, only keep main and
> >> open_controller, do not link with the native library, you can confirm
> >> that this same program runs without trouble?
> >>
> >
> >  Without  Xenomai related stuff, it runs  OK.
>
> You sure of that?  The exact same code, with the same kernel, with the
> mlockall?
>
> --
>                                                                 Gilles.
>

Oh. I assumed without mlockall (it wasn't part of my original code).
Now, I placed mlockall in my original code (right before open_controller())
and the pin gets toggled according to my scope.

--90e6ba6150dc644c4e049aa4b680
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 24, 2011 at 11:02 PM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">at91_enthus wrote:<br>
&gt; On Mon, Jan 24, 2011 at 10:54 PM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt; On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix &lt;<br=
>
&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix=
 &lt;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gi=
lles.chanteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chante=
perdrix &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 8:41 PM, Gille=
s Chanteperdrix &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =A0was testing Xenomai on my=
 AT91SAM9G20-based board and tried to<br>
&gt;&gt;&gt;&gt;&gt;&gt; adapt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; code found here:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.armadeus.com/wiki/index.php?title=3DXenomai:=
Blinking_LEDs" target=3D"_blank">http://www.armadeus.com/wiki/index.php?tit=
le=3DXenomai:Blinking_LEDs</a>.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; By the way, this code is ridiculou=
s. It creates a real-time task<br>
&gt;&gt; to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; write to some non real-time device=
, which makes the real-time task<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; useless.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I know.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Yes, but this example is bad in many ways:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - first it uses xenomai api to create a re=
al-time task, and uses<br>
&gt;&gt; write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; which causes the real-time task to switch =
to secondary domain;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - the Makefile does not use xeno-config, w=
hich have been the<br>
&gt;&gt;&gt;&gt; recommended<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; way of getting the compiler flags since da=
y 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - it nullifies SIGTERM and SIGINT, which i=
s a dubious decision, and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; could lead people to believe that they sho=
uld do the same when using<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai, whereas there is no such requirem=
ent.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - the pointers point to outdated version o=
f the documentation.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - it uses runinfo/xeno-load, which are kin=
d of outdated too, make<br>
&gt;&gt;&gt;&gt; things<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; uselessly complicated, and in any case, te=
ll you to type Ctrl-C to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; interrupt the program, which is bound to f=
ail if anything goes<br>
&gt;&gt; wrong,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; since SIGINT is neutralized in the program=
.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s why I went to mmap().<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That is not really the right solution eith=
er. I admit that for<br>
&gt;&gt; driving<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; leds, it may be a bit overkill, but anyway=
, what you should do is<br>
&gt;&gt;&gt;&gt; write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; an RTDM driver for driving the leds. Keepi=
ng the driver separated<br>
&gt;&gt; from<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the application will allow the same progra=
m to run on other<br>
&gt;&gt; platforms<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; where driving the LEDS is done differently=
 without changing much of<br>
&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; application code. In other word, the appli=
cation/driver separation<br>
&gt;&gt; is<br>
&gt;&gt;&gt;&gt; a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sane one.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Anyway, mmap should work.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0(I chose that sample code because, for<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; now, I am only learning to use basic f=
unctions)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Wrong test here. Should be &quot;i=
f (aic_base =3D=3D MAP_FAILED)&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Indeed, my program fails miserably whe=
n I check the mapping of AIC,<br>
&gt;&gt;&gt;&gt; not<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; PIOB&#39;s. And yet, I just can&#39;t =
figure why in the non-Xenomai code,<br>
&gt;&gt; AIC<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; mmap-ing works =A0fine.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Well errno might give you a clue. Do you h=
ave FCSE enabled?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Gilles.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; FCSE is enabled. errno returns =A022 (invalid =
argument).<br>
&gt;&gt;&gt;&gt;&gt;&gt; best effort or guaranteed?<br>
&gt;&gt;&gt;&gt;&gt; Best effort<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Please activate FCSE messages.<br>
&gt;&gt;&gt;&gt;&gt; ... compiling new kernel<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; How big is<br>
&gt;&gt;&gt;&gt;&gt;&gt; MAP_SIZE?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; 4096<br>
&gt;&gt;&gt;&gt; Ok. Could you post your full kernel configuration, as well=
 as the full<br>
&gt;&gt;&gt;&gt; program?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; I put the .config and the code in the attachments.<br>
&gt;&gt;<br>
&gt;<br>
&gt;&gt; If you remove all the native skin stuff, only keep main and<br>
&gt;&gt; open_controller, do not link with the native library, you can conf=
irm<br>
&gt;&gt; that this same program runs without trouble?<br>
&gt;&gt;<br>
&gt;<br>
&gt; =A0Without =A0Xenomai related stuff, it runs =A0OK.<br>
<br>
</div></div>You sure of that? =A0The exact same code, with the same kernel,=
 with the<br>
mlockall?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>Oh. I assumed without mlockall (it wasn&#39;t=
 part of my original code). <br>Now, I placed mlockall in my original code =
(right before open_controller()) and the pin gets toggled according to my s=
cope.<br>
=A0<br><br>

--90e6ba6150dc644c4e049aa4b680--

