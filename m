MIME-Version: 1.0
In-Reply-To: <1285054174.4114.30.camel@domain.hid>
References: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
	<1285054174.4114.30.camel@domain.hid>
Date: Tue, 21 Sep 2010 16:59:49 +0200
Message-ID: <AANLkTinYnaJjMj-9R=UJd1j7DzT3kCYGZNa=w4LwXzXZ@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d975c7d562e10490c64794
Subject: Re: [Xenomai-help] t_getreg / t_setreg undefined references in
	pSOS+ skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0016e6d975c7d562e10490c64794
Content-Type: text/plain; charset=ISO-8859-1

Hello

There was a small copy-paste issue in your code.
In the file src/skins/psos+/task.c:

+u_long t_setreg(u_long tid, u_long regnum, u_long regvalue)
+{
+       return XENOMAI_SKINCALL3(__psos_muxid, __psos_t_setreg,
+                                tid, regnum, regvalue);
+}
+
+u_long t_getreg(u_long tid, u_long regnum, u_long *regvalue_r)
+{
+       return XENOMAI_SKINCALL3(__psos_muxid, __psos_t_setreg,
+                                tid, regnum, regvalue_r);
+}

The function t_getreg should use __psos_t_getreg instead of __psos_t_setreg.

Once I changed this, the code seems to work.

BTW I'm really impressed by the code-quality and responsiveness of the
Xenomai community.

Best regards,
Ronny

On Tue, Sep 21, 2010 at 9:29 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2010-09-20 at 22:42 +0200, ronny meeus wrote:
> > Hello
> >
> > I see in the psos.h file the function declaration for both the
> > t_getreg and the t_setreg functions.
> > Also in the psos kernel module I see functionality available.
> > What I miss it the references for both service calls in the syscall.c
> > file.
> >
> > This results in undefined references if I try to use the service call
> > in my application.
> >
> > Is there any patch available that solves my problem?
>
> Untested:
>
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=740e3b9e5f77588f3df010752c255ecd24adea4e
>
> >
> > Thanks
> > Ronny
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>

--0016e6d975c7d562e10490c64794
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>There was a small copy-paste issue in your code.<br>In the fil=
e src/skins/psos+/task.c:<br><br>+u_long t_setreg(u_long tid, u_long regnum=
, u_long regvalue)<br>+{<br>+=A0=A0=A0=A0=A0=A0 return XENOMAI_SKINCALL3(__=
psos_muxid, __psos_t_setreg,<br>
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 tid, regnum, regvalue);<br>+}<br>+<br>+u_long t_getre=
g(u_long tid, u_long regnum, u_long *regvalue_r)<br>+{<br>+=A0=A0=A0=A0=A0=
=A0 return XENOMAI_SKINCALL3(__psos_muxid, __psos_t_setreg,<br>+=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 tid, regnum, regvalue_r);<br>
+}<br><br>The function t_getreg should use __psos_t_getreg instead of __pso=
s_t_setreg.<br><br>Once I changed this, the code seems to work.<br><br>BTW =
I&#39;m really impressed by the code-quality and responsiveness of the Xeno=
mai community.<br>
<br>Best regards,<br>Ronny<br><br><div class=3D"gmail_quote">On Tue, Sep 21=
, 2010 at 9:29 AM, Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:r=
pm@domain.hid">rpm@xenomai.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Mon, 2010-09-20 at 22:42 +0200, ronny =
meeus wrote:<br>
&gt; Hello<br>
&gt;<br>
&gt; I see in the psos.h file the function declaration for both the<br>
&gt; t_getreg and the t_setreg functions.<br>
&gt; Also in the psos kernel module I see functionality available.<br>
&gt; What I miss it the references for both service calls in the syscall.c<=
br>
&gt; file.<br>
&gt;<br>
&gt; This results in undefined references if I try to use the service call<=
br>
&gt; in my application.<br>
&gt;<br>
&gt; Is there any patch available that solves my problem?<br>
<br>
</div></div>Untested:<br>
<a href=3D"http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3D740e3=
b9e5f77588f3df010752c255ecd24adea4e" target=3D"_blank">http://git.xenomai.o=
rg/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3D740e3b9e5f77588f3df010752c255ecd24ad=
ea4e</a><br>

<br>
&gt;<br>
&gt; Thanks<br>
&gt; Ronny<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e6d975c7d562e10490c64794--

