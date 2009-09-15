MIME-Version: 1.0
In-Reply-To: <1253020726.2676.103.camel@domain.hid>
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
	<4AA6BC5D.8020704@domain.hid>
	<7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>
	<4AA7C4F7.6000903@domain.hid>
	<7a15153d0909091206y5d16ffcck32d0c8cc3c120f6c@domain.hid>
	<4AA820D4.8000302@domain.hid>
	<7a15153d0909101028p11716996q7929815b6b65ccb0@domain.hid>
	<4AA93B24.8010802@domain.hid>
	<7a15153d0909150549x13fada73r35a310227ae27b62@domain.hid>
	<1253020726.2676.103.camel@domain.hid>
Date: Tue, 15 Sep 2009 11:52:57 -0300
Message-ID: <7a15153d0909150752x14ba8810j9856b02c1bc68a2@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d645141be7ea04739ef0b6
Subject: Re: [Xenomai-help] High Latency on PXA
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

--0016e6d645141be7ea04739ef0b6
Content-Type: text/plain; charset=ISO-8859-1

So, i applied the patch sent by gilles that Henri told and it works .....
At afternoon I'll do more tests , but for now i'm happy with the results
.......

by the way thanks for attention !!!

here the latency test running

root@domain.hid$ ./latency -p 3000
== Sampling period: 3000 us
== Test mode: periodic user-mode task
== All results in microseconds
[   69.267317] Xenomai: registered exported object dispsem-309 (semaphores)
warming up...
RTT|  00:00:01  (periodic user-mode task, 3000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      40.923|      47.692|     127.384|       0|      40.923|
127.384
RTD|      40.923|      47.384|     116.307|       0|      40.923|
127.384
RTD|      40.923|      47.999|     137.230|       0|      40.923|
137.230
RTD|      40.923|      46.769|     123.692|       0|      40.923|
137.230
RTD|      40.923|      47.999|     139.076|       0|      40.923|
139.076
RTD|      40.923|      47.076|     127.692|       0|      40.923|
139.076
RTD|      40.923|      47.384|     122.769|       0|      40.923|
139.076

Felipe

On Tue, Sep 15, 2009 at 10:18 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Tue, 2009-09-15 at 09:49 -0300, Felipe Castro wrote:
> > Hi,
> >
> > I guess I compiled all with msoft-float OK , i disabled the float
> > point emulation in the kernel , did a new filesystem with busybox
> > compiled with soft float and compiled the xenomai user space to but
> > running the latency program i still having a problem.
> >
> > During the boot everything seems to be ok ....
> >
> > Attached follow a log file, with the kernel load , and ipipe trace.
> > what i supposed to do to get it running ok ?
> >
>
> As Gilles pointed out already, you are supposed to use a pipeline patch
> which does not exhibit the issue reported by Xenomai, which raises the
> debug assertion reported in the log.
>
> This patch only exists starting from 2.6.28, since the fix was not
> backported to earlier kernel releases. Since you want to stick with a
> non-mainline kernel, you will have to backport the fix yourself, and see
> how it goes.
>
>
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=912dcfb63c3315d8a20b8d467f72e443dad3852b
>
>
> > As you asked me , I'm running version 2.4.9.1 of xenomai .
> >
> > On Thu, Sep 10, 2009 at 2:45 PM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> >         Felipe Castro wrote:
> >         > I'm a little bit lost about this issues cause when running
> >         the xenomai
> >         > 2.4.8 with the patch that you send me it worked, but with
> >         new version it
> >         > doesn't work.
> >         > Acctually i using the kernel 2.6.27 and i understand what
> >         you told me ,
> >         > in version 2.4.9.1 there aren't a patch to this kernel
> >         version, neither
> >         > xenomai 2.4.8.  :S
> >
> >
> >         2.4.8 appeared to work, but it had a bug.
> >         See
> >         https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
> >
> >         >
> >         > The problem is, I'm using a Voipac development kit, and the
> >         have only
> >         > the kernel 2.6.27 BSP.
> >         >
> >         > So , i tried to disable the float point emulation but the
> >         kernel didn't
> >         > load OK .
> >
> >
> >         It proves that your user-space support is compiled for
> >         hardware float,
> >         but not PXA hardware floats. This is a pure waste of CPU
> >         power. See:
> >
> >         http://www.arm.linux.org.uk/mailinglists/faq.php#f3
> >
> >         Note that Xenomai applications compiled that way will not work
> >         either.
> >
> >         --
> >                                                  Gilles
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>

--0016e6d645141be7ea04739ef0b6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So, i applied the patch sent by gilles that Henri told and it works ..... <=
br>At afternoon I&#39;ll do more tests , but for now i&#39;m happy with the=
 results ....... <br><br>by the way thanks for attention !!!<br><br>here th=
e latency test running<br>
<br>root@domain.hid$ ./latency -p 3000<br>=3D=3D Sampling per=
iod: 3000 us<br>=3D=3D Test mode: periodic user-mode task<br>=3D=3D All res=
ults in microseconds<br>[=A0=A0 69.267317] Xenomai: registered exported obj=
ect dispsem-309 (semaphores)<br>
warming up...<br>RTT|=A0 00:00:01=A0 (periodic user-mode task, 3000 us peri=
od, priority 99)<br>RTH|-----lat min|-----lat avg|-----lat max|-overrun|---=
-lat best|---lat worst<br>RTD|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0=A0 47.692=
|=A0=A0=A0=A0 127.384|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=
=A0 127.384<br>
RTD|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0=A0 47.384|=A0=A0=A0=A0 116.307|=A0=
=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0 127.384<br>RTD|=A0=A0=
=A0=A0=A0 40.923|=A0=A0=A0=A0=A0 47.999|=A0=A0=A0=A0 137.230|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0 137.230<br>RTD|=A0=A0=A0=A0=A0=
 40.923|=A0=A0=A0=A0=A0 46.769|=A0=A0=A0=A0 123.692|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0 137.230<br>
RTD|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0=A0 47.999|=A0=A0=A0=A0 139.076|=A0=
=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0 139.076<br>RTD|=A0=A0=
=A0=A0=A0 40.923|=A0=A0=A0=A0=A0 47.076|=A0=A0=A0=A0 127.692|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0 139.076<br>RTD|=A0=A0=A0=A0=A0=
 40.923|=A0=A0=A0=A0=A0 47.384|=A0=A0=A0=A0 122.769|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 40.923|=A0=A0=A0=A0 139.076<br>
<br>Felipe<br><br><div class=3D"gmail_quote">On Tue, Sep 15, 2009 at 10:18 =
AM, Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org"=
>rpm@xenomai.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
<div class=3D"im">On Tue, 2009-09-15 at 09:49 -0300, Felipe Castro wrote:<b=
r>
&gt; Hi,<br>
&gt;<br>
&gt; I guess I compiled all with msoft-float OK , i disabled the float<br>
&gt; point emulation in the kernel , did a new filesystem with busybox<br>
&gt; compiled with soft float and compiled the xenomai user space to but<br=
>
&gt; running the latency program i still having a problem.<br>
&gt;<br>
&gt; During the boot everything seems to be ok ....<br>
&gt;<br>
&gt; Attached follow a log file, with the kernel load , and ipipe trace.<br=
>
&gt; what i supposed to do to get it running ok ?<br>
&gt;<br>
<br>
</div>As Gilles pointed out already, you are supposed to use a pipeline pat=
ch<br>
which does not exhibit the issue reported by Xenomai, which raises the<br>
debug assertion reported in the log.<br>
<br>
This patch only exists starting from 2.6.28, since the fix was not<br>
backported to earlier kernel releases. Since you want to stick with a<br>
non-mainline kernel, you will have to backport the fix yourself, and see<br=
>
how it goes.<br>
<br>
<a href=3D"http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3D912dcfb63c3=
315d8a20b8d467f72e443dad3852b" target=3D"_blank">http://git.denx.de/?p=3Dip=
ipe-2.6.git;a=3Dcommit;h=3D912dcfb63c3315d8a20b8d467f72e443dad3852b</a><br>
<div><div></div><div class=3D"h5"><br>
<br>
&gt; As you asked me , I&#39;m running version 2.4.9.1 of xenomai .<br>
&gt;<br>
&gt; On Thu, Sep 10, 2009 at 2:45 PM, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 Felipe Castro wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; I&#39;m a little bit lost about this issues cause=
 when running<br>
&gt; =A0 =A0 =A0 =A0 the xenomai<br>
&gt; =A0 =A0 =A0 =A0 &gt; 2.4.8 with the patch that you send me it worked, =
but with<br>
&gt; =A0 =A0 =A0 =A0 new version it<br>
&gt; =A0 =A0 =A0 =A0 &gt; doesn&#39;t work.<br>
&gt; =A0 =A0 =A0 =A0 &gt; Acctually i using the kernel 2.6.27 and i underst=
and what<br>
&gt; =A0 =A0 =A0 =A0 you told me ,<br>
&gt; =A0 =A0 =A0 =A0 &gt; in version 2.4.9.1 there aren&#39;t a patch to th=
is kernel<br>
&gt; =A0 =A0 =A0 =A0 version, neither<br>
&gt; =A0 =A0 =A0 =A0 &gt; xenomai 2.4.8. =A0:S<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 2.4.8 appeared to work, but it had a bug.<br>
&gt; =A0 =A0 =A0 =A0 See<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"https://mail.gna.org/public/xenomai-core/20=
09-08/msg00021.html" target=3D"_blank">https://mail.gna.org/public/xenomai-=
core/2009-08/msg00021.html</a><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; The problem is, I&#39;m using a Voipac developmen=
t kit, and the<br>
&gt; =A0 =A0 =A0 =A0 have only<br>
&gt; =A0 =A0 =A0 =A0 &gt; the kernel 2.6.27 BSP.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; So , i tried to disable the float point emulation=
 but the<br>
&gt; =A0 =A0 =A0 =A0 kernel didn&#39;t<br>
&gt; =A0 =A0 =A0 =A0 &gt; load OK .<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 It proves that your user-space support is compiled for=
<br>
&gt; =A0 =A0 =A0 =A0 hardware float,<br>
&gt; =A0 =A0 =A0 =A0 but not PXA hardware floats. This is a pure waste of C=
PU<br>
&gt; =A0 =A0 =A0 =A0 power. See:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"http://www.arm.linux.org.uk/mailinglists/fa=
q.php#f3" target=3D"_blank">http://www.arm.linux.org.uk/mailinglists/faq.ph=
p#f3</a><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Note that Xenomai applications compiled that way will =
not work<br>
&gt; =A0 =A0 =A0 =A0 either.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
&gt;<br>
&gt;<br>
</div></div><div class=3D"im">&gt; ________________________________________=
_______<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
</div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e6d645141be7ea04739ef0b6--

