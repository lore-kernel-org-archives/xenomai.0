MIME-Version: 1.0
In-Reply-To: <4EA1BE4C.5030301@domain.hid>
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
	<4EA19A9D.1080502@domain.hid>
	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
	<4EA1B033.6060707@domain.hid>
	<CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>
	<4EA1BE4C.5030301@domain.hid>
Date: Fri, 21 Oct 2011 17:01:51 -0200
Message-ID: <CAMwkeZzPDN5TFKiU05tuZdW4=yHT1XoWe2=xwceiimRw-rF4_w@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520e627adf61e04afd3b4f1
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

--bcaec520e627adf61e04afd3b4f1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 21 de octubre de 2011 16:47, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> escribi=C3=B3:

> On 10/21/2011 08:08 PM, Fernando Herrero Carr=C3=B3n wrote:
> > Alright, excuse me, I missed that explanation.
> >
> > Then let me move to the actual figures at hand:
> >
> >  $ cat /proc/xenomai/latency
> > 3349
> >
> > and, as I explained above, all values below 11450 are being rejected in
> my
> > case.
>
> I guess you have to check the code to understand what happens. But
> really, running tasks with a 11500 period is already preposterous.


It's the very minimal example that I could come up with, I can attach the
code if you will. But there is not much more than mlockall(),
rt_task_shadow(), rt_task_set_periodic() and
while(){rt_tast_wait_period()}...

Why do you mean it is preposterous? Because it is not a round figure or
because it is too low? If you mean it is too low, well, I have a DAQ board
that can make acquisitions at up to 120kHz, which means a period of 8000 ns=
.
I want to achieve the fastest acquistion rate possible, and was pushing the
limits to see where xenomai could go.


> > my point of view. Especially when it refers to documentation, I believe
> that
> > "too much" is never too much.
>
> Conciseness is really important for a documentation, look at an example,
> the sentence explaining the -EINVAL return value for
> rt_task_make_periodic was a bit long, and you missed the important part,
> even though I had told you that it was where was the answer to your
> question. So, too much documentation is a problem, because users will
> inevitably miss what is important.
>
> Now look at an example outside Xenomai documentation:
>
> http://pubs.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_lo=
ck.html
>
> The documentation for EINVAL says:
> [EINVAL]
>    The value specified by mutex does not refer to an initialized mutex
> object.
>
> It does not say, "or an object for which pthread_mutex_init failed", it
> is pretty obvious that if pthread_mutex_init failed, the mutex is not
> initialized. period.
>
>
But it also does not say "pthread_mutex_init was not called"... It is
stating a precondition on the state of the program (or process, to be more
precise), not on the calling sequence of functions. Translating this to our
case, we could say "[EINVAL] The task has not been properly configured to
run in periodic mode.", or something like that, which includes both the cas=
e
of not calling the configuring function or that function failing.

Anyway, my suggestion was not such a big issue. It is ok for me to leave th=
e
documentation as it is.

Thanks for your attention,
Fernando

--bcaec520e627adf61e04afd3b4f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 21 de octubre de 2011 16:47, Gilles Chanteper=
drix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
rg">gilles.chanteperdrix@xenomai.org</a>&gt;</span> escribi=C3=B3:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 10/21/2011 08:08 PM, Fernando Herrero Carr=C3=B3n wrot=
e:<br>
&gt; Alright, excuse me, I missed that explanation.<br>
&gt;<br>
&gt; Then let me move to the actual figures at hand:<br>
&gt;<br>
&gt; =C2=A0$ cat /proc/xenomai/latency<br>
&gt; 3349<br>
&gt;<br>
&gt; and, as I explained above, all values below 11450 are being rejected i=
n my<br>
&gt; case.<br>
<br>
</div>I guess you have to check the code to understand what happens. But<br=
>
really, running tasks with a 11500 period is already preposterous.=C2=A0</b=
lockquote><div><br>It&#39;s the very minimal example that I could come up w=
ith, I can attach the code if you will. But there is not much more than mlo=
ckall(), rt_task_shadow(), rt_task_set_periodic() and while(){rt_tast_wait_=
period()}...<br>
<br>Why do you mean it is preposterous? Because it is not a round figure or=
 because it is too low? If you mean it is too low, well, I have a DAQ board=
 that can make acquisitions at up to 120kHz, which means a period of 8000 n=
s. I want to achieve the fastest acquistion rate possible, and was pushing =
the limits to see where xenomai could go.<br>
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt =
0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><=
div class=3D"im">
&gt; my point of view. Especially when it refers to documentation, I believ=
e that<br>
&gt; &quot;too much&quot; is never too much.<br>
<br>
</div>Conciseness is really important for a documentation, look at an examp=
le,<br>
the sentence explaining the -EINVAL return value for<br>
rt_task_make_periodic was a bit long, and you missed the important part,<br=
>
even though I had told you that it was where was the answer to your<br>
question. So, too much documentation is a problem, because users will<br>
inevitably miss what is important.<br>
<br>
Now look at an example outside Xenomai documentation:<br>
<a href=3D"http://pubs.opengroup.org/onlinepubs/000095399/functions/pthread=
_mutex_lock.html" target=3D"_blank">http://pubs.opengroup.org/onlinepubs/00=
0095399/functions/pthread_mutex_lock.html</a><br>
<br>
The documentation for EINVAL says:<br>
[EINVAL]<br>
 =C2=A0 =C2=A0The value specified by mutex does not refer to an initialized=
 mutex<br>
object.<br>
<br>
It does not say, &quot;or an object for which pthread_mutex_init failed&quo=
t;, it<br>
is pretty obvious that if pthread_mutex_init failed, the mutex is not<br>
initialized. period.<br>
<font color=3D"#888888"><br></font></blockquote><div><br>But it also does n=
ot say &quot;pthread_mutex_init was not called&quot;... It is stating a pre=
condition on the state of the program (or process, to be more precise), not=
 on the calling sequence of functions. Translating this to our case, we cou=
ld say &quot;[EINVAL] The task has not been properly configured to run in p=
eriodic mode.&quot;, or something like that, which includes both the case o=
f not calling the configuring function or that function failing.<br>
<br>Anyway, my suggestion was not such a big issue. It is ok for me to leav=
e the documentation as it is.<br><br>Thanks for your attention,<br>Fernando=
<br><br><br></div></div><br>

--bcaec520e627adf61e04afd3b4f1--

