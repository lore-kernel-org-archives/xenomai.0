Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2555.6A991774"
Date: Tue, 25 Aug 2009 09:26:52 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9C7@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
	<4A8F1E70.6090608@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
	<4A925F27.4070104@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] RE :  Native message queue and synchronisation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA2555.6A991774
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

It works for me.

It also solve some problem for me using the latency program in the test =
suite. I suppose it was the same kind of lock.

There is still the registration problem, that cause an error at the =
deletion of the task. If it persists and I can find any information from =
the mail archive, I'll opened a new thread.

Thank you for help,

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien
| Trainee at Altran Ouest
| Centre d'Affaires Alphasis
| 35760 Saint-Gr=E9goire - FRANCE
| Tel: 06-76-35-29-55
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D



-------- Message d'origine--------
De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Date: lun. 24/08/2009 11:36
=C0: Berruer S=E9bastien
Cc: xenomai@xenomai.org
Objet : Re: RE : [Xenomai-help] Native message queue and synchronisation
=20
Berruer S=E9bastien wrote:
> Hi,
>=20
> Sorry for the delay, I've issued a problem using the serial line.
>=20
> As I can see in the Oops trace, the problem is due to my compiler. =
I'll
> checked my compilation parameters or a newer version of my compiler.

No. The problem is due to the FPU handling. Coud you try and apply the
patch below to Xenomai sources?

Once you have done that, recompile the kernel and user-space, and be
sure, when you compile Xenomai user-space applications to compile them
not to use the FPU, by passing -msoft-float in the CFLAGS.

Please keep us informed.

> I can also see that there is a problem with the CPU_FREQ option. It's
> mentioned as a "latency killer" in the TROUBLESHOOTING document. I'll
> checked it too.

Yes, you should disable CPU_FREQ.

--=20
                                          Gilles

diff --git a/ksrc/arch/arm/switch.S b/ksrc/arch/arm/switch.S
index a7c3dba..384f2cd 100644
--- a/ksrc/arch/arm/switch.S
+++ b/ksrc/arch/arm/switch.S
@@ -102,10 +102,12 @@ ENTRY(rthal_thread_switch)
     strex   r5, r4, [ip]                    @ Clear exclusive monitor
 #endif
 #endif
+#if 0
 #if defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_IWMMXT)
     mra     r4, r5, acc0
     stmia   ip, {r4, r5}
 #endif
+#endif
 #if defined(CONFIG_HAS_TLS_REG)
     mcr     p15, 0, r3, c13, c0, 3          @ set TLS register
 #elif !defined(CONFIG_TLS_REG_EMUL)
@@ -129,6 +131,7 @@ ENTRY(rthal_thread_switch)
 #endif
     VFPFMXR FPEXC, r4
 #endif
+#if 0
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 18) &&
defined(CONFIG_IWMMXT)
     bl      iwmmxt_task_switch
 #endif
@@ -137,13 +140,16 @@ ENTRY(rthal_thread_switch)
     ldmib   r4, {r4, r5}
     mar     acc0, r4, r5
 #endif
+#endif
     add            r4, r2, #TI_CPU_SAVE
+#if 0
 #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 18) &&
defined(CONFIG_IWMMXT)
     mov            r5, r0
     mov     r0, r2
     bl     iwmmxt_task_switch
     mov            r0, r5
-#endif
+#endif
+#endif
     ldmia   r4, {r4 - sl, fp, sp, pc}       @ Load all regs saved
previously

 /*





------_=_NextPart_001_01CA2555.6A991774
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE : [Xenomai-help] Native message queue and =
synchronisation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
It works for me.<BR>
<BR>
It also solve some problem for me using the latency program in the test =
suite. I suppose it was the same kind of lock.<BR>
<BR>
There is still the registration problem, that cause an error at the =
deletion of the task. If it persists and I can find any information from =
the mail archive, I'll opened a new thread.<BR>
<BR>
Thank you for help,<BR>
<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER S=E9bastien<BR>
| Trainee at Altran Ouest<BR>
| Centre d'Affaires Alphasis<BR>
| 35760 Saint-Gr=E9goire - FRANCE<BR>
| Tel: 06-76-35-29-55<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
<BR>
<BR>
-------- Message d'origine--------<BR>
De: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperd=
rix@domain.hid</A>]<BR>
Date: lun. 24/08/2009 11:36<BR>
=C0: Berruer S=E9bastien<BR>
Cc: xenomai@xenomai.org<BR>
Objet : Re: RE : [Xenomai-help] Native message queue and =
synchronisation<BR>
<BR>
Berruer S=E9bastien wrote:<BR>
&gt; Hi,<BR>
&gt;<BR>
&gt; Sorry for the delay, I've issued a problem using the serial =
line.<BR>
&gt;<BR>
&gt; As I can see in the Oops trace, the problem is due to my compiler. =
I'll<BR>
&gt; checked my compilation parameters or a newer version of my =
compiler.<BR>
<BR>
No. The problem is due to the FPU handling. Coud you try and apply =
the<BR>
patch below to Xenomai sources?<BR>
<BR>
Once you have done that, recompile the kernel and user-space, and be<BR>
sure, when you compile Xenomai user-space applications to compile =
them<BR>
not to use the FPU, by passing -msoft-float in the CFLAGS.<BR>
<BR>
Please keep us informed.<BR>
<BR>
&gt; I can also see that there is a problem with the CPU_FREQ option. =
It's<BR>
&gt; mentioned as a &quot;latency killer&quot; in the TROUBLESHOOTING =
document. I'll<BR>
&gt; checked it too.<BR>
<BR>
Yes, you should disable CPU_FREQ.<BR>
<BR>
--<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles<BR>
<BR>
diff --git a/ksrc/arch/arm/switch.S b/ksrc/arch/arm/switch.S<BR>
index a7c3dba..384f2cd 100644<BR>
--- a/ksrc/arch/arm/switch.S<BR>
+++ b/ksrc/arch/arm/switch.S<BR>
@@ -102,10 +102,12 @@ ENTRY(rthal_thread_switch)<BR>
&nbsp;&nbsp;&nbsp;&nbsp; strex&nbsp;&nbsp; r5, r4, =
[ip]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @ Clear exclusive =
monitor<BR>
&nbsp;#endif<BR>
&nbsp;#endif<BR>
+#if 0<BR>
&nbsp;#if defined(CONFIG_CPU_XSCALE) &amp;&amp; =
!defined(CONFIG_IWMMXT)<BR>
&nbsp;&nbsp;&nbsp;&nbsp; mra&nbsp;&nbsp;&nbsp;&nbsp; r4, r5, acc0<BR>
&nbsp;&nbsp;&nbsp;&nbsp; stmia&nbsp;&nbsp; ip, {r4, r5}<BR>
&nbsp;#endif<BR>
+#endif<BR>
&nbsp;#if defined(CONFIG_HAS_TLS_REG)<BR>
&nbsp;&nbsp;&nbsp;&nbsp; mcr&nbsp;&nbsp;&nbsp;&nbsp; p15, 0, r3, c13, =
c0, 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @ set TLS =
register<BR>
&nbsp;#elif !defined(CONFIG_TLS_REG_EMUL)<BR>
@@ -129,6 +131,7 @@ ENTRY(rthal_thread_switch)<BR>
&nbsp;#endif<BR>
&nbsp;&nbsp;&nbsp;&nbsp; VFPFMXR FPEXC, r4<BR>
&nbsp;#endif<BR>
+#if 0<BR>
&nbsp;#if LINUX_VERSION_CODE &lt; KERNEL_VERSION(2, 6, 18) =
&amp;&amp;<BR>
defined(CONFIG_IWMMXT)<BR>
&nbsp;&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iwmmxt_task_switch<BR>
&nbsp;#endif<BR>
@@ -137,13 +140,16 @@ ENTRY(rthal_thread_switch)<BR>
&nbsp;&nbsp;&nbsp;&nbsp; ldmib&nbsp;&nbsp; r4, {r4, r5}<BR>
&nbsp;&nbsp;&nbsp;&nbsp; mar&nbsp;&nbsp;&nbsp;&nbsp; acc0, r4, r5<BR>
&nbsp;#endif<BR>
+#endif<BR>
&nbsp;&nbsp;&nbsp;&nbsp; =
add&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r4, r2, #TI_CPU_SAVE<BR>
+#if 0<BR>
&nbsp;#if LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(2, 6, 18) =
&amp;&amp;<BR>
defined(CONFIG_IWMMXT)<BR>
&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r5, r0<BR>
&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp;&nbsp; r0, r2<BR>
&nbsp;&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp;&nbsp; =
iwmmxt_task_switch<BR>
&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r0, r5<BR>
-#endif<BR>
+#endif<BR>
+#endif<BR>
&nbsp;&nbsp;&nbsp;&nbsp; ldmia&nbsp;&nbsp; r4, {r4 - sl, fp, sp, =
pc}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @ Load all regs saved<BR>
previously<BR>
<BR>
&nbsp;/*<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2555.6A991774--

