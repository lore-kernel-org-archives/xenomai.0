MIME-Version: 1.0
In-Reply-To: <4A9BE7CF.3030406@domain.hid>
References: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>
	<4A981B54.4020908@domain.hid> <4A981C1E.8000904@domain.hid>
	<7a15153d0908281209i5b133c53l4fa816993df7d0eb@domain.hid>
	<4A982D08.4050802@domain.hid>
	<7a15153d0908310753s68f36dffg817df3cb9a16db06@domain.hid>
	<4A9BE7CF.3030406@domain.hid>
Date: Mon, 31 Aug 2009 15:36:30 -0300
Message-ID: <7a15153d0908311136g2a1619d5mc5ec803244da6553@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=000feaf26f7d00ff42047274505d
Subject: Re: [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--000feaf26f7d00ff42047274505d
Content-Type: text/plain; charset=ISO-8859-1

Ok i got ,

When i tried to run latency with 3 ms, it works but i received the message
[149.437671] Xenomai: Switching display-321 to secondary modo after
exception #5 from user-spcae at 0x9588 (pid 232)

So , if i put my test software posted in the last message, to run with 3ms
period task, the software freeze.
I can run this software only with 10ms period time, what i'm doing wrong ?

On Mon, Aug 31, 2009 at 12:10 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Felipe Castro wrote:
> > hi !
> >
> > I apllied the patch that you sent me, but there are some weird!
> > When i run latency program the result is:
> >
> > root@domain.hid$ /usr/xenomai/bin/latency
> > == Sampling period: 100 us
> > == Test mode: periodic user-mode task
> > == All results in microseconds
> > warming up...
> > RTT|  00:00:02  (periodic user-mode task, 100 us period, priority 99)
> > RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> > worst
> > RTD|      83.384|     146.769|     189.538|    1803|      83.384|
> > 189.538
>
> 100us is to short a period for an ARM without FCSE enabled. Actually it
> is also too short for an ARM with FCSE. Look at the latency: you are
> asking a 100us period whereas the latency is 150us on average, don't you
> see the problem?
>
> You can try a period of 1ms, it is more reasonable. If you want periods
> of 70us, you can not use an ARM.
>
> >
> >
> > And than the program just freeze, and the kernel trace:
> >
> > [  780.136217] Xenomai: Switching display-343 to secondary mode after
> > exception #5 from user-space at 0x93e0 (pid 345)
>
> That is another problem which should be fixed in the next Xenomai
> release, which should happen real soon now.
>
> --
>                                           Gilles
>
>

--000feaf26f7d00ff42047274505d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok i got , <br><br>When i tried to run latency with 3 ms, it works but i re=
ceived the message<br>[149.437671] Xenomai: Switching display-321 to second=
ary modo after exception #5 from user-spcae at 0x9588 (pid 232)<br><br>So ,=
 if i put my test software posted in the last message, to run with 3ms peri=
od task, the software freeze. <br>

I can run this software only with 10ms period time, what i&#39;m doing wron=
g ?<br><br><div class=3D"gmail_quote">On Mon, Aug 31, 2009 at 12:10 PM, Gil=
les Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Felipe Castro wrote:<br>
&gt; hi !<br>
&gt;<br>
&gt; I apllied the patch that you sent me, but there are some weird!<br>
&gt; When i run latency program the result is:<br>
&gt;<br>
&gt; root@domain.hid$ /usr/xenomai/bin/latency<br>
&gt; =3D=3D Sampling period: 100 us<br>
&gt; =3D=3D Test mode: periodic user-mode task<br>
&gt; =3D=3D All results in microseconds<br>
&gt; warming up...<br>
&gt; RTT| =A000:00:02 =A0(periodic user-mode task, 100 us period, priority =
99)<br>
&gt; RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---la=
t<br>
&gt; worst<br>
&gt; RTD| =A0 =A0 =A083.384| =A0 =A0 146.769| =A0 =A0 189.538| =A0 =A01803|=
 =A0 =A0 =A083.384|<br>
&gt; 189.538<br>
<br>
</div>100us is to short a period for an ARM without FCSE enabled. Actually =
it<br>
is also too short for an ARM with FCSE. Look at the latency: you are<br>
asking a 100us period whereas the latency is 150us on average, don&#39;t yo=
u<br>
see the problem?<br>
<br>
You can try a period of 1ms, it is more reasonable. If you want periods<br>
of 70us, you can not use an ARM.<br>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; And than the program just freeze, and the kernel trace:<br>
&gt;<br>
&gt; [ =A0780.136217] Xenomai: Switching display-343 to secondary mode afte=
r<br>
&gt; exception #5 from user-space at 0x93e0 (pid 345)<br>
<br>
</div>That is another problem which should be fixed in the next Xenomai<br>
release, which should happen real soon now.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
<br>
</font></blockquote></div><br>

--000feaf26f7d00ff42047274505d--

