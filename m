Message-ID: <4720AC27.9040705@domain.hid>
Date: Thu, 25 Oct 2007 10:45:59 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <4720A719.7090100@domain.hid> <4720AB1B.4060300@domain.hid>
In-Reply-To: <4720AB1B.4060300@domain.hid>
Content-Type: multipart/mixed; boundary="------------050806080206050805050003"
Subject: Re: [Xenomai-core] kernel BUG running cyclictest on powerpc 405
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050806080206050805050003
Content-Type: multipart/alternative;
 boundary="------------030500090509080605050803"


--------------030500090509080605050803
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks!  I'll try your patch and report if I still have trouble.

I've attached my patch for PPC405.

    Steve

Philippe Gerum wrote:
> Steven A. Falco wrote:
>   
>> I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai 2.4-rc3. 
>> Architecture is powerpc, processor is a 405GP.
>>
>> I had to make some additions to arch/powerpc/kernel/head_40x.S, and I
>> can submit a patch if someone tells me where to post it.
>>
>>     
>
> Here would be nice, or to the Adeos list, indifferently - I would pick
> it from both anyway.
>
>   
>> However, while the kernel boots and runs, the xenomai user apps do not
>> work correctly.  Specifically, when running cyclictest, I get the following:
>>
>>     
>
> This patch should fix this issue.
>
> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
> index eeb38e2..5a38086 100644
> --- a/arch/powerpc/sysdev/uic.c
> +++ b/arch/powerpc/sysdev/uic.c
> @@ -48,7 +48,7 @@ struct uic {
>  	int index;
>  	int dcrbase;
>
> -	spinlock_t lock;
> +	ipipe_spinlock_t lock;
>
>  	/* The remapper for this UIC */
>  	struct irq_host	*irqhost;
>   
>> How do I debug this?  I have done a little kernel hacking, but I am a
>> noob when it comes to Xenomai...
>>
>>     
>
> Well, actually, it's shame on me. I did not notice that the universal
> interrupt controller code was missing some bits in post-2.6.21 I-pipe
> patches.
>
>   

--------------030500090509080605050803
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>Thanks!  I'll try your patch and report if I still have trouble.<br>
<br>
I've attached my patch for PPC405.<br>
<br>
    Steve<br>
</tt><br>
Philippe Gerum wrote:
<blockquote cite="mid:4720AB1B.4060300@domain.hid" type="cite">
  <pre wrap="">Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai 2.4-rc3. 
Architecture is powerpc, processor is a 405GP.

I had to make some additions to arch/powerpc/kernel/head_40x.S, and I
can submit a patch if someone tells me where to post it.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Here would be nice, or to the Adeos list, indifferently - I would pick
it from both anyway.

  </pre>
  <blockquote type="cite">
    <pre wrap="">However, while the kernel boots and runs, the xenomai user apps do not
work correctly.  Specifically, when running cyclictest, I get the following:

    </pre>
  </blockquote>
  <pre wrap=""><!---->
This patch should fix this issue.

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index eeb38e2..5a38086 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -48,7 +48,7 @@ struct uic {
 	int index;
 	int dcrbase;

-	spinlock_t lock;
+	ipipe_spinlock_t lock;

 	/* The remapper for this UIC */
 	struct irq_host	*irqhost;
  </pre>
  <blockquote type="cite">
    <pre wrap="">How do I debug this?  I have done a little kernel hacking, but I am a
noob when it comes to Xenomai...

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, actually, it's shame on me. I did not notice that the universal
interrupt controller code was missing some bits in post-2.6.21 I-pipe
patches.

  </pre>
</blockquote>
</body>
</html>

--------------030500090509080605050803--

--------------050806080206050805050003
Content-Type: text/x-patch;
 name="ipipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe.patch"

--- linux-2.6-denx.xenomai/arch/powerpc/kernel/head_40x.S	2007-09-28 13:40:46.000000000 -0400
+++ linux-2.6-denx/arch/powerpc/kernel/head_40x.S	2007-10-24 14:02:23.000000000 -0400
@@ -227,6 +227,12 @@
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
 			  ret_from_except_full)
 
+#ifdef CONFIG_IPIPE
+#define EXC_XFER_IPIPE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
+			  __ipipe_ret_from_except)
+#endif /* CONFIG_IPIPE */
+
 #define EXC_XFER_LITE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
@@ -395,7 +401,11 @@
 	EXC_XFER_EE_LITE(0x400, handle_page_fault)
 
 /* 0x0500 - External Interrupt Exception */
+#ifdef CONFIG_IPIPE
+	EXCEPTION(0x0500, HardwareInterrupt, __ipipe_grab_irq, EXC_XFER_IPIPE)
+#else /* !CONFIG_IPIPE */
 	EXCEPTION(0x0500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
+#endif /* CONFIG_IPIPE */
 
 /* 0x0600 - Alignment Exception */
 	START_EXCEPTION(0x0600, Alignment)
@@ -433,7 +443,11 @@
 	lis	r0,TSR_PIS@h
 	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_IPIPE
+	EXC_XFER_IPIPE(0x1000, __ipipe_grab_timer)
+#else /* !CONFIG_IPIPE */
 	EXC_XFER_LITE(0x1000, timer_interrupt)
+#endif /* CONFIG_IPIPE */
 
 #if 0
 /* NOTE:

--------------050806080206050805050003--

