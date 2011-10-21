MIME-Version: 1.0
In-Reply-To: <4EA1B033.6060707@domain.hid>
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
	<4EA19A9D.1080502@domain.hid>
	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
	<4EA1B033.6060707@domain.hid>
Date: Fri, 21 Oct 2011 16:08:10 -0200
Message-ID: <CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=f46d04170619b72b4f04afd2f47b
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

--f46d04170619b72b4f04afd2f47b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 21 de octubre de 2011 15:47, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> escribi=C3=B3:

> On 10/21/2011 07:37 PM, Fernando Herrero Carr=C3=B3n wrote:
> > El 21 de octubre de 2011 14:15, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> escribi=C3=B3:
> >
> >> On 10/21/2011 06:04 PM, Fernando Herrero Carr=C3=B3n wrote:
> >>> Dear list,
> >>>
> >>> I am running xenomai-2.6-rc4 on an amd64 linux kernel version 2.6.38.=
8.
> >>>
> >>> I am setting up a periodic task using
> >>>
> >>> rt_task_set_periodic(NULL, TM_NOW, 11500);
> >>>
> >>> For period values smaller than 11450 I get an EINVAL return value. I'=
ve
> >> got
> >>> one question regarding this, and it's how is this threshold calculate=
d?
> >>
> >> See:
> >>
> >>
> http://www.xenomai.org/documentation/trunk/html/api/group__pod.html#gaed5=
776a428e7c59b52b1da76f0d765fa
> >>
> >
> > Hmm, that doesn't make very clear why some values for "period" are
> accepted
> > and some others are not. Are they fixed? Are they calculated based on
> some
> > system-dependent calibration procedure?
>
> Summarized version: "-EINVAL is returned if (...) period is different
> from TM_INFINITE but shorter than the scheduling latency value for the
> target system, as available from /proc/xenomai/latency"
>
> I do not see how it could be made more clear.
>

Alright, excuse me, I missed that explanation.

Then let me move to the actual figures at hand:

 $ cat /proc/xenomai/latency
3349

and, as I explained above, all values below 11450 are being rejected in my
case.



> >
> >
> >>>
> >>> However, further down the program, supposing rt_task_set_periodic()
> >> failed
> >>> with the above result, calling
> >>>
> >>> rt_task_wait_period()
> >>>
> >>> will return EAGAIN, which is not documented in
> >>>
> >>
> http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga16=
45d3a072ef3cefeed3bcbb27dcf108
> >>> .
> >>
> >> That is because glibc choose to have EWOULDBLOCK =3D=3D EAGAIN. And
> >> EWOULDBLOCK is documented.
> >>
> >>
> > Ok, I see. This seems a bit confusing to me. What would happen if someo=
ne
> > were using a different libc than glibc? If the code is using EWOULDBLOC=
K
> all
> > over the place then that's fine.
> >
> > Finally, what do you think of extending:
>
> I find the current version perfectly clear and find no reason to extend
> it this way. Having called a function which failed should be equivalent
> to not having called the function, in any reasonable API.
>

>From the system's perspective this is true. I mean, they should be
equivalent in the sense that the state of the system should be the same
after "not calling" a function and after calling that function and having i=
t
fail.

I disagree from a developer/debugger perspective. When tracing errors that
depend on the execution history of your program, it is not the same to not
call a function than to call it and have a bug in your error correction
code. Because if you have a function failing and you are aware that all the
preconditions for it are met, you will most surely look for the source of
your error somewhere else. If at some point you are pointed to one of those
preconditions not being met, then finding the solution becomes easier. So
considering the programmer's state of mind, I don't feel both situations ar=
e
equivalent. I don't mean to be too picky on this one, I just want to explai=
n
my point of view. Especially when it refers to documentation, I believe tha=
t
"too much" is never too much.

Not checking services return values, and continuing anyway in case of
> error is a bad programming habit, especially when writing "critical" code=
.
>

Well, this I know, but as a library designer you should not rely on your
users exhibiting best practices for your library to be correct and complete=
.
And your piece of advice does in no way preclude you from providing the mos=
t
complete documentation possible.

Fernando

--f46d04170619b72b4f04afd2f47b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">El 21 de octubre de 2011 15:47, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> escribi=C3=B3:<=
br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bo=
rder-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 10/21/2011 07:37 PM, Fernando Herrero Carr=C3=B3n wrot=
e:<br>
&gt; El 21 de octubre de 2011 14:15, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; escribi=C3=B3:<br>
&gt;<br>
&gt;&gt; On 10/21/2011 06:04 PM, Fernando Herrero Carr=C3=B3n wrote:<br>
&gt;&gt;&gt; Dear list,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am running xenomai-2.6-rc4 on an amd64 linux kernel version =
2.6.38.8.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am setting up a periodic task using<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; rt_task_set_periodic(NULL, TM_NOW, 11500);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For period values smaller than 11450 I get an EINVAL return va=
lue. I&#39;ve<br>
&gt;&gt; got<br>
&gt;&gt;&gt; one question regarding this, and it&#39;s how is this threshol=
d calculated?<br>
&gt;&gt;<br>
&gt;&gt; See:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.xenomai.org/documentation/trunk/html/api/gro=
up__pod.html#gaed5776a428e7c59b52b1da76f0d765fa" target=3D"_blank">http://w=
ww.xenomai.org/documentation/trunk/html/api/group__pod.html#gaed5776a428e7c=
59b52b1da76f0d765fa</a><br>

&gt;&gt;<br>
&gt;<br>
&gt; Hmm, that doesn&#39;t make very clear why some values for &quot;period=
&quot; are accepted<br>
&gt; and some others are not. Are they fixed? Are they calculated based on =
some<br>
&gt; system-dependent calibration procedure?<br>
<br>
</div>Summarized version: &quot;-EINVAL is returned if (...) period is diff=
erent<br>
from TM_INFINITE but shorter than the scheduling latency value for the<br>
target system, as available from /proc/xenomai/latency&quot;<br>
<br>
I do not see how it could be made more clear.<br></blockquote><div><br>Alri=
ght, excuse me, I missed that explanation.<br><br>Then let me move to the a=
ctual figures at hand:<br><br><div style=3D"margin-left: 40px;">=C2=A0$ cat=
 /proc/xenomai/latency <br>
3349<br><br></div>and, as I explained above, all values below 11450 are bei=
ng rejected in my case.<br></div><div><br>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb=
(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">
&gt;<br>
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; However, further down the program, supposing rt_task_set_perio=
dic()<br>
&gt;&gt; failed<br>
&gt;&gt;&gt; with the above result, calling<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; rt_task_wait_period()<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; will return EAGAIN, which is not documented in<br>
&gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.xenomai.org/documentation/trunk/html/api/gro=
up__task.html#ga1645d3a072ef3cefeed3bcbb27dcf108" target=3D"_blank">http://=
www.xenomai.org/documentation/trunk/html/api/group__task.html#ga1645d3a072e=
f3cefeed3bcbb27dcf108</a><br>

&gt;&gt;&gt; .<br>
&gt;&gt;<br>
&gt;&gt; That is because glibc choose to have EWOULDBLOCK =3D=3D EAGAIN. An=
d<br>
&gt;&gt; EWOULDBLOCK is documented.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Ok, I see. This seems a bit confusing to me. What would happen if some=
one<br>
&gt; were using a different libc than glibc? If the code is using EWOULDBLO=
CK all<br>
&gt; over the place then that&#39;s fine.<br>
&gt;<br>
&gt; Finally, what do you think of extending:<br>
<br>
</div>I find the current version perfectly clear and find no reason to exte=
nd<br>
it this way. Having called a function which failed should be equivalent<br>
to not having called the function, in any reasonable API.<br></blockquote><=
div><br>From the system&#39;s perspective this is true. I mean, they should=
 be equivalent in the sense that the state of the system should be the same=
 after &quot;not calling&quot; a function and after calling that function a=
nd having it fail.<br>
<br>I disagree from a developer/debugger perspective. When tracing errors t=
hat depend on the execution history of your program, it is not the same to =
not call a function than to call it and have a bug in your error correction=
 code. Because if you have a function failing and you are aware that all th=
e preconditions for it are met, you will most surely look for the source of=
 your error somewhere else. If at some point you are pointed to one of thos=
e preconditions not being met, then finding the solution becomes easier. So=
 considering the programmer&#39;s state of mind, I don&#39;t feel both situ=
ations are equivalent. I don&#39;t mean to be too picky on this one, I just=
 want to explain my point of view. Especially when it refers to documentati=
on, I believe that &quot;too much&quot; is never too much.<br>
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt=
 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1e=
x;">
Not checking services return values, and continuing anyway in case of<br>
error is a bad programming habit, especially when writing &quot;critical&qu=
ot; code.<font color=3D"#888888"><br>
</font></blockquote></div><br>Well, this I know, but as a library designer =
you should not rely on your users exhibiting best practices for your librar=
y to be correct and complete. And your piece of advice does in no way precl=
ude you from providing the most complete documentation possible.<br>
<br>Fernando<br>

--f46d04170619b72b4f04afd2f47b--

