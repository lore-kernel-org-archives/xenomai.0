MIME-Version: 1.0
In-Reply-To: <4A8D295C.2080402@domain.hid>
References: <abaf774b0908040623w1583f930xda88c125b64394b1@domain.hid>
	<4A7BC4DC.70209@domain.hid>
	<abaf774b0908190127y4092620cr9c19b65b6434d7b1@domain.hid>
	<4A8BBA87.5010305@domain.hid>
	<abaf774b0908190229q4d1e0641wfc2d6927a8b34e42@domain.hid>
	<4A8BC7BE.5020201@domain.hid>
	<abaf774b0908190246j61f0e841s60a1b284ab1bb86@domain.hid>
	<4A8D295C.2080402@domain.hid>
Date: Wed, 26 Aug 2009 16:18:50 +0100
Message-ID: <abaf774b0908260818k3de24ccah285b460b144a88fc@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=0015174be152e3604904720cf750
Subject: Re: [Xenomai-help] Xenomai 2.5-rc2 clock_gettime bad tv_nsec value
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

--0015174be152e3604904720cf750
Content-Type: text/plain; charset=ISO-8859-1

2009/8/20 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Steve wrote:
> > On 19/08/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> wrote:
> >> Steve wrote:
> >>> Were you going to delay handling this until later, or were you hoping
> >>> it wouldn't be a problem?  If it's the former then this is not my
> >>> number one priority at the moment, so from my perspective I can wait
> >>> until the next release candidate / release.
> >> To be completely frank, I was not really worried about this issue, since
> >> you had not answered, I thought that maybe the issue was in your test
> >> program.
> >>
> >>> Linux kernel: 2.6.29.4
> >>> Xenomai: 2.5-rc2
> >>> Adeos: adeos-ipipe-2.6.29.4-x86-2.4-01
> >>>
> >>> OS: Ubuntu (8.04 with updates)
> >>> Hardware:
> >>> Intel Core 2 CPU, kernel compiled using processor family
> 'Pentium-4/etc'
> >> compiled for 32 or 64 bits?
> >>
> >> --
> >>                                           Gilles
> >>
> >>
> >
> > 32 bit,
>
> Ok. It turns out that the error is portable, and there is no other way
> than to fix the result after the multiplication (trying to round
> differently leads to the converse error). So, could you try the
> following patch:
>
> diff --git a/include/asm-generic/bits/timeconv.h
> b/include/asm-generic/bits/time
> index 79060b3..aa595fe 100644
> --- a/include/asm-generic/bits/timeconv.h
> +++ b/include/asm-generic/bits/timeconv.h
> @@ -60,10 +60,17 @@ long long xnarch_ns_to_tsc(long long ns)
>  unsigned long long xnarch_divrem_billion(unsigned long long value,
>                                         unsigned long *rem)
>  {
> -       unsigned long long r;
> -       r = xnarch_nodiv_ullimd(value, bln_frac.frac, bln_frac.integ);
> -       *rem = value - r * 1000000000;
> -       return r;
> +       unsigned long long q;
> +       unsigned r;
> +
> +       q = xnarch_nodiv_ullimd(value, bln_frac.frac, bln_frac.integ);
> +       r = value - q * 1000000000;
> +       if (r >= 1000000000) {
> +               ++q;
> +               r -= 1000000000;
> +       }
> +       *rem = r;
> +       return q;
>  }
>  #else /* !XNARCH_HAVE_NODIV_LLIMD */
>  long long xnarch_ns_to_tsc(long long ns)
>
>
> --
>                                             Gilles.
>
Hi,

I have applied the patch and it works - the kernel messages from the
previous patch are no longer produced, and my test program works without
clock_gettime tv_nsec checks.  Thank you.

Just for completeness, are we sure that the value given by r is never more
than 2 billion?  I only ask because the patch only deals with one second
worth of overrun.

Steve

--0015174be152e3604904720cf750
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/8/20 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
<div><div></div><div class=3D"h5">Steve wrote:<br>
&gt; On 19/08/2009, Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chant=
eperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt;&gt; Steve wrote:<br>
&gt;&gt;&gt; Were you going to delay handling this until later, or were you=
 hoping<br>
&gt;&gt;&gt; it wouldn&#39;t be a problem? =A0If it&#39;s the former then t=
his is not my<br>
&gt;&gt;&gt; number one priority at the moment, so from my perspective I ca=
n wait<br>
&gt;&gt;&gt; until the next release candidate / release.<br>
&gt;&gt; To be completely frank, I was not really worried about this issue,=
 since<br>
&gt;&gt; you had not answered, I thought that maybe the issue was in your t=
est<br>
&gt;&gt; program.<br>
&gt;&gt;<br>
&gt;&gt;&gt; Linux kernel: 2.6.29.4<br>
&gt;&gt;&gt; Xenomai: 2.5-rc2<br>
&gt;&gt;&gt; Adeos: adeos-ipipe-2.6.29.4-x86-2.4-01<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; OS: Ubuntu (8.04 with updates)<br>
&gt;&gt;&gt; Hardware:<br>
&gt;&gt;&gt; Intel Core 2 CPU, kernel compiled using processor family &#39;=
Pentium-4/etc&#39;<br>
&gt;&gt; compiled for 32 or 64 bits?<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 Gilles<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; 32 bit,<br>
<br>
</div></div>Ok. It turns out that the error is portable, and there is no ot=
her way<br>
than to fix the result after the multiplication (trying to round<br>
differently leads to the converse error). So, could you try the<br>
following patch:<br>
<br>
diff --git a/include/asm-generic/bits/timeconv.h<br>
b/include/asm-generic/bits/time<br>
index 79060b3..aa595fe 100644<br>
--- a/include/asm-generic/bits/timeconv.h<br>
+++ b/include/asm-generic/bits/timeconv.h<br>
@@ -60,10 +60,17 @@ long long xnarch_ns_to_tsc(long long ns)<br>
=A0unsigned long long xnarch_divrem_billion(unsigned long long value,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 unsigned long *rem)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long long r;<br>
- =A0 =A0 =A0 r =3D xnarch_nodiv_ullimd(value, bln_frac.frac, bln_frac.inte=
g);<br>
- =A0 =A0 =A0 *rem =3D value - r * 1000000000;<br>
- =A0 =A0 =A0 return r;<br>
+ =A0 =A0 =A0 unsigned long long q;<br>
+ =A0 =A0 =A0 unsigned r;<br>
+<br>
+ =A0 =A0 =A0 q =3D xnarch_nodiv_ullimd(value, bln_frac.frac, bln_frac.inte=
g);<br>
+ =A0 =A0 =A0 r =3D value - q * 1000000000;<br>
+ =A0 =A0 =A0 if (r &gt;=3D 1000000000) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++q;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 r -=3D 1000000000;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 *rem =3D r;<br>
+ =A0 =A0 =A0 return q;<br>
=A0}<br>
=A0#else /* !XNARCH_HAVE_NODIV_LLIMD */<br>
=A0long long xnarch_ns_to_tsc(long long ns)<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div>Hi,<br><br>I have applied the patch and it works =
- the kernel messages from the previous patch are no longer produced, and m=
y test program works without clock_gettime tv_nsec checks.=A0 Thank you.<br=
>
<br>Just for completeness, are we sure that the value given by r is never m=
ore than 2 billion?=A0 I only ask because the patch only deals with one sec=
ond worth of overrun.<br><br>Steve<br><br>

--0015174be152e3604904720cf750--

