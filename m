From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3878120.1166714345679.JavaMail.ngmail@domain.hid>
References: <1166710393.4960.13.camel@domain.hid>
	<b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<3878120.1166714345679.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 17:54:40 +0100
Message-Id: <1166720080.4960.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: Re: Re: Re: Re: A fairly small rtnet/Xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-12-21 at 16:19 +0100, M. Koehrer wrote:
> Hi Philippe,
> 
> > - does enabling CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP in
> > the kernel hacking section cause Linux warnings to appear while the test
> > code runs over 2.6.19, before the box crashes?
> 
> Unfortunately, I am not able to get the xeno_nucleus compiled when I have the 
> kernel hacking configuration set as proposed. 
> The kernel linker complains about an undefined "tasklist_lock" in xeno_nucleus.ko
> Thus, I am not able to perform this test.
> 

This patch against the linux tree fixes the issue:

--- arch/i386/kernel/ipipe.c~	2006-12-18 22:03:37.000000000 +0100
+++ arch/i386/kernel/ipipe.c	2006-12-21 17:52:22.000000000 +0100
@@ -901,6 +901,7 @@
 EXPORT_SYMBOL_GPL(show_stack);
 EXPORT_PER_CPU_SYMBOL_GPL(init_tss);
 #ifdef CONFIG_SMP
+EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(__ipipe_logical_cpuid);
 EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 #endif /* CONFIG_SMP */

> Regards
> Mathias
> 
-- 
Philippe.



