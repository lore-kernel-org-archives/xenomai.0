MIME-Version: 1.0
Date: Wed, 18 Aug 2010 21:16:47 +0530
Message-ID: <AANLkTi=2kNE2KznfnY0voTbWMFqy5_LESXswjJ25O-hk@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5a8ed24d460048e1af96d
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
To: xenomai@xenomai.org

--001636c5a8ed24d460048e1af96d
Content-Type: text/plain; charset=ISO-8859-1

>
> prakash srinivasan wrote:
> >>>>> printf(TOTAL LOOP TIMING=%ld us\n",
> >>>>> (long)((rt_timer_ticks2ns(end-start))/1000);
> >>>> What does: printf(TOTAL LOOP TIMING=%lld us\n",
> >>>> rt_timer_ticks2ns(end-start)/1000); report.
> >>> TOTAL LOOP TIMING = 5377070 us In this case, the (unsigned)
> >>> (long) (long)tart returns 1069623206 and (unsigned) (long)
> >>> (long)end returns 2151726697
> >> Are you happy with that result? Did really pass approx. 5 seconds
> > between start and end?
>
> Could you format your mails correctly to make them readable? Use text,
> not HTML, truncate at 72 characters, and use > as a quotation mark,
> meaning that one '>' is the sign that you quote someone, two '>' is you
> quoting someone who quoted someone else, etc... I am really sorry to
> have to tell you about this, this is really basic knowledge of the
> netiquette, we should not have to tell you about it.
>
> > Definitely not and I am not confident about this output. Coz in this
> > loop period I am sending datas from client to the server. Visibly
> > noted that the server is getting all the datas within a second. So I
> > am not sure the 5 sec is the right output. I just like to know all
> > the above conversions are correct? and is it ok that the start ticks
> > can be more than the end ticks?
>
> The result of rt_timer_read is a long long, so, if you cast it to an
> unsigned, you loose the most significant bits. So, the result is totally
> meaningless. This again, is basic knowledge of the C language, we should
> not have to explain.
>
> Your bug report is quite insufficient, we do not even know what version
> of Xenomai you use, maybe you are reporting a bug which has been solved
> a long time ago. Neither do we know what version of Linux and of the
> Adoes patch you use, or the contents of your .config file. We do not
> have a self-contained example that we can run to try and reproduce your
> issue.
>
> So if you want some answers, please give us the means to answer you.
>

As an community person I AGREED with what you pointed out. My main
mistake was I subscribed the
mailing list with an useless mailID. Now I changed my mail ID. Surely
you will get the proper
quote in future. In between the mail change, I lost the continuation
for this topic and did not
get this reply mail to my new mail ID. Simply copy and pasted the last
mail from the archive.

Obviously I should improve my C language skills.

I am using linux kernel 2.6.30.8 on Ubuntu 8.04,
Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3

-Prakash

--001636c5a8ed24d460048e1af96d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


<blockquote style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">prakash srinivasa=
n wrote:<br>&gt;&gt;&gt;&gt;&gt; printf(TOTAL LOOP TIMING=3D%ld us\n&quot;,=
<br>
&gt;&gt;&gt;&gt;&gt; (long)((rt_timer_ticks2ns(end-start))/1000);<br>&gt;&g=
t;&gt;&gt; What does: printf(TOTAL LOOP TIMING=3D%lld us\n&quot;,<br>&gt;&g=
t;&gt;&gt; rt_timer_ticks2ns(end-start)/1000); report.<br>&gt;&gt;&gt; TOTA=
L LOOP TIMING =3D 5377070 us In this case, the (unsigned)<br>
&gt;&gt;&gt; (long) (long)tart returns 1069623206 and (unsigned) (long)<br>=
&gt;&gt;&gt; (long)end returns 2151726697<br>&gt;&gt; Are you happy with th=
at result? Did really pass approx. 5 seconds<br>&gt; between start and end?=
<br>
<br>Could you format your mails correctly to make them readable? Use text,<=
br>not HTML, truncate at 72 characters, and use &gt; as a quotation mark,<b=
r>meaning that one &#39;&gt;&#39; is the sign that you quote someone, two &=
#39;&gt;&#39; is you<br>
quoting someone who quoted someone else, etc... I am really sorry to<br>hav=
e to tell you about this, this is really basic knowledge of the<br>netiquet=
te, we should not have to tell you about it.<br><br>&gt; Definitely not and=
 I am not confident about this output. Coz in this<br>
&gt; loop period I am sending datas from client to the server. Visibly<br>&=
gt; noted that the server is getting all the datas within a second. So I<br=
>&gt; am not sure the 5 sec is the right output. I just like to know all<br=
>
&gt; the above conversions are correct? and is it ok that the start ticks<b=
r>&gt; can be more than the end ticks?<br><br>The result of rt_timer_read i=
s a long long, so, if you cast it to an<br>unsigned, you loose the most sig=
nificant bits. So, the result is totally<br>
meaningless. This again, is basic knowledge of the C language, we should<br=
>not have to explain.<br><br>Your bug report is quite insufficient, we do n=
ot even know what version<br>of Xenomai you use, maybe you are reporting a =
bug which has been solved<br>
a long time ago. Neither do we know what version of Linux and of the<br>Ado=
es patch you use, or the contents of your .config file. We do not<br>have a=
 self-contained example that we can run to try and reproduce your<br>issue.=
<br>
<br>So if you want some answers, please give us the means to answer you.<br=
></blockquote><pre style=3D"font-family: courier new,monospace;"><font size=
=3D"2"><font><br>As an community person I AGREED with what you pointed out.=
 My main mistake was I subscribed the<br>
mailing list with an useless mailID. Now I changed my mail ID. Surely you w=
ill get the proper <br>quote in future. In between the mail change, I lost =
the continuation for this topic and did not<br>get this reply mail to my ne=
w mail ID. Simply copy and pasted the last mail from the archive. </font></=
font>=A0<br>
</pre><font style=3D"font-family: courier new,monospace;" size=3D"2">
Obviously I should improve my C language skills.
<br><br>I am using linux kernel 2.6.30.8 on Ubuntu 8.04, Adeos-ipipe-2.6.30=
.8-x86-2.4-09.patch and Xenomai-2.5.3<br><br>-Prakash</font>
<br>

--001636c5a8ed24d460048e1af96d--

