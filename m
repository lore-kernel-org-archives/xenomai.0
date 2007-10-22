Message-ID: <471C7308.7020409@domain.hid>
Date: Mon, 22 Oct 2007 11:53:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB255@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB255@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc4: freeze with RTAI skin,
 fine with other skins
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Hi,
> 
> As Philippe has been suggesting it, I've been testing v2.4-rc4 on x86 
> (not favourite board though :) with the RTAI skin (not my favourite skin
> too).
> Anyway, a legacy RTAI application which was fine with v2.3.2/2.6.20, is
> now 
> freezing the box randomly in the first 30 seconds. On the other hand, 
> the programs from the testsuite are running stable. So we may rule out 
> a problem in the I-Pipe/kernel.
> 
> For the legacy RTAI application to load, the attached patch was
> necessary.
> The patch against ksrc/skins/rtai/shm.c is somewhat defeating the
> purpose
> of a lower XNCORE_PAGE_SIZE, so a better fix might be expected.
> 

This one should prevent -EINVAL from being returned. Hopefully.

--- ksrc/skins/rtai/shm.c	(revision 3095)
+++ ksrc/skins/rtai/shm.c	(working copy)
@@ -150,8 +150,7 @@
 	/* Account for the overhead so that the actual free space is
 	   large enough to match the requested size. */

-	heapsize += xnheap_overhead(heapsize, XNCORE_PAGE_SIZE);
-	heapsize = XNCORE_PAGE_ALIGN(heapsize);
+	heapsize = xnheap_rounded_size(heapsize, XNCORE_PAGE_SIZE);

 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	err = xnheap_init_mapped(p->heap,

> The box is running FC5 on a pentium D, but kernel is compiled for UP.
> $ cat /proc/ipipe/version
> 1.10-09
> $ cat /proc/xenomai/version
> 2.4-rc4
> $ cat /proc/version
> Linux version 2.6.23.1 () (gcc version 4.1.1 20070105 (Red Hat
> 4.1.1-51))
> 
> The kernel config file is attached.
> 
> I'm currently stripping down the RTAI code out of the application
> in order to have a simple testbed reproducing the freeze.
> 
> In the mean time, does anyone have a clue where to look particularly?
> 

Hard to say at this point. Since the nucleus watchdog does not trigger,
you may want to try disabling X86_UP_IOAPIC while keeping X86_UP_APIC,
and arm the kernel NMI watchdog on the LAPIC (nmi_watchdog=2). You may
be lucky and have a backtrace after the freeze.

PS: maybe enabling all the nucleus debug options would catch something too.

> TIA
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

