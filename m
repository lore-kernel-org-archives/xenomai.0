MIME-Version: 1.0
In-Reply-To: <1294069047.1837.79.camel@domain.hid>
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
	<4D1F4BA4.6090000@domain.hid>
	<AANLkTik-H5J-Wp=6Oc8ne_G+m=qzWyUTDTNdUiLjUJPt@domain.hid>
	<4D1FA645.1000101@domain.hid>
	<AANLkTim1wpPyNNUFWot0KRVZoQTz1fwxuyP259VrkHiU@mail.gmail.com>
	<1294068560.1837.72.camel@domain.hid>
	<1294069047.1837.79.camel@domain.hid>
Date: Mon, 3 Jan 2011 14:01:01 -0200
Message-ID: <AANLkTinfZLuYCBuqiUZLBoRYagwu0S6q9DSESouWFZrP@mail.gmail.com>
From: Alexandre Oliveira <alexandrenagy@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba4fc4a83290d90498f342a8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--90e6ba4fc4a83290d90498f342a8
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I'm gonna try it right now, disable l-pipe and recompile.


I'm trying to use this feature, by running 'cpufreq-set' and setting the
frequency myself but, didnt work too.

====
root@domain.hid# cpufreq-set -f 3.0Ghz
No cpufreq support
root@domain.hid#
====

Let's see what happen.


I really thank you all for the attention.

Att.
Alexandre


2011/1/3 Philippe Gerum <rpm@xenomai.org>

> On Mon, 2011-01-03 at 16:29 +0100, Philippe Gerum wrote:
> > On Mon, 2011-01-03 at 13:20 -0200, Alexandre Oliveira wrote:
> > > In attachment:
> > >
> > > .config file from my kernel 2.6.34.1
> > > and the complete dmesg file.
> > >
> > > I already updated the BIOS version of the mother board... but the same
> > > problem occurs.
> > > The /proc/cpuinfo file still returns 0.000 of frequency.
> >
> > Then you should send this report to the linux kernel folks.
>
> ... after having disabled Xenomai and the I-pipe, that is. Since there
> is calibration involved, make sure to try again without I-pipe, and
> report upstream only if /proc/cpuinfo still displays a null frequency.
>
> >
> > >
> > > ========
> > > root@domain.hid# ./run
> > > *
> > > *
> > > * Type ^C to stop this application.
> > > *
> > > *
> > > Xenomai: /dev/rtheap is missing
> > > (chardev, major=10 minor=254)
> > >
> > > ============
> > >
> > > ====
> > > processor    : 0
> > > vendor_id    : GenuineIntel
> > > cpu family    : 15
> > > model        : 4
> > > model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
> > > stepping    : 3
> > > cpu MHz        : 0.000
> > > cache size    : 2048 KB
> > > fdiv_bug    : no
> > > hlt_bug        : no
> > > f00f_bug    : no
> > > coma_bug    : no
> > > fpu        : yes
> > > fpu_exception    : yes
> > > cpuid level    : 5
> > > wp        : yes
> > > flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> > > constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
> > > bogomips    : 1495.04
> > > clflush size    : 64
> > > cache_alignment    : 128
> > > address sizes    : 36 bits physical, 48 bits virtual
> > > power management:
> > >
> > > =======
> > >
> > > Any other file?
> > >
> > > Thanks again for helping. :)
> > >
> > > Att.
> > > Alexandre.
> > >
> > >
> > >
> > > 2011/1/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> > >         Alexandre Oliveira wrote:
> > >         > Hello,
> > >         >
> > >         > I'm not running linux from a vmware. I didn't see that point
> > >         of the topic...
> > >         >
> > >         >
> > >         > On Monday, I will be at the laboratory and I will send the
> > >         complete dmesg
> > >         > file for help.
> > >
> > >
> > >         Please also send us the full kernel configuration.
> > >
> > >         --
> > >
> > >          Gilles.
> > >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >
>
> --
> Philippe.
>
>
>

--90e6ba4fc4a83290d90498f342a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I&#39;m gonna try it right now, disable l-pipe and recompile.=
<br><br><br>I&#39;m trying to use this feature, by running &#39;cpufreq-set=
&#39; and setting the frequency myself but, didnt work too.<br><br>=3D=3D=
=3D=3D<br>

root@domain.hid# cpufreq-set -f 3.0Ghz<br>No cpufreq support<br>root=
@PHall:/home/phall# <br>=3D=3D=3D=3D<br><br>Let&#39;s see what happen.<br><=
br><br>I really thank you all for the attention.<br><br>Att.<br>Alexandre<b=
r><br>
<br><div class=3D"gmail_quote">2011/1/3 Philippe Gerum <span dir=3D"ltr">&l=
t;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Mon, 2011-01-03 at 16:29 +0100, Philippe Gerum wrote:<=
br>
&gt; On Mon, 2011-01-03 at 13:20 -0200, Alexandre Oliveira wrote:<br>
&gt; &gt; In attachment:<br>
&gt; &gt;<br>
&gt; &gt; .config file from my kernel 2.6.34.1<br>
&gt; &gt; and the complete dmesg file.<br>
&gt; &gt;<br>
&gt; &gt; I already updated the BIOS version of the mother board... but the=
 same<br>
&gt; &gt; problem occurs.<br>
&gt; &gt; The /proc/cpuinfo file still returns 0.000 of frequency.<br>
&gt;<br>
&gt; Then you should send this report to the linux kernel folks.<br>
<br>
</div>... after having disabled Xenomai and the I-pipe, that is. Since ther=
e<br>
is calibration involved, make sure to try again without I-pipe, and<br>
report upstream only if /proc/cpuinfo still displays a null frequency.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; root@domain.hid# ./run<br=
>
&gt; &gt; *<br>
&gt; &gt; *<br>
&gt; &gt; * Type ^C to stop this application.<br>
&gt; &gt; *<br>
&gt; &gt; *<br>
&gt; &gt; Xenomai: /dev/rtheap is missing<br>
&gt; &gt; (chardev, major=3D10 minor=3D254)<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D<br>
&gt; &gt; processor =A0 =A0: 0<br>
&gt; &gt; vendor_id =A0 =A0: GenuineIntel<br>
&gt; &gt; cpu family =A0 =A0: 15<br>
&gt; &gt; model =A0 =A0 =A0 =A0: 4<br>
&gt; &gt; model name =A0 =A0: Intel(R) Pentium(R) 4 CPU 3.00GHz<br>
&gt; &gt; stepping =A0 =A0: 3<br>
&gt; &gt; cpu MHz =A0 =A0 =A0 =A0: 0.000<br>
&gt; &gt; cache size =A0 =A0: 2048 KB<br>
&gt; &gt; fdiv_bug =A0 =A0: no<br>
&gt; &gt; hlt_bug =A0 =A0 =A0 =A0: no<br>
&gt; &gt; f00f_bug =A0 =A0: no<br>
&gt; &gt; coma_bug =A0 =A0: no<br>
&gt; &gt; fpu =A0 =A0 =A0 =A0: yes<br>
&gt; &gt; fpu_exception =A0 =A0: yes<br>
&gt; &gt; cpuid level =A0 =A0: 5<br>
&gt; &gt; wp =A0 =A0 =A0 =A0: yes<br>
&gt; &gt; flags =A0 =A0 =A0 =A0: fpu vme de pse tsc msr pae mce cx8 apic se=
p mtrr pge<br>
&gt; &gt; mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pb=
e lm<br>
&gt; &gt; constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 x=
tpr<br>
&gt; &gt; bogomips =A0 =A0: 1495.04<br>
&gt; &gt; clflush size =A0 =A0: 64<br>
&gt; &gt; cache_alignment =A0 =A0: 128<br>
&gt; &gt; address sizes =A0 =A0: 36 bits physical, 48 bits virtual<br>
&gt; &gt; power management:<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; Any other file?<br>
&gt; &gt;<br>
&gt; &gt; Thanks again for helping. :)<br>
&gt; &gt;<br>
&gt; &gt; Att.<br>
&gt; &gt; Alexandre.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; 2011/1/1 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chante=
perdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 Alexandre Oliveira wrote:<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt; Hello,<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt; I&#39;m not running linux from a vmware. I d=
idn&#39;t see that point<br>
&gt; &gt; =A0 =A0 =A0 =A0 of the topic...<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt; On Monday, I will be at the laboratory and I=
 will send the<br>
&gt; &gt; =A0 =A0 =A0 =A0 complete dmesg<br>
&gt; &gt; =A0 =A0 =A0 =A0 &gt; file for help.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 Please also send us the full kernel configuration=
.<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 --<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Xenomai-help mailing list<br>
&gt; &gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><=
br>
&gt; &gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"=
_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
<br>
--<br>
Philippe.<br>
<br>
<br>
</div></div></blockquote></div><br>

--90e6ba4fc4a83290d90498f342a8--

