Message-ID: <48639233.7040803@domain.hid>
Date: Thu, 26 Jun 2008 08:57:23 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <4856B7AE.9030805@domain.hid> <4857682B.8060900@domain.hid>
	<4857BBCD.6020902@domain.hid> <48593525.2040103@domain.hid>
	<48594232.5020505@domain.hid> <485943D0.2000506@domain.hid>
	<48594CC9.4030408@domain.hid> <485A15D7.1000809@domain.hid>
In-Reply-To: <485A15D7.1000809@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------060804070203030609000508"
Subject: Re: [Xenomai-core] Compile-time bug,
	and problem with PPC440 ethernet
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
--------------060804070203030609000508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


>> Beautiful.  The patch works!  I now get DHCP replies.
>>
>> Is this the patch you will put into the official tree, or do you still
>> need to do more?
>>
>>     
>
> One thing, could you confirm that your network card relies on edge interrupts
> (and not level)?
>
> Aside of that, it should be ok. It's the same IRQ lock out issue fixed in the
> ppc/ branch recently.
>
>   

Sorry for the delay in getting back to you - vacation. 

The ethernet interrupts on the PPC440 are level-sensitive.  I gather
that is not what you were expecting, so I wonder what the implications are.

After looking at it more closely, I don't really understand this fix. 
uic_mask_ack_irq() is just uic_mask_irq() followed by uic_ack_irq(). 
So, why do you remove the ipipe_irq_lock() from uic_mask_ack_irq() and
not from uic_mask_irq()?  Also, since uic_unmask_irq() always calls
ipipe_irq_unlock(), doesn't that mean you can wind up with more unlocks
than locks (since uic_mask_ack_irq/uic_unmask_irq are no longer balanced)?

>> Also, please include my compile-time patch, if that is acceptible.
>>
>>     
>
> I recently committed a different fix for the same issue after you reported it.
> This should work without requiring additional #ifdef'ing as well. Thanks for the
> heads up.
>
> --- a/include/asm-powerpc/ipipe.h
> +++ b/include/asm-powerpc/ipipe.h
> @@ -62,8 +62,6 @@
>  		local_irq_enable_hw(); x;				\
>  	} )
>
> -#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
> -
>  struct ipipe_domain;
>
>  struct ipipe_sysinfo {
> @@ -209,4 +207,6 @@ do {									\
>
>  #endif /* CONFIG_IPIPE */
>
> +#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
> +
>  #endif /* !__ASM_POWERPC_IPIPE_H */
>   

Ok - thanks.  I'll apply that fix instead.

    Steve



--------------060804070203030609000508
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:485A15D7.1000809@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">Beautiful.  The patch works!  I now get DHCP replies.

Is this the patch you will put into the official tree, or do you still
need to do more?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
One thing, could you confirm that your network card relies on edge interrupts
(and not level)?

Aside of that, it should be ok. It's the same IRQ lock out issue fixed in the
ppc/ branch recently.

  </pre>
</blockquote>
<tt><br>
</tt><tt>Sorry for the delay in getting back to you - vacation.&nbsp; </tt><br>
<br>
<tt>The ethernet interrupts on the PPC440 are level-sensitive.&nbsp; I
gather that is not what you were expecting, so I wonder what the
implications are.<br>
<br>
After looking at it more closely, I don't really understand this fix.&nbsp;
uic_mask_ack_irq() is just uic_mask_irq() followed by uic_ack_irq().&nbsp;
So, why do you remove the ipipe_irq_lock() from uic_mask_ack_irq() and
not from uic_mask_irq()?&nbsp; Also, since uic_unmask_irq() always calls
ipipe_irq_unlock(), doesn't that mean you can wind up with more unlocks
than locks (since </tt><tt>uic_mask_ack_irq/</tt><tt>uic_unmask_irq
are no longer balanced)</tt><tt>?</tt><br>
<br>
<tt></tt>
<blockquote cite="mid:485A15D7.1000809@domain.hid" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">Also, please include my compile-time patch, if that is acceptible.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
I recently committed a different fix for the same issue after you reported it.
This should work without requiring additional #ifdef'ing as well. Thanks for the
heads up.

--- a/include/asm-powerpc/ipipe.h
+++ b/include/asm-powerpc/ipipe.h
@@ -62,8 +62,6 @@
 		local_irq_enable_hw(); x;				\
 	} )

-#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
-
 struct ipipe_domain;

 struct ipipe_sysinfo {
@@ -209,4 +207,6 @@ do {									\

 #endif /* CONFIG_IPIPE */

+#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
+
 #endif /* !__ASM_POWERPC_IPIPE_H */
  </pre>
</blockquote>
<tt><br>
Ok - thanks.&nbsp; I'll apply that fix instead.<br>
<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt><br>
</body>
</html>

--------------060804070203030609000508--

