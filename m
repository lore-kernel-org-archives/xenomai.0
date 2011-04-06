Message-ID: <BLU0-SMTP74AA1DAE7E44EF487B424DBDA50@domain.hid>
MIME-Version: 1.0
In-Reply-To: <4D9CA930.3000204@domain.hid>
References: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
	<4D9CA930.3000204@domain.hid>
Date: Wed, 6 Apr 2011 19:31:11 +0100
From: krishna murthy j s <krishnamurthyjs@domain.hid>
Content-Type: multipart/alternative; boundary="00151747864c75a13c04a044325a"
Subject: Re: [Xenomai-core] Backfire: User <-> Kernel latancy mesurement
 tool on Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--00151747864c75a13c04a044325a
Content-Type: text/plain; charset="ISO-8859-1"

Thanks for the reply. Can you please tell me why my questions are useless.
Such attitude will take Xenomai user group no where.

On Wed, Apr 6, 2011 at 6:56 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> krishna m wrote:
> > I ported the backfire tool in the OSADL site [
> https://www.osadl.org/backfire-4.backfire.0.html] to measure the user
> to/from kernel latency.I wanted to measure the difference between the
> RT_PREEMPT kernel and Xenomai Kernel. Surprisingly i see RT_PREEMPT
> performance better than Xenomai.
> >
> > Here are few points to note:
> > 1. The thread priority of the "sendme" tool of backfire in RT_PREEMPT is
> 99 [highest]
> > 2. I have made the thread priority 99 for the rt_task that i spawn [par
> of ported sendme]
> > ret = rt_task_shadow(&rt_task_desc, NULL, 99, 0);
> >
> > My Questions:
> > * I wanted to know if any one has done such measurements using backfire
> and how dose Xenomai fair agnist RT_PREEMPT?
> > * is there any similar tool like backfire in the Xenomai tool set that
> dose the similar measurements?
> > * Do I need to do more Xenomai specific optimization in the "sendme" and
> "backfire" code to get better performance?
>
> Useless notes, useless questions. Show us the "ported" code.
>
>
> --
>                                             Gilles.
>
>

--00151747864c75a13c04a044325a
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Thanks for the reply. Can you please tell me why=
 my questions are useless. Such attitude will take Xenomai user group no wh=
ere. <br><br>On Wed, Apr 6, 2011 at 6:56 PM, Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">krishna m=
 wrote:<br>
&gt; I ported the backfire tool in the OSADL site [<a href=3D"https://www.o=
sadl.org/backfire-4.backfire.0.html" target=3D"_blank">https://www.osadl.or=
g/backfire-4.backfire.0.html</a>] to measure the user to/from kernel latenc=
y.I wanted to measure the difference between the RT_PREEMPT kernel and Xeno=
mai Kernel. Surprisingly i see RT_PREEMPT performance better than Xenomai.<=
br>

&gt;<br>
&gt; Here are few points to note:<br>
&gt; 1. The thread priority of the &quot;sendme&quot; tool of backfire in R=
T_PREEMPT is 99 [highest]<br>
&gt; 2. I have made the thread priority 99 for the rt_task that i spawn [pa=
r of ported sendme]<br>
&gt; ret =3D rt_task_shadow(&amp;rt_task_desc, NULL, 99, 0);<br>
&gt;<br>
&gt; My Questions:<br>
&gt; * I wanted to know if any one has done such measurements using backfir=
e and how dose Xenomai fair agnist RT_PREEMPT?<br>
&gt; * is there any similar tool like backfire in the Xenomai tool set that=
 dose the similar measurements?<br>
&gt; * Do I need to do more Xenomai specific optimization in the &quot;send=
me&quot; and &quot;backfire&quot; code to get better performance?<br>
<br>
</div></div>Useless notes, useless questions. Show us the &quot;ported&quot=
; code.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br>

--00151747864c75a13c04a044325a--

