Message-ID: <507C8977.506@nta-inc.net>
Date: Mon, 15 Oct 2012 17:08:55 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Problem with ipipe-core-3.2.21-x86-1.patch?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to build xenomai from the xenomai-2.6.git repo under ubuntu 12.04 on a x86_64 desktop machine.  When I try to build a xenomai-enabled kernel from the 3.2.21 sources, the build fails with a compile error.  (Sorry, I didn't save the error message, but I can repeat the process if necessary.)  In order to get things to compile, I made the following change to ipipe-core-3.2.21-x86-1.patch.  Is this a bug?  If so, I'm wondering why no one else has run into this one yet.  I think I built a kernel without any compiler errors under ubuntu 10.04 using this patch, but I'm not 100% certain about that.

-Jeff

diff --git a/ksrc/arch/x86/patches/ipipe-core-3.2.21-x86-1.patch b/ksrc/arch/x86/patches/ipipe-core-3.2.21-x86-1.patch
index 18b23be..58bdbf4 100644
--- a/ksrc/arch/x86/patches/ipipe-core-3.2.21-x86-1.patch
+++ b/ksrc/arch/x86/patches/ipipe-core-3.2.21-x86-1.patch
@@ -1751,12 +1751,12 @@ index 6d939d7..9bbe781 100644
   #ifdef CONFIG_SMP
   	chip->irq_set_affinity = ir_ioapic_set_affinity;
  +#ifdef CONFIG_IPIPE
-+	chip->irq_move = move_xxapic_irq,
++	chip->irq_move = move_xxapic_irq;
  +#endif
  +#endif
  +#ifdef CONFIG_IPIPE
-+	chip->irq_hold = hold_ioapic_irq,
-+	chip->irq_release = release_ioapic_irq,
++	chip->irq_hold = hold_ioapic_irq;
++	chip->irq_release = release_ioapic_irq;
   #endif
   }
   #endif /* CONFIG_IRQ_REMAP */

