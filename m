MIME-Version: 1.0
In-Reply-To: <4E61D028.3000702@domain.hid>
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
Date: Sun, 4 Sep 2011 13:10:40 +0800
Message-ID: <CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
From: rainbow <lvqq05@domain.hid>
Content-Type: multipart/alternative; boundary=f46d043894b99d7e2804ac169da0
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

--f46d043894b99d7e2804ac169da0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Sorry to reply so late, I did a test about install ftrace on xenomai. the
following is my procedure:
#git://git.xenomai.org/xenomai-jki.git queues/ftrace
#git://git.kiszka.org/ipipe-2.6 queues/2.6.35-x86-trace
#cd queues/ftrace
#git checkout -b remotes/origin/queues/ftrace
 origin/queues/2.6.35-x86-trace  //change to the ftrace xenomai branch
#cd ../2.6.35-x86-trace
#git checkout
-b origin/queues/2.6.35-x86-trace origin/queues/2.6.35-x86-trace
#cd ../ftrace
#./scripts/prepare-kernel.sh  --arch=3Di386
--adeos=3Dksrc/arch/x86/patches/adeos-ipipe-2.6.35.9-x86-2.8-04.patch
--linux=3D../2.6.35-x86-trace/
#cd /2.6.35-x86-trace/

then I compile the kernel but I get the following error message:
arch/x86/kernel/ipipe.c:851: error: conflicting types for =91update_vsyscal=
l=92
include/linux/clocksource.h:316: note: previous declaration of
=91update_vsyscall=92 was here
make[2]: *** [arch/x86/kernel/ipipe.o] Error 1
make[1]: *** [arch/x86/kernel] Error 2
make: *** [arch/x86] Error 2

I am not sure the reason is that I get the wrong patch or the kernel
configuration is wrong, Is the procedure above right? Thanks!

2011/9/3 Jan Kiszka <jan.kiszka@domain.hid>

> On 2011-09-03 04:52, rainbow wrote:
> > hi,all,I want to use ftrace in xenomai-2.5.6,but when I use git://
> > git.kiszka.org/ipipe.git queues/2.6.35-x86-trace to get the linux
> > kernel,there is no option about xenomai or ipipe . If I want to patch t=
he
> > xenomai patch,there are some problem. How should I use ftrace on
> > xenomai?Thanks!
>
> First of all, make sure to read README.INSTALL in the Xenomai tree for
> the basic installation procedure.
>
> That git branch above replaces the installation step of picking a
> vanilla Linux source tree and applying the ipipe patch to it (if there
> is no ipipe option in the kernel config, you probably haven't check out
> the right branch yet).
>
> The next step would be running Xenomai's prepare-kernel.sh, in this case
> using a Xenomai tree that has the required ftrace patches, see
>
> http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/7966
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

--f46d043894b99d7e2804ac169da0
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8">So=
rry to reply so late, I did a test about install ftrace on xenomai. the fol=
lowing is my procedure:<div>#git://<a href=3D"http://git.xenomai.org/xenoma=
i-jki.git">git.xenomai.org/xenomai-jki.git</a> queues/ftrace</div>
<div>#git://<a href=3D"http://git.kiszka.org/ipipe-2.6">git.kiszka.org/ipip=
e-2.6</a> queues/2.6.35-x86-trace</div><div>#cd queues/ftrace</div><div>#gi=
t checkout -b=A0remotes/origin/queues/ftrace =A0 =A0origin/queues/2.6.35-x8=
6-trace =A0//change to the ftrace xenomai branch</div>
<div>#cd ../2.6.35-x86-trace</div><div>#git checkout -b=A0origin/queues/2.6=
.35-x86-trace=A0origin/queues/2.6.35-x86-trace</div><div>#cd ../ftrace</div=
><div>#./scripts/prepare-kernel.sh =A0--arch=3Di386 --adeos=3Dksrc/arch/x86=
/patches/adeos-ipipe-2.6.35.9-x86-2.8-04.patch --linux=3D../2.6.35-x86-trac=
e/</div>
<div>#cd=A0/2.6.35-x86-trace/=A0</div><div><br></div><div>then I compile th=
e kernel but I get the following error message:</div><div><div>arch/x86/ker=
nel/ipipe.c:851: error: conflicting types for =91update_vsyscall=92</div><d=
iv>include/linux/clocksource.h:316: note: previous declaration of =91update=
_vsyscall=92 was here</div>
<div>make[2]: *** [arch/x86/kernel/ipipe.o] Error 1</div><div>make[1]: *** =
[arch/x86/kernel] Error 2</div><div>make: *** [arch/x86] Error 2</div></div=
><div><br></div><div>I am not sure the reason is that I get the wrong patch=
 or the kernel configuration is wrong, Is the procedure above right? Thanks=
!</div>
<br><div class=3D"gmail_quote">2011/9/3 Jan Kiszka <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">
<div class=3D"im">On 2011-09-03 04:52, rainbow wrote:<br>
&gt; hi,all,I want to use ftrace in xenomai-2.5.6,but when I use git://<br>
&gt; <a href=3D"http://git.kiszka.org/ipipe.git" target=3D"_blank">git.kisz=
ka.org/ipipe.git</a> queues/2.6.35-x86-trace to get the linux<br>
&gt; kernel,there is no option about xenomai or ipipe . If I want to patch =
the<br>
&gt; xenomai patch,there are some problem. How should I use ftrace on<br>
&gt; xenomai?Thanks!<br>
<br>
</div>First of all, make sure to read README.INSTALL in the Xenomai tree fo=
r<br>
the basic installation procedure.<br>
<br>
That git branch above replaces the installation step of picking a<br>
vanilla Linux source tree and applying the ipipe patch to it (if there<br>
is no ipipe option in the kernel config, you probably haven&#39;t check out=
<br>
the right branch yet).<br>
<br>
The next step would be running Xenomai&#39;s prepare-kernel.sh, in this cas=
e<br>
using a Xenomai tree that has the required ftrace patches, see<br>
<br>
<a href=3D"http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/7=
966" target=3D"_blank">http://permalink.gmane.org/gmane.linux.real-time.xen=
omai.devel/7966</a><br>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Qingq=
uan Lv<br>School of Information Science &amp; Engineering , Lanzhou Univers=
ity.<br>mail: <a href=3D"mailto:lvqq05@domain.hid">lvqq05@domain.hid</a><br>
Do what you like,<br>Enjoy your life.<br>

--f46d043894b99d7e2804ac169da0--

