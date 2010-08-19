MIME-Version: 1.0
In-Reply-To: <4C6C019D.1040406@domain.hid>
References: <AANLkTi=2kNE2KznfnY0voTbWMFqy5_LESXswjJ25O-hk@domain.hid>
	<4C6C019D.1040406@domain.hid>
Date: Thu, 19 Aug 2010 13:21:28 +0530
Message-ID: <AANLkTi=uuzsAsgt8mk04VJE0-tmd1YQ5KoiTu3a-dO3v@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5b3552ae2f2048e28733b
Subject: Re: [Xenomai-help] Timing calculation
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

--001636c5b3552ae2f2048e28733b
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 18, 2010 at 9:21 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Prakash A S wrote:
> >     prakash srinivasan wrote:
> >     >>>>> printf(TOTAL LOOP TIMING=%ld us\n",
> >     >>>>> (long)((rt_timer_ticks2ns(end-start))/1000);
> >     >>>> What does: printf(TOTAL LOOP TIMING=%lld us\n",
> >     >>>> rt_timer_ticks2ns(end-start)/1000); report.
> >     >>> TOTAL LOOP TIMING = 5377070 us In this case, the (unsigned)
> >     >>> (long) (long)tart returns 1069623206 and (unsigned) (long)
> >     >>> (long)end returns 2151726697
> >     >> Are you happy with that result? Did really pass approx. 5 seconds
> >     > between start and end?
> >
> >     Could you format your mails correctly to make them readable? Use
> text,
> >     not HTML, truncate at 72 characters, and use > as a quotation mark,
> >     meaning that one '>' is the sign that you quote someone, two '>' is
> you
> >     quoting someone who quoted someone else, etc... I am really sorry to
> >     have to tell you about this, this is really basic knowledge of the
> >     netiquette, we should not have to tell you about it.
> >
> >     > Definitely not and I am not confident about this output. Coz in
> this
> >     > loop period I am sending datas from client to the server. Visibly
> >     > noted that the server is getting all the datas within a second. So
> I
> >     > am not sure the 5 sec is the right output. I just like to know all
> >     > the above conversions are correct? and is it ok that the start
> ticks
> >     > can be more than the end ticks?
> >
> >     The result of rt_timer_read is a long long, so, if you cast it to an
> >     unsigned, you loose the most significant bits. So, the result is
> totally
> >     meaningless. This again, is basic knowledge of the C language, we
> should
> >     not have to explain.
> >
> >     Your bug report is quite insufficient, we do not even know what
> version
> >     of Xenomai you use, maybe you are reporting a bug which has been
> solved
> >     a long time ago. Neither do we know what version of Linux and of the
> >     Adoes patch you use, or the contents of your .config file. We do not
> >     have a self-contained example that we can run to try and reproduce
> your
> >     issue.
> >
> >     So if you want some answers, please give us the means to answer you.
> >
> >
> > As an community person I AGREED with what you pointed out. My main
> mistake was I subscribed the
> >
> > mailing list with an useless mailID. Now I changed my mail ID. Surely you
> will get the proper
> > quote in future. In between the mail change, I lost the continuation for
> this topic and did not
> > get this reply mail to my new mail ID. Simply copy and pasted the last
> mail from the archive.
>
> We still receive HTML.
>

May be because of simply copy and pasted the old content in the last thread.

How about the scenario now?.


>
> >
> > Obviously I should improve my C language skills.
> >
> > I am using linux kernel 2.6.30.8 on Ubuntu 8.04,
> > Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3
>
> What about the kernel configuration and self-contained test exhibiting
> the behaviour you do not understand?
>

My .config file is here, http://pastebin.ca/1919917
I tested and understand few test cases below.
switchtest : I am using Intel Dual core processor. ~5731 context switches
happening in a second
cyclictest : Tested with 10 threads. Maximum timer latency is 38us and
minimum is 1us
clocktest : Simply prints the time offset, drift value and wraps compare
with normal linux's gettimeofday(). Not much understand from this test.
latency : user mode latency test provides maximum latency time is 15us.
latency : kernel mode latency test provides maximum latency time is 3.6 us
latency : timer mode latency test provides maximum latency time is 3 us

Not much understand about the clocktest.
More helpful if we have any documentations for the all tests rather than how
to use the tests.

-Prakash

--001636c5b3552ae2f2048e28733b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 18, 2010 at 9:21 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">Prakash A S wrote:<br>
&gt; =A0 =A0 prakash srinivasan wrote:<br>
&gt; =A0 =A0 &gt;&gt;&gt;&gt;&gt; printf(TOTAL LOOP TIMING=3D%ld us\n&quot;=
,<br>
&gt; =A0 =A0 &gt;&gt;&gt;&gt;&gt; (long)((rt_timer_ticks2ns(end-start))/100=
0);<br>
&gt; =A0 =A0 &gt;&gt;&gt;&gt; What does: printf(TOTAL LOOP TIMING=3D%lld us=
\n&quot;,<br>
&gt; =A0 =A0 &gt;&gt;&gt;&gt; rt_timer_ticks2ns(end-start)/1000); report.<b=
r>
&gt; =A0 =A0 &gt;&gt;&gt; TOTAL LOOP TIMING =3D 5377070 us In this case, th=
e (unsigned)<br>
&gt; =A0 =A0 &gt;&gt;&gt; (long) (long)tart returns 1069623206 and (unsigne=
d) (long)<br>
&gt; =A0 =A0 &gt;&gt;&gt; (long)end returns 2151726697<br>
&gt; =A0 =A0 &gt;&gt; Are you happy with that result? Did really pass appro=
x. 5 seconds<br>
&gt; =A0 =A0 &gt; between start and end?<br>
&gt;<br>
&gt; =A0 =A0 Could you format your mails correctly to make them readable? U=
se text,<br>
&gt; =A0 =A0 not HTML, truncate at 72 characters, and use &gt; as a quotati=
on mark,<br>
&gt; =A0 =A0 meaning that one &#39;&gt;&#39; is the sign that you quote som=
eone, two &#39;&gt;&#39; is you<br>
&gt; =A0 =A0 quoting someone who quoted someone else, etc... I am really so=
rry to<br>
&gt; =A0 =A0 have to tell you about this, this is really basic knowledge of=
 the<br>
&gt; =A0 =A0 netiquette, we should not have to tell you about it.<br>
&gt;<br>
&gt; =A0 =A0 &gt; Definitely not and I am not confident about this output. =
Coz in this<br>
&gt; =A0 =A0 &gt; loop period I am sending datas from client to the server.=
 Visibly<br>
&gt; =A0 =A0 &gt; noted that the server is getting all the datas within a s=
econd. So I<br>
&gt; =A0 =A0 &gt; am not sure the 5 sec is the right output. I just like to=
 know all<br>
&gt; =A0 =A0 &gt; the above conversions are correct? and is it ok that the =
start ticks<br>
&gt; =A0 =A0 &gt; can be more than the end ticks?<br>
&gt;<br>
&gt; =A0 =A0 The result of rt_timer_read is a long long, so, if you cast it=
 to an<br>
&gt; =A0 =A0 unsigned, you loose the most significant bits. So, the result =
is totally<br>
&gt; =A0 =A0 meaningless. This again, is basic knowledge of the C language,=
 we should<br>
&gt; =A0 =A0 not have to explain.<br>
&gt;<br>
&gt; =A0 =A0 Your bug report is quite insufficient, we do not even know wha=
t version<br>
&gt; =A0 =A0 of Xenomai you use, maybe you are reporting a bug which has be=
en solved<br>
&gt; =A0 =A0 a long time ago. Neither do we know what version of Linux and =
of the<br>
&gt; =A0 =A0 Adoes patch you use, or the contents of your .config file. We =
do not<br>
&gt; =A0 =A0 have a self-contained example that we can run to try and repro=
duce your<br>
&gt; =A0 =A0 issue.<br>
&gt;<br>
&gt; =A0 =A0 So if you want some answers, please give us the means to answe=
r you.<br>
&gt;<br>
&gt;<br>
&gt; As an community person I AGREED with what you pointed out. My main mis=
take was I subscribed the<br>
&gt;<br>
&gt; mailing list with an useless mailID. Now I changed my mail ID. Surely =
you will get the proper<br>
&gt; quote in future. In between the mail change, I lost the continuation f=
or this topic and did not<br>
&gt; get this reply mail to my new mail ID. Simply copy and pasted the last=
 mail from the archive.<br>
<br>
</div></div>We still receive HTML.<br></blockquote><div><br>May be because =
of simply copy and pasted the old content in the last thread. <br>How about=
 the scenario now?.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">

<div class=3D"im"><br>
&gt;<br>
&gt; Obviously I should improve my C language skills.<br>
&gt;<br>
&gt; I am using linux kernel 2.6.30.8 on Ubuntu 8.04,<br>
&gt; Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3<br>
<br>
</div>What about the kernel configuration and self-contained test exhibitin=
g<br>
the behaviour you do not understand?<br></blockquote><div><br></div></div>M=
y .config file is here, <a href=3D"http://pastebin.ca/1919917">http://paste=
bin.ca/1919917</a><br>I tested and understand few test cases below.<br>swit=
chtest : I am using Intel Dual core processor. ~5731 context switches happe=
ning in a second<br>
cyclictest : Tested with 10 threads. Maximum timer latency is 38us and mini=
mum is 1us<br>clocktest : Simply prints the time offset, drift value and wr=
aps compare with normal linux&#39;s gettimeofday(). Not much understand fro=
m this test.<br>
latency : user mode latency test provides maximum latency time is 15us.<br>=
latency : kernel mode latency test provides maximum latency time is 3.6 us<=
br>latency : timer mode latency test provides maximum latency time is 3 us<=
br>
<br>Not much understand about the clocktest. <br>More helpful if we have an=
y documentations for the all tests rather than how to use the tests.<br><br=
>-Prakash<br>=A0<br><pre><br></pre>=20

--001636c5b3552ae2f2048e28733b--

