Message-ID: <b647ffbd0603011101p1247cd87t@domain.hid>
Date: Wed, 1 Mar 2006 21:01:03 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4405C527.8060908@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1767_27097244.1141239663026"
References: <C029D34C.25A3%steve@domain.hid> <440575EB.4080304@domain.hid>
	<b647ffbd0603010725t60066558h@domain.hid>
	<4405C527.8060908@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] rt_task_wait_period() and overruns
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_1767_27097244.1141239663026
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 01/03/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Dmitry Adamushko wrote:
> >
> > On 01/03/06, *Philippe Gerum* <rpm@xenomai.org <mailto:rpm@xenomai.org>=
>
> > wrote:
> >
> >
> >      The other option I've described for
> >     dealing with overruns in rt_task_wait_period would be as follows:
> >
> >     - save the count of overruns
> >     - clear the count of overruns  /* i.e. "purge" */
> >     - return both the saved count and -ETIMEDOUT to the user.
> >
> >     This way, rt_task_wait_period would return only once with an error
> >     status, telling
> >     the user about the exact count of pending overruns in the same time=
.
> >
> >
> >
> > I definitely agree with you here.
> >
> > IMHO, there is no point in calling rt_task_wait_period() a few
> > times in a row just to clean up the "poverrun" counter
> > (if there were a few overruns) when the whole may be reported at once.
> > This former way just gives unnecessary overhead.
> >
>
> My concern is that some recovery procedure might require to get the exact
> number
> of pending overruns to operate properly in order to catch up with the
> missing
> expiries, and there is no way to get this information out of the current
> API (!).
> Even calling rt_task_wait_period in loop and testing for -ETIMEDOUT is
> unusable,
> since well, we would obviously get blocked when the overrun count drops t=
o
> zero,
> which is not what we want in order to be able to run the recovery
> procedure asap.


All in all, I would vote for changing the current rt_task_wait_period()
interface.



>
> > Actually, there is a kind of application that must not rely on
> > the "poverrun" counter, the klatency/latency utility and alike.
> >
> > They are run normally (at least at the very first time) in the untruste=
d
> > environment
> > where SMI or something similar - that may prevent a CPU from handling
> normal
> > interrupts for quite a long time - make occur happily.
> > As the "poeverrun" counting is dependent on the timer interrupt,
> > it becomes irrelevant.
> >
> > Something like
> > overruns =3D (real_time_of_wakeup - desired_time_of_wakeup) / period (*=
)
> > should be rather used there (of course, the timing source must not be
> > interrupt-dependent).
>
> Ah! you know what, I'm pretty sure that one of your very first public
> posts on the
> RTAI/fusion mailing list at that time, was exactely about this issue :o)


Good memory indeed; so it's too earlier for you to get retired :o)


--
>
> Philippe.
>



--
Best regards,
Dmitry Adamushko

------=_Part_1767_27097244.1141239663026
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 01/03/06, <b class=3D"gmail_sendern=
ame">Philippe Gerum</b> &lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org.=
org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt;<br>&gt; On 01/03/06, *Philippe Gerum* &lt;<=
a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a> &lt;mailto:<a href=3D=
"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;&gt;<br>&gt; wrote:<br>&gt;
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The other option I've d=
escribed for<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; dealing with overruns in rt_ta=
sk_wait_period would be as follows:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
 - save the count of overruns<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; - clear the c=
ount of overruns&nbsp;&nbsp;/*=20
i.e. &quot;purge&quot; */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; - return both the=
 saved count and -ETIMEDOUT to the user.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&=
nbsp; This way, rt_task_wait_period would return only once with an error<br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status, telling<br>&gt;&nbsp;&nbsp;&nbsp;&nbs=
p; the user about the exact count of pending overruns in the same time.
<br>&gt;<br>&gt;<br>&gt;<br>&gt; I definitely agree with you here.<br>&gt;<=
br>&gt; IMHO, there is no point in calling rt_task_wait_period() a few<br>&=
gt; times in a row just to clean up the &quot;poverrun&quot; counter<br>
&gt; (if there were a few overruns) when the whole may be reported at once.=
<br>&gt; This former way just gives unnecessary overhead.<br>&gt;<br><br>My=
 concern is that some recovery procedure might require to get the exact num=
ber
<br>of pending overruns to operate properly in order to catch up with the m=
issing<br>expiries, and there is no way to get this information out of the =
current API (!).<br>Even calling rt_task_wait_period in loop and testing fo=
r -ETIMEDOUT is unusable,
<br>since well, we would obviously get blocked when the overrun count drops=
 to zero,<br>which is not what we want in order to be able to run the recov=
ery procedure asap.</blockquote><div><br>
All in all, I would vote for changing the current rt_task_wait_period() int=
erface.<br>
&nbsp;<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br=
>&gt; Actually, there is a kind of application that must not rely on<br>&gt=
; the &quot;poverrun&quot; counter, the klatency/latency utility and alike.
<br>&gt;<br>&gt; They are run normally (at least at the very first time) in=
 the untrusted<br>&gt; environment<br>&gt; where SMI or something similar -=
 that may prevent a CPU from handling normal<br>&gt; interrupts for quite a=
 long time - make occur happily.
<br>&gt; As the &quot;poeverrun&quot; counting is dependent on the timer in=
terrupt,<br>&gt; it becomes irrelevant.<br>&gt;<br>&gt; Something like<br>&=
gt; overruns =3D (real_time_of_wakeup - desired_time_of_wakeup) / period (*=
)
<br>&gt; should be rather used there (of course, the timing source must not=
 be<br>&gt; interrupt-dependent).<br><br>Ah! you know what, I'm pretty sure=
 that one of your very first public posts on the<br>RTAI/fusion mailing lis=
t at that time, was exactely about this issue :o)
</blockquote><div><br>
Good memory indeed; so it's too earlier for you to get retired :o)<br>
&nbsp;<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br><br>P=
hilippe.<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Best regard=
s,
<br>Dmitry Adamushko

------=_Part_1767_27097244.1141239663026--

