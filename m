MIME-Version: 1.0
Sender: lcasassa@domain.hid
In-Reply-To: <4AC72281.9090901@domain.hid>
References: <47a3101a0910021728p63da56f7g59edabc521cc4dfe@domain.hid> 
	<4AC72281.9090901@domain.hid>
From: Linus Casassa <linus@domain.hid>
Date: Sun, 4 Oct 2009 02:03:37 -0400
Message-ID: <47a3101a0910032303n54357389nd8573284eadba063@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd14ec83baf81047515c3b8
Subject: Re: [Xenomai-help] Xenomai on gumstix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--000e0cd14ec83baf81047515c3b8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don't understand. The example is for a periodic task. What did I miss? :S

On Sat, Oct 3, 2009 at 6:08 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Linus Casassa wrote:
> > It works!
> >
> > But I notice that the frequency is bad configured.
> >
> > I am using the trivial-periodic example.
> >
> http://www.xenomai.org/documentation/xenomai-2.4/html/api/trivial-periodi=
c_8c-example.html
> >
> > I had to change
> > rt_task_set_periodic(NULL, TM_NOW, 1000000000);
> > to
> > rt_task_set_periodic(NULL, TM_NOW, 1000);
> > to get 1 second.
> >
> > How can I fix this?
>
> You probably selected a periodic timer for the native skin. The example
> is made for the aperiodic timer.
>
> --
>                                             Gilles.
>



--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd14ec83baf81047515c3b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don&#39;t understand. The example is for a periodic task. What did I miss=
? :S<br><br><div class=3D"gmail_quote">On Sat, Oct 3, 2009 at 6:08 AM, Gill=
es Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdr=
ix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Linus Casassa wrote:<br>
&gt; It works!<br>
&gt;<br>
&gt; But I notice that the frequency is bad configured.<br>
&gt;<br>
&gt; I am using the trivial-periodic example.<br>
&gt; <a href=3D"http://www.xenomai.org/documentation/xenomai-2.4/html/api/t=
rivial-periodic_8c-example.html" target=3D"_blank">http://www.xenomai.org/d=
ocumentation/xenomai-2.4/html/api/trivial-periodic_8c-example.html</a><br>


&gt;<br>
&gt; I had to change<br>
&gt; rt_task_set_periodic(NULL, TM_NOW, 1000000000);<br>
&gt; to<br>
&gt; rt_task_set_periodic(NULL, TM_NOW, 1000);<br>
&gt; to get 1 second.<br>
&gt;<br>
&gt; How can I fix this?<br>
<br>
</div>You probably selected a periodic timer for the native skin. The examp=
le<br>
is made for the aperiodic timer.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Linus Casassa<br=
>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>

--000e0cd14ec83baf81047515c3b8--

