MIME-Version: 1.0
In-Reply-To: <4D1F4BA4.6090000@domain.hid>
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
	<4D1F4BA4.6090000@domain.hid>
Date: Sat, 1 Jan 2011 15:53:15 -0200
Message-ID: <AANLkTik-H5J-Wp=6Oc8ne_G+m=qzWyUTDTNdUiLjUJPt@domain.hid>
From: Alexandre Oliveira <alexandrenagy@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba4fc4a8e627f00498cc970f
Subject: Re: [Xenomai-help] Problems with Installation. Error message in
 xeno-test: "Xenomai: /dev/rtheap is missing".
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

--90e6ba4fc4a8e627f00498cc970f
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I'm not running linux from a vmware. I didn't see that point of the topic...


On Monday, I will be at the laboratory and I will send the complete dmesg
file for help.

Att.
Alexandre.

Thanks for helping again. :)




2011/1/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Alexandre Oliveira wrote:
> > I think I discovered the problem at boot log.
> >
> >
> > ====
> > [    2.456000] Xenomai has detected a CPU frequency of 0. Aborting.
> > [    2.456000] Xenomai: system init failed, code -19.
> > [    2.456000] Xenomai: native skin init failed, code -19.
> > [    2.456000] Xenomai: starting POSIX services.
> > [    2.456000] Xenomai: POSIX skin init failed, code -19.
> > [    2.456000] Xenomai: RTDM skin init failed, code -19.
> > ===
> >
> > My cpuinfo:
> >
> > ===
> > phall@domain.hid:~$ cat /proc/cpuinfo
> > processor    : 0
> > vendor_id    : GenuineIntel
> > cpu family    : 15
> > model        : 4
> > model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
> > stepping    : 3
> > cpu MHz        : 0.000
> > cache size    : 2048 KB
> > fdiv_bug    : no
> > hlt_bug        : no
> > f00f_bug    : no
> > coma_bug    : no
> > fpu        : yes
> > fpu_exception    : yes
> > cpuid level    : 5
> > wp        : yes
> > flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> > constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
> > bogomips    : 1495.04
> > clflush size    : 64
> > cache_alignment    : 128
> > address sizes    : 36 bits physical, 48 bits virtual
> > power management:
> > ====
> >
> > I really don't know how to make this work. Is there anything to do for
> > correctthe correction of the CPU frequency?
> >
> > The same problem is discussed here, but I couldn't see the solution.
> >
> > http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632
>
> The thread you are referring to describes the issue as happening inside
> some emulator (virtualbox), and clearly shows that the a solution was
> implemented (Xenomai refuses to start if the reported frequency is 0,
> instead of crashing with a division by 0).
>
> If you have this issue when running inside an emulator, then the
> emulator needs fixing, if you do not run inside an emulator, then the
> issue is a different one, and the thread you refer to is irrelevant.
>
> --
>                                                                 Gilles.
>

--90e6ba4fc4a8e627f00498cc970f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I&#39;m not running linux from a vmware. I didn&#39;t see tha=
t point of the topic... <br><br>On Monday, I will be at the laboratory and =
I will send the complete dmesg file for help.<br><br>Att.<br>Alexandre.<br>
<br>Thanks for helping again. :)<br><br><br><br><br><div class=3D"gmail_quo=
te">2011/1/1 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:g=
illes.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</=
span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Alexandre Oliveira wrote:<br>
&gt; I think I discovered the problem at boot log.<br>
&gt;<br>
&gt;<br>
&gt; =3D=3D=3D=3D<br>
&gt; [ =A0 =A02.456000] Xenomai has detected a CPU frequency of 0. Aborting=
.<br>
&gt; [ =A0 =A02.456000] Xenomai: system init failed, code -19.<br>
&gt; [ =A0 =A02.456000] Xenomai: native skin init failed, code -19.<br>
&gt; [ =A0 =A02.456000] Xenomai: starting POSIX services.<br>
&gt; [ =A0 =A02.456000] Xenomai: POSIX skin init failed, code -19.<br>
&gt; [ =A0 =A02.456000] Xenomai: RTDM skin init failed, code -19.<br>
&gt; =3D=3D=3D<br>
&gt;<br>
&gt; My cpuinfo:<br>
&gt;<br>
&gt; =3D=3D=3D<br>
&gt; phall@domain.hid:~$ cat /proc/cpuinfo<br>
&gt; processor =A0 =A0: 0<br>
&gt; vendor_id =A0 =A0: GenuineIntel<br>
&gt; cpu family =A0 =A0: 15<br>
&gt; model =A0 =A0 =A0 =A0: 4<br>
&gt; model name =A0 =A0: Intel(R) Pentium(R) 4 CPU 3.00GHz<br>
&gt; stepping =A0 =A0: 3<br>
&gt; cpu MHz =A0 =A0 =A0 =A0: 0.000<br>
&gt; cache size =A0 =A0: 2048 KB<br>
&gt; fdiv_bug =A0 =A0: no<br>
&gt; hlt_bug =A0 =A0 =A0 =A0: no<br>
&gt; f00f_bug =A0 =A0: no<br>
&gt; coma_bug =A0 =A0: no<br>
&gt; fpu =A0 =A0 =A0 =A0: yes<br>
&gt; fpu_exception =A0 =A0: yes<br>
&gt; cpuid level =A0 =A0: 5<br>
&gt; wp =A0 =A0 =A0 =A0: yes<br>
&gt; flags =A0 =A0 =A0 =A0: fpu vme de pse tsc msr pae mce cx8 apic sep mtr=
r pge mca<br>
&gt; cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm<br>
&gt; constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr<b=
r>
&gt; bogomips =A0 =A0: 1495.04<br>
&gt; clflush size =A0 =A0: 64<br>
&gt; cache_alignment =A0 =A0: 128<br>
&gt; address sizes =A0 =A0: 36 bits physical, 48 bits virtual<br>
&gt; power management:<br>
&gt; =3D=3D=3D=3D<br>
&gt;<br>
&gt; I really don&#39;t know how to make this work. Is there anything to do=
 for<br>
&gt; correctthe correction of the CPU frequency?<br>
&gt;<br>
&gt; The same problem is discussed here, but I couldn&#39;t see the solutio=
n.<br>
&gt;<br>
&gt; <a href=3D"http://comments.gmane.org/gmane.linux.real-time.xenomai.dev=
el/6632" target=3D"_blank">http://comments.gmane.org/gmane.linux.real-time.=
xenomai.devel/6632</a><br>
<br>
</div></div>The thread you are referring to describes the issue as happenin=
g inside<br>
some emulator (virtualbox), and clearly shows that the a solution was<br>
implemented (Xenomai refuses to start if the reported frequency is 0,<br>
instead of crashing with a division by 0).<br>
<br>
If you have this issue when running inside an emulator, then the<br>
emulator needs fixing, if you do not run inside an emulator, then the<br>
issue is a different one, and the thread you refer to is irrelevant.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--90e6ba4fc4a8e627f00498cc970f--

