From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 17 Dec 2007 23:50:48 +0100
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01A9B226@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01A9B226@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712172350.48963.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Oprofile with PPC in timer mode
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

Hi,

> I'm trying to get oprofile working on a MPC8270 with xenomai. However,
> hardware perofromance counters don't seem to work due to a bug in the
> 603 processor. I tried it with oprofile's timer mode without success.
> Before digging deeper: Has anyone experience with this? Since oprofile's
> timer mode requires interrupts not to be disabled, I suspect this
> interferes somehow with the adeos ipipe ...

I tried oprofile in timer mode on PPC405GPr (Linux 2.6.19.2 / Xenomai 2.3.3 / 
oprofile-0.9.3) a few months ago.

That was not working really well, opreport was not able to locate in which 
process the CPU was during any timer tick. After some instrumentation, I 
found out the instruction pointer was not passed to Linux through the 
interrupt pipeline.

So with this little patch,  the problem was fixed. I did not find enough time 
to double check what I did. Therefore, I did not send any mail to disclose 
the problem, which is not very nice.

Sorry.

Alexis.

diff -uNrp orig/arch/ppc/kernel/ipipe-root.c new/arch/ppc/kernel/ipipe-root.c
--- orig/arch/ppc/kernel/ipipe-root.c   2007-08-12 19:27:01.000000000 +0200
+++ new/arch/ppc/kernel/ipipe-root.c    2007-08-12 19:27:07.000000000 +0200
@@ -357,6 +357,10 @@ int __ipipe_grab_timer(struct pt_regs *r
 
        __ipipe_tick_regs[cpuid].msr = regs->msr; /* for do_timer() */
 
+#ifdef CONFIG_OPROFILE
+       __ipipe_tick_regs[cpuid].nip = regs->nip; /* for oprofile_tick() */
+#endif /* CONFIG_OPROFILE */
+
 #ifndef CONFIG_40x
        if (__ipipe_decr_ticks != tb_ticks_per_jiffy) {
                unsigned long long next_date, now;







