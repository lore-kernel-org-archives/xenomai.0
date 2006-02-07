Message-ID: <43E8C523.2030107@domain.hid>
Date: Tue, 07 Feb 2006 17:04:51 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>	<43E0BEC1.2060400@domain.hid>
	<43E73441.9090702@domain.hid>
In-Reply-To: <43E73441.9090702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Slow is faster arch/ppc/syslib/open_pic.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

When trying to run Xenomai on PowerPC with OpenPIC, I have (finally) found that 
interrupt latency is much improved with the following patch:



--- arch/ppc/syslib/open_pic.c~ 2006-01-08 03:15:24.000000000 +0100
+++ arch/ppc/syslib/open_pic.c  2006-02-07 16:56:14.000000000 +0100
@@ -820,7 +820,7 @@
   */
  static void openpic_ack_irq(unsigned int irq_nr)
  {
-#ifdef __SLOW_VERSION__
+#if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
         openpic_disable_irq(irq_nr);
         openpic_eoi();
  #else
@@ -831,7 +831,7 @@

  static void openpic_end_irq(unsigned int irq_nr)
  {
-#ifdef __SLOW_VERSION__
+#if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
         if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
             && irq_desc[irq_nr].action)
                 openpic_enable_irq(irq_nr);



The reason for this, is that the fast version doesn't call openpic_eoi until the 
interrupt is ended, which means that all RT-interrupts are delayed by a pending 
Linux interrupt.

-- 

Regards

Anders Blomdell

