MIME-Version: 1.0
In-Reply-To: <4E63829E.1090500@domain.hid>
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
	<4E635FD3.3010704@domain.hid>
	<CAG0ejMGyNRZCAoyhnQ3A10g21HXxUx66DQjckZYeDUcuAMmAsA@mail.gmail.com>
	<4E636667.4030107@domain.hid>
	<CAG0ejMEmmevXe0yn_=ufgcO7HKLv5+3pV-diuxw4x-rvepuwOQ@mail.gmail.com>
	<4E637061.8090605@domain.hid>
	<CAG0ejMFKjFdvhXWLabv5+V8sJy=OXdpP=XZAUasHS2PEGqTg8g@domain.hid>
	<4E63829E.1090500@domain.hid>
Date: Sun, 4 Sep 2011 22:12:08 +0800
Message-ID: <CAG0ejMHD8EZoORTiy0eieRQ80td6f7ENwv8yF5h_mLhh+-_NKQ@mail.gmail.com>
From: rainbow <lvqq05@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba4fc4e00c2fe904ac1e2e45
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

--90e6ba4fc4e00c2fe904ac1e2e45
Content-Type: text/plain; charset=ISO-8859-1

Thank you for so detailed answers!! I will test it.

2011/9/4 Jan Kiszka <jan.kiszka@domain.hid>

> On 2011-09-04 15:16, rainbow wrote:
> > 2011/9/4 Jan Kiszka <jan.kiszka@domain.hid>
> >
> >> On 2011-09-04 14:21, rainbow wrote:
> >>> Is the ipipe patch the same as patch like
> >>> adeos-ipipe-2.6.37.6-x86-2.9-02.patch,
> >>
> >> Except that the trace branch is for 2.6.35, yes. More precisely it is
> >> now the same, I just pushed the latest version that includes two more
> >> backported ipipe fixes.
> >>
> >>> I know the latter is xenomai patch
> >>> and after I patch it, I can see "Real-time sub-system  ---> " Option.
> But
> >> If
> >>> I use 2.6.35-x86-trace which contains ,there is no such option.
> >>
> >> That menu option is introduced by Xenomai, ie. after running
> >> prepare-kernel.sh. You likely forgot that step.
> >>
> >
> >
> >> Yes,I forget the step. So I think I only have to run prepare-kernel.sh
> >> --arch=x86_64
> >
> > --linux=2.6.35-x86-trace  , I do not need --adeos option because
> >> the 2.6.35-x86-trace contains the ipipe patch.
> >>
> >
> >
> >
> >> Note again that you have to use a Xenomai tree with the required ftrace
> >> patches on top if you want Xenomai to generate ftrace events as well.
> >>
> >> "Xenomai tree with required ftrace patches on top" you mean the branch
> > "remotes/origin/queues/ftrace"?
>
> Yep. I just pushed a rebased version of current git master.
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

--90e6ba4fc4e00c2fe904ac1e2e45
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you for so detailed answers!! I will test it.<br><br><div class=3D"gm=
ail_quote">2011/9/4 Jan Kiszka <span dir=3D"ltr">&lt;<a href=3D"mailto:jan.=
kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span><br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex;">
<div class=3D"im">On 2011-09-04 15:16, rainbow wrote:<br>
&gt; 2011/9/4 Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszk=
a@domain.hid</a>&gt;<br>
&gt;<br>
&gt;&gt; On 2011-09-04 14:21, rainbow wrote:<br>
&gt;&gt;&gt; Is the ipipe patch the same as patch like<br>
&gt;&gt;&gt; adeos-ipipe-2.6.37.6-x86-2.9-02.patch,<br>
&gt;&gt;<br>
&gt;&gt; Except that the trace branch is for 2.6.35, yes. More precisely it=
 is<br>
&gt;&gt; now the same, I just pushed the latest version that includes two m=
ore<br>
&gt;&gt; backported ipipe fixes.<br>
&gt;&gt;<br>
&gt;&gt;&gt; I know the latter is xenomai patch<br>
&gt;&gt;&gt; and after I patch it, I can see &quot;Real-time sub-system =A0=
---&gt; &quot; Option. But<br>
&gt;&gt; If<br>
&gt;&gt;&gt; I use 2.6.35-x86-trace which contains ,there is no such option=
.<br>
&gt;&gt;<br>
&gt;&gt; That menu option is introduced by Xenomai, ie. after running<br>
&gt;&gt; prepare-kernel.sh. You likely forgot that step.<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; Yes,I forget the step. So I think I only have to run prepare-kerne=
l.sh<br>
&gt;&gt; --arch=3Dx86_64<br>
&gt;<br>
&gt; --linux=3D2.6.35-x86-trace =A0, I do not need --adeos option because<b=
r>
&gt;&gt; the 2.6.35-x86-trace contains the ipipe patch.<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; Note again that you have to use a Xenomai tree with the required f=
trace<br>
&gt;&gt; patches on top if you want Xenomai to generate ftrace events as we=
ll.<br>
&gt;&gt;<br>
&gt;&gt; &quot;Xenomai tree with required ftrace patches on top&quot; you m=
ean the branch<br>
&gt; &quot;remotes/origin/queues/ftrace&quot;?<br>
<br>
</div>Yep. I just pushed a rebased version of current git master.<br>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Qingq=
uan Lv<br>School of Information Science &amp; Engineering , Lanzhou Univers=
ity.<br>mail: <a href=3D"mailto:lvqq05@domain.hid">lvqq05@domain.hid</a><br>
Do what you like,<br>Enjoy your life.<br>

--90e6ba4fc4e00c2fe904ac1e2e45--

