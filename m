MIME-Version: 1.0
In-Reply-To: <4E637061.8090605@domain.hid>
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
	<4E635FD3.3010704@domain.hid>
	<CAG0ejMGyNRZCAoyhnQ3A10g21HXxUx66DQjckZYeDUcuAMmAsA@mail.gmail.com>
	<4E636667.4030107@domain.hid>
	<CAG0ejMEmmevXe0yn_=ufgcO7HKLv5+3pV-diuxw4x-rvepuwOQ@mail.gmail.com>
	<4E637061.8090605@domain.hid>
Date: Sun, 4 Sep 2011 21:16:04 +0800
Message-ID: <CAG0ejMFKjFdvhXWLabv5+V8sJy=OXdpP=XZAUasHS2PEGqTg8g@domain.hid>
From: rainbow <lvqq05@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba4fc4e0920c3804ac1d6558
Subject: Re: [Xenomai-core] xenomai-core ftrace
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

--90e6ba4fc4e0920c3804ac1d6558
Content-Type: text/plain; charset=ISO-8859-1

2011/9/4 Jan Kiszka <jan.kiszka@domain.hid>

> On 2011-09-04 14:21, rainbow wrote:
> > Is the ipipe patch the same as patch like
> > adeos-ipipe-2.6.37.6-x86-2.9-02.patch,
>
> Except that the trace branch is for 2.6.35, yes. More precisely it is
> now the same, I just pushed the latest version that includes two more
> backported ipipe fixes.
>
> > I know the latter is xenomai patch
> > and after I patch it, I can see "Real-time sub-system  ---> " Option. But
> If
> > I use 2.6.35-x86-trace which contains ,there is no such option.
>
> That menu option is introduced by Xenomai, ie. after running
> prepare-kernel.sh. You likely forgot that step.
>


> Yes,I forget the step. So I think I only have to run prepare-kernel.sh
> --arch=x86_64

--linux=2.6.35-x86-trace  , I do not need --adeos option because
> the 2.6.35-x86-trace contains the ipipe patch.
>



> Note again that you have to use a Xenomai tree with the required ftrace
> patches on top if you want Xenomai to generate ftrace events as well.
>
> "Xenomai tree with required ftrace patches on top" you mean the branch
"remotes/origin/queues/ftrace"?


> > Another  problem is that there are so many xenomai gits , how can i
> download
> > the correct git?
>
> By cloning the the git repository you obtain all available branches. You
> just need to checkout the desired one afterward.
>
> > I am a newby to xenomai and I am sorry to ask so many questions but I
> want
> > to do something on xenomai :) . Thank you for your detail answers.
>
> Setting up ftrace for Xenomai is not necessarily a newbie task, but I
> think I know the background of this. :)
>

I think you really know the background :).

>
> Jan
>
>


-- 
Qingquan Lv
School of Information Science & Engineering , Lanzhou University.
mail: lvqq05@domain.hid
Do what you like,
Enjoy your life.

--90e6ba4fc4e0920c3804ac1d6558
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/9/4 Jan Kiszka <span dir=3D"ltr">&l=
t;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span><br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">
<div class=3D"im">On 2011-09-04 14:21, rainbow wrote:<br>
&gt; Is the ipipe patch the same as patch like<br>
&gt; adeos-ipipe-2.6.37.6-x86-2.9-02.patch,<br>
<br>
</div>Except that the trace branch is for 2.6.35, yes. More precisely it is=
<br>
now the same, I just pushed the latest version that includes two more<br>
backported ipipe fixes.<br>
<div class=3D"im"><br>
&gt; I know the latter is xenomai patch<br>
&gt; and after I patch it, I can see &quot;Real-time sub-system =A0---&gt; =
&quot; Option. But If<br>
&gt; I use 2.6.35-x86-trace which contains ,there is no such option.<br>
<br>
</div>That menu option is introduced by Xenomai, ie. after running<br>
prepare-kernel.sh. You likely forgot that step.<br></blockquote><div>=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex;">Yes,I forget the step. So I think I only=
 have to run prepare-kernel.sh --arch=3Dx86_64</blockquote>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">--linux=3D2.6.35-x86-trace =A0, I do not ne=
ed --adeos option because the=A02.6.35-x86-trace contains the ipipe patch.<=
br>
</blockquote><div><br></div><div>=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">N=
ote again that you have to use a Xenomai tree with the required ftrace<br>
patches on top if you want Xenomai to generate ftrace events as well.<br>
<div class=3D"im"><br></div></blockquote><div>&quot;Xenomai tree with requi=
red ftrace patches on top&quot; you mean the branch &quot;remotes/origin/qu=
eues/ftrace&quot;?</div><div>=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">
&gt; Another =A0problem is that there are so many xenomai gits , how can i =
download<br>
&gt; the correct git?<br>
<br>
</div>By cloning the the git repository you obtain all available branches. =
You<br>
just need to checkout the desired one afterward.<br>
<div class=3D"im"><br>
&gt; I am a newby to xenomai and I am sorry to ask so many questions but I =
want<br>
&gt; to do something on xenomai :) . Thank you for your detail answers.<br>
<br>
</div>Setting up ftrace for Xenomai is not necessarily a newbie task, but I=
<br>
think I know the background of this. :)<br></blockquote><div><br></div><div=
>I think you really know the background :).=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex;">

<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Qingq=
uan Lv<br>School of Information Science &amp; Engineering , Lanzhou Univers=
ity.<br>mail: <a href=3D"mailto:lvqq05@domain.hid">lvqq05@domain.hid</a><br>
Do what you like,<br>Enjoy your life.<br>

--90e6ba4fc4e0920c3804ac1d6558--

