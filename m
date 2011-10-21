MIME-Version: 1.0
In-Reply-To: <4EA19A9D.1080502@domain.hid>
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
	<4EA19A9D.1080502@domain.hid>
Date: Fri, 21 Oct 2011 15:37:49 -0200
Message-ID: <CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520f1cf29362c04afd2886c
Subject: Re: [Xenomai-help] rt_task_wait_period returns an undocumented value
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
Cc: Xenomai-help@domain.hid

--bcaec520f1cf29362c04afd2886c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 21 de octubre de 2011 14:15, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> escribi=C3=B3:

> On 10/21/2011 06:04 PM, Fernando Herrero Carr=C3=B3n wrote:
> > Dear list,
> >
> > I am running xenomai-2.6-rc4 on an amd64 linux kernel version 2.6.38.8.
> >
> > I am setting up a periodic task using
> >
> > rt_task_set_periodic(NULL, TM_NOW, 11500);
> >
> > For period values smaller than 11450 I get an EINVAL return value. I've
> got
> > one question regarding this, and it's how is this threshold calculated?
>
> See:
>
> http://www.xenomai.org/documentation/trunk/html/api/group__pod.html#gaed5=
776a428e7c59b52b1da76f0d765fa
>

Hmm, that doesn't make very clear why some values for "period" are accepted
and some others are not. Are they fixed? Are they calculated based on some
system-dependent calibration procedure?


> >
> > However, further down the program, supposing rt_task_set_periodic()
> failed
> > with the above result, calling
> >
> > rt_task_wait_period()
> >
> > will return EAGAIN, which is not documented in
> >
> http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga16=
45d3a072ef3cefeed3bcbb27dcf108
> > .
>
> That is because glibc choose to have EWOULDBLOCK =3D=3D EAGAIN. And
> EWOULDBLOCK is documented.
>
>
Ok, I see. This seems a bit confusing to me. What would happen if someone
were using a different libc than glibc? If the code is using EWOULDBLOCK al=
l
over the place then that's fine.

Finally, what do you think of extending:

-EWOULDBLOCK is returned if
rt_task_set_periodic()<http://www.xenomai.org/documentation/trunk/html/api/=
group__task.html#gababee94264156693cd4f5b9b70d3c5a1>has
not previously been called for the calling task.

to

-EWOULDBLOCK is returned either if
rt_task_set_periodic()<http://www.xenomai.org/documentation/trunk/html/api/=
group__task.html#gababee94264156693cd4f5b9b70d3c5a1>has
not previously been called for the calling task, or if a previous call
to that function failed.

Just for the sake of completeness ;)

Fernando

--bcaec520f1cf29362c04afd2886c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 21 de octubre de 2011 14:15, Gilles Chanteper=
drix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
rg">gilles.chanteperdrix@xenomai.org</a>&gt;</span> escribi=C3=B3:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 10/21/2011 06:04 PM, Fernando Herrero Carr=C3=B3n wrot=
e:<br>
&gt; Dear list,<br>
&gt;<br>
&gt; I am running xenomai-2.6-rc4 on an amd64 linux kernel version 2.6.38.8=
.<br>
&gt;<br>
&gt; I am setting up a periodic task using<br>
&gt;<br>
&gt; rt_task_set_periodic(NULL, TM_NOW, 11500);<br>
&gt;<br>
&gt; For period values smaller than 11450 I get an EINVAL return value. I&#=
39;ve got<br>
&gt; one question regarding this, and it&#39;s how is this threshold calcul=
ated?<br>
<br>
</div>See:<br>
<a href=3D"http://www.xenomai.org/documentation/trunk/html/api/group__pod.h=
tml#gaed5776a428e7c59b52b1da76f0d765fa" target=3D"_blank">http://www.xenoma=
i.org/documentation/trunk/html/api/group__pod.html#gaed5776a428e7c59b52b1da=
76f0d765fa</a><br>
<div class=3D"im"></div></blockquote><div><br>Hmm, that doesn&#39;t make ve=
ry clear why some values for &quot;period&quot; are accepted and some other=
s are not. Are they fixed? Are they calculated based on some system-depende=
nt calibration procedure?<br>
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt =
0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div =
class=3D"im">
&gt;<br>
&gt; However, further down the program, supposing rt_task_set_periodic() fa=
iled<br>
&gt; with the above result, calling<br>
&gt;<br>
&gt; rt_task_wait_period()<br>
&gt;<br>
&gt; will return EAGAIN, which is not documented in<br>
&gt; <a href=3D"http://www.xenomai.org/documentation/trunk/html/api/group__=
task.html#ga1645d3a072ef3cefeed3bcbb27dcf108" target=3D"_blank">http://www.=
xenomai.org/documentation/trunk/html/api/group__task.html#ga1645d3a072ef3ce=
feed3bcbb27dcf108</a><br>

&gt; .<br>
<br>
</div>That is because glibc choose to have EWOULDBLOCK =3D=3D EAGAIN. And<b=
r>
EWOULDBLOCK is documented.<br>
<br></blockquote></div><br>Ok, I see. This seems a bit confusing to me. Wha=
t would happen if someone were using a different libc than glibc? If the co=
de is using EWOULDBLOCK all over the place then that&#39;s fine.<br><br>
Finally, what do you think of extending:<br><br><div style=3D"margin-left: =
40px;">-EWOULDBLOCK is returned if <a class=3D"el" href=3D"http://www.xenom=
ai.org/documentation/trunk/html/api/group__task.html#gababee94264156693cd4f=
5b9b70d3c5a1" title=3D"Make a real-time task periodic.">rt_task_set_periodi=
c()</a> has not previously been called for the calling task.<br>
<br></div>to<br><div style=3D"margin-left: 40px;"><br>-EWOULDBLOCK is retur=
ned either if <a class=3D"el" href=3D"http://www.xenomai.org/documentation/=
trunk/html/api/group__task.html#gababee94264156693cd4f5b9b70d3c5a1" title=
=3D"Make a real-time task periodic.">rt_task_set_periodic()</a> has not pre=
viously been called for the calling task, or if a previous call to that fun=
ction failed.<br>
<br></div>Just for the sake of completeness ;)<br><br>Fernando<br>

--bcaec520f1cf29362c04afd2886c--

