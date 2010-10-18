MIME-Version: 1.0
In-Reply-To: <4CBCC40D.8040902@domain.hid>
References: <30575170.2609951287430146052.JavaMail.defaultUser@domain.hid>
	<4CBCC40D.8040902@domain.hid>
Date: Tue, 19 Oct 2010 00:55:39 +0200
Message-ID: <AANLkTi=-y4huBX54ahfs6B025Ttk4N4vFZtM3n6DQL24@domain.hid>
From: Cyril Wallois <walloiscyril@domain.hid>
Content-Type: multipart/alternative; boundary=0003255767a63fd8150492ec1322
Subject: Re: [Xenomai-help] R: Re: Error building xenomai 2.5.5.1 on kubuntu
 10.10 64 bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, "gprizzi@domain.hid" <gprizzi@domain.hid>

--0003255767a63fd8150492ec1322
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I'm trying to compile linux 2.6.35.7 on an x86 non 64 with Xenomai, and it
return the advice to disable CONFIG_CC_STACKPROTECTOR (with an error). I'm
now compiling with CONFIG_CC_STACKPROTECTOR disable.

Is it the same "problem" (apparently not)?


Regards,

Cyril

2010/10/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> gprizzi@domain.hid wrote:
> >
> > Here below you can find my .config file.
> >
> > What have I missed?
> >
> > Thank you for your support.
>
> The problem is that we do not enable CONFIG_CC_STACKPROTECTOR in our
> x86_84 build test and that we got caught. Could you try the following
> patch?
>
> diff --git a/include/asm-x86/wrappers_64.h b/include/asm-x86/wrappers_64.h
> index a61f6ba..0d04b9c 100644
> --- a/include/asm-x86/wrappers_64.h
> +++ b/include/asm-x86/wrappers_64.h
> @@ -78,4 +78,8 @@ typedef union thread_xstate x86_fpustate;
>  #define x86_fpustate_ptr(t) ((t)->fpu.state)
>  #endif
>
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)
> +#define per_cpu_var(var) (var)
> +#endif /* Linux >= 2.6.34 */
> +
>  #endif /* _XENO_ASM_X86_WRAPPERS_64_H */
>
> Also note that the configuration you posted is not suitable for running
> Linux with Xenomai, please have a look at this page:
> http://www.xenomai.org/index.php/Configuring_x86_kernels
>
> --
>                                                                Gilles.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--0003255767a63fd8150492ec1322
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I&#39;m trying to compile linux 2.6.35.7 on an x86 non 64 wi=
th Xenomai, and it return the advice to disable CONFIG_CC_STACKPROTECTOR (w=
ith an error). I&#39;m now compiling with CONFIG_CC_STACKPROTECTOR disable.=
<br>
<br> Is it the same &quot;problem&quot; (<span id=3D"result_box" class=3D"s=
hort_text" lang=3D"en"><span style=3D"" title=3D"">apparently not</span></s=
pan>)?<br><br><br>Regards,<br><br>Cyril<br><br><div class=3D"gmail_quote">2=
010/10/19 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gill=
es.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</spa=
n><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><a href=3D"mailto=
:gprizzi@domain.hid">gprizzi@domain.hid</a> wrote:<br>
&gt;<br>
&gt; Here below you can find my .config file.<br>
&gt;<br>
&gt; What have I missed?<br>
&gt;<br>
&gt; Thank you for your support.<br>
<br>
The problem is that we do not enable CONFIG_CC_STACKPROTECTOR in our<br>
x86_84 build test and that we got caught. Could you try the following patch=
?<br>
<br>
diff --git a/include/asm-x86/wrappers_64.h b/include/asm-x86/wrappers_64.h<=
br>
index a61f6ba..0d04b9c 100644<br>
--- a/include/asm-x86/wrappers_64.h<br>
+++ b/include/asm-x86/wrappers_64.h<br>
@@ -78,4 +78,8 @@ typedef union thread_xstate x86_fpustate;<br>
=A0#define x86_fpustate_ptr(t) ((t)-&gt;fpu.state)<br>
=A0#endif<br>
<br>
+#if LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(2,6,34)<br>
+#define per_cpu_var(var) (var)<br>
+#endif /* Linux &gt;=3D 2.6.34 */<br>
+<br>
=A0#endif /* _XENO_ASM_X86_WRAPPERS_64_H */<br>
<br>
Also note that the configuration you posted is not suitable for running<br>
Linux with Xenomai, please have a look at this page:<br>
<a href=3D"http://www.xenomai.org/index.php/Configuring_x86_kernels" target=
=3D"_blank">http://www.xenomai.org/index.php/Configuring_x86_kernels</a><br=
>
<div><div></div><div class=3D"h5"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br>

--0003255767a63fd8150492ec1322--

