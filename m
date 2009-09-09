MIME-Version: 1.0
In-Reply-To: <4AA6BC5D.8020704@domain.hid>
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
	<4AA6BC5D.8020704@domain.hid>
Date: Wed, 9 Sep 2009 12:03:28 -0300
Message-ID: <7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6db2ae7aeb2ab04732662bb
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

--0016e6db2ae7aeb2ab04732662bb
Content-Type: text/plain; charset=ISO-8859-1

Yes , i compiled with msoft-float , anyway  I downloaded xenomai 2.4.9.1 and
recompile my kernel,

During the startup it was ok ,

[    1.340935] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.344875] I-pipe: Domain Xenomai registered.
[    1.344970] Xenomai: hal/arm started.
[    1.375581] I-pipe: Domain IShield registered.
[    1.377746] Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.

and running xeno-info i got:

root@domain.hid$ ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.6.1 (2009-07-15 08:44:38 BRT) multi-call binary
Linux vpac270 2.6.27-vpac1 #55 PREEMPT Wed Sep 9 06:07:03 BRT 2009 armv5tel
unknown

module-init-tools      found
Modules Loaded         xeno_native

But running latency test program:

root@domain.hid$ ./latency -p 3000
== Sampling period: 3000 us
== Test mode: periodic user-mode task
== All results in microseconds
[  360.030571] Xenomai: fatal: bug at kernel/xenomai/nucleus/shadow.c:1128
(!irqs_disabled_hw())
[  360.030608]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  360.030631]    0  0       -1      0        00500088  ROOT
[  360.030653] >  0  363      0      0        00300180  display-361
[  360.030678] Master time base: clock=1170102652
[  360.030697]
[  360.123559] [<c0021dec>] (show_stack+0x0/0x48) from [<c007e0a8>]
(xnshadow_harden+0x1b8/0x210)
[  360.149304] [<c007def0>] (xnshadow_harden+0x0/0x210) from [<c007e5c8>]
(xnshadow_wait_barrier+0xf8/0x108)
[  360.177811]  r8:00000018 r7:00000000 r6:c787bfb0 r5:c7a80810 r4:c787a000
[  360.197738] [<c007e4d0>] (xnshadow_wait_barrier+0x0/0x108) from
[<c007fb18>] (xnshadow_sys_barrier+0x14/0x18)
[  360.227281]  r6:c787a000 r5:c787bfb0 r4:00000001
[  360.241003] [<c007fb04>] (xnshadow_sys_barrier+0x0/0x18) from
[<c007feac>] (losyscall_event+0xbc/0x1ac)
[  360.268996] [<c007fdf0>] (losyscall_event+0x0/0x1ac) from [<c0066094>]
(__ipipe_dispatch_event+0xd0/0x1c8)
[  360.297788] [<c0065fc4>] (__ipipe_dispatch_event+0x0/0x1c8) from
[<c0022c8c>] (__ipipe_syscall_root+0x7c/0x110)
[  360.327847] [<c0022c10>] (__ipipe_syscall_root+0x0/0x110) from
[<c001e028>] (vector_swi+0x68/0xa8)

any sugestion ?

Thanks!!

On Tue, Sep 8, 2009 at 5:19 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Felipe Castro wrote:
> > Spam detection software, running on the system "xenomai.org", has
> > identified this incoming email as possible spam.  The original message
> > has been attached to this so you can view it (if it isn't spam) or label
> > similar future email.  If you have any questions, see
> > the administrator of that system for details.
>
> >
> > Content preview:  I'm running Xenomai 2.4.8 with kernel 2.6.27 on a
> Voipac development
> >    kit with PXA270 processor. Once applied a patch (Thanks Giles)
> everythink
> >    looks to run ok , but running the latency test program i got: [...]
> >
> > Content analysis details:   (4.8 points, 4.5 required)
> >
> >  pts rule name              description
> > ---- ----------------------
> --------------------------------------------------
> >  1.1 URIBL_RHS_DOB          Contains an URI of a new domain (Day Old
> Bread)
> >                             [URIs: gna.org]
> >  2.0 HTML_MESSAGE           BODY: HTML included in message
> >  1.8 MIME_BASE64_TEXT       RAW: Message text disguised using base64
> encoding
> >
> > The original message was not completely plain text, and may be unsafe to
> > open with some email clients; in particular, it may contain a virus,
> > or confirm that your address can receive spam.  If you wish to view
> > it, it may be safer to save it to a file and open it with an editor.
> >
>
> Please avoid sending messages which look like spam, you will get faster
> responses since I do read my spam box only once a day.
>
> > I'm running Xenomai 2.4.8 with kernel 2.6.27 on a Voipac development kit
> > with PXA270 processor.
>
> Please switch to Xenomai 2.4.9.1.
>
> >
> > Once applied a patch (Thanks Giles) everythink looks to run ok , but
> running
> > the latency test program i got:
>
> All patches have been included in 2.4.9.1. What is your status with
> regard to floating points? Are you compiling with -msoft-float? It is
> mandatory on PXA.
>
>
> --
>                                             Gilles.
>

--0016e6db2ae7aeb2ab04732662bb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes , i compiled with msoft-float , anyway=A0 I downloaded xenomai 2.4.9.1 =
and recompile my kernel,<br><br>During the startup it was ok , <br><br>[=A0=
=A0=A0 1.340935] NetWinder Floating Point Emulator V0.97 (double precision)=
<br>[=A0=A0=A0 1.344875] I-pipe: Domain Xenomai registered.<br>
[=A0=A0=A0 1.344970] Xenomai: hal/arm started.<br>[=A0=A0=A0 1.375581] I-pi=
pe: Domain IShield registered.<br>[=A0=A0=A0 1.377746] Xenomai: real-time n=
ucleus v2.4.9.1 (Big Bad Moon) loaded.<br><br>and running xeno-info i got:<=
br><br>root@domain.hid$ ./xeno-info <br>
If some fields are empty or look unusual you may have an old version.<br>Co=
mpare to the current minimal requirements in Documentation/Changes.<br>=A0<=
br>BusyBox v1.6.1 (2009-07-15 08:44:38 BRT) multi-call binary<br>Linux vpac=
270 2.6.27-vpac1 #55 PREEMPT Wed Sep 9 06:07:03 BRT 2009 armv5tel unknown<b=
r>
=A0<br>module-init-tools=A0=A0=A0=A0=A0 found<br>Modules Loaded=A0=A0=A0=A0=
=A0=A0=A0=A0 xeno_native<br><br>But running latency test program:<br><br>ro=
ot@domain.hid$ ./latency -p 3000<br>=3D=3D Sampling period: 3=
000 us<br>=3D=3D Test mode: periodic user-mode task<br>
=3D=3D All results in microseconds<br>[=A0 360.030571] Xenomai: fatal: bug =
at kernel/xenomai/nucleus/shadow.c:1128 (!irqs_disabled_hw())<br>[=A0 360.0=
30608]=A0 CPU=A0 PID=A0=A0=A0 PRI=A0=A0=A0=A0=A0 TIMEOUT=A0 STAT=A0=A0=A0=
=A0=A0 NAME<br>[=A0 360.030631]=A0=A0=A0 0=A0 0=A0=A0=A0=A0=A0=A0 -1=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 00500088=A0 ROOT<br>
[=A0 360.030653] &gt;=A0 0=A0 363=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0 00300180=A0 display-361<br>[=A0 360.030678] Master time bas=
e: clock=3D1170102652<br>[=A0 360.030697] <br>[=A0 360.123559] [&lt;c0021de=
c&gt;] (show_stack+0x0/0x48) from [&lt;c007e0a8&gt;] (xnshadow_harden+0x1b8=
/0x210)<br>
[=A0 360.149304] [&lt;c007def0&gt;] (xnshadow_harden+0x0/0x210) from [&lt;c=
007e5c8&gt;] (xnshadow_wait_barrier+0xf8/0x108)<br>[=A0 360.177811]=A0 r8:0=
0000018 r7:00000000 r6:c787bfb0 r5:c7a80810 r4:c787a000<br>[=A0 360.197738]=
 [&lt;c007e4d0&gt;] (xnshadow_wait_barrier+0x0/0x108) from [&lt;c007fb18&gt=
;] (xnshadow_sys_barrier+0x14/0x18)<br>
[=A0 360.227281]=A0 r6:c787a000 r5:c787bfb0 r4:00000001<br>[=A0 360.241003]=
 [&lt;c007fb04&gt;] (xnshadow_sys_barrier+0x0/0x18) from [&lt;c007feac&gt;]=
 (losyscall_event+0xbc/0x1ac)<br>[=A0 360.268996] [&lt;c007fdf0&gt;] (losys=
call_event+0x0/0x1ac) from [&lt;c0066094&gt;] (__ipipe_dispatch_event+0xd0/=
0x1c8)<br>
[=A0 360.297788] [&lt;c0065fc4&gt;] (__ipipe_dispatch_event+0x0/0x1c8) from=
 [&lt;c0022c8c&gt;] (__ipipe_syscall_root+0x7c/0x110)<br>[=A0 360.327847] [=
&lt;c0022c10&gt;] (__ipipe_syscall_root+0x0/0x110) from [&lt;c001e028&gt;] =
(vector_swi+0x68/0xa8)<br>
<br>any sugestion ?<br><br>Thanks!!<br><br><div class=3D"gmail_quote">On Tu=
e, Sep 8, 2009 at 5:19 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Felipe Castro wro=
te:<br>
&gt; Spam detection software, running on the system &quot;<a href=3D"http:/=
/xenomai.org" target=3D"_blank">xenomai.org</a>&quot;, has<br>
&gt; identified this incoming email as possible spam. =A0The original messa=
ge<br>
&gt; has been attached to this so you can view it (if it isn&#39;t spam) or=
 label<br>
&gt; similar future email. =A0If you have any questions, see<br>
&gt; the administrator of that system for details.<br>
<br>
&gt;<br>
&gt; Content preview: =A0I&#39;m running Xenomai 2.4.8 with kernel 2.6.27 o=
n a Voipac development<br>
<div class=3D"im">&gt; =A0 =A0kit with PXA270 processor. Once applied a pat=
ch (Thanks Giles) everythink<br>
</div>&gt; =A0 =A0looks to run ok , but running the latency test program i =
got: [...]<br>
&gt;<br>
&gt; Content analysis details: =A0 (4.8 points, 4.5 required)<br>
&gt;<br>
&gt; =A0pts rule name =A0 =A0 =A0 =A0 =A0 =A0 =A0description<br>
&gt; ---- ---------------------- ------------------------------------------=
--------<br>
&gt; =A01.1 URIBL_RHS_DOB =A0 =A0 =A0 =A0 =A0Contains an URI of a new domai=
n (Day Old Bread)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [URIs: <a href=
=3D"http://gna.org" target=3D"_blank">gna.org</a>]<br>
&gt; =A02.0 HTML_MESSAGE =A0 =A0 =A0 =A0 =A0 BODY: HTML included in message=
<br>
&gt; =A01.8 MIME_BASE64_TEXT =A0 =A0 =A0 RAW: Message text disguised using =
base64 encoding<br>
&gt;<br>
&gt; The original message was not completely plain text, and may be unsafe =
to<br>
&gt; open with some email clients; in particular, it may contain a virus,<b=
r>
&gt; or confirm that your address can receive spam. =A0If you wish to view<=
br>
&gt; it, it may be safer to save it to a file and open it with an editor.<b=
r>
&gt;<br>
<br>
Please avoid sending messages which look like spam, you will get faster<br>
responses since I do read my spam box only once a day.<br>
<div class=3D"im"><br>
&gt; I&#39;m running Xenomai 2.4.8 with kernel 2.6.27 on a Voipac developme=
nt kit<br>
&gt; with PXA270 processor.<br>
<br>
</div>Please switch to Xenomai 2.4.9.1.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Once applied a patch (Thanks Giles) everythink looks to run ok , but r=
unning<br>
&gt; the latency test program i got:<br>
<br>
</div>All patches have been included in 2.4.9.1. What is your status with<b=
r>
regard to floating points? Are you compiling with -msoft-float? It is<br>
mandatory on PXA.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e6db2ae7aeb2ab04732662bb--

