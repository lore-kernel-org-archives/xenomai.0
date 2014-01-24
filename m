Message-ID: <52E1D646.8050907@steinkuehler.net>
Date: Thu, 23 Jan 2014 20:56:06 -0600
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] ARM/BeagleBone Thumb2 Kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

So when I try to build a Xenomai patched kernel for the BeagleBone using
Thumb2 instructions, I get the following linker errors:

>   LD      init/built-in.o
> arch/arm/kernel/built-in.o: In function `__irq_usr':
> :(.kprobes.text+0x3c2): relocation truncated to fit: R_ARM_THM_JUMP19
> against symbol `__ipipe_ret_to_user_irqs_disabled' defined in .text
> section in arch/arm/kernel/built-in.o
> arch/arm/kernel/built-in.o: In function `ret_from_exception':
> :(.kprobes.text+0x600): relocation truncated to fit: R_ARM_THM_JUMP19
> against symbol `__ipipe_ret_to_user_irqs_disabled' defined in .text
> section in arch/arm/kernel/built-in.o
> make: *** [vmlinux] Error 1
> =

> The link error goes away if I disable CONFIG_THUMB2_KERNEL, which wasn't
> set in the original kernel config.

This has recently become more of a problem, as the default BeagleBone
kernel has switched to enabling CONFIG_THUMB2_KERNEL.

A bit of Googling turned up the following patch to fix a similar problem
on the Tegra (not Xenomai related):

  http://patchwork.ozlabs.org/patch/236760/

I applied a similar if-then patch (see below) to the two Xenomai calls
that generate the linker errors, and the result is a working kernel.

Can someone more familiar with iPipeand ARM assembly review the attached
minor patch and advise on whether or not it seems OK?

As I understand things, the two bne calls in the default ipipe patch
don't work when building a kernel using the thumb instructions due to
the limited range of the conditional branch.  Using the if-then
construct when THUMB2 is enabled allows for a larger addressing range in
the branch, thus avoiding the linker errors.  If this seems OK, perhaps
it should be applied to the master ipipe patch set?  If not, is there a
better way to avoid the linker errors when building with the thumb
instructions?

-- =

Charles Steinkuehler
charles@steinkuehler.net
-------------- next part --------------
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e2bc263..6f4d9f0 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -469,6 +469,7 @@ __irq_usr:
 	kuser_cmpxchg_check
 	irq_handler
 #ifdef CONFIG_IPIPE
+THUMB(	it	ne )
 	bne	__ipipe_ret_to_user_irqs_disabled
 #endif	/* CONFIG_IPIPE */
 	get_thread_info tsk
@@ -767,6 +768,7 @@ ENTRY(ret_from_exception)
 	disable_irq
 	bl	__ipipe_check_root
 	cmp     r0, #1
+THUMB(	it	ne )
 	bne	__ipipe_ret_to_user_irqs_disabled  @ Fast exit path over non-root dom=
ains
 #endif /* CONFIG_IPIPE */
 	get_thread_info tsk
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140123/8019559=
b/attachment.sig>
