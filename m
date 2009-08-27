MIME-Version: 1.0
In-Reply-To: <4A9566C9.7000805@domain.hid>
References: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>
	<4A9566C9.7000805@domain.hid>
Date: Thu, 27 Aug 2009 10:46:05 +0200
Message-ID: <2f7260f50908270146h4e80b012q22d00219e62233be@domain.hid>
From: =?ISO-8859-1?Q?Imanol_Mart=EDnez?= <imanolmc@domain.hid>
Content-Type: multipart/alternative; boundary=00032555753224b53e04721b99df
Subject: Re: [Xenomai-help] Problem with PXA320 and xenomai 2.4.9
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

--00032555753224b53e04721b99df
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>Please check that when starting from the configuration where you have
>the bug, if you disable Xenomai (CONFIG_XENOMAI) and the interrupt
>pipeline (CONFIG_IPIPE), the system works.

This way it works, but when applying the patch it still does not work, I get
the same error...

>If it works, could you try the attached patch?
>diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
>index f6e0300..f8a25d5 100644
>--- a/arch/arm/mach-pxa/irq.c
>+++ b/arch/arm/mach-pxa/irq.c
>@@ -111,7 +111,11 @@ static void __init pxa_init_low_gpio_irq(set_wake_t
fn)

>       for (irq = IRQ_GPIO0; irq <= IRQ_GPIO1; irq++) {
>               set_irq_chip(irq, &pxa_low_gpio_chip);
>+#ifndef CONFIG_IPIPE
>               set_irq_handler(irq, handle_edge_irq);
>+#else /* CONFIG_IPIPE */
>+               set_irq_handler(irq, handle_level_irq);
>+#endif /* CONFIG_IPIPE */
>               set_irq_flags(irq, IRQF_VALID);
>      }




--
                                          Gilles

--00032555753224b53e04721b99df
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">&gt;Please check that when starting from the con=
figuration where you have<br>
&gt;the bug, if you disable Xenomai (CONFIG_XENOMAI) and the interrupt<br>
&gt;pipeline (CONFIG_IPIPE), the system works.<br>
<br>This way it works, but when applying the patch it still does not work, =
I get the same error...<br><br>
&gt;If it works, could you try the attached patch?<br>
&gt;diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c<br>
&gt;index f6e0300..f8a25d5 100644<br>
&gt;--- a/arch/arm/mach-pxa/irq.c<br>
&gt;+++ b/arch/arm/mach-pxa/irq.c<br>
&gt;@@ -111,7 +111,11 @@ static void __init pxa_init_low_gpio_irq(set_wake_=
t fn)<br>
<br>
 &gt;=A0 =A0 =A0=A0 for (irq =3D IRQ_GPIO0; irq &lt;=3D IRQ_GPIO1; irq++) {=
<br>
 &gt;=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 set_irq_chip(irq, &amp;pxa_low_gpio_chi=
p);<br>&gt;+#ifndef CONFIG_IPIPE<br>
 &gt;=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 set_irq_handler(irq, handle_edge_irq);<=
br>&gt;+#else /* CONFIG_IPIPE */<br>
&gt;+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq, handle_level_irq);<b=
r>
&gt;+#endif /* CONFIG_IPIPE */<br>
 &gt;=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 set_irq_flags(irq, IRQF_VALID);<br>
 &gt; =A0 =A0=A0 }<br>
<br>
<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
<br>
</font></div><br>

--00032555753224b53e04721b99df--

