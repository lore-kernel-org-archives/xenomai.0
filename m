Message-ID: <2862c2c80708030127r2a9b5c8as49139fed67369644@domain.hid>
Date: Fri, 3 Aug 2007 16:27:50 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <18098.23646.615920.431030@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_84900_27104902.1186129670230"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
	<2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
	<18095.41752.74240.393339@domain.hid>
	<18095.43878.759358.210266@domain.hid>
	<2862c2c80707312153w1765ceaeo9d81a55db2ce6dea@domain.hid>
	<18098.23646.615920.431030@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
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
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_84900_27104902.1186129670230
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Thanks. I get what you mean and the problem is solved.

I saw the registration of TCs in the at91rm9200.c. Anyway, can you pinpoint
where the TC clocks are disable?

regards,
chun yeow

On 8/3/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Yeoh Chun Yeow wrote:
> > Dear Gilles,
> >
> > Did you figure out what is wrong with the I-PIPE patch?
> >
> > My kernel hangs at this stage, not even until the mounting of NFS:
> > udc: at91_udc version 3 May 2006
> > mice: PS/2 mouse device common for all mice
> > AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
> > TCP cubic registered
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> >
> > I find out that the problem is not coming from "excessive" interrupts
> that I
> > faced last time.
> >
> > Yes, when I-PIPE disabled, everything works fine.
>
> Ok, I got it. The problem is that the I-pipe patch registers its own
> clock object for the tc it uses. This is fine with the stock kernel
> which does not registers clock objects for tcs. But it fails to work
> with the AT91 patch, because the AT91 patch registers and disables the
> TC clocks. So, the solution is to use the kernel clock objects if they
> exist. This way, the I-pipe patch works with or without the AT91 patch.
> Attached a patch which does that.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>
> diff --git a/arch/arm/mach-at91rm9200/at91rm9200_time.c
> b/arch/arm/mach-at91rm9200/at91rm9200_time.c
> index 7b2d711..cda06f2 100644
> --- a/arch/arm/mach-at91rm9200/at91rm9200_time.c
> +++ b/arch/arm/mach-at91rm9200/at91rm9200_time.c
> @@ -36,6 +36,8 @@ static unsigned long last_crtr;
>
> #ifdef CONFIG_IPIPE
> #include <linux/clk.h>
> +#include <linux/stringify.h>
> +#include <linux/err.h>
> #include <linux/console.h>
> #include <linux/module.h>
> #include <asm/arch/at91_tc.h>
> @@ -371,10 +373,8 @@ static struct irqaction at91rm9200_timer_irq = {
>         .handler        = &at91rm9200_timer_interrupt
> };
>
> -static char clk_name [] = "tc%";
> -
> -static struct clk tc = {
> -       .name           = (const char *) clk_name,
> +static struct clk *tc, local_tc = {
> +       .name           = "tc" __stringify(CONFIG_IPIPE_AT91_TC) "_clk",
>         .users          = 0,
>         .type           = CLK_TYPE_PERIPHERAL,
>         .pmc_mask       = 1 << (KERNEL_TIMER_IRQ_NUM),
> @@ -391,9 +391,12 @@ void __init at91rm9200_timer_init(void)
>         if (clk_get_rate(clk_get(NULL, "mck")) != CONFIG_IPIPE_AT91_MCK)
>                 at91rm9200_timer_irq.handler = &at91rm9200_bad_freq;
>
> -       snprintf(clk_name, sizeof(clk_name), "tc%d",
> CONFIG_IPIPE_AT91_TC);
> -       clk_register(&tc);
> -       clk_enable(&tc);
> +       tc = clk_get(NULL, local_tc.name);
> +       if (IS_ERR(tc)) {
> +               tc = &local_tc;
> +               clk_register(tc);
> +       }
> +       clk_enable(tc);
>
>         /* No Sync. */
>         at91_tc_write(AT91_TC_BCR, 0);
> diff --git a/drivers/net/arm/at91_ether.c b/drivers/net/arm/at91_ether.c
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
>
>

------=_Part_84900_27104902.1186129670230
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Thanks. I get what you mean and the problem is solved.<br><br>I saw the registration of TCs in the at91rm9200.c. Anyway, can you pinpoint where the TC clocks are disable?<br><br>regards,<br>chun yeow<br>
<br><div><span class="gmail_quote">On 8/3/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Yeoh Chun Yeow wrote:<br> &gt; Dear Gilles,<br> &gt;<br> &gt; Did you figure out what is wrong with the I-PIPE patch?<br> &gt;<br> &gt; My kernel hangs at this stage, not even until the mounting of NFS:<br> &gt; udc: at91_udc version 3 May 2006
<br> &gt; mice: PS/2 mouse device common for all mice<br> &gt; AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire<br> &gt; TCP cubic registered<br> &gt; NET: Registered protocol family 1<br> &gt; NET: Registered protocol family 17
<br> &gt;<br> &gt; I find out that the problem is not coming from &quot;excessive&quot; interrupts that I<br> &gt; faced last time.<br> &gt;<br> &gt; Yes, when I-PIPE disabled, everything works fine.<br><br>Ok, I got it. The problem is that the I-pipe patch registers its own
<br>clock object for the tc it uses. This is fine with the stock kernel<br>which does not registers clock objects for tcs. But it fails to work<br>with the AT91 patch, because the AT91 patch registers and disables the<br>
TC clocks. So, the solution is to use the kernel clock objects if they<br>exist. This way, the I-pipe patch works with or without the AT91 patch.<br>Attached a patch which does that.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
<br><br>diff --git a/arch/arm/mach-at91rm9200/at91rm9200_time.c b/arch/arm/mach-at91rm9200/at91rm9200_time.c<br>index 7b2d711..cda06f2 100644<br>--- a/arch/arm/mach-at91rm9200/at91rm9200_time.c<br>+++ b/arch/arm/mach-at91rm9200/at91rm9200_time.c
<br>@@ -36,6 +36,8 @@ static unsigned long last_crtr;<br><br> #ifdef CONFIG_IPIPE<br> #include &lt;linux/clk.h&gt;<br>+#include &lt;linux/stringify.h&gt;<br>+#include &lt;linux/err.h&gt;<br> #include &lt;linux/console.h&gt;
<br> #include &lt;linux/module.h&gt;<br> #include &lt;asm/arch/at91_tc.h&gt;<br>@@ -371,10 +373,8 @@ static struct irqaction at91rm9200_timer_irq = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.handler&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= &amp;at91rm9200_timer_interrupt<br> };<br>
<br>-static char clk_name [] = &quot;tc%&quot;;<br>-<br>-static struct clk tc = {<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = (const char *) clk_name,<br>+static struct clk *tc, local_tc = {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;tc&quot; __stringify(CONFIG_IPIPE_AT91_TC) &quot;_clk&quot;,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.users&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 0,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = CLK_TYPE_PERIPHERAL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.pmc_mask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 1 &lt;&lt; (KERNEL_TIMER_IRQ_NUM),<br>@@ -391,9 +391,12 @@ void __init at91rm9200_timer_init(void)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (clk_get_rate(clk_get(NULL, &quot;mck&quot;)) != CONFIG_IPIPE_AT91_MCK)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at91rm9200_timer_irq.handler = &amp;at91rm9200_bad_freq;<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(clk_name, sizeof(clk_name), &quot;tc%d&quot;, CONFIG_IPIPE_AT91_TC);<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_register(&amp;tc);<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_enable(&amp;tc);
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tc = clk_get(NULL, local_tc.name);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(tc)) {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tc = &amp;local_tc;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_register(tc);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_enable(tc);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* No Sync. */
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at91_tc_write(AT91_TC_BCR, 0);<br>diff --git a/drivers/net/arm/at91_ether.c b/drivers/net/arm/at91_ether.c<br>diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c<br><br></blockquote></div><br>

------=_Part_84900_27104902.1186129670230--

