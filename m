MIME-Version: 1.0
In-Reply-To: <4B7657E2.6000901@domain.hid>
References: <1f3e02581002110136x481f99cby7edbb811af7f905b@domain.hid> 
	<4B73ED7A.9090803@domain.hid>
	<1f3e02581002121826j9341915v1349a2188e75927@domain.hid> 
	<4B7657E2.6000901@domain.hid>
From: Sergey Didenko <didenkos@domain.hid>
Date: Sat, 13 Feb 2010 16:56:44 +0900
Message-ID: <1f3e02581002122356o54cc9f38ge7cfd7af0811ee59@domain.hid>
Content-Type: multipart/alternative; boundary=001636e0a7a8d29cea047f76bad5
Subject: Re: [Xenomai-help] [ARM-MV88F6290] Xenomai 2.5.1 latency test
	results (still negative and huge)
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

--001636e0a7a8d29cea047f76bad5
Content-Type: text/plain; charset=UTF-8

Hi Gilles

On 13 February 2010 16:42, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Sergey Didenko wrote:
> > Thank you, Gilles
> >
> > 1) Yeah, I understand that my application (originally written for
> VxWorks)
> > is not adapted somehow to work properly under Xenomai (the threads are
> > switching to secondary mode very often, for example)..ok..but, test
> > application is also running under xenomai and if I define the highest
> > priority for my test task it should show the best latency it can ever get
> > from Xenomai, I'm I right?
> > Could you please comment what kind of BUG I should try find out...in how
> > should I optimize my application?
>
> The bug is not in the applications, since the application in question
> (latency) is running fine on other platforms, including ARM ones. The
> bug is in your port.


Ok, than...my previous questions was like "what cause such huge latencies,
especially negative?" and there were no any hints from you on it like "what
I have to focus on to fix it" please give me some!
What is wrong with the timer or interrupts, what kind of problem is there?
Help me to understand, guys!
I'm new in this area, but I'm eager to find and solve this problem, just
give me some tips where to dig.

> 2) which options you usualy use for diff command to make the proper (I
> mean
> > the format which is commonly used by Xenomai guys) diff file?
>
> diff -u
> git diff does it just fine. And if you do not use git, you should.


I'm using git, but not so a long time to know all the beauty of it, thanks a
lot!

Thank you in advance for support.
Sergey.

--001636e0a7a8d29cea047f76bad5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Gilles<br><br><div class=3D"gmail_quote">On 13 February 2010 16:42, Gill=
es Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdr=
ix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex;">

<div class=3D"im">Sergey Didenko wrote:<br>
&gt; Thank you, Gilles<br>
&gt;<br>
&gt; 1) Yeah, I understand that my application (originally written for VxWo=
rks)<br>
&gt; is not adapted somehow to work properly under Xenomai (the threads are=
<br>
&gt; switching to secondary mode very often, for example)..ok..but, test<br=
>
&gt; application is also running under xenomai and if I define the highest<=
br>
&gt; priority for my test task it should show the best latency it can ever =
get<br>
&gt; from Xenomai, I&#39;m I right?<br>
&gt; Could you please comment what kind of BUG I should try find out...in h=
ow<br>
&gt; should I optimize my application?<br>
<br>
</div>The bug is not in the applications, since the application in question=
<br>
(latency) is running fine on other platforms, including ARM ones. The<br>
bug is in your port.</blockquote><div>=C2=A0</div><div>Ok, than...my previo=
us questions was like &quot;what cause such huge latencies, especially nega=
tive?&quot; and there were no any hints from you on it like &quot;what I ha=
ve to focus on to fix it&quot; please give me some!</div>

<div>What is wrong with the timer or interrupts, what kind of problem is th=
ere? Help me to understand, guys!</div><div>I&#39;m new in this area, but I=
&#39;m eager to find and solve this problem, just give me some tips where t=
o dig.</div>

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im">
&gt; 2) which options you usualy use for diff command to make the proper (I=
 mean<br>
&gt; the format which is commonly used by Xenomai guys) diff file?<br>
<br>
</div>diff -u<br>
git diff does it just fine. And if you do not use git, you should.</blockqu=
ote><div>=C2=A0=C2=A0</div><div>I&#39;m using git, but not so a long time t=
o know all the beauty of it, thanks a lot!</div></div><div><br></div><div>T=
hank you in advance for support.</div>

<div>Sergey.</div>

--001636e0a7a8d29cea047f76bad5--

