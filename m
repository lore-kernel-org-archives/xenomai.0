MIME-Version: 1.0
Date: Fri, 16 Apr 2010 00:00:33 +0200
Message-ID: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
From: Gilles DOFFE <g.doffe@domain.hid>
Content-Type: multipart/alternative; boundary=0016367b5f20b2434604844d9fd9
Subject: [Adeos-main] [Vortx86DX] What's wrong with kernels upper than
	2.6.30.10 ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

--0016367b5f20b2434604844d9fd9
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I try to install a real-time Linux kernel on a Roboard based on a Vortex86DX
(a x486 with TSC).

All works fine with :
Linux Kernel 2.6.30.10
Xenomai 2.5.1
Adeos patch adeos-ipipe-2.6.30.8-x86-2.4-09.patch

But, for all kernels upper or equal to 2.6.31, I always get a double fault
when testing WP bit. I have this double fault just after that :

*Checking if this processor honours the WP bit even in supervisor mode...*

I traced with some simple printk that the problem occurs in this function,
at the end or after the call of fix_to_virt  :

*static noinline int do_test_wp_bit(void)
{
        char tmp_reg;
        int flag;

        __asm__ __volatile__(
                "       movb %0, %1     \n"
                "1:     movb %1, %0     \n"
                "       xorl %2, %2     \n"
                "2:                     \n"
                _ASM_EXTABLE(1b,2b)
                :"=m" (*(char *)fix_to_virt(FIX_WP_TEST)),
                 "=q" (tmp_reg),
                 "=r" (flag)
                :"2" (1)
                :"memory");

        return flag;
}*

I'm (quasi) sure that the problem is not that function, due to it works when
the kernel is not patched.
But where should I search ?

Can you give me some indications ?

Thanks,
Gilles

--0016367b5f20b2434604844d9fd9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I try to install a real-time Linux kernel on a Roboard based =
on a Vortex86DX (a x486 with TSC).<br><br>All works fine with :<br>Linux Ke=
rnel 2.6.30.10<br>Xenomai 2.5.1<div>Adeos patch adeos-ipipe-2.6.30.8-x86-2.=
4-09.patch</div>


<br>But, for all kernels upper or equal to 2.6.31, I always get a
double fault when testing WP bit. I have this double fault just after
that :<br><br><b>Checking if this processor honours the WP bit even in supe=
rvisor mode...</b><br>
<br>I traced with some simple printk that the problem occurs in this functi=
on, at the end or after the call of fix_to_virt=A0 :<br><br><b>static noinl=
ine int do_test_wp_bit(void)<br>{<br>=A0=A0=A0=A0=A0=A0=A0 char tmp_reg;<br=
>=A0=A0=A0=A0=A0=A0=A0 int flag;<br>


<br>=A0=A0=A0=A0=A0=A0=A0 __asm__ __volatile__(<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 &quot;=A0=A0=A0=A0=A0=A0 movb %0, %1=A0=A0=A0=A0 \n&q=
uot;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;1:=A0=A0=A0=A0 =
movb %1, %0=A0=A0=A0=A0 \n&quot;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 &quot;=A0=A0=A0=A0=A0=A0 xorl %2, %2=A0=A0=A0=A0 \n&quot;<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \n&quot;<br>


=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _ASM_EXTABLE(1b,2b)<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :&quot;=3Dm&quot; (*(char *)fix_to_=
virt(FIX_WP_TEST)),<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &qu=
ot;=3Dq&quot; (tmp_reg),<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 &quot;=3Dr&quot; (flag)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 :&quot;2&quot; (1)<br>


=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :&quot;memory&quot;);<br><br>=
=A0=A0=A0=A0=A0=A0=A0 return flag;<br>}</b><br><br>I&#39;m (quasi) sure tha=
t the problem is not that function, due to it works when the kernel is not =
patched.<br>But where should I search ?<br>


<br>Can you give me some indications ?<br><br>Thanks,<br><font color=3D"#88=
8888">Gilles</font>

--0016367b5f20b2434604844d9fd9--

