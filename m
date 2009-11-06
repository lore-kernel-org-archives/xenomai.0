MIME-Version: 1.0
In-Reply-To: <4AF1591E.7080408@domain.hid>
References: <1f3e02580911040102r1dead1d3lbc66d9a4d9d26d33@domain.hid> 
	<4AF1591E.7080408@domain.hid>
From: Sergey Didenko <didenkos@domain.hid>
Date: Fri, 6 Nov 2009 10:49:45 +0900
Message-ID: <1f3e02580911051749v682be0f3j4dcffd1ebe344cc@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd32a9a1c96ff0477aa104b
Subject: Re: [Xenomai-help] [ARM_MV 88F6290] Task limit, msg receive error
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

--000e0cd32a9a1c96ff0477aa104b
Content-Type: text/plain; charset=UTF-8

2009/11/4 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Didenko Sergey wrote:
> > Dear Experts
>
> Hi, you do not need to flatter us to get answers :-)
>

Then, who are you if not the experts in Xenomai?
Do not be so modest ;-)


> >
> > we are facing 2 problems now:
> >
> > 1) in our test application (very simple one) we can create maximum 50
> > tasks, next task is failed to create with error *12*
> > *- Is there any task number limit?*
> > *- what does 12 mean?*
>
> Please read the TROUBLESHOOTING guide which comes with Xenomai, for the
> question about the task number limit.
>

So, to solve that problem we did try, as guide says: "A work-around consists
of setting a
lower user-limit for initial stack allocation, like calling "ulimit
-s <initial-size-in-kbytes>" in your parent shell before running
your application", but it did not help at all.

We were able to increase the number of created tasks by increasing the value
of CONFIG_XENO_OPT_SYS_HEAPSZ and CONFIG_XENO_OPT_REGESTRY_NRSLOTS in
configuration for kernel.
For instance, in our test application, finally, we were able to create up to
500 tasks (stack is 10 KB) when options were like
CONFIG_XENO_OPT_SYS_HEAPSZ = 4096
CONFIG_XENO_OPT_REGESTRY_NRSLOTS = 1024


> For the error codes, see:
> http://www.xenomai.org/index.php/Resolving_Error_Codes
>
> >
> > 2) in our project (originally developed for VxWorks), msgQReceive
> > function returns -1 and sets errno to 4
> > *We think that it might be related to XNBREAK thread's flag.*
>
> Yes, error 4 is EINTR, it means that msgQReceive was interrupted by a
> signal. We can only tell you whether this is normal if you tell us in
> exactly what conditions you get this error (a test case reduced to the
> minimum would be welcome).
>
> It was our application's problem, now it is solved.

Sergey

--000e0cd32a9a1c96ff0477aa104b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/11/4 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

Didenko Sergey wrote:<br>
&gt; Dear Experts<br>
<br>
Hi, you do not need to flatter us to get answers :-)<br></blockquote><div>=
=C2=A0</div><div>Then, who are you if not the experts in Xenomai?</div><div=
>Do not be so modest ;-)</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;=
">


<div class=3D"im"><br>
&gt;<br>
&gt; we are facing 2 problems now:<br>
&gt;<br>
&gt; 1) in our test application (very simple one) we can create maximum 50<=
br>
&gt; tasks, next task is failed to create with error *12*<br>
&gt; *- Is there any task number limit?*<br>
</div>&gt; *- what does 12 mean?*<br>
<br>
Please read the TROUBLESHOOTING guide which comes with Xenomai, for the<br>
question about the task number limit.<br></blockquote><div><br></div><div>S=
o, to solve that problem we did try, as guide says: &quot;A work-around con=
sists of setting a</div><div><div>lower user-limit for initial stack alloca=
tion, like calling &quot;ulimit -s=C2=A0&lt;initial-size-in-kbytes&gt;&quot=
; in your parent shell before running your=C2=A0application&quot;, but it d=
id not help at all.</div>

<div><br></div><div>We were able to increase the number of created tasks by=
 increasing the value of CONFIG_XENO_OPT_SYS_HEAPSZ and=C2=A0CONFIG_XENO_OP=
T_REGESTRY_NRSLOTS in configuration for kernel.</div><div>For instance, in =
our test application, finally, we were able to create up to 500 tasks (stac=
k is 10 KB) when options were like</div>

<div>CONFIG_XENO_OPT_SYS_HEAPSZ =3D 4096</div><div>CONFIG_XENO_OPT_REGESTRY=
_NRSLOTS =3D 1024</div><div><br></div></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"=
>
<br>
For the error codes, see:<br>
<a href=3D"http://www.xenomai.org/index.php/Resolving_Error_Codes" target=
=3D"_blank">http://www.xenomai.org/index.php/Resolving_Error_Codes</a><br>
<div class=3D"im"><br>
&gt;<br>
&gt; 2) in our project (originally developed for VxWorks), msgQReceive<br>
&gt; function returns -1 and sets errno to 4<br>
</div>&gt; *We think that it might be related to XNBREAK thread&#39;s flag.=
*<br>
<br>
Yes, error 4 is EINTR, it means that msgQReceive was interrupted by a<br>
signal. We can only tell you whether this is normal if you tell us in<br>
exactly what conditions you get this error (a test case reduced to the<br>
minimum would be welcome).<br>
<br></blockquote><div>It was our application&#39;s problem, now it is solve=
d.</div><div><br></div><div>Sergey</div></div>

--000e0cd32a9a1c96ff0477aa104b--

