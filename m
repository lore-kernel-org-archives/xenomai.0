MIME-Version: 1.0
In-Reply-To: <4C7BD811.9070403@domain.hid>
References: <AANLkTin4EBuE7jeKeeJorBVk+CGy=6w86o2_DzjHLdUs@domain.hid>
	<4C7BD811.9070403@domain.hid>
Date: Tue, 31 Aug 2010 10:25:49 +0530
Message-ID: <AANLkTing0uT_MwKPj2oKmAHAw5h3o3Hyfjk-0TqsZsf6@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5b8581054cf048f17655d
Subject: Re: [Xenomai-help] Xeno-test failed on ARM AT91RM9200 processor
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

--001636c5b8581054cf048f17655d
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 30, 2010 at 9:40 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Prakash A S wrote:
> > Hi,
> >     I am trying to port Xenomai-2.4.0 on ARM AT91RM9200 processor. I used
> > adeos-ipipe-2.6.20-arm-1.7-06.patch with Linux kernel 2.6.20.
>
> That is a useless effort, since that patch already contains a port of
> Xenomai on this processor. Besides, these versions are outdated.
>

Yes, Let it be. We already discussed more about it.
As I said it is just an try; not an permanent development part from my side.
I will move to the suggested method/versions shortly.


>
>  All the stuffs
> > went fine, compiled the kernel and ported on the same processor. The
> xenomai
> > components loaded fine while loading the kernel image. However when I
> > executed the xeno-test, I am getting the error,  "please build busybox's
> ash
> > with support for getopts" and quit the test.
> >
> > I am using BusyBox-1.15.3 enabled with GETOPT. I noticed that the
> "getopts"
> > link is not available with the busybox bin. But it has only "getopt". I
> > checked few other latest version of Busybox. But I could not find it in
> > other versions also. However the x86 desktop Linux contains both getopt
> and
> > getopts.
> >
> > Few online guides claimed that the getopts is builtin with Busybox. I
> > created an getopts softlink for busybox manually anf then tried the
> > xeno-test. But getting the error,  "getopts: applet not found". I could
> not
> > find the exact reason for this issue. I also tried to execute the tests
> > separately like latency, switchtest,.etc. But getting the same error,
> "syntax
> > error: word unexpected (expecting ")")".
> >
> > FYI, the busybox configured with ASH shell.
> >
> > Help me to solve the issues.
>
> Well this is an issue with busybox, which has nothing to do with
> Xenomai, so, you are posting on the wrong list.
>

Not sure! According to my search and try, the Busybox is not come-up with
"getopts". But it has "getopt". However I got this discussion from the
achieve, http://www.mail-archive.com/xenomai@xenomai.org and
Jan added "getopts" for busybox also. Just curious to know whether this
modifications tested with busybox?.

However few online resources claims that the Busybox ASH is not supporting
getopts; But it is available for Bash2 shell.

As you said, Busybox community is the right place to clear these
clarifications. I will also post the same query to the busybox community and
return back to you.

-Prakash

--001636c5b8581054cf048f17655d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 30, 2010 at 9:40 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Prakash A S wrote:<br>
&gt; Hi,<br>
&gt; =A0 =A0 I am trying to port Xenomai-2.4.0 on ARM AT91RM9200 processor.=
 I used<br>
&gt; adeos-ipipe-2.6.20-arm-1.7-06.patch with Linux kernel 2.6.20.<br>
<br>
</div>That is a useless effort, since that patch already contains a port of=
<br>
Xenomai on this processor. Besides, these versions are outdated.<br></block=
quote><div><br>Yes, Let it be. We already discussed more about it.<br>As I =
said it is just an try; not an permanent development part from my side. I w=
ill move to the suggested method/versions shortly.=A0 <br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
=A0All the stuffs<br>
&gt; went fine, compiled the kernel and ported on the same processor. The x=
enomai<br>
&gt; components loaded fine while loading the kernel image. However when I<=
br>
&gt; executed the xeno-test, I am getting the error, =A0&quot;please build =
busybox&#39;s ash<br>
&gt; with support for getopts&quot; and quit the test.<br>
&gt;<br>
&gt; I am using BusyBox-1.15.3 enabled with GETOPT. I noticed that the &quo=
t;getopts&quot;<br>
&gt; link is not available with the busybox bin. But it has only &quot;geto=
pt&quot;. I<br>
&gt; checked few other latest version of Busybox. But I could not find it i=
n<br>
&gt; other versions also. However the x86 desktop Linux contains both getop=
t and<br>
&gt; getopts.<br>
&gt;<br>
&gt; Few online guides claimed that the getopts is builtin with Busybox. I<=
br>
&gt; created an getopts softlink for busybox manually anf then tried the<br=
>
&gt; xeno-test. But getting the error, =A0&quot;getopts: applet not found&q=
uot;. I could not<br>
&gt; find the exact reason for this issue. I also tried to execute the test=
s<br>
&gt; separately like latency, switchtest,.etc. But getting the same error, =
&quot;syntax<br>
&gt; error: word unexpected (expecting &quot;)&quot;)&quot;.<br>
&gt;<br>
&gt; FYI, the busybox configured with ASH shell.<br>
&gt;<br>
&gt; Help me to solve the issues.<br>
<br>
</div>Well this is an issue with busybox, which has nothing to do with<br>
Xenomai, so, you are posting on the wrong list.<br></blockquote></div><br>N=
ot sure! According to my search and try, the Busybox is not come-up with &q=
uot;getopts&quot;. But it has &quot;getopt&quot;. However I got this discus=
sion from the achieve, <a href=3D"http://www.mail-archive.com/xenomai-core@=
gna.org/msg03362.html">http://www.mail-archive.com/xenomai@xenomai.org=
03362.html</a> and Jan added &quot;getopts&quot; for busybox also. Just cur=
ious to know whether this modifications tested with busybox?. <br>
<br>However few online resources claims that the Busybox ASH is not support=
ing getopts; But it is available for Bash2 shell. <br>=A0<br>As you said, B=
usybox community is the right place to clear these clarifications. I will a=
lso post the same query to the busybox community and return back to you. <b=
r>
<br>-Prakash<br><br>=A0 <br>

--001636c5b8581054cf048f17655d--

