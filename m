MIME-Version: 1.0
In-Reply-To: <BANLkTik6JTjfceEMa+NLBJxUA-cOWgbQ+A@mail.gmail.com>
References: <BANLkTi=UuSsFMmin_vGQFp3-vn=7JVT8Cg@domain.hid>
	<1303941212.1932.38.camel@domain.hid>
	<BANLkTimc7+mvdqosEw+1YGonxKYUQnrcsA@mail.gmail.com>
	<BANLkTikG9UFeR0C69oh+=umQLJN2Zva3dQ@mail.gmail.com>
	<1304066654.2845.12.camel@domain.hid>
	<BANLkTim+cY=KkurCjqUTTNt-Ocv7ZUQd6A@mail.gmail.com>
	<1304159360.1823.7.camel@domain.hid>
	<BANLkTi=WWysZb0kV6cuPcwS8u8mrr6ch8g@domain.hid>
	<BANLkTinkL_X8J+PzkntmUE7=oK417wBmxQ@mail.gmail.com>
	<1304331623.2150.5.camel@domain.hid>
	<BANLkTik6JTjfceEMa+NLBJxUA-cOWgbQ+A@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Wed, 4 May 2011 17:56:21 +0200
Message-ID: <BANLkTimQsR9pFEhXYYVb4KFsGqDDHgbutg@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec501668d72626a04a2754d8b
Subject: Re: [Xenomai-core] [PowerPC]Badness at mmu_context_nohash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--bcaec501668d72626a04a2754d8b
Content-Type: text/plain; charset=UTF-8

2011/5/2 Jean-Michel Hautbois <jhautbois@domain.hid>

> 2011/5/2 Philippe Gerum <rpm@xenomai.org>:
> > On Mon, 2011-05-02 at 11:56 +0200, Jean-Michel Hautbois wrote:
> >> 2011/5/2 Jean-Michel Hautbois <jhautbois@domain.hid>:
> >> > 2011/4/30 Philippe Gerum <rpm@xenomai.org>:
> >> >> On Fri, 2011-04-29 at 18:08 +0200, Jean-Michel Hautbois wrote:
> >> >>> 2011/4/29 Philippe Gerum <rpm@xenomai.org>:
> >> >>> > On Thu, 2011-04-28 at 10:33 +0200, Jean-Michel Hautbois wrote:
> >> >>> >> 2011/4/27 Philippe Gerum <rpm@xenomai.org>:
> >> >>> >> > On Wed, 2011-04-27 at 20:42 +0200, Jean-Michel Hautbois wrote:
> >> >>> >> >> Hi list,
> >> >>> >> >>
> >> >>> >> >> I am currently using a Xenomai port on a linux 2.6.35.11 linux
> kernel
> >> >>> >> >> and the adeos-ipipe-2.6.35.7-powerpc-2.12-01.patch.
> >> >>> >> >> I am facing a scheduling issue on a P2020 (dual core PowerPC),
> and I
> >> >>> >> >> get the following message :
> >> >>> >> >>
> >> >>> >> >> Badness at arch/powerpc/mm/mmu_context_nohash.c:209
> >> >>> >> >> NIP: c0018d20 LR: c039b94c CTR: c00343e4
> >> >>> >> >> REGS: ecfadce0 TRAP: 0700   Tainted: G        W    (2.6.35.11)
> >> >>> >> >> MSR: 00021000 <ME,CE>  CR: 24000488  XER: 00000000
> >> >>> >> >> TASK = ec5220d0[496] 'sipaq' THREAD: ecfac000 CPU: 1
> >> >>> >> >> GPR00: 00000001 ecfadd90 ec5220d0 ec5df340 ec58a700 00000000
> ffffffff 00000003
> >> >>> >> >> GPR08: c04a2d98 00000007 c04a2d98 0067e000 0002f385 1007f1f8
> c04a5b40 ecfac040
> >> >>> >> >> GPR16: c04a5b40 c04deb80 c04a2120 c04a2d98 c04a5b40 c04d008c
> ecfac000 00029000
> >> >>> >> >> GPR24: c04d0000 c04d1e6c 00000001 ec58a700 eceaf390 c04d1e78
> c0b23b40 ec5df340
> >> >>> >> >> NIP [c0018d20] switch_mmu_context+0x80/0x438
> >> >>> >> >> LR [c039b94c] schedule+0x774/0x7dc
> >> >>> >> >> Call Trace:
> >> >>> >> >> [ecfadd90] [44000484] 0x44000484 (unreliable)
> >> >>> >> >> [ecfadde0] [c039b94c] schedule+0x774/0x7dc
> >> >>> >> >> [ecfade50] [c039cb98] do_nanosleep+0xc8/0x114
> >> >>> >> >> [ecfade80] [c0059bf8] hrtimer_nanosleep+0xd8/0x158
> >> >>> >> >> [ecfadf10] [c0059d48] sys_nanosleep+0xd0/0xd4
> >> >>> >> >> [ecfadf40] [c0013c0c] ret_from_syscall+0x0/0x3c
> >> >>> >> >> --- Exception: c01 at 0xffa6cc4
> >> >>> >> >>    LR = 0xffa6cb0
> >> >>> >> >> Instruction dump:
> >> >>> >> >> 40a2fff0 4c00012c 2f800000 409e0128 813b018c 2f830000 39290001
> 913b018c
> >> >>> >> >> 419e0020 8003018c 7c000034 5400d97e <0f000000> 8123018c
> 3929ffff 9123018c
> >> >>> >> >>
> >> >>> >> >> Do you have a clue on how to start debugging it ?
> >> >>> >> >
> >> >>> >> > Yes, but that can't be easily summarized here. In short, we
> have a
> >> >>> >> > serious problem with the sharing of the MMU context between the
> Linux
> >> >>> >> > and Xenomai schedulers in the SMP case on powerpc.
> >> >>> >>
> >> >>> >> OK, good to know that it is a known issue. If there is a thread
> with
> >> >>> >> some thoughts about it, I am interested ;).
> >> >>> >>
> >> >>> >> >> It is happening quite randomly... :).
> >> >>> >> >
> >> >>> >> > Does disabling CONFIG_XENO_HW_UNLOCKED_SWITCH clear this issue?
> >> >>> >> >
> >> >>> >>
> >> >>> >> Well, yes and no. It starts well, but when booting the kernel I
> get :
> >> >>> >
> >> >>> >
> >> >>> > The mm switch issue was specifically addressed by this patch,
> which is
> >> >>> > part of 2.12-01:
> >> >>> >
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=c14a47630d62d0328de1957636dceb1d498f7048
> >> >>> >
> >> >>> > However, it the last 2.6.35 patch issued was based on 2.6.35.7,
> not
> >> >>> > 2.6.35.11, so there is still the possibility that something went
> wrong
> >> >>> > while you forward ported this code.
> >> >>> >
> >> >>> > - Please check that mmu_context_nohash.c does contain the fix
> above as
> >> >>> > it should
> >> >>>
> >> >>> It is ok, I have the fix.
> >> >>
> >> >> Does 2.6.35.7-2.12-02 exhibit the issue as well?
> >> >
> >> > It doesn't seem to exhibit the issue... I didn't try during a long
> >> > time though...
> >> >
> >> >>>
> >> >>> > - Please try Richard's suggestion, i.e. moving to 2.6.36, which
> may give
> >> >>> > us more hints.
> >> >>>
> >> >>> It is better. I don't have the badness on mmu context anymore.
> >> >>> This gives some hints ;).
> >> >>>
> >> >>
> >> >> Yes and no. The mmu management code involved was untouched between
> >> >> 2.6.35 and 2.6.36, so I still don't get why this activity counter
> gets
> >> >> trashed yet.
> >> >>
> >> >>> >> Badness at kernel/lockdep.c:2327
> >> >>> >> NIP: c006e554 LR: c006e53c CTR: 000186a0
> >> >>> >
> >> >>> > Adeos sometimes conflicts with the vanilla IRQ state tracer. I'll
> have a
> >> >>> > look at this. Disable CONFIG_TRACE_IRQFLAGS.
> >> >>>
> >> >>> Yes, but I *want* to have the CONFIG_TRACE_IRQFLAGS on. I just
> wanted
> >> >>> to tell that I had the problem, in order to be sure it is known ;).
> >> >>>
> >> >>
> >> >> Sure, but one issue at a time.
> >> >>
> >> >>> JM
> >> >>
> >> >> --
> >> >> Philippe.
> >> >>
> >>
> >> OK, the badness disappears, but the 2.6.36 kernel seems more stable
> >> than 2.6.35 with this patch.
> >
> > What does "more stable" mean? Do you have lockups, any issue reported in
> > the kernel log? Any weird Xenomai behavior?
> >
>
> Well, my applications work very well with the 2.6.36, comparing to the
> 2.6.35 were it can crash without any informative message.
> I can't say much more because I don't have much more :).
>
> JM
>


OK, I will give some more details, and correct myself BTW :
- A 2.6.35-11 with the 2.6.35.7-powerpc-2.11.02 is showing the badness
- A 2.6.35-11 with the 2.6.35.7-powerpc-2.12.01 is showing the badness
- A 2.6.35-11 with the 2.6.35.7-powerpc-2.12.02 is NOT showing the badness

So, the problem is solved from my point of view, sorry for the noise...
JM

--bcaec501668d72626a04a2754d8b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/5/2 Jean-Michel Hautbois <span dir=3D"ltr">=
&lt;<a href=3D"mailto:jhautbois@domain.hid">jhautbois@domain.hid</a>&gt;</spa=
n><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

2011/5/2 Philippe Gerum &lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org.=
org</a>&gt;:<br>
<div><div></div><div class=3D"h5">&gt; On Mon, 2011-05-02 at 11:56 +0200, J=
ean-Michel Hautbois wrote:<br>
&gt;&gt; 2011/5/2 Jean-Michel Hautbois &lt;<a href=3D"mailto:jhautbois@domain.hid=
l.com">jhautbois@domain.hid</a>&gt;:<br>
&gt;&gt; &gt; 2011/4/30 Philippe Gerum &lt;<a href=3D"mailto:rpm@xenomai.org=
g">rpm@xenomai.org</a>&gt;:<br>
&gt;&gt; &gt;&gt; On Fri, 2011-04-29 at 18:08 +0200, Jean-Michel Hautbois w=
rote:<br>
&gt;&gt; &gt;&gt;&gt; 2011/4/29 Philippe Gerum &lt;<a href=3D"mailto:rpm@xenomai.org=
nomai.org">rpm@xenomai.org</a>&gt;:<br>
&gt;&gt; &gt;&gt;&gt; &gt; On Thu, 2011-04-28 at 10:33 +0200, Jean-Michel H=
autbois wrote:<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; 2011/4/27 Philippe Gerum &lt;<a href=3D"mail=
to:rpm@xenomai.org">rpm@xenomai.org</a>&gt;:<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; On Wed, 2011-04-27 at 20:42 +0200, Jean=
-Michel Hautbois wrote:<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; Hi list,<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; I am currently using a Xenomai port=
 on a linux 2.6.35.11 linux kernel<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; and the adeos-ipipe-2.6.35.7-powerp=
c-2.12-01.patch.<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; I am facing a scheduling issue on a=
 P2020 (dual core PowerPC), and I<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; get the following message :<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; Badness at arch/powerpc/mm/mmu_cont=
ext_nohash.c:209<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; NIP: c0018d20 LR: c039b94c CTR: c00=
343e4<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; REGS: ecfadce0 TRAP: 0700 =C2=A0 Ta=
inted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0 =C2=A0(2.6.35.11)<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; MSR: 00021000 &lt;ME,CE&gt; =C2=A0C=
R: 24000488 =C2=A0XER: 00000000<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; TASK =3D ec5220d0[496] &#39;sipaq&#=
39; THREAD: ecfac000 CPU: 1<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; GPR00: 00000001 ecfadd90 ec5220d0 e=
c5df340 ec58a700 00000000 ffffffff 00000003<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; GPR08: c04a2d98 00000007 c04a2d98 0=
067e000 0002f385 1007f1f8 c04a5b40 ecfac040<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; GPR16: c04a5b40 c04deb80 c04a2120 c=
04a2d98 c04a5b40 c04d008c ecfac000 00029000<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; GPR24: c04d0000 c04d1e6c 00000001 e=
c58a700 eceaf390 c04d1e78 c0b23b40 ec5df340<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; NIP [c0018d20] switch_mmu_context+0=
x80/0x438<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; LR [c039b94c] schedule+0x774/0x7dc<=
br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; Call Trace:<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; [ecfadd90] [44000484] 0x44000484 (u=
nreliable)<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; [ecfadde0] [c039b94c] schedule+0x77=
4/0x7dc<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; [ecfade50] [c039cb98] do_nanosleep+=
0xc8/0x114<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; [ecfade80] [c0059bf8] hrtimer_nanos=
leep+0xd8/0x158<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; [ecfadf10] [c0059d48] sys_nanosleep=
+0xd0/0xd4<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; [ecfadf40] [c0013c0c] ret_from_sysc=
all+0x0/0x3c<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; --- Exception: c01 at 0xffa6cc4<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; =C2=A0 =C2=A0LR =3D 0xffa6cb0<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; Instruction dump:<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; 40a2fff0 4c00012c 2f800000 409e0128=
 813b018c 2f830000 39290001 913b018c<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; 419e0020 8003018c 7c000034 5400d97e=
 &lt;0f000000&gt; 8123018c 3929ffff 9123018c<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; Do you have a clue on how to start =
debugging it ?<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; Yes, but that can&#39;t be easily summa=
rized here. In short, we have a<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; serious problem with the sharing of the=
 MMU context between the Linux<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; and Xenomai schedulers in the SMP case =
on powerpc.<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; OK, good to know that it is a known issue. I=
f there is a thread with<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; some thoughts about it, I am interested ;).<=
br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;&gt; It is happening quite randomly... :=
).<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; Does disabling CONFIG_XENO_HW_UNLOCKED_=
SWITCH clear this issue?<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; Well, yes and no. It starts well, but when b=
ooting the kernel I get :<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; The mm switch issue was specifically addressed b=
y this patch, which is<br>
&gt;&gt; &gt;&gt;&gt; &gt; part of 2.12-01:<br>
&gt;&gt; &gt;&gt;&gt; &gt; <a href=3D"http://git.denx.de/?p=3Dipipe-2.6.git=
;a=3Dcommit;h=3Dc14a47630d62d0328de1957636dceb1d498f7048" target=3D"_blank"=
>http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3Dc14a47630d62d0328de19=
57636dceb1d498f7048</a><br>


&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; However, it the last 2.6.35 patch issued was bas=
ed on 2.6.35.7, not<br>
&gt;&gt; &gt;&gt;&gt; &gt; 2.6.35.11, so there is still the possibility tha=
t something went wrong<br>
&gt;&gt; &gt;&gt;&gt; &gt; while you forward ported this code.<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; - Please check that mmu_context_nohash.c does co=
ntain the fix above as<br>
&gt;&gt; &gt;&gt;&gt; &gt; it should<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; It is ok, I have the fix.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Does 2.6.35.7-2.12-02 exhibit the issue as well?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; It doesn&#39;t seem to exhibit the issue... I didn&#39;t try =
during a long<br>
&gt;&gt; &gt; time though...<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; - Please try Richard&#39;s suggestion, i.e. movi=
ng to 2.6.36, which may give<br>
&gt;&gt; &gt;&gt;&gt; &gt; us more hints.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; It is better. I don&#39;t have the badness on mmu con=
text anymore.<br>
&gt;&gt; &gt;&gt;&gt; This gives some hints ;).<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Yes and no. The mmu management code involved was untouche=
d between<br>
&gt;&gt; &gt;&gt; 2.6.35 and 2.6.36, so I still don&#39;t get why this acti=
vity counter gets<br>
&gt;&gt; &gt;&gt; trashed yet.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; Badness at kernel/lockdep.c:2327<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; NIP: c006e554 LR: c006e53c CTR: 000186a0<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; Adeos sometimes conflicts with the vanilla IRQ s=
tate tracer. I&#39;ll have a<br>
&gt;&gt; &gt;&gt;&gt; &gt; look at this. Disable CONFIG_TRACE_IRQFLAGS.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Yes, but I *want* to have the CONFIG_TRACE_IRQFLAGS o=
n. I just wanted<br>
&gt;&gt; &gt;&gt;&gt; to tell that I had the problem, in order to be sure i=
t is known ;).<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Sure, but one issue at a time.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; JM<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; Philippe.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; OK, the badness disappears, but the 2.6.36 kernel seems more stabl=
e<br>
&gt;&gt; than 2.6.35 with this patch.<br>
&gt;<br>
&gt; What does &quot;more stable&quot; mean? Do you have lockups, any issue=
 reported in<br>
&gt; the kernel log? Any weird Xenomai behavior?<br>
&gt;<br>
<br>
</div></div>Well, my applications work very well with the 2.6.36, comparing=
 to the<br>
2.6.35 were it can crash without any informative message.<br>
I can&#39;t say much more because I don&#39;t have much more :).<br>
<font color=3D"#888888"><br>
JM<br>
</font></blockquote></div><br><br>OK, I will give some more details, and co=
rrect myself BTW :<br>- A 2.6.35-11 with the 2.6.35.7-powerpc-2.11.02 is sh=
owing the badness<br>- A 2.6.35-11 with the 2.6.35.7-powerpc-2.12.01 is sho=
wing the badness<br>

- A 2.6.35-11 with the 2.6.35.7-powerpc-2.12.02 is NOT showing the badness<=
br><br>So, the problem is solved from my point of view, sorry for the noise=
...<br>JM<br>

--bcaec501668d72626a04a2754d8b--

