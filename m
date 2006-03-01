Message-ID: <b647ffbd0603010725t60066558h@domain.hid>
Date: Wed, 1 Mar 2006 17:25:58 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <440575EB.4080304@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3649_23912633.1141226758945"
References: <C029D34C.25A3%steve@domain.hid> <440575EB.4080304@domain.hid>
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

------=_Part_3649_23912633.1141226758945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 01/03/06, Philippe Gerum <rpm@xenomai.org> wrote:


 The other option I've described for
> dealing with overruns in rt_task_wait_period would be as follows:
>
> - save the count of overruns
> - clear the count of overruns  /* i.e. "purge" */
> - return both the saved count and -ETIMEDOUT to the user.
>
> This way, rt_task_wait_period would return only once with an error status=
,
> telling
> the user about the exact count of pending overruns in the same time.



I definitely agree with you here.

IMHO, there is no point in calling rt_task_wait_period() a few
times in a row just to clean up the "poverrun" counter
(if there were a few overruns) when the whole may be reported at once. This
former way just gives unnecessary overhead.


Actually, there is a kind of application that must not rely on
the "poverrun" counter, the klatency/latency utility and alike.

They are run normally (at least at the very first time) in the untrusted
environment
where SMI or something similar - that may prevent a CPU from handling norma=
l
interrupts for quite a long time - make occur happily.
As the "poeverrun" counting is dependent on the timer interrupt,
it becomes irrelevant.

Something like
overruns =3D (real_time_of_wakeup - desired_time_of_wakeup) / period (*)
should be rather used there (of course, the timing source must not be
interrupt-dependent).

Other applications may likely rely on the "poverrun" counter
(returned by rt_task_wait_period(&overrun)) as they normally
run in the (more or less) studied and tweaked environment.

Ok, some "paranoid" programmers would think differently even then
but there is always the (*) way :o)


--
Best regards,
Dmitry Adamushko

------=_Part_3649_23912633.1141226758945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 01/03/06, <b class=3D"gmail_sendern=
ame">Philippe Gerum</b> &lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org.=
org</a>&gt; wrote:</span><br>
<div>&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">&nbsp;The other option I've described for<br>dealing with overruns in r=
t_task_wait_period would be as follows:
<br><br>- save the count of overruns<br>- clear the count of overruns&nbsp;=
&nbsp;/* i.e. &quot;purge&quot; */<br>- return both the saved count and -ET=
IMEDOUT to the user.<br><br>This way, rt_task_wait_period would return only=
 once with an error status, telling
<br>the user about the exact count of pending overruns in the same time. </=
blockquote><div><br>
<br>
I definitely agree with you here.<br>
<br>
IMHO, there is no point in calling rt_task_wait_period() a few<br>
times in a row just to clean up the &quot;poverrun&quot; counter<br>
(if there were a few overruns) when the whole may be reported at once. This=
 former way just gives unnecessary overhead.<br>
<br>
<br>
Actually, there is a kind of application that must not rely on<br>
the &quot;poverrun&quot; counter, the klatency/latency utility and alike.<b=
r>
<br>
They are run normally (at least at the very first time) in the untrusted en=
vironment<br>
where SMI or something similar - that may prevent a CPU from handling norma=
l<br>
interrupts for quite a long time - make occur happily.<br>
As the &quot;poeverrun&quot; counting is dependent on the timer interrupt,<=
br>
it becomes irrelevant.<br>
<br>
Something like<br>
overruns =3D (real_time_of_wakeup - desired_time_of_wakeup) / period (*)<br=
>
should be rather used there (of course, the timing source must not be<br>
interrupt-dependent).<br>
<br>
Other applications may likely rely on the &quot;poverrun&quot; counter<br>
(returned by rt_task_wait_period(&amp;overrun)) as they normally<br>
run in the (more or less) studied and tweaked environment.<br>
<br>
Ok, some &quot;paranoid&quot; programmers would think differently even then=
<br>
but there is always the (*) way :o)<br>
<br>
</div></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_3649_23912633.1141226758945--

