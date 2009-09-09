MIME-Version: 1.0
In-Reply-To: <4AA7C4F7.6000903@domain.hid>
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
	<4AA6BC5D.8020704@domain.hid>
	<7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>
	<4AA7C4F7.6000903@domain.hid>
Date: Wed, 9 Sep 2009 16:06:25 -0300
Message-ID: <7a15153d0909091206y5d16ffcck32d0c8cc3c120f6c@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64c2e028f2d13047329c70e
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

--0016e64c2e028f2d13047329c70e
Content-Type: text/plain; charset=ISO-8859-1

i applied the adeos path that comes with xenomai 2.4.9.1 overriding the old
one that I was using, is that a problem ?

the result is :

root@domain.hid:~$ cat /proc/ipipe/version
1.12-02


On Wed, Sep 9, 2009 at 12:08 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Felipe Castro wrote:
> > Yes , i compiled with msoft-float , anyway  I downloaded xenomai 2.4.9.1
> > and recompile my kernel,
> >
> > During the startup it was ok ,
> >
> > [    1.340935] NetWinder Floating Point Emulator V0.97 (double precision)
> > [    1.344875] I-pipe: Domain Xenomai registered.
> > [    1.344970] Xenomai: hal/arm started.
> > [    1.375581] I-pipe: Domain IShield registered.
> > [    1.377746] Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.
> >
> > and running xeno-info i got:
> >
> > root@domain.hid$ ./xeno-info
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> >
> > BusyBox v1.6.1 (2009-07-15 08:44:38 BRT) multi-call binary
> > Linux vpac270 2.6.27-vpac1 #55 PREEMPT Wed Sep 9 06:07:03 BRT 2009
> > armv5tel unknown
> >
> > module-init-tools      found
> > Modules Loaded         xeno_native
> >
> > But running latency test program:
> >
> > root@domain.hid$ ./latency -p 3000
> > == Sampling period: 3000 us
> > == Test mode: periodic user-mode task
> > == All results in microseconds
> > [  360.030571] Xenomai: fatal: bug at
> > kernel/xenomai/nucleus/shadow.c:1128 (!irqs_disabled_hw())
> > [  360.030608]  CPU  PID    PRI      TIMEOUT  STAT      NAME
> > [  360.030631]    0  0       -1      0        00500088  ROOT
> > [  360.030653] >  0  363      0      0        00300180  display-361
> > [  360.030678] Master time base: clock=1170102652
> > [  360.030697]
> > [  360.123559] [<c0021dec>] (show_stack+0x0/0x48) from [<c007e0a8>]
> > (xnshadow_harden+0x1b8/0x210)
> > [  360.149304] [<c007def0>] (xnshadow_harden+0x0/0x210) from
> > [<c007e5c8>] (xnshadow_wait_barrier+0xf8/0x108)
> > [  360.177811]  r8:00000018 r7:00000000 r6:c787bfb0 r5:c7a80810
> r4:c787a000
> > [  360.197738] [<c007e4d0>] (xnshadow_wait_barrier+0x0/0x108) from
> > [<c007fb18>] (xnshadow_sys_barrier+0x14/0x18)
> > [  360.227281]  r6:c787a000 r5:c787bfb0 r4:00000001
> > [  360.241003] [<c007fb04>] (xnshadow_sys_barrier+0x0/0x18) from
> > [<c007feac>] (losyscall_event+0xbc/0x1ac)
> > [  360.268996] [<c007fdf0>] (losyscall_event+0x0/0x1ac) from
> > [<c0066094>] (__ipipe_dispatch_event+0xd0/0x1c8)
> > [  360.297788] [<c0065fc4>] (__ipipe_dispatch_event+0x0/0x1c8) from
> > [<c0022c8c>] (__ipipe_syscall_root+0x7c/0x110)
> > [  360.327847] [<c0022c10>] (__ipipe_syscall_root+0x0/0x110) from
> > [<c001e028>] (vector_swi+0x68/0xa8)
> >
> > any sugestion ?
>
> You are probably not using the I-pipe patch which comes with Xenomai
> 2.4.9.1,
> type:
> cat /proc/ipipe/version
>
> --
>                                           Gilles
>
>

--0016e64c2e028f2d13047329c70e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

i applied the adeos path that comes with xenomai 2.4.9.1 overriding the old=
 one that I was using, is that a problem ?<br>
<br>
the result is :<br>
<br>
root@domain.hid:~$ cat /proc/ipipe/version <br>
1.12-02<br>
<br><br><div class=3D"gmail_quote">On Wed, Sep 9, 2009 at 12:08 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">Felipe Castro wrote:<br>
&gt; Yes , i compiled with msoft-float , anyway =A0I downloaded xenomai 2.4=
.9.1<br>
&gt; and recompile my kernel,<br>
&gt;<br>
&gt; During the startup it was ok ,<br>
&gt;<br>
&gt; [ =A0 =A01.340935] NetWinder Floating Point Emulator V0.97 (double pre=
cision)<br>
&gt; [ =A0 =A01.344875] I-pipe: Domain Xenomai registered.<br>
&gt; [ =A0 =A01.344970] Xenomai: hal/arm started.<br>
&gt; [ =A0 =A01.375581] I-pipe: Domain IShield registered.<br>
&gt; [ =A0 =A01.377746] Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) =
loaded.<br>
&gt;<br>
&gt; and running xeno-info i got:<br>
&gt;<br>
&gt; root@domain.hid$ ./xeno-info<br>
&gt; If some fields are empty or look unusual you may have an old version.<=
br>
&gt; Compare to the current minimal requirements in Documentation/Changes.<=
br>
&gt;<br>
&gt; BusyBox v1.6.1 (2009-07-15 08:44:38 BRT) multi-call binary<br>
&gt; Linux vpac270 2.6.27-vpac1 #55 PREEMPT Wed Sep 9 06:07:03 BRT 2009<br>
&gt; armv5tel unknown<br>
&gt;<br>
&gt; module-init-tools =A0 =A0 =A0found<br>
&gt; Modules Loaded =A0 =A0 =A0 =A0 xeno_native<br>
&gt;<br>
&gt; But running latency test program:<br>
&gt;<br>
&gt; root@domain.hid$ ./latency -p 3000<br>
&gt; =3D=3D Sampling period: 3000 us<br>
&gt; =3D=3D Test mode: periodic user-mode task<br>
&gt; =3D=3D All results in microseconds<br>
&gt; [ =A0360.030571] Xenomai: fatal: bug at<br>
&gt; kernel/xenomai/nucleus/shadow.c:1128 (!irqs_disabled_hw())<br>
&gt; [ =A0360.030608] =A0CPU =A0PID =A0 =A0PRI =A0 =A0 =A0TIMEOUT =A0STAT =
=A0 =A0 =A0NAME<br>
&gt; [ =A0360.030631] =A0 =A00 =A00 =A0 =A0 =A0 -1 =A0 =A0 =A00 =A0 =A0 =A0=
 =A000500088 =A0ROOT<br>
&gt; [ =A0360.030653] &gt; =A00 =A0363 =A0 =A0 =A00 =A0 =A0 =A00 =A0 =A0 =
=A0 =A000300180 =A0display-361<br>
&gt; [ =A0360.030678] Master time base: clock=3D1170102652<br>
&gt; [ =A0360.030697]<br>
&gt; [ =A0360.123559] [&lt;c0021dec&gt;] (show_stack+0x0/0x48) from [&lt;c0=
07e0a8&gt;]<br>
&gt; (xnshadow_harden+0x1b8/0x210)<br>
&gt; [ =A0360.149304] [&lt;c007def0&gt;] (xnshadow_harden+0x0/0x210) from<b=
r>
&gt; [&lt;c007e5c8&gt;] (xnshadow_wait_barrier+0xf8/0x108)<br>
&gt; [ =A0360.177811] =A0r8:00000018 r7:00000000 r6:c787bfb0 r5:c7a80810 r4=
:c787a000<br>
&gt; [ =A0360.197738] [&lt;c007e4d0&gt;] (xnshadow_wait_barrier+0x0/0x108) =
from<br>
&gt; [&lt;c007fb18&gt;] (xnshadow_sys_barrier+0x14/0x18)<br>
&gt; [ =A0360.227281] =A0r6:c787a000 r5:c787bfb0 r4:00000001<br>
&gt; [ =A0360.241003] [&lt;c007fb04&gt;] (xnshadow_sys_barrier+0x0/0x18) fr=
om<br>
&gt; [&lt;c007feac&gt;] (losyscall_event+0xbc/0x1ac)<br>
&gt; [ =A0360.268996] [&lt;c007fdf0&gt;] (losyscall_event+0x0/0x1ac) from<b=
r>
&gt; [&lt;c0066094&gt;] (__ipipe_dispatch_event+0xd0/0x1c8)<br>
&gt; [ =A0360.297788] [&lt;c0065fc4&gt;] (__ipipe_dispatch_event+0x0/0x1c8)=
 from<br>
&gt; [&lt;c0022c8c&gt;] (__ipipe_syscall_root+0x7c/0x110)<br>
&gt; [ =A0360.327847] [&lt;c0022c10&gt;] (__ipipe_syscall_root+0x0/0x110) f=
rom<br>
&gt; [&lt;c001e028&gt;] (vector_swi+0x68/0xa8)<br>
&gt;<br>
&gt; any sugestion ?<br>
<br>
</div></div>You are probably not using the I-pipe patch which comes with Xe=
nomai<br>
2.4.9.1,<br>
type:<br>
cat /proc/ipipe/version<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
<br>
</font></blockquote></div><br>

--0016e64c2e028f2d13047329c70e--

