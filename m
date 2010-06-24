MIME-Version: 1.0
In-Reply-To: <4C234679.10209@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
	<4C1B8C04.3010900@domain.hid> <4C1BCCBF.7010400@domain.hid>
	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
	<1277330401.2453.145.camel@domain.hid>
	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
	<4C234679.10209@domain.hid>
Date: Thu, 24 Jun 2010 18:51:52 +0530
Message-ID: <AANLkTilPgVl1k1TUWBjwmT969SL5ga227so3x8VSqXtP@mail.gmail.com>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64dbd929fb9410489c68905
Subject: Re: [Xenomai-core] Fwd: problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e64dbd929fb9410489c68905
Content-Type: text/plain; charset=ISO-8859-1

Yes, the measurements are on no-load scenarios.
I will try to repeat my measurements with system-loads as you suggest.

Following is the cpu-info of my board:
----------------------------------------------------------
Processor       : ARM926EJ-S rev 5 (v5l)
BogoMIPS        : 131.48
Features        : swp half fastmult edsp java
CPU implementer : 0x41
CPU architecture: 5TEJ
CPU variant     : 0x0
CPU part        : 0x926
CPU revision    : 5
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format C
Cache format    : Harvard
I size          : 16384
I assoc         : 4
I line length   : 32
I sets          : 128
D size          : 16384
D assoc         : 4
D line length   : 32
D sets          : 128
----------------------------------------------------------

On Thu, Jun 24, 2010 at 5:20 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Nero Fernandez wrote:
> > Thanks for your response, Philippe.
> >
> > The concerns while the carrying out my experiments were to:
> >
> >  - compare xenomai co-kernel overheads (timer and context switch
> latencies)
> >    in xenomai-space vs similar native-linux overheads. These are
> > presented in
> >    the first two sheets.
>
> On what ARM system do you get these latency figures? I really doubt the
> linux kernel has a bounded latency under 35us. Because:
> - the preempt_rt people, which work on getting a bounded latency get
> something around 200us on AT91, an ARM9;
> - there would be no reason of the preempt_rt effort if the linux kernel
> interrupt latency was already bounded.
>
> So, I take it that you do your measurement without generating a load. We
> do our measurements using the latency test, while generating a load for
> several hours. And on the average ARM, we usually get an interrupt
> latency around 50us.
>
> Please add some load on the system, and do the measurments again. The
> best source of load we have found so far is to load the LTP testsuite
> while running the latency test.
>
> If you tell me what ARM SOC, or at least what ARM architecture revision
> you use (the ARM920T core is an armv4, and the ARM926EJS is an armv5, so
> ARM 9 does not tell us much), I can provide you with the root filesystem
> we use for our tests.
>
> --
>                                             Gilles.
>

--0016e64dbd929fb9410489c68905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Yes, the measurements are on no-load scenarios.<br>I will try to repeat=
 my measurements with system-loads as you suggest.<br><br>Following is the =
cpu-info of my board:<br><span style=3D"font-family: courier new,monospace;=
">----------------------------------------------------------</span><br>
<span style=3D"font-family: courier new,monospace;">Processor=A0=A0=A0=A0=
=A0=A0 : ARM926EJ-S rev 5 (v5l)</span><br style=3D"font-family: courier new=
,monospace;"><span style=3D"font-family: courier new,monospace;">BogoMIPS=
=A0=A0=A0=A0=A0=A0=A0 : 131.48</span><br style=3D"font-family: courier new,=
monospace;">
<span style=3D"font-family: courier new,monospace;">Features=A0=A0=A0=A0=A0=
=A0=A0 : swp half fastmult edsp java </span><br style=3D"font-family: couri=
er new,monospace;"><span style=3D"font-family: courier new,monospace;">CPU =
implementer : 0x41</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">CPU architecture: 5TEJ<=
/span><br style=3D"font-family: courier new,monospace;"><span style=3D"font=
-family: courier new,monospace;">CPU variant=A0=A0=A0=A0 : 0x0</span><br st=
yle=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">CPU part=A0=A0=A0=A0=A0=
=A0=A0 : 0x926</span><br style=3D"font-family: courier new,monospace;"><spa=
n style=3D"font-family: courier new,monospace;">CPU revision=A0=A0=A0 : 5</=
span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">Cache type=A0=A0=A0=A0=
=A0 : write-back</span><br style=3D"font-family: courier new,monospace;"><s=
pan style=3D"font-family: courier new,monospace;">Cache clean=A0=A0=A0=A0 :=
 cp15 c7 ops</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">Cache lockdown=A0 : for=
mat C</span><br style=3D"font-family: courier new,monospace;"><span style=
=3D"font-family: courier new,monospace;">Cache format=A0=A0=A0 : Harvard</s=
pan><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">I size=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 : 16384</span><br style=3D"font-family: courier new,monospace;=
"><span style=3D"font-family: courier new,monospace;">I assoc=A0=A0=A0=A0=
=A0=A0=A0=A0 : 4</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">I line length=A0=A0 : 3=
2</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fo=
nt-family: courier new,monospace;">I sets=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 128<=
/span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">D size=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 : 16384</span><br style=3D"font-family: courier new,monospace;=
"><span style=3D"font-family: courier new,monospace;">D assoc=A0=A0=A0=A0=
=A0=A0=A0=A0 : 4</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">D line length=A0=A0 : 3=
2</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fo=
nt-family: courier new,monospace;">D sets=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 128<=
/span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">-----------------------=
-----------------------------------</span><br><br><div class=3D"gmail_quote=
">On Thu, Jun 24, 2010 at 5:20 PM, Gilles Chanteperdrix <span dir=3D"ltr">&=
lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix=
@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>Nero Fernandez wrote:<br>
&gt; Thanks for your response, Philippe.<br>
&gt;<br>
&gt; The concerns while the carrying out my experiments were to:<br>
&gt;<br>
&gt; =A0- compare xenomai co-kernel overheads (timer and context switch lat=
encies)<br>
&gt; =A0 =A0in xenomai-space vs similar native-linux overheads. These are<b=
r>
&gt; presented in<br>
&gt; =A0 =A0the first two sheets.<br>
<br>
</div>On what ARM system do you get these latency figures? I really doubt t=
he<br>
linux kernel has a bounded latency under 35us. Because:<br>
- the preempt_rt people, which work on getting a bounded latency get<br>
something around 200us on AT91, an ARM9;<br>
- there would be no reason of the preempt_rt effort if the linux kernel<br>
interrupt latency was already bounded.<br>
<br>
So, I take it that you do your measurement without generating a load. We<br=
>
do our measurements using the latency test, while generating a load for<br>
several hours. And on the average ARM, we usually get an interrupt<br>
latency around 50us.<br>
<br>
Please add some load on the system, and do the measurments again. The<br>
best source of load we have found so far is to load the LTP testsuite<br>
while running the latency test.<br>
<br>
If you tell me what ARM SOC, or at least what ARM architecture revision<br>
you use (the ARM920T core is an armv4, and the ARM926EJS is an armv5, so<br=
>
ARM 9 does not tell us much), I can provide you with the root filesystem<br=
>
we use for our tests.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e64dbd929fb9410489c68905--

