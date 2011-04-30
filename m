MIME-Version: 1.0
In-Reply-To: <4DBC6D98.2070306@domain.hid>
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid> <4DB99E47.7000904@domain.hid>
	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
	<4DB9C0D3.4030003@domain.hid> <4DBA9C26.2040903@domain.hid>
	<4DBAA1DE.4000108@domain.hid> <4DBBDCA9.1040609@domain.hid>
	<BANLkTintQjX=O0DBYbyW2=jhyNQuyeZ=pQ@mail.gmail.com>
	<4DBC6D98.2070306@domain.hid>
Date: Sun, 1 May 2011 02:28:41 +0600
Message-ID: <BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=20cf300fad3be2851904a228a284
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--20cf300fad3be2851904a228a284
Content-Type: text/plain; charset=ISO-8859-1

2011/5/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> Ok. Could you try only keeping the part with ipipe_handle_chained_irq,
> leaving the handle_edge_irqs?
>

Sure. I'll do it tomorrow.

There is another one issue: the board hangs after about 2-3 minutes running.
I found that it is caused by a semi-permanent (order of 2^64 iterations)
loop in (untouched) kernel timer code, most likely due to weird return value
of __ipipe_tsc_get. I haven't found the source of this problem yet. I tried
a small fix:

--- time.c.org    2011-04-26 20:52:00.000000000 +0600
+++ time.c    2011-05-01 02:03:33.000000000 +0600
@@ -124,7 +124,7 @@

 static inline unsigned long timer_freerunning_getvalue(void)
 {
-    return __raw_readl(S3C2410_TCNTO(3));
+    return (unsigned long)__raw_readw(S3C2410_TCNTO(3));
 }

 static inline unsigned long timer_freerunning_getticksoffset(unsigned long
tval)
@@ -390,6 +390,6 @@

 unsigned long __ipipe_mach_get_dec(void)
 {
-    return __raw_readl(S3C2410_TCNTO(4));
+    return (unsigned long)__raw_readw(S3C2410_TCNTO(4));
 }
 #endif /* CONFIG_IPIPE */

but it didn't work. (In fact, TCNTOs of S4C2440 are 16-bit, not 32-bit, and
the datasheet does not guarantee that higher bits are read as zeroes; in
fact they are, but I tried explicit conversion anyway just in case. No
effect.).

--
Alex

--20cf300fad3be2851904a228a284
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/5/1 Gilles Chanteperdrix <span dir=3D"ltr">=
&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdri=
x@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5"><br>
</div></div>Ok. Could you try only keeping the part with ipipe_handle_chain=
ed_irq,<br>
leaving the handle_edge_irqs?<font color=3D"#888888"><br></font></blockquot=
e><div><br>Sure. I&#39;ll do it tomorrow.<br><br>There is another one issue=
: the board hangs after about 2-3 minutes running. I found that it is cause=
d by a semi-permanent (order of 2^64 iterations) loop in (untouched) kernel=
 timer code, most likely due to weird return value of __ipipe_tsc_get. I ha=
ven&#39;t found the source of this problem yet. I tried a small fix:<br>
<br></div></div>--- <a href=3D"http://time.c.org">time.c.org</a>=A0=A0=A0 2=
011-04-26 20:52:00.000000000 +0600<br>+++ time.c=A0=A0=A0 2011-05-01 02:03:=
33.000000000 +0600<br>@@ -124,7 +124,7 @@<br>=A0<br>=A0static inline unsign=
ed long timer_freerunning_getvalue(void)<br>
=A0{<br>-=A0=A0=A0 return __raw_readl(S3C2410_TCNTO(3));<br>+=A0=A0=A0 retu=
rn (unsigned long)__raw_readw(S3C2410_TCNTO(3));<br>=A0}<br>=A0<br>=A0stati=
c inline unsigned long timer_freerunning_getticksoffset(unsigned long tval)=
<br>@@ -390,6 +390,6 @@<br>
=A0<br>=A0unsigned long __ipipe_mach_get_dec(void)<br>=A0{<br>-=A0=A0=A0 re=
turn __raw_readl(S3C2410_TCNTO(4));<br>+=A0=A0=A0 return (unsigned long)__r=
aw_readw(S3C2410_TCNTO(4));<br>=A0}<br>=A0#endif /* CONFIG_IPIPE */<br><br>=
but it didn&#39;t work. (In fact, TCNTOs of S4C2440 are 16-bit, not 32-bit,=
 and the datasheet does not guarantee that higher bits are read as zeroes; =
in fact they are, but I tried explicit conversion anyway just in case. No e=
ffect.).<br>
<br>--<br>Alex<br>

--20cf300fad3be2851904a228a284--

