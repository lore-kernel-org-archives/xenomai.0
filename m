MIME-Version: 1.0
In-Reply-To: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
Date: Wed, 29 Dec 2010 18:47:14 -0200
Message-ID: <AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
From: Alexandre Oliveira <alexandrenagy@domain.hid>
Content-Type: multipart/alternative; boundary=00221534d6cb95c72a049892ac3a
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
To: xenomai@xenomai.org

--00221534d6cb95c72a049892ac3a
Content-Type: text/plain; charset=ISO-8859-1

I think I discovered the problem at boot log.


====
[    2.456000] Xenomai has detected a CPU frequency of 0. Aborting.
[    2.456000] Xenomai: system init failed, code -19.
[    2.456000] Xenomai: native skin init failed, code -19.
[    2.456000] Xenomai: starting POSIX services.
[    2.456000] Xenomai: POSIX skin init failed, code -19.
[    2.456000] Xenomai: RTDM skin init failed, code -19.
===

My cpuinfo:

===
phall@domain.hid:~$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 15
model        : 4
model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping    : 3
cpu MHz        : 0.000
cache size    : 2048 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 5
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc up
pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
bogomips    : 1495.04
clflush size    : 64
cache_alignment    : 128
address sizes    : 36 bits physical, 48 bits virtual
power management:
====

I really don't know how to make this work. Is there anything to do for
correctthe correction of the CPU frequency?

The same problem is discussed here, but I couldn't see the solution.

http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632


Thanks again for the help.

Att.
Alexandre.





2010/12/29 Alexandre Oliveira <alexandrenagy@domain.hid>

> Hello Guys,
>
> I'm having trouble installing Xenomai for my project
>
> I use this tutorial for installing and it matches with the installation at
> the Xenomai's website.
>
> http://www.lara.unb.br/wiki/index.php/Ubuntu_Real-time_Xenomai
>
> The new kernel was compiled ok with no problem.
>
> ====
> phall@domain.hid$ uname -a
> Linux PHall 2.6.34.1-xenomai #3 SMP PREEMPT Mon Dec 27 18:22:46 BRST 2010
> i686 GNU/Linux
> phall@domain.hid$
> ====
>
> The problem is that when I run xeno-test, it doesn't work. Any of the tests
> work. All tests return this message and I can't undestard why:
>
> ====
> root@domain.hid# ./run
> *
> *
> * Type ^C to stop this application.
> *
> *
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)
> ====
>
> I'm sending the answers of xeno-test command.
>
> I'm using Orocos for a real time software and the compilation went ok too.
> The configuration file is down. I could compile all my files but the same
> error happens:
>
> ==============
> Orocos RTT version  (1.10.4)
> No orocos-rtt.cmake file loaded, using default settings.See
> orocos-rtt.default.cmake
> -- CMAKE_VERSION: 2.6.4
> Boost found in /usr/include
> -- Could NOT find Xerces  (missing:  XERCES_DEPDOM_LIBRARY)
> Orocos target is xenomai
> -- Found XENOMAI
> -- Found PTHREAD
> -- Detected gcc4: 4.4.1
>
> -- Found Doxygen -- API documentation can be built
> -- Configuring done
> -- Generating done
> ===============
>
> ====
> phall@domain.hid$ ./phall
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)
> phall@domain.hid$
> ====
>
> Anyone ever passed through this and could help?
>
> Att.
> Alexandre Oliveira.
>

--00221534d6cb95c72a049892ac3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think I discovered the problem at boot log.<br><br><br>=3D=3D=3D=3D<br>[=
=A0=A0=A0 2.456000] Xenomai has detected a CPU frequency of 0. Aborting.<br=
>[=A0=A0=A0 2.456000] Xenomai: system init failed, code -19.<br>[=A0=A0=A0 =
2.456000] Xenomai: native skin init failed, code -19.<br>
[=A0=A0=A0 2.456000] Xenomai: starting POSIX services.<br>[=A0=A0=A0 2.4560=
00] Xenomai: POSIX skin init failed, code -19.<br>[=A0=A0=A0 2.456000] Xeno=
mai: RTDM skin init failed, code -19.<br>=3D=3D=3D<br><br>My cpuinfo:<br><b=
r>=3D=3D=3D<br>phall@domain.hid:~$ cat /proc/cpuinfo <br>
processor=A0=A0=A0 : 0<br>vendor_id=A0=A0=A0 : GenuineIntel<br>cpu family=
=A0=A0=A0 : 15<br>model=A0=A0=A0 =A0=A0=A0 : 4<br>model name=A0=A0=A0 : Int=
el(R) Pentium(R) 4 CPU 3.00GHz<br>stepping=A0=A0=A0 : 3<br>cpu MHz=A0=A0=A0=
 =A0=A0=A0 : 0.000<br>cache size=A0=A0=A0 : 2048 KB<br>fdiv_bug=A0=A0=A0 : =
no<br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 5<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0 =
=A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc up=
 pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr<br>
bogomips=A0=A0=A0 : 1495.04<br>clflush size=A0=A0=A0 : 64<br>cache_alignmen=
t=A0=A0=A0 : 128<br>address sizes=A0=A0=A0 : 36 bits physical, 48 bits virt=
ual<br>power management:<br>=3D=3D=3D=3D<br><br>I really don&#39;t know how=
 to make this work. Is there anything to do for correctthe correction of th=
e CPU frequency?<br>
<br>The same problem is discussed here, but I couldn&#39;t see the solution=
.<br><br><a href=3D"http://comments.gmane.org/gmane.linux.real-time.xenomai=
.devel/6632">http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/=
6632</a><br>
<br><br>Thanks again for the help.<br><br>Att.<br>Alexandre.<br><br><br><br=
><br><br><div class=3D"gmail_quote">2010/12/29 Alexandre Oliveira <span dir=
=3D"ltr">&lt;<a href=3D"mailto:alexandrenagy@domain.hid">alexandrenagy@domain.hid=
.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hello Guys,<br><b=
r>I&#39;m having trouble installing Xenomai for my project<br><br>I use thi=
s tutorial for installing and it matches with the installation at the Xenom=
ai&#39;s website.<br>
<br><a href=3D"http://www.lara.unb.br/wiki/index.php/Ubuntu_Real-time_Xenom=
ai" target=3D"_blank">http://www.lara.unb.br/wiki/index.php/Ubuntu_Real-tim=
e_Xenomai</a><br>
<br>The new kernel was compiled ok with no problem.<br><br>=3D=3D=3D=3D<br>=
phall@domain.hid$ uname -a<br>Linux PHall 2.6.34.1-xenomai #3 SMP=
 PREEMPT Mon Dec 27 18:22:46 BRST 2010 i686 GNU/Linux<br>phall@domain.hid=
space/v5$ <br>

=3D=3D=3D=3D<br><br>The problem is that when I run xeno-test, it doesn&#39;=
t work. Any of the tests work. All tests return this message and I can&#39;=
t undestard why:<br><br>=3D=3D=3D=3D<br>root@domain.hid=
ai/testsuite/latency# ./run <br>

*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>Xenomai: /dev/rt=
heap is missing<br>(chardev, major=3D10 minor=3D254)<br>=3D=3D=3D=3D<br><br=
>I&#39;m sending the answers of xeno-test command.<br><br>I&#39;m using Oro=
cos for a real time software and the compilation went ok too. The configura=
tion file is down. I could compile all my files but the same error happens:=
<br>

<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Orocos RTT version=A0 (1.=
10.4)<br>No orocos-rtt.cmake file loaded, using default settings.See orocos=
-rtt.default.cmake<br>-- CMAKE_VERSION: 2.6.4<br>Boost found in /usr/includ=
e<br>-- Could NOT find Xerces=A0 (missing:=A0 XERCES_DEPDOM_LIBRARY)<br>

Orocos target is xenomai<br>-- Found XENOMAI <br>-- Found PTHREAD <br>-- De=
tected gcc4: 4.4.1<br><br>-- Found Doxygen -- API documentation can be buil=
t<br>-- Configuring done<br>-- Generating done<br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br><br>

=3D=3D=3D=3D<br>phall@domain.hid$ ./phall<br>Xenomai: /dev/rtheap=
 is missing<br>(chardev, major=3D10 minor=3D254)<br>phall@domain.hid=
/v5$ <br>=3D=3D=3D=3D<br><br>Anyone ever passed through this and could help=
?<br><br>Att.<br>
<font color=3D"#888888">
Alexandre Oliveira.<br>
</font></blockquote></div><br>

--00221534d6cb95c72a049892ac3a--

