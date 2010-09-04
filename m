From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1283531433.789315367@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid>  <1281960823.030215299@domain.hid>
	<4C692FC3.5040802@domain.hid>  <1283531433.789315367@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 04 Sep 2010 10:51:25 +0200
Message-ID: <1283590285.1709.2153.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2010-09-03 at 17:30 +0100,
edward.robbins@domain.hid wrote:
> I have now installed the i-pipe tracer and run some tests. Yesterday I thought I had gotten a high latency without X running, while compiling the kernel to stress the system, but now I think I might have been mistaken. Either way I was using a kernel whose configuration I couldn't remember, and didn't have the I-Pipe tracer installed at that time, so the observation wasn't particularly useful.
> 
> Today I have tried using the intel video driver with the option "NoAccel", and that seems to stop the high latencies; with this option I can kill X, restart it, and run glxgears without issues, all while compiling the linux kernel and having xeno-test or latency running. The highest latency I have gotten so far is 18uS. 
> 
> However, if anyone is interested I have made a trace without the NoAccel option, when the latency jumped to 1113uS upon starting X, attached.
> 
> A couple of other things:
> 
> Yesterday when running xeno-test, I got a few of these messages:
>    "INFO: task sync:20539 blocked for more than 120 seconds...."
> I have not seen this again today, and I don't know if it could be related, but I was also getting lots of strange USB disconnect sort of messages yesterday... I haven't seen any more today, and as I said before that kernel may have been useless anyway.
> 
> I am also getting this message from xeno-test:
>    "FATAL: module xeno-nucleus not found"
> 
> And:
>    "Warning Linux is compiled to use FPU in kernel space
>     For this reason, switch test can not test using FPU in Linux Kernel-space"
> 
> I presume these last two are because I did something wrong at kernel compile time?
> 
> Also, I tried to compile Xenomai 2.5.4 with a 2.6.34 kernel because it has a network driver that I really need, but the build failed. I think this has been resolved previously (as I have seen some information in the mailing list about a problem in the debian kernel patch script), but am not sure how to use the corrected script with my system. Can anyone help?
> 
> I will keep testing.

Please try this patch. Your trace log reveals that we are only virtually
masking interrupts while flushing the TLB, which is quite wrong.

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 7f3eba0..b0a4112 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -30,7 +30,7 @@ static inline void __native_flush_tlb_global(void)
 	 * from interrupts. (Use the raw variant because this code can
 	 * be called from deep inside debugging code.)
 	 */
-	raw_local_irq_save(flags);
+	local_irq_save_hw(flags);
 
 	cr4 = native_read_cr4();
 	/* clear PGE */
@@ -38,7 +38,7 @@ static inline void __native_flush_tlb_global(void)
 	/* write old PGE again and flush TLBs */
 	native_write_cr4(cr4);
 
-	raw_local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 static inline void __native_flush_tlb_single(unsigned long addr)

-- 
Philippe.



