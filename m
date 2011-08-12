MIME-Version: 1.0
In-Reply-To: <0418d479ba74e1d8c47f00d4477f82f2.squirrel@domain.hid>
References: <CAKvQZ_201P0vHGH0QFyGGqmOHFugbEfcZ=-vspNJU+F9Z+1dqw@domain.hid>
	<0418d479ba74e1d8c47f00d4477f82f2.squirrel@domain.hid>
Date: Fri, 12 Aug 2011 14:47:48 +0200
Message-ID: <CAKvQZ_3uaxWk0PPZRmzXYiQ_B+sJUoa7roH5jYQheYuWoh_pow@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=20cf303b41431c77ba04aa4e52b7
Subject: Re: [Xenomai-help] depracated use case of xeno-config,
	how to update ?
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
Cc: xenomai@xenomai.org, canfestival-devel@domain.hid

--20cf303b41431c77ba04aa4e52b7
Content-Type: text/plain; charset=ISO-8859-1

2011/8/12 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> Willy Lambert wrote:
> > Now, as xeno-config depracated messages suggest I should not use "
> > $XENO_CONFIG --xeno-ldflags" but "$XENO_CONFIG --skin=native --ldflags"
> > without adding -lnative.
> > My problem is that I have both -lnative and -lrtdm so I wonder why skin
> is
> > only accepting one at a time.
> > Is it forbidden now to do such mixes ?
> > Did CanFestival code should be separated into 2 pieces one with
> > skin=native
> > the other with skin=rtdm ?
> > Should I only add -lrtdm "brutally"
>
> No, nothing is forbidden. You should call xeno-config twice. Once with
> --skin=native, once with --skin=rtdm. At least, this is the way it is
> supposed to be used.
>

Ok thanks.



>
> --
>                     Gilles.
>
>

--20cf303b41431c77ba04aa4e52b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/8/12 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">
<div class=3D"im"><br>
Willy Lambert wrote:<br>
&gt; Now, as xeno-config depracated messages suggest I should not use &quot=
;<br>
&gt; $XENO_CONFIG --xeno-ldflags&quot; but &quot;$XENO_CONFIG --skin=3Dnati=
ve --ldflags&quot;<br>
&gt; without adding -lnative.<br>
&gt; My problem is that I have both -lnative and -lrtdm so I wonder why ski=
n is<br>
&gt; only accepting one at a time.<br>
&gt; Is it forbidden now to do such mixes ?<br>
&gt; Did CanFestival code should be separated into 2 pieces one with<br>
&gt; skin=3Dnative<br>
&gt; the other with skin=3Drtdm ?<br>
&gt; Should I only add -lrtdm &quot;brutally&quot;<br>
<br>
</div>No, nothing is forbidden. You should call xeno-config twice. Once wit=
h<br>
--skin=3Dnative, once with --skin=3Drtdm. At least, this is the way it is<b=
r>
supposed to be used.<br></blockquote><div><br>Ok thanks.<br><br>=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-=
left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br>

--20cf303b41431c77ba04aa4e52b7--

