MIME-Version: 1.0
In-Reply-To: <4E635FD3.3010704@domain.hid>
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
	<4E635FD3.3010704@domain.hid>
Date: Sun, 4 Sep 2011 19:49:50 +0800
Message-ID: <CAG0ejMGyNRZCAoyhnQ3A10g21HXxUx66DQjckZYeDUcuAMmAsA@mail.gmail.com>
From: rainbow <lvqq05@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3063e09f2339a604ac1c31fa
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

--20cf3063e09f2339a604ac1c31fa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

you mean I use remotes/origin/queues/2.6.37-x86 branch and use the ipipe
patch for 2.6.37 then install them on x86_64, the ftrace can work?I will
have a try, thank you!

2011/9/4 Jan Kiszka <jan.kiszka@domain.hid>

> On 2011-09-04 07:10, rainbow wrote:
> > Sorry to reply so late, I did a test about install ftrace on xenomai. t=
he
> > following is my procedure:
> > #git://git.xenomai.org/xenomai-jki.git queues/ftrace
> > #git://git.kiszka.org/ipipe-2.6 queues/2.6.35-x86-trace
> > #cd queues/ftrace
> > #git checkout -b remotes/origin/queues/ftrace
> >  origin/queues/2.6.35-x86-trace  //change to the ftrace xenomai branch
> > #cd ../2.6.35-x86-trace
> > #git checkout
> > -b origin/queues/2.6.35-x86-trace origin/queues/2.6.35-x86-trace
> > #cd ../ftrace
> > #./scripts/prepare-kernel.sh  --arch=3Di386
> > --adeos=3Dksrc/arch/x86/patches/adeos-ipipe-2.6.35.9-x86-2.8-04.patch
> > --linux=3D../2.6.35-x86-trace/
> > #cd /2.6.35-x86-trace/
> >
> > then I compile the kernel but I get the following error message:
> > arch/x86/kernel/ipipe.c:851: error: conflicting types for
> =91update_vsyscall=92
> > include/linux/clocksource.h:316: note: previous declaration of
> > =91update_vsyscall=92 was here
> > make[2]: *** [arch/x86/kernel/ipipe.o] Error 1
> > make[1]: *** [arch/x86/kernel] Error 2
> > make: *** [arch/x86] Error 2
>
> That's a build issues of the underlying old ipipe patch. However, it's
> x86-32 only. And as the documentation stated, only x86-64 is supported
> by the ftrace patches. So build for 64 bit instead.
>
> Jan
>
>


--=20
Qingquan Lv
School of Information Science & Engineering , Lanzhou University.
mail: lvqq05@domain.hid
Do what you like,
Enjoy your life.

--20cf3063e09f2339a604ac1c31fa
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

you mean I use=A0remotes/origin/queues/2.6.37-x86 branch and use the ipipe =
patch for 2.6.37 then install them on x86_64, the ftrace can work?I will ha=
ve a try, thank you!<br><br><div class=3D"gmail_quote">2011/9/4 Jan Kiszka =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
e</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 2011-09-04 07:10, rain=
bow wrote:<br>
&gt; Sorry to reply so late, I did a test about install ftrace on xenomai. =
the<br>
&gt; following is my procedure:<br>
&gt; #git://<a href=3D"http://git.xenomai.org/xenomai-jki.git" target=3D"_b=
lank">git.xenomai.org/xenomai-jki.git</a> queues/ftrace<br>
&gt; #git://<a href=3D"http://git.kiszka.org/ipipe-2.6" target=3D"_blank">g=
it.kiszka.org/ipipe-2.6</a> queues/2.6.35-x86-trace<br>
&gt; #cd queues/ftrace<br>
&gt; #git checkout -b remotes/origin/queues/ftrace<br>
&gt; =A0origin/queues/2.6.35-x86-trace =A0//change to the ftrace xenomai br=
anch<br>
&gt; #cd ../2.6.35-x86-trace<br>
&gt; #git checkout<br>
&gt; -b origin/queues/2.6.35-x86-trace origin/queues/2.6.35-x86-trace<br>
&gt; #cd ../ftrace<br>
&gt; #./scripts/prepare-kernel.sh =A0--arch=3Di386<br>
&gt; --adeos=3Dksrc/arch/x86/patches/adeos-ipipe-2.6.35.9-x86-2.8-04.patch<=
br>
&gt; --linux=3D../2.6.35-x86-trace/<br>
&gt; #cd /2.6.35-x86-trace/<br>
&gt;<br>
&gt; then I compile the kernel but I get the following error message:<br>
&gt; arch/x86/kernel/ipipe.c:851: error: conflicting types for =91update_vs=
yscall=92<br>
&gt; include/linux/clocksource.h:316: note: previous declaration of<br>
&gt; =91update_vsyscall=92 was here<br>
&gt; make[2]: *** [arch/x86/kernel/ipipe.o] Error 1<br>
&gt; make[1]: *** [arch/x86/kernel] Error 2<br>
&gt; make: *** [arch/x86] Error 2<br>
<br>
</div>That&#39;s a build issues of the underlying old ipipe patch. However,=
 it&#39;s<br>
x86-32 only. And as the documentation stated, only x86-64 is supported<br>
by the ftrace patches. So build for 64 bit instead.<br>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Qingq=
uan Lv<br>School of Information Science &amp; Engineering , Lanzhou Univers=
ity.<br>mail: <a href=3D"mailto:lvqq05@domain.hid">lvqq05@domain.hid</a><br>
Do what you like,<br>Enjoy your life.<br>

--20cf3063e09f2339a604ac1c31fa--

