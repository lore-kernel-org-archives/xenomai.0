MIME-Version: 1.0
In-Reply-To: <4BDAECA0.8030006@domain.hid>
References: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>
	<4BDAECA0.8030006@domain.hid>
Date: Fri, 30 Apr 2010 16:48:34 +0200
Message-ID: <z2sa2d86cab1004300748n41fbef55t5fefc57827f2f089@domain.hid>
From: Leyrit Vincent <sec.leyrit@domain.hid>
Content-Type: multipart/alternative; boundary=0015174764fc761f76048575561c
Subject: Re: [Xenomai-help] help with porting simple posix application
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

--0015174764fc761f76048575561c
Content-Type: text/plain; charset=ISO-8859-1

Thanks you for the link, i have already have a look on it ...
The only thing that i do not understand in the code i have posted, is that i
never do any call to a linux domain syscall ...
but i don't see my thread in "runnable" (R) in the xenomai scheduler
/proc/xenomai/sched...

On Fri, Apr 30, 2010 at 4:43 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Leyrit Vincent wrote:
> > Hello,
> >
> > i would like to port a POSIX application on XENOMAI ..
>
> See:
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
>
>
> > CODE
> -----------------------------------------------------------------------
> >
> > int recursive_method(int cp)
> > {
> >   struct timeval ta;
> >   struct timespec ts_start, ts_end;
> >
> >   if(cp < n_recurs)
> >     {
> >       for(int i=0; i < 10;i++)
> >         {
> >           clock_gettime(CLOCK_REALTIME,&ts_start);
> >           xnprintf("%d\n", ts_start.tv_nsec);
>
> printf here causes a switch to secondary mode.
>
> --
>                                             Gilles.
>

--0015174764fc761f76048575561c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks you for the link, i have already have a look on it ...<br>The only t=
hing that i do not understand in the code i have posted, is that i never do=
 any call to a linux domain syscall ... <br>but i don&#39;t see my thread i=
n &quot;runnable&quot; (R) in the xenomai scheduler /proc/xenomai/sched...<=
br>
<br><div class=3D"gmail_quote">On Fri, Apr 30, 2010 at 4:43 PM, Gilles Chan=
teperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
mai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Leyrit Vincent wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; i would like to port a POSIX application on XENOMAI ..<br>
<br>
</div>See:<br>
<a href=3D"http://www.xenomai.org/index.php/Porting_POSIX_applications_to_X=
enomai" target=3D"_blank">http://www.xenomai.org/index.php/Porting_POSIX_ap=
plications_to_Xenomai</a><br>
<div class=3D"im"><br>
<br>
&gt; CODE -----------------------------------------------------------------=
------<br>
&gt;<br>
&gt; int recursive_method(int cp)<br>
&gt; {<br>
&gt; =A0 struct timeval ta;<br>
&gt; =A0 struct timespec ts_start, ts_end;<br>
&gt;<br>
&gt; =A0 if(cp &lt; n_recurs)<br>
&gt; =A0 =A0 {<br>
&gt; =A0 =A0 =A0 for(int i=3D0; i &lt; 10;i++)<br>
&gt; =A0 =A0 =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 clock_gettime(CLOCK_REALTIME,&amp;ts_start);<br>
&gt; =A0 =A0 =A0 =A0 =A0 xnprintf(&quot;%d\n&quot;, ts_start.tv_nsec);<br>
<br>
</div>printf here causes a switch to secondary mode.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0015174764fc761f76048575561c--

