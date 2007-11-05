Message-ID: <472F990A.2030209@domain.hid>
Date: Mon, 05 Nov 2007 23:28:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid> <472F6DAD.20308@domain.hid>
In-Reply-To: <472F6DAD.20308@domain.hid>
Content-Type: multipart/mixed; boundary="------------050604040600040406080206"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------050604040600040406080206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> This patch addresses the recently discovered issue that I-pipe actually
>> need to deal with faults over non-root domain in which the current
>> domain shows no interest in. Such faults could be triggered inside
>> copy_*_user, thus can cleanly be handled by Linux - if we only allow for
>> this. Currently, if debugging is on, we warn about a potential bug, and
>> corrupt the pipeline states otherwise.
>>
>> The new approach is to unconditionally drop to root domain in such
>> cases, but - for debugging purposes of non-fixable faults - keep track
>> of the original domain and report it on oops.
>>
>> Similar patches are required for other archs. Maybe I can look into
>> x86_64 later.
>>

Nak, this patch would not work as wanted. Again, what you need is to 
always fixup, and conditionally send a bug report to the kernel log if 
CONFIG_IPIPE_DEBUG is enabled, nothing more.

This patch assumes that die() is always going to be fired for any 
in-kernel fault, so that all reports only need to go through this 
routine, which is wrong. Kernel fixups through exception tables may fix 
the fault early and silently, and this is particularly the case for 
copy_to_user helpers, which do include kernel fixup code.  By being 
silent when fixing up things in __ipipe_handle_exception() like your 
patch currently is, we would be left with no trace at all that some 
unhandled fault just happened, except by looking at /proc/xenomai/faults.

By sending the report immediately when fixing up in the latter routine, 
you also avoid the ugly ipipe_orig_domain stuff.

--------------050604040600040406080206
Content-Type: text/x-patch;
 name="fixup-unhandled-fault.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixup-unhandled-fault.patch"

diff --git a/arch/i386/kernel/ipipe.c b/arch/i386/kernel/ipipe.c
index bf6443d..9323951 100644
--- a/arch/i386/kernel/ipipe.c
+++ b/arch/i386/kernel/ipipe.c
@@ -644,16 +644,20 @@ fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int
 #endif /* CONFIG_KGDB */
 
 	if (!ipipe_trap_notify(vector, regs)) {
-#ifdef CONFIG_IPIPE_DEBUG
 		if (!ipipe_root_domain_p) {
 			/* Fix up domain so that Linux can handle this. */
+#ifdef CONFIG_IPIPE_DEBUG
+			struct ipipe_domain *ipd = ipipe_current_domain;
 			ipipe_current_domain = ipipe_root_domain;
 			ipipe_trace_panic_freeze();
 			printk(KERN_ERR "BUG: Unhandled exception over domain"
 					" %s - switching to ROOT\n",
-					ipipe_current_domain->name);
-		}
+					ipd->name);
+			dump_stack();
+#else
+			ipipe_current_domain = ipipe_root_domain;
 #endif /* CONFIG_IPIPE_DEBUG */
+		}
 		__ipipe_std_extable[vector](regs, error_code);
 		local_irq_restore(flags);
 		__fixup_if(regs);

--------------050604040600040406080206--

