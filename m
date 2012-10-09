Message-ID: <50743048.1050305@xenomai.org>
Date: Tue, 09 Oct 2012 16:10:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmtLLcZnbJ5vXJFRkdyoy1Qk_wfGR84LdB0dkb8KynS+Yg@mail.gmail.com>
In-Reply-To: <CANKLDmtLLcZnbJ5vXJFRkdyoy1Qk_wfGR84LdB0dkb8KynS+Yg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Exporting __ipipe_get_cs_tsc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 10/09/2012 02:32 PM, Henri Roosen wrote:
> Hi,
> 
> I'm using the current git heads of core-3.4 and xenomai 2.6.1 for x86
> with the attached config file.
> 
> When compiling the modules I get undefined symbols:
> ERROR: "__ipipe_get_cs_tsc" [kernel/xenomai/skins/posix/xeno_posix.ko]
> undefined!
> 
> This is because the run time seleted __ipipe_get_cs_tsc assembly
> function is not exported for module use.
> I don't know how to export this or whether the symbol should be used
> by modules in the first place.
> 

Please try this:

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 430aeea..2d2f83c 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -634,6 +634,11 @@ void update_vsyscall(struct timespec *wall_time,
struct timespec *wtm,
 void update_vsyscall_tz(void)
 {
 }
+
+#ifdef CONFIG_IPIPE_WANT_CLOCKSOURCE
+EXPORT_SYMBOL_GPL(__ipipe_get_cs_tsc);
+#endif
+
 #endif /* CONFIG_X86_32 */

 struct task_struct *__switch_to(struct task_struct *prev_p,
> Please advice.
> 
> Thanks,
> Henri.
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: .config
> Type: application/octet-stream
> Size: 57776 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121009/524a0516/attachment.obj>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

