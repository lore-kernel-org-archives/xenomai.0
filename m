MIME-Version: 1.0
In-Reply-To: <4D3E5BC2.6070700@domain.hid>
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
Date: Mon, 24 Jan 2011 23:32:25 -0600
Message-ID: <AANLkTikzrOHi8caNdYg_FOY4NdhjWsh5qZZGYvD1URJ2@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/mixed; boundary=0016367fadcf9c2fc7049aa50a50
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

--0016367fadcf9c2fc7049aa50a50
Content-Type: multipart/alternative; boundary=0016367fadcf9c2fc1049aa50a4e

--0016367fadcf9c2fc1049aa50a4e
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 24, 2011 at 11:12 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Mon, Jan 24, 2011 at 11:02 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> at91_enthus wrote:
> >>> On Mon, Jan 24, 2011 at 10:54 PM, Gilles Chanteperdrix <
> >>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>
> >>>> at91_enthus wrote:
> >>>>> On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix <
> >>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>
> >>>>>> at91_enthus wrote:
> >>>>>>> On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix <
> >>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>
> >>>>>>>> at91_enthus wrote:
> >>>>>>>>> On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix <
> >>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>
> >>>>>>>>>> at91_enthus wrote:
> >>>>>>>>>>> On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
> >>>>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> at91_enthus wrote:
> >>>>>>>>>>>>> Hi.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I  was testing Xenomai on my AT91SAM9G20-based board and
> tried
> >> to
> >>>>>>>> adapt
> >>>>>>>>>>>> the
> >>>>>>>>>>>>> code found here:
> >>>>>>>>>>>>>
> >>>> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs.
> >>>>>>>>>>>> By the way, this code is ridiculous. It creates a real-time
> task
> >>>> to
> >>>>>>>>>>>> write to some non real-time device, which makes the real-time
> >> task
> >>>>>>>>>> useless.
> >>>>>>>>>>> I know.
> >>>>>>>>>> Yes, but this example is bad in many ways:
> >>>>>>>>>> - first it uses xenomai api to create a real-time task, and uses
> >>>> write
> >>>>>>>>>> which causes the real-time task to switch to secondary domain;
> >>>>>>>>>> - the Makefile does not use xeno-config, which have been the
> >>>>>> recommended
> >>>>>>>>>> way of getting the compiler flags since day 1;
> >>>>>>>>>> - it nullifies SIGTERM and SIGINT, which is a dubious decision,
> >> and
> >>>>>>>>>> could lead people to believe that they should do the same when
> >> using
> >>>>>>>>>> Xenomai, whereas there is no such requirement.
> >>>>>>>>>> - the pointers point to outdated version of the documentation.
> >>>>>>>>>> - it uses runinfo/xeno-load, which are kind of outdated too,
> make
> >>>>>> things
> >>>>>>>>>> uselessly complicated, and in any case, tell you to type Ctrl-C
> to
> >>>>>>>>>> interrupt the program, which is bound to fail if anything goes
> >>>> wrong,
> >>>>>>>>>> since SIGINT is neutralized in the program.
> >>>>>>>>>>
> >>>>>>>>>>> That's why I went to mmap().
> >>>>>>>>>> That is not really the right solution either. I admit that for
> >>>> driving
> >>>>>>>>>> leds, it may be a bit overkill, but anyway, what you should do
> is
> >>>>>> write
> >>>>>>>>>> an RTDM driver for driving the leds. Keeping the driver
> separated
> >>>> from
> >>>>>>>>>> the application will allow the same program to run on other
> >>>> platforms
> >>>>>>>>>> where driving the LEDS is done differently without changing much
> >> of
> >>>>>> the
> >>>>>>>>>> application code. In other word, the application/driver
> separation
> >>>> is
> >>>>>> a
> >>>>>>>>>> sane one.
> >>>>>>>>>>
> >>>>>>>>>> Anyway, mmap should work.
> >>>>>>>>>>
> >>>>>>>>>>  (I chose that sample code because, for
> >>>>>>>>>>> now, I am only learning to use basic functions)
> >>>>>>>>>>>> Wrong test here. Should be "if (aic_base == MAP_FAILED)"
> >>>>>>>>>>> Indeed, my program fails miserably when I check the mapping of
> >> AIC,
> >>>>>> not
> >>>>>>>>>>> PIOB's. And yet, I just can't figure why in the non-Xenomai
> code,
> >>>> AIC
> >>>>>>>>>>> mmap-ing works  fine.
> >>>>>>>>>> Well errno might give you a clue. Do you have FCSE enabled?
> >>>>>>>>>>
> >>>>>>>>>> Regards.
> >>>>>>>>>>
> >>>>>>>>>> --
> >>>>>>>>>>
> >>>>>> Gilles.
> >>>>>>>>> FCSE is enabled. errno returns  22 (invalid argument).
> >>>>>>>> best effort or guaranteed?
> >>>>>>> Best effort
> >>>>>>>
> >>>>>>>
> >>>>>>>> Please activate FCSE messages.
> >>>>>>> ... compiling new kernel
> >>>>>>>
> >>>>>>>
> >>>>>>>> How big is
> >>>>>>>> MAP_SIZE?
> >>>>>>>>
> >>>>>>>>
> >>>>>>> 4096
> >>>>>> Ok. Could you post your full kernel configuration, as well as the
> full
> >>>>>> program?
> >>>>>>
> >>>>> I put the .config and the code in the attachments.
> >>>> If you remove all the native skin stuff, only keep main and
> >>>> open_controller, do not link with the native library, you can confirm
> >>>> that this same program runs without trouble?
> >>>>
> >>>  Without  Xenomai related stuff, it runs  OK.
> >> You sure of that?  The exact same code, with the same kernel, with the
> >> mlockall?
> >>
> >> --
> >>                                                                 Gilles.
> >>
> >
> > Oh. I assumed without mlockall (it wasn't part of my original code).
> > Now, I placed mlockall in my original code (right before
> open_controller())
> > and the pin gets toggled according to my scope.
>
> Ok. Show me the Makefile then.

And the code which works.


 see attachment


> Including the
> value of the defines please (not all of them, only those the program
> uses for open_controller).
>
>
>
#define AT91C_BASE_AIC          0xFFFFF000 // (AIC) Base Address
#define AT91C_BASE_PIOB        0xFFFFF600 // (PIOB) Base Address
#define PIO_PER             0x00000000 // (PIO_PER) PIO Enable Register
#define PIO_PDR             0x00000004 // (PIO_PDR) PIO Disable Register
#define PIO_PSR             0x00000008 // (PIO_PSR) PIO Status Register
#define PIO_OER             0x00000010 // (PIO_OER) Output Enable Register
#define PIO_SODR           0x00000030 // (PIO_SODR) Set Output Data Register
#define PIO_CODR           0x00000034 // (PIO_CODR) Clear Output Data
Register
#define PIO_PPUDR         0x00000060 // (PIO_PPUDR) Pull-up Disable Register
#define PIO_MDDR           0x00000054 // (PIO_MDDR) Multi-driver Disable
Register

--0016367fadcf9c2fc1049aa50a4e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 24, 2011 at 11:12 PM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">at91_enthus wrote:<br>
&gt; On Mon, Jan 24, 2011 at 11:02 PM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt; On Mon, Jan 24, 2011 at 10:54 PM, Gilles Chanteperdrix &lt;<br=
>
&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 10:28 PM, Gilles Chanteperdrix=
 &lt;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gi=
lles.chanteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chant=
eperdrix &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 9:25 PM, Gille=
s Chanteperdrix &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Mon, Jan 24, 2011 at 8:41 P=
M, Gilles Chanteperdrix &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chant=
eperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =A0was testing Xenom=
ai on my AT91SAM9G20-based board and tried<br>
&gt;&gt; to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; adapt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; code found here:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; <a href=3D"http://www.armadeus.com/wiki/index.php?title=3D=
Xenomai:Blinking_LEDs" target=3D"_blank">http://www.armadeus.com/wiki/index=
.php?title=3DXenomai:Blinking_LEDs</a>.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; By the way, this code is r=
idiculous. It creates a real-time task<br>
&gt;&gt;&gt;&gt; to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; write to some non real-tim=
e device, which makes the real-time<br>
&gt;&gt; task<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; useless.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I know.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Yes, but this example is bad in ma=
ny ways:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - first it uses xenomai api to cre=
ate a real-time task, and uses<br>
&gt;&gt;&gt;&gt; write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; which causes the real-time task to=
 switch to secondary domain;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - the Makefile does not use xeno-c=
onfig, which have been the<br>
&gt;&gt;&gt;&gt;&gt;&gt; recommended<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; way of getting the compiler flags =
since day 1;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - it nullifies SIGTERM and SIGINT,=
 which is a dubious decision,<br>
&gt;&gt; and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; could lead people to believe that =
they should do the same when<br>
&gt;&gt; using<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai, whereas there is no such =
requirement.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - the pointers point to outdated v=
ersion of the documentation.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - it uses runinfo/xeno-load, which=
 are kind of outdated too, make<br>
&gt;&gt;&gt;&gt;&gt;&gt; things<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; uselessly complicated, and in any =
case, tell you to type Ctrl-C to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; interrupt the program, which is bo=
und to fail if anything goes<br>
&gt;&gt;&gt;&gt; wrong,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; since SIGINT is neutralized in the=
 program.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s why I went to mmap(=
).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That is not really the right solut=
ion either. I admit that for<br>
&gt;&gt;&gt;&gt; driving<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; leds, it may be a bit overkill, bu=
t anyway, what you should do is<br>
&gt;&gt;&gt;&gt;&gt;&gt; write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; an RTDM driver for driving the led=
s. Keeping the driver separated<br>
&gt;&gt;&gt;&gt; from<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the application will allow the sam=
e program to run on other<br>
&gt;&gt;&gt;&gt; platforms<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; where driving the LEDS is done dif=
ferently without changing much<br>
&gt;&gt; of<br>
&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; application code. In other word, t=
he application/driver separation<br>
&gt;&gt;&gt;&gt; is<br>
&gt;&gt;&gt;&gt;&gt;&gt; a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sane one.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Anyway, mmap should work.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0(I chose that sample code becau=
se, for<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; now, I am only learning to use=
 basic functions)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Wrong test here. Should be=
 &quot;if (aic_base =3D=3D MAP_FAILED)&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Indeed, my program fails miser=
ably when I check the mapping of<br>
&gt;&gt; AIC,<br>
&gt;&gt;&gt;&gt;&gt;&gt; not<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; PIOB&#39;s. And yet, I just ca=
n&#39;t figure why in the non-Xenomai code,<br>
&gt;&gt;&gt;&gt; AIC<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; mmap-ing works =A0fine.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Well errno might give you a clue. =
Do you have FCSE enabled?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Gilles.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; FCSE is enabled. errno returns =A022 (=
invalid argument).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; best effort or guaranteed?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Best effort<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Please activate FCSE messages.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ... compiling new kernel<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; How big is<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; MAP_SIZE?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4096<br>
&gt;&gt;&gt;&gt;&gt;&gt; Ok. Could you post your full kernel configuration,=
 as well as the full<br>
&gt;&gt;&gt;&gt;&gt;&gt; program?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I put the .config and the code in the attachments.<br>
&gt;&gt;&gt;&gt; If you remove all the native skin stuff, only keep main an=
d<br>
&gt;&gt;&gt;&gt; open_controller, do not link with the native library, you =
can confirm<br>
&gt;&gt;&gt;&gt; that this same program runs without trouble?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; =A0Without =A0Xenomai related stuff, it runs =A0OK.<br>
&gt;&gt; You sure of that? =A0The exact same code, with the same kernel, wi=
th the<br>
&gt;&gt; mlockall?<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Oh. I assumed without mlockall (it wasn&#39;t part of my original code=
).<br>
&gt; Now, I placed mlockall in my original code (right before open_controll=
er())<br>
&gt; and the pin gets toggled according to my scope.<br>
<br>
</div></div>Ok. Show me the Makefile then.=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">And the code which works. </blockq=
uote>
<div><br>=A0see attachment<br>=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">Including the<br>
value of the defines please (not all of them, only those the program<br>
uses for open_controller).<br>
<br>
<br></blockquote><div><br>#define AT91C_BASE_AIC=A0=A0=A0=A0 =A0 =A0=A0 0xF=
FFFF000 // (AIC) Base Address<br>#define AT91C_BASE_PIOB=A0=A0=A0=A0 =A0=A0=
 0xFFFFF600 // (PIOB) Base Address<br>#define PIO_PER=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x00000000 // (PIO_PER) PIO Enable Register<br>
#define PIO_PDR=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 0x00000004 // (PIO_PDR) P=
IO Disable Register<br>#define PIO_PSR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
0x00000008 // (PIO_PSR) PIO Status Register<br>#define PIO_OER=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0x00000010 // (PIO_OER) Output Enable Register<br>
#define PIO_SODR=A0=A0=A0=A0=A0=A0 =A0=A0=A0 0x00000030 // (PIO_SODR) Set O=
utput Data Register<br>#define PIO_CODR=A0=A0=A0=A0=A0=A0 =A0=A0=A0 0x00000=
034 // (PIO_CODR) Clear Output Data Register<br>#define PIO_PPUDR=A0=A0=A0=
=A0 =A0=A0=A0 0x00000060 // (PIO_PPUDR) Pull-up Disable Register<br>
#define PIO_MDDR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00000054 // (PIO_MDDR) Mul=
ti-driver Disable Register<br><br><br></div></div>

--0016367fadcf9c2fc1049aa50a4e--

--0016367fadcf9c2fc7049aa50a50
Content-Type: text/x-csrc; charset=US-ASCII; name="gpiob_bit0.c"
Content-Disposition: attachment; filename="gpiob_bit0.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjcd8dse0

LyogdXNlci1sYW5kIGRyaXZlciBmb3IgUElPQiAoYml0IDAgLSBKMikgCkJvYXJkOiBFbGVjdHJ1
bTEwMCAtIE1pY3JvbWludCwgQVQ5MVNBTTlHMjAKKi8KCiNpbmNsdWRlIDxzdGRpby5oPgojaW5j
bHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoj
aW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8ZmNudGwuaD4K
I2luY2x1ZGUgPGN0eXBlLmg+CiNpbmNsdWRlIDx0ZXJtaW9zLmg+CiNpbmNsdWRlIDxzeXMvdHlw
ZXMuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CgojaW5jbHVkZSAiZGVmaW5pdGlvbnMuaCIKCgoj
ZGVmaW5lIE1BUF9TSVpFIDQwOTZVTCAvLzRrCiNkZWZpbmUgTUFQX01BU0sgKE1BUF9TSVpFIC0g
MSkKCgppbnQgZmQsIGk7CnVuc2lnbmVkIGNoYXIgKnBpb2JfYmFzZSwgKmFpY19iYXNlOyAKCgoK
dm9pZCBvcGVuX2NvbnRyb2xsZXIoKXsKCgogICAgaWYoKGZkID0gb3BlbigiL2Rldi9tZW0iLCBP
X1JEV1IgfCBPX1NZTkMpKSA9PSAtMSkgCiAgICB7CiAgICAJcHJpbnRmKCJDb3VsZG4ndCBvcGVu
IC9kZXYvbWVtLiBlcnJvciAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKCWV4aXQoMSk7CiAgICB9
CiAgICBwcmludGYoIi9kZXYvbWVtIG9wZW5lZC5cbiIpOyAKICAgIGZmbHVzaChzdGRvdXQpOwog
ICAgCiAgICAvKiBtYXBwaW5nIG9mIFBJT0IgKi8KCWFpY19iYXNlID0gIG1tYXAoMCwgTUFQX1NJ
WkUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsIGZkLCBBVDkxQ19CQVNFX1BJ
T0IgJiB+TUFQX01BU0spOwoJcGlvYl9iYXNlID0gYWljX2Jhc2UgKyBBVDkxQ19CQVNFX1BJT0Ig
LSBBVDkxQ19CQVNFX0FJQzsKCQoKICAgIGlmKCAoYWljX2Jhc2UgPT0gTUFQX0ZBSUxFRCkpIHsK
CiAgICAJcHJpbnRmKCJDb3VsZG4ndCBnZXQgTWFwLUFkZHJlc3MuICVkXG4iLCBlcnJubyk7CQkK
CWV4aXQoMSk7CgoJfQoKCiAgICBmZmx1c2goc3Rkb3V0KTsKCn0KCmludCBtYWluKCkgewoKCiBt
bG9ja2FsbChNQ0xfQ1VSUkVOVHxNQ0xfRlVUVVJFKTsKIG9wZW5fY29udHJvbGxlcigpOwogICAK
KigodW5zaWduZWQgaW50ICopIChwaW9iX2Jhc2UgKyBQSU9fSURSKSkgPSAxPDwwOwoqKCh1bnNp
Z25lZCBpbnQgKikgKHBpb2JfYmFzZSArIFBJT19QRVIpKSA9IDE8PDA7CiooKHVuc2lnbmVkIGlu
dCAqKSAocGlvYl9iYXNlICsgUElPX0NPRFIpKSA9MTw8MDsKKigodW5zaWduZWQgaW50ICopIChw
aW9iX2Jhc2UgKyBQSU9fUFBVRFIpKSA9MTw8MDsKCiooKHVuc2lnbmVkIGludCAqKSAocGlvYl9i
YXNlICsgUElPX09FUikpID0gMTw8MDsKKigodW5zaWduZWQgaW50ICopIChwaW9iX2Jhc2UgKyBQ
SU9fTUREUikpID0gMTw8MDsKCgp3aGlsZSgxKXsKCiAqKCh1bnNpZ25lZCBpbnQgKikgKHBpb2Jf
YmFzZSArIFBJT19TT0RSKSkgPSAxPDwwOwoKICooKHVuc2lnbmVkIGludCAqKSAocGlvYl9iYXNl
ICsgUElPX0NPRFIpKSA9IDE8PDA7Cgp9CgogICAgY2xvc2UoZmQpOwogICAgcmV0dXJuIDA7Cn0K
Cg==
--0016367fadcf9c2fc7049aa50a50
Content-Type: application/octet-stream; name=Makefile
Content-Disposition: attachment; filename=Makefile
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjcd9xxo1

REVTVF9ESVI9Li8KaW5jbHVkZSAKWEVOTz0vdXNyL3hlbm9tYWkKRVhFQz14ZW4KIApTUkM9ICQo
d2lsZGNhcmQgKi5jKQpPQko9ICQoU1JDOi5jPS5vKQpDRkxBR1M9LWcgLVcgLVdhbGwgLUkkKFhF
Tk8pL2luY2x1ZGUgLUkkKFhFTk8pL2luY2x1ZGUvbmF0aXZlICAtSSQoWEVOTykvaW5jbHVkZS9y
dGRtICAgLURfR05VX1NPVVJDRSAtRF9SRUVOVFJBTlQKTERGTEFHUz0tTCQoWEVOTykvbGliIC1Y
bGlua2VyIC1ycGF0aCAkKFhFTk8pL2xpYiAtWGxpbmtlciAkKFhFTk8pL2xpYi9saWJuYXRpdmUu
YSAgICQoWEVOTykvbGliL2xpYnJ0ZG0uYSAtbHB0aHJlYWQgLWxuYXRpdmUgLWxydGRtIC1seGVu
b21haQogCiQoRVhFQyk6ICQoT0JKKQoJJChDQykgLW8gJEAgJF4gJChMREZMQUdTKQogCiQoT0JK
KTogJChTUkMpCgkkKENDKSAkKENGTEFHUykgLW8gJEAgLWMgJDwKIAphbGw6ICQoRVhFQykKIApj
bGVhbjoKCXJtIC1yZiAkKE9CSikKCXJtIC1yZiAkKEVYRUMpCglybSAtZiAqLmN+ICouaH4gTWFr
ZWZpbGV+CiAKaW5zdGFsbDogJChFWEVDKQoJQG1rZGlyIC1wICQoREVTVF9ESVIpLyQoRVhFQykK
CWVjaG8gIiQoRVhFQyk6bmF0aXZlOiEuLyQoRVhFQyk7cG9wYWxsOmNvbnRyb2xfYyIgPiAkKERF
U1RfRElSKS8kKEVYRUMpLy5ydW5pbmZvCgljcCAtZiAkKEVYRUMpICQoREVTVF9ESVIpLyQoRVhF
QykKIAptcnByb3BlcjogY2xlYW4KCXJtIC1yZiAkKERFU1RfRElSKS8kKEVYRUMpCiAKLlBIT05Z
OiBhbGwgaW5zdGFsbCBjbGVhbiBtcnByb3Blcgo=
--0016367fadcf9c2fc7049aa50a50--

