MIME-Version: 1.0
In-Reply-To: <4DB143E8.3000900@domain.hid>
References: <BANLkTimmraMpqpZ2areb0z9aC2U19SE5_w@domain.hid>
	<4DB143E8.3000900@domain.hid>
Date: Fri, 22 Apr 2011 14:49:42 +0200
Message-ID: <BANLkTi=9PCgerpAwqzRgUii5ypxL5hmgnQ@mail.gmail.com>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec51ba1f5b48afe04a1814a06
Subject: Re: [Xenomai-help] first module help
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
Cc: xenomai@xenomai.org

--bcaec51ba1f5b48afe04a1814a06
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ok i'm sorry i wasn't clear at all...
my problem is : when i call readl in a rt_task, the task is stopped...
(maybe because the rt_task is launched in a module?)
"Xenomai: suspending kernel thread bf0041c8 ('test_rt') at 0xbf003824 after
exception #0"
if i remove the readl there is no problem

With a normal Linux, in a module there isn't any problem

thanks

2011/4/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Aurele Traynard wrote:
> > hello,
> >
> > I am new in xenomai, I am trying to make a module to read a "FPGA
> register"
> > who is on the "data bus".
> > without xenomai I use "ioremap" and "readl/writel" but with xenomai tho=
se
> > doesn't work...
> >
> > so i would like to know how i could read this register?
> > i would like to know if there is a book i could read?
>
>
> Ok. No answer, I probably started on the wrong foot. First, you should
> read the documents here:
>
> http://www.xenomai.org/index.php/Publications
> http://www.xenomai.org/index.php/Included_documentation_summary
>
> More generally, we try to have most ressources in the wiki
> http://www.xenomai.org
>
> Then, you will understand that your question is a bit vague. I recently
> answered the more precise question which you will probably have after
> you have read all this, see:
> https://mail.gna.org/public/xenomai-help/2011-04/msg00059.html
>
> > i would like to know if a rt_task can read/write memory allocated by th=
e
> > kernel ("kmalloc")?
>
> Yes, it can.
>
> > i would like to know if there are any forums where i could find any hel=
p?
> >
> > i would like to know a lots of things...
>
>
> This list is the right place to ask, but please take care of reading the
> documentation and especially the FAQ, in order to avoid asking questions
>  which have already been asked.
>
> http://www.xenomai.org/index.php/FAQs
>
>
> > thanks for any help
> >
> > Aur=E8le
> >
> > PS : http://www.captain.at/xenomai.php is dead...
>
> This site is not Xenomai website, so, there is nothing we can do about it=
.
>
>
> --
>                                             Gilles.
>
>

--bcaec51ba1f5b48afe04a1814a06
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ok i&#39;m sorry i wasn&#39;t clear at all...<br>my problem is : when i cal=
l readl in a rt_task, the task is stopped... (maybe because the rt_task is =
launched in a module?)<br>&quot;Xenomai: suspending kernel thread bf0041c8 =
(&#39;test_rt&#39;) at 0xbf003824 after exception #0&quot;<br>

if i remove the readl there is no problem<br><br>With a normal Linux, in a =
module there isn&#39;t any problem<br><br>thanks<br><br><div class=3D"gmail=
_quote">2011/4/22 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&=
gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">Aurele Traynard wrote:<br=
>
&gt; hello,<br>
&gt;<br>
&gt; I am new in xenomai, I am trying to make a module to read a &quot;FPGA=
 register&quot;<br>
&gt; who is on the &quot;data bus&quot;.<br>
&gt; without xenomai I use &quot;ioremap&quot; and &quot;readl/writel&quot;=
 but with xenomai those<br>
&gt; doesn&#39;t work...<br>
&gt;<br>
&gt; so i would like to know how i could read this register?<br>
&gt; i would like to know if there is a book i could read?<br>
<br>
<br>
</div>Ok. No answer, I probably started on the wrong foot. First, you shoul=
d<br>
read the documents here:<br>
<br>
<a href=3D"http://www.xenomai.org/index.php/Publications" target=3D"_blank"=
>http://www.xenomai.org/index.php/Publications</a><br>
<a href=3D"http://www.xenomai.org/index.php/Included_documentation_summary"=
 target=3D"_blank">http://www.xenomai.org/index.php/Included_documentation_=
summary</a><br>
<br>
More generally, we try to have most ressources in the wiki<br>
<a href=3D"http://www.xenomai.org" target=3D"_blank">http://www.xenomai.org=
</a><br>
<br>
Then, you will understand that your question is a bit vague. I recently<br>
answered the more precise question which you will probably have after<br>
you have read all this, see:<br>
<a href=3D"https://mail.gna.org/public/xenomai-help/2011-04/msg00059.html" =
target=3D"_blank">https://mail.gna.org/public/xenomai-help/2011-04/msg00059=
.html</a><br>
<div class=3D"im"><br>
&gt; i would like to know if a rt_task can read/write memory allocated by t=
he<br>
&gt; kernel (&quot;kmalloc&quot;)?<br>
<br>
</div>Yes, it can.<br>
<div class=3D"im"><br>
&gt; i would like to know if there are any forums where i could find any he=
lp?<br>
&gt;<br>
&gt; i would like to know a lots of things...<br>
<br>
<br>
</div>This list is the right place to ask, but please take care of reading =
the<br>
documentation and especially the FAQ, in order to avoid asking questions<br=
>
=A0which have already been asked.<br>
<br>
<a href=3D"http://www.xenomai.org/index.php/FAQs" target=3D"_blank">http://=
www.xenomai.org/index.php/FAQs</a><br>
<div class=3D"im"><br>
<br>
&gt; thanks for any help<br>
&gt;<br>
&gt; Aur=E8le<br>
&gt;<br>
&gt; PS : <a href=3D"http://www.captain.at/xenomai.php" target=3D"_blank">h=
ttp://www.captain.at/xenomai.php</a> is dead...<br>
<br>
</div>This site is not Xenomai website, so, there is nothing we can do abou=
t it.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br>

--bcaec51ba1f5b48afe04a1814a06--

