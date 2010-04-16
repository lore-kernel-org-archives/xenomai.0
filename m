MIME-Version: 1.0
In-Reply-To: <1271402874.2365.715.camel@domain.hid>
References: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
	<1271402874.2365.715.camel@domain.hid>
Date: Fri, 16 Apr 2010 15:23:02 +0200
Message-ID: <z2n95dbcd241004160623s90d4c846w44e566f38981eed2@domain.hid>
From: Gilles DOFFE <g.doffe@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6563b78c8348404845a826f
Subject: Re: [Adeos-main] [Vortx86DX] What's wrong with kernels upper than
	2.6.30.10 ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

--0016e6563b78c8348404845a826f
Content-Type: text/plain; charset=ISO-8859-1

Hello Jan and Philippe,

It works fine now with the patches you gave Philippe.
And all is clear with the commit explanations. :)

Thanks a lot,
Gilles

2010/4/16 Philippe Gerum <rpm@xenomai.org>

> On Fri, 2010-04-16 at 00:00 +0200, Gilles DOFFE wrote:
> > Hello,
> >
> > I try to install a real-time Linux kernel on a Roboard based on a
> > Vortex86DX (a x486 with TSC).
> >
> > All works fine with :
> > Linux Kernel 2.6.30.10
> > Xenomai 2.5.1
> > Adeos patch adeos-ipipe-2.6.30.8-x86-2.4-09.patch
> >
> > But, for all kernels upper or equal to 2.6.31, I always get a double
> > fault when testing WP bit. I have this double fault just after that :
> >
> > Checking if this processor honours the WP bit even in supervisor
> > mode...
> >
> > I traced with some simple printk that the problem occurs in this
> > function, at the end or after the call of fix_to_virt  :
> >
> > static noinline int do_test_wp_bit(void)
> > {
> >         char tmp_reg;
> >         int flag;
> >
> >         __asm__ __volatile__(
> >                 "       movb %0, %1     \n"
> >                 "1:     movb %1, %0     \n"
> >                 "       xorl %2, %2     \n"
> >                 "2:                     \n"
> >                 _ASM_EXTABLE(1b,2b)
> >                 :"=m" (*(char *)fix_to_virt(FIX_WP_TEST)),
> >                  "=q" (tmp_reg),
> >                  "=r" (flag)
> >                 :"2" (1)
> >                 :"memory");
> >
> >         return flag;
> > }
> >
> > I'm (quasi) sure that the problem is not that function, due to it
> > works when the kernel is not patched.
> > But where should I search ?
>
> Try backporting these two 2.6.32 patches to your kernel; this should be
> straightforward:
>
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=576f57f82dfd6c3ac285b0af76e5e0ce617679ba
>
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=a250e984a76fd327a0d8cfada5290b27e99f1e4d
>
>
> >
> > Can you give me some indications ?
> >
> > Thanks,
> > Gilles
> > _______________________________________________
> > Adeos-main mailing list
> > Adeos-main@domain.hid
> > https://mail.gna.org/listinfo/adeos-main
>
>
> --
> Philippe.
>
>
>

--0016e6563b78c8348404845a826f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Jan and Philippe,<br><br>It works fine now with the patches you gave =
Philippe.<br>And all is clear with the commit explanations. :)<br><br>Thank=
s a lot,<br>Gilles<br><br><div class=3D"gmail_quote">2010/4/16 Philippe Ger=
um <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Fri, 2010-04-16 at 00:00 +0200, Gilles DOFFE wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I try to install a real-time Linux kernel on a Roboard based on a<br>
&gt; Vortex86DX (a x486 with TSC).<br>
&gt;<br>
&gt; All works fine with :<br>
&gt; Linux Kernel 2.6.30.10<br>
&gt; Xenomai 2.5.1<br>
&gt; Adeos patch adeos-ipipe-2.6.30.8-x86-2.4-09.patch<br>
&gt;<br>
&gt; But, for all kernels upper or equal to 2.6.31, I always get a double<b=
r>
&gt; fault when testing WP bit. I have this double fault just after that :<=
br>
&gt;<br>
&gt; Checking if this processor honours the WP bit even in supervisor<br>
&gt; mode...<br>
&gt;<br>
&gt; I traced with some simple printk that the problem occurs in this<br>
&gt; function, at the end or after the call of fix_to_virt =A0:<br>
&gt;<br>
&gt; static noinline int do_test_wp_bit(void)<br>
&gt; {<br>
&gt; =A0 =A0 =A0 =A0 char tmp_reg;<br>
&gt; =A0 =A0 =A0 =A0 int flag;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 __asm__ __volatile__(<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot; =A0 =A0 =A0 movb %0, %1 =A0 =A0=
 \n&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;1: =A0 =A0 movb %1, %0 =A0 =A0 \=
n&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot; =A0 =A0 =A0 xorl %2, %2 =A0 =A0=
 \n&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;2: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 \n&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _ASM_EXTABLE(1b,2b)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :&quot;=3Dm&quot; (*(char *)fix_to_vir=
t(FIX_WP_TEST)),<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;=3Dq&quot; (tmp_reg),<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;=3Dr&quot; (flag)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :&quot;2&quot; (1)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :&quot;memory&quot;);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 return flag;<br>
&gt; }<br>
&gt;<br>
&gt; I&#39;m (quasi) sure that the problem is not that function, due to it<=
br>
&gt; works when the kernel is not patched.<br>
&gt; But where should I search ?<br>
<br>
</div></div>Try backporting these two 2.6.32 patches to your kernel; this s=
hould be<br>
straightforward:<br>
<a href=3D"http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3D576f57f82df=
d6c3ac285b0af76e5e0ce617679ba" target=3D"_blank">http://git.denx.de/?p=3Dip=
ipe-2.6.git;a=3Dcommit;h=3D576f57f82dfd6c3ac285b0af76e5e0ce617679ba</a><br>
<a href=3D"http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3Da250e984a76=
fd327a0d8cfada5290b27e99f1e4d" target=3D"_blank">http://git.denx.de/?p=3Dip=
ipe-2.6.git;a=3Dcommit;h=3Da250e984a76fd327a0d8cfada5290b27e99f1e4d</a><br>
<div class=3D"im"><br>
<br>
&gt;<br>
&gt; Can you give me some indications ?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Gilles<br>
</div><div class=3D"im">&gt; ______________________________________________=
_<br>
&gt; Adeos-main mailing list<br>
&gt; <a href=3D"mailto:Adeos-main@domain.hid">Adeos-main@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/adeos-main" target=3D"_blank"=
>https://mail.gna.org/listinfo/adeos-main</a><br>
<br>
<br>
</div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e6563b78c8348404845a826f--

