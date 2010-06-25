MIME-Version: 1.0
In-Reply-To: <AANLkTimofdDy_OSC6dr_2l4X8vAn8oPsQdqVXrSWZ-2e@domain.hid>
References: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>
	<4C23B213.5080103@domain.hid>
	<AANLkTimofdDy_OSC6dr_2l4X8vAn8oPsQdqVXrSWZ-2e@domain.hid>
Date: Fri, 25 Jun 2010 09:42:25 +0200
Message-ID: <AANLkTikA0fz6Rt8-4NqaOGL7_b_UdbVzSXCRYxg8J68h@domain.hid>
From: Charles Clerdan <charles.clerdan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d99e8b896a890489d5e9a0
Subject: [Xenomai-help]  Some questions about Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6d99e8b896a890489d5e9a0
Content-Type: text/plain; charset=ISO-8859-1

> An off-topic remark: "actually" is a "faux-ami", it does not mean at all
> the same thing as "actuellement" in french.
>
>
Indeed...

>
> >
> > How can I detect that a Xenomai thread is in secondary mode (I try to use
> > RT_TASK_INFO but the value is always 0 even if I do non-RT call) ? And
> does
> > a mecanism like assertion exist in order to prevent this?
>
> You do not want to detect that a Xenomai thread is running in secondary
> mode, this can lead to crappy code which we do not want to cause you to
> write. What you may want, however, is to detect that a thread which you
> would want to run in primary mode has switched to secondary mode. For
> this, you should do what the file examples/native/sigdebug.c found in
> Xenomai sources does, or if you are using the POSIX skin, what is
> documented here:
>
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Using_the_PTHREAD_WARNSW_bit
> .
>
>
Ok, I will try this.


> >
> > I want to make an IT server as exemple, how can I get back some IT or
> > generate them from the ADEOS' I-pipe ?
>
> Well. You may theoretically use the native or POSIX API to handle
> interrupts (I guess by IT you mean interrupts?) in user-space, but it is
> discouraged. What you should do, however, is to write an RTDM driver. See:
>
> http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-and-Applications.pdf
>
> For the detailed documentations of the native, posix and RTDM skins, see:
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html
>
> --
>                                             Gilles.
>

Ok, Thank you for your answer.

And a last one (for now ...), I read here  :
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf
that :
*"When a realtime
task executes into the Linux domain on a given processor, the
Linux kernel as a whole inherits the realtime
priority of such task, and thus
competes for the CPU resource by priority with other realtime
tasks regardless of
the domain (i.e. Linux or Xenomai) they happen to belong to. In other words,
the
realtime
priority scheme enforced by the native API is consistent across domains. "*

I was thinking that Linux were a process of Xenomai with the lowest
effective priority, and a task in secondary mode were only in competition
with the others Linux threads (or others Xenomai thread in 2ndary mode). But
if I'm wrong, how can the 2 schedulers share ressources in order to keep a
hard real-time behaviour (at less for Xenomai tasks in 1st mode).

Charles

--0016e6d99e8b896a890489d5e9a0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><div class=3D"gmail_quote"><div class=3D"im"=
><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bord=
er-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">An off-topic rem=
ark: &quot;actually&quot; is a &quot;faux-ami&quot;, it does not mean at al=
l<br>


the same thing as &quot;actuellement&quot; in french.<br>
<div><br></div></blockquote></div><div><br>Indeed...<br>
</div><div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin: =
0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left:=
 1ex;"><div><br>
&gt;<br>
&gt; How can I detect that a Xenomai thread is in secondary mode (I try to =
use<br>
&gt; RT_TASK_INFO but the value is always 0 even if I do non-RT call) ? And=
 does<br>
&gt; a mecanism like assertion exist in order to prevent this?<br>
<br>
</div>You do not want to detect that a Xenomai thread is running in seconda=
ry<br>
mode, this can lead to crappy code which we do not want to cause you to<br>
write. What you may want, however, is to detect that a thread which you<br>
would want to run in primary mode has switched to secondary mode. For<br>
this, you should do what the file examples/native/sigdebug.c found in<br>
Xenomai sources does, or if you are using the POSIX skin, what is<br>
documented here:<br>
<a href=3D"http://www.xenomai.org/index.php/Porting_POSIX_applications_to_X=
enomai#Using_the_PTHREAD_WARNSW_bit" target=3D"_blank">http://www.xenomai.o=
rg/index.php/Porting_POSIX_applications_to_Xenomai#Using_the_PTHREAD_WARNSW=
_bit</a>.<br>


<div><br></div></blockquote></div><div><br>Ok, I will try this.<br>=A0</div=
><div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0=
pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;=
"><div>


&gt;<br>
&gt; I want to make an IT server as exemple, how can I get back some IT or<=
br>
&gt; generate them from the ADEOS&#39; I-pipe ?<br>
<br>
</div>Well. You may theoretically use the native or POSIX API to handle<br>
interrupts (I guess by IT you mean interrupts?) in user-space, but it is<br=
>
discouraged. What you should do, however, is to write an RTDM driver. See:<=
br>
<a href=3D"http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-an=
d-Applications.pdf" target=3D"_blank">http://www.xenomai.org/documentation/=
branches/v2.3.x/pdf/RTDM-and-Applications.pdf</a><br>
<br>
For the detailed documentations of the native, posix and RTDM skins, see:<b=
r>
<a href=3D"http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.=
html" target=3D"_blank">http://www.xenomai.org/documentation/xenomai-2.5/ht=
ml/api/index.html</a><br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote><br>
</div></div>Ok, Thank you for your answer.<br><br>And a last one (for now .=
..), I read here=A0 : <a href=3D"http://www.xenomai.org/documentation/branc=
hes/v2.3.x/pdf/Native-API-Tour-rev-C.pdf" target=3D"_blank">http://www.xeno=
mai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf</a><br>

that : <br><i>&quot;When a realtime<br>task executes into the Linux domain =
on a given processor, the<br>Linux kernel as a whole inherits the realtime<=
br>priority of such task, and thus<br>competes for the CPU resource by prio=
rity with other realtime<br>

tasks regardless of<br>the domain (i.e. Linux or Xenomai) they happen to be=
long to. In other words, the<br>realtime<br>priority scheme enforced by the=
 native API is consistent across domains. &quot;</i><br><br>I was thinking =
that Linux were a process of Xenomai with the lowest effective priority, an=
d a task in secondary mode were only in competition with the others Linux t=
hreads (or others Xenomai thread in 2ndary mode). But if I&#39;m wrong, how=
 can the 2 schedulers share ressources in order to keep a hard real-time be=
haviour (at less for Xenomai tasks in 1st mode).<br>
<font color=3D"#888888">
<br>Charles<br><br>
</font></div><br>

--0016e6d99e8b896a890489d5e9a0--

