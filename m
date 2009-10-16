MIME-Version: 1.0
In-Reply-To: <200910170031.06247.berlemont.hauw@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<72cf3fb0910161406g313db0ffm61c6bd09a65e025c@domain.hid>
	<96eea0c80910161506v6292310et2d5fdf617355d97e@domain.hid>
	<200910170031.06247.berlemont.hauw@domain.hid>
Date: Fri, 16 Oct 2009 16:48:47 -0700
Message-ID: <96eea0c80910161648l1991b124w20ea9949e70f5ae0@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016e645b8ca84fb6604761609be
Subject: Re: [Xenomai-help] national instruments card and comedi-rtdm-dev
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

--0016e645b8ca84fb6604761609be
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey Alexis,

>> That's because you did not retrieve the "comedi" branch, you are working
the
>> master branch which is left unused.
>> You should create a branch on your local repository with the remote
comedi
>> branch as reference.
Sorry... I managed to do it :) (I am new to git) However, I could not
compile the kernel :(

drivers/xenomai/comedi/intel/8255.c:50:47: error: macro
"subdev_8255_interrupt" requires 2 arguments, but only 1 given
drivers/xenomai/comedi/intel/8255.c:51: error: expected =91=3D=92, =91,=92,=
 =91;=92, =91asm=92
or =91__attribute__=92 before =91{=92 token
drivers/xenomai/comedi/intel/8255.c: In function =91do_config=92:
drivers/xenomai/comedi/intel/8255.c:85: error: =91CR_CW=92 undeclared (firs=
t use
in this function)
drivers/xenomai/comedi/intel/8255.c:85: error: (Each undeclared identifier
is reported only once
drivers/xenomai/comedi/intel/8255.c:85: error: for each function it appears
in.)
drivers/xenomai/comedi/intel/8255.c:88: error: =91CR_A_IO=92 undeclared (fi=
rst
use in this function)
drivers/xenomai/comedi/intel/8255.c:90: error: =91CR_B_IO=92 undeclared (fi=
rst
use in this function)
drivers/xenomai/comedi/intel/8255.c:92: error: =91CR_C_LO_IO=92 undeclared
(first use in this function)
drivers/xenomai/comedi/intel/8255.c:94: error: =91CR_C_HI_IO=92 undeclared
(first use in this function)
drivers/xenomai/comedi/intel/8255.c:95: error: =91_8255_CR=92 undeclared (f=
irst
use in this function)
drivers/xenomai/comedi/intel/8255.c: In function =91subd_8255_insn_bits=92:
drivers/xenomai/comedi/intel/8255.c:146: error: =91_8255_DATA=92 undeclared
(first use in this function)
drivers/xenomai/comedi/intel/8255.c:204:42: error: macro "subdev_8255_init"
requires 2 arguments, but only 1 given
drivers/xenomai/comedi/intel/8255.c: At top level:
drivers/xenomai/comedi/intel/8255.c:205: error: expected =91=3D=92, =91,=92=
, =91;=92,
=91asm=92 or =91__attribute__=92 before =91{=92 token
drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_attach=92:
drivers/xenomai/comedi/intel/8255.c:274: error: =91_8255_SIZE=92 undeclared
(first use in this function)
drivers/xenomai/comedi/intel/8255.c:282:25: error: macro "subdev_8255_init"
requires 2 arguments, but only 1 given
drivers/xenomai/comedi/intel/8255.c:282: error: =91subdev_8255_init=92
undeclared (first use in this function)
drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_detach=92:
drivers/xenomai/comedi/intel/8255.c:306: error: =91_8255_SIZE=92 undeclared
(first use in this function)
make[4]: *** [drivers/xenomai/comedi/intel/8255.o] Error 1
make[3]: *** [drivers/xenomai/comedi/intel] Error 2
make[2]: *** [drivers/xenomai/comedi] Error 2
make[1]: *** [drivers/xenomai] Error 2
make: *** [drivers] Error 2

When I reconfigure the kernel to not compile 8255 and friends it does not
compile either...

... snip ...
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Root device is (8, 1)
Setup is 11692 bytes (padded to 11776 bytes).
System is 2347 kB
CRC 84c0200
Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "comedi_alloc_subd" [drivers/xenomai/comedi/testing/comedi_loop.ko]
undefined!
ERROR: "comedi_alloc_subd" [drivers/xenomai/comedi/testing/comedi_fake.ko]
undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

I tried 2.6.31 and 2.6.30.5.

I really appreciate your help !

Thanks,
 peter

On Fri, Oct 16, 2009 at 3:31 PM, Alexis Berlemont <berlemont.hauw@domain.hid>w=
rote:

> On Saturday 17 October 2009 00:06:21 Peter Pastor wrote:
> > Hey Alexis,
> >
> > Thanks for your response !!
> >
> > >> Yes take the abe repository, please. I will make a pull request soon=
.
> >
> > I downloaded the git xenomai-abe repository and installed linux-2.6.29.=
1
> > (since there was no patch for 2.6.30.5).
> >
>
> That's because you did not retrieve the "comedi" branch, you are working
> the
> master branch which is left unused.
>
> You should create a branch on your local repository with the remote comed=
i
> branch as reference.
>
> > The installation worked out, however, it seems that the comedi_pcimio
> >  driver is not included.
> > Am I missing something during configuring the kernel ??
> >
> > From what I understand now is that I need xeno_comedi.ko which is the
> > interface to xenomai and RTDM and I need comedi_pcimio.ko which actuall=
y
> > talks to the hardware and does real-time capable I/O. Is this correct ?=
?
> >
> > Thanks a lot, I am really glad that I am getting somewhere !!
> >
> >  peter
> >
>
> Alexis.
>

--0016e645b8ca84fb6604761609be
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey Alexis,<br><br>&gt;&gt; That&#39;s because you did not retrieve the &qu=
ot;comedi&quot; branch, you are working the<br>&gt;&gt; master branch which=
 is left unused.<br>
&gt;&gt; You should create a branch on your local repository with the remot=
e comedi<br>
&gt;&gt; branch as reference.<br>
Sorry... I managed to do it :) (I am new to git) However, I could not compi=
le the kernel :(<br><br>drivers/xenomai/comedi/intel/8255.c:50:47: error: m=
acro &quot;subdev_8255_interrupt&quot; requires 2 arguments, but only 1 giv=
en<br>
drivers/xenomai/comedi/intel/8255.c:51: error: expected =91=3D=92, =91,=92,=
 =91;=92, =91asm=92 or =91__attribute__=92 before =91{=92 token<br>drivers/=
xenomai/comedi/intel/8255.c: In function =91do_config=92:<br>drivers/xenoma=
i/comedi/intel/8255.c:85: error: =91CR_CW=92 undeclared (first use in this =
function)<br>
drivers/xenomai/comedi/intel/8255.c:85: error: (Each undeclared identifier =
is reported only once<br>drivers/xenomai/comedi/intel/8255.c:85: error: for=
 each function it appears in.)<br>drivers/xenomai/comedi/intel/8255.c:88: e=
rror: =91CR_A_IO=92 undeclared (first use in this function)<br>
drivers/xenomai/comedi/intel/8255.c:90: error: =91CR_B_IO=92 undeclared (fi=
rst use in this function)<br>drivers/xenomai/comedi/intel/8255.c:92: error:=
 =91CR_C_LO_IO=92 undeclared (first use in this function)<br>drivers/xenoma=
i/comedi/intel/8255.c:94: error: =91CR_C_HI_IO=92 undeclared (first use in =
this function)<br>
drivers/xenomai/comedi/intel/8255.c:95: error: =91_8255_CR=92 undeclared (f=
irst use in this function)<br>drivers/xenomai/comedi/intel/8255.c: In funct=
ion =91subd_8255_insn_bits=92:<br>drivers/xenomai/comedi/intel/8255.c:146: =
error: =91_8255_DATA=92 undeclared (first use in this function)<br>
drivers/xenomai/comedi/intel/8255.c:204:42: error: macro &quot;subdev_8255_=
init&quot; requires 2 arguments, but only 1 given<br>drivers/xenomai/comedi=
/intel/8255.c: At top level:<br>drivers/xenomai/comedi/intel/8255.c:205: er=
ror: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or =91__attribute__=92=
 before =91{=92 token<br>
drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_attach=92:<br>=
drivers/xenomai/comedi/intel/8255.c:274: error: =91_8255_SIZE=92 undeclared=
 (first use in this function)<br>drivers/xenomai/comedi/intel/8255.c:282:25=
: error: macro &quot;subdev_8255_init&quot; requires 2 arguments, but only =
1 given<br>
drivers/xenomai/comedi/intel/8255.c:282: error: =91subdev_8255_init=92 unde=
clared (first use in this function)<br>drivers/xenomai/comedi/intel/8255.c:=
 In function =91dev_8255_detach=92:<br>drivers/xenomai/comedi/intel/8255.c:=
306: error: =91_8255_SIZE=92 undeclared (first use in this function)<br>
make[4]: *** [drivers/xenomai/comedi/intel/8255.o] Error 1<br>make[3]: *** =
[drivers/xenomai/comedi/intel] Error 2<br>make[2]: *** [drivers/xenomai/com=
edi] Error 2<br>make[1]: *** [drivers/xenomai] Error 2<br>make: *** [driver=
s] Error 2<br>
<br>When I reconfigure the kernel to not compile 8255 and friends it does n=
ot compile either...<br><br>... snip ...<br>=A0 AS=A0=A0=A0=A0=A0 arch/x86/=
boot/header.o<br>=A0 LD=A0=A0=A0=A0=A0 arch/x86/boot/setup.elf<br>=A0 OBJCO=
PY arch/x86/boot/setup.bin<br>
=A0 BUILD=A0=A0 arch/x86/boot/bzImage<br>Root device is (8, 1)<br>Setup is =
11692 bytes (padded to 11776 bytes).<br>System is 2347 kB<br>CRC 84c0200<br=
>Kernel: arch/x86/boot/bzImage is ready=A0 (#1)<br>ERROR: &quot;comedi_allo=
c_subd&quot; [drivers/xenomai/comedi/testing/comedi_loop.ko] undefined!<br>
ERROR: &quot;comedi_alloc_subd&quot; [drivers/xenomai/comedi/testing/comedi=
_fake.ko] undefined!<br>make[1]: *** [__modpost] Error 1<br>make: *** [modu=
les] Error 2<br><br>I tried 2.6.31 and 2.6.30.5.<br><br>I really appreciate=
 your help !<br>
<br>Thanks,<br>=A0peter<br><br><div class=3D"gmail_quote">On Fri, Oct 16, 2=
009 at 3:31 PM, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:be=
rlemont.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Saturday 17 October 2009 00:06:21 Peter Pastor wrote:<=
br>
&gt; Hey Alexis,<br>
&gt;<br>
&gt; Thanks for your response !!<br>
&gt;<br>
&gt; &gt;&gt; Yes take the abe repository, please. I will make a pull reque=
st soon.<br>
&gt;<br>
&gt; I downloaded the git xenomai-abe repository and installed linux-2.6.29=
.1<br>
&gt; (since there was no patch for 2.6.30.5).<br>
&gt;<br>
<br>
</div>That&#39;s because you did not retrieve the &quot;comedi&quot; branch=
, you are working the<br>
master branch which is left unused.<br>
<br>
You should create a branch on your local repository with the remote comedi<=
br>
branch as reference.<br>
<div><div></div><div class=3D"h5"><br>
&gt; The installation worked out, however, it seems that the comedi_pcimio<=
br>
&gt; =A0driver is not included.<br>
&gt; Am I missing something during configuring the kernel ??<br>
&gt;<br>
&gt; From what I understand now is that I need xeno_comedi.ko which is the<=
br>
&gt; interface to xenomai and RTDM and I need comedi_pcimio.ko which actual=
ly<br>
&gt; talks to the hardware and does real-time capable I/O. Is this correct =
??<br>
&gt;<br>
&gt; Thanks a lot, I am really glad that I am getting somewhere !!<br>
&gt;<br>
&gt; =A0peter<br>
&gt;<br>
<br>
</div></div><font color=3D"#888888">Alexis.<br>
</font></blockquote></div><br>

--0016e645b8ca84fb6604761609be--

