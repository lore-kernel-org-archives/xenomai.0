MIME-Version: 1.0
In-Reply-To: <4E6471E8.90001@domain.hid>
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
	<CAG0ejMEyzyvr79Bf8x79R65+u3MBapCPq3t_RGarfDGaLVe+Zg@domain.hid>
	<4E6471E8.90001@domain.hid>
Date: Mon, 5 Sep 2011 15:39:49 +0800
Message-ID: <CAG0ejMFAH_W0hjkVSj7sucuQ18w__Z5QK=wMCufXJ4-gZRAs_w@domain.hid>
From: rainbow <lvqq05@domain.hid>
Content-Type: multipart/alternative; boundary=f46d043894b9d7f17e04ac2cd038
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

--f46d043894b9d7f17e04ac2cd038
Content-Type: text/plain; charset=ISO-8859-1

Yes, you are right, it is ok for 2.6.35-x86-trace.Thank you very much.

2011/9/5 Jan Kiszka <jan.kiszka@domain.hid>

> On 2011-09-05 04:32, rainbow wrote:
> > hi,
> > I did a test for ftrace-xenomai on x86_64 test just now:
> > the environment is : OS: debian 6.0 gcc-4.1
> > I use origin/queues/2.6.37-x86 branch on git
> > git://git.kiszka.org/ipipe-2.6for linux kernel and use branch
> > origin/queues/ftrace on git git://
> > git.xenomai.org/xenomai-jki.git
> > then I do as the following procedures:
> > 1,cd xenomai git
> > 2, ./scripts/prepare-kernel.sh --arch=x86_64 --linux=path_to_2.6.37-x86
> > 3, cd path_to_2.6.37_x86
> > 4,make menuconfig
> > then enble ftrace on kernel hacking option.
> > 5,install the kernel and reboot the machine.
> > 6,do ftrace test
> > 6.1 mount -t debugfs nodev /sys/kernel/debug
> > 6.2 cd /sys/kernel/debug/tracing
> > 6.3 echo function > current_tracer
> > At last the machine reboot.
> > Is there something wrong about the above procedure? Thanks!
>
> Only queues/2.6.35-x86-trace contains ftrace support.
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

--f46d043894b9d7f17e04ac2cd038
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, you are right, it is ok for 2.6.35-x86-trace.Thank you very much.<br><=
br><div class=3D"gmail_quote">2011/9/5 Jan Kiszka <span dir=3D"ltr">&lt;<a =
href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span><br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 2011-09-05 04:32, rainbow wrote:<br>
&gt; hi,<br>
&gt; I did a test for ftrace-xenomai on x86_64 test just now:<br>
&gt; the environment is : OS: debian 6.0 gcc-4.1<br>
&gt; I use origin/queues/2.6.37-x86 branch on git<br>
</div>&gt; git://<a href=3D"http://git.kiszka.org/ipipe-2.6for" target=3D"_=
blank">git.kiszka.org/ipipe-2.6for</a> linux kernel and use branch<br>
<div class=3D"im">&gt; origin/queues/ftrace on git git://<br>
&gt; <a href=3D"http://git.xenomai.org/xenomai-jki.git" target=3D"_blank">g=
it.xenomai.org/xenomai-jki.git</a><br>
&gt; then I do as the following procedures:<br>
&gt; 1,cd xenomai git<br>
&gt; 2, ./scripts/prepare-kernel.sh --arch=3Dx86_64 --linux=3Dpath_to_2.6.3=
7-x86<br>
&gt; 3, cd path_to_2.6.37_x86<br>
&gt; 4,make menuconfig<br>
&gt; then enble ftrace on kernel hacking option.<br>
&gt; 5,install the kernel and reboot the machine.<br>
&gt; 6,do ftrace test<br>
&gt; 6.1 mount -t debugfs nodev /sys/kernel/debug<br>
&gt; 6.2 cd /sys/kernel/debug/tracing<br>
&gt; 6.3 echo function &gt; current_tracer<br>
&gt; At last the machine reboot.<br>
&gt; Is there something wrong about the above procedure? Thanks!<br>
<br>
</div>Only queues/2.6.35-x86-trace contains ftrace support.<br>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Qingquan Lv<br>S=
chool of Information Science &amp; Engineering , Lanzhou University.<br>mai=
l: <a href=3D"mailto:lvqq05@domain.hid">lvqq05@domain.hid</a><br>Do what you =
like,<br>
Enjoy your life.<br>

--f46d043894b9d7f17e04ac2cd038--

