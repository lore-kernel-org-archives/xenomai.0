Message-ID: <481B2CF9.9000404@domain.hid>
Date: Fri, 02 May 2008 17:02:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <481AA6B5.9070508@domain.hid> <481AC93E.3030107@domain.hid>
	<6B8F1229FFBDCA47BA5C9712C46F18DF493016@domain.hid>
In-Reply-To: <6B8F1229FFBDCA47BA5C9712C46F18DF493016@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] MSI Interrupt Crash
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
To: Thomas Schaefer <thomass@domain.hid>
Cc: xenomai@xenomai.org

Thomas Schaefer wrote:
> 
>> Does this help?
>>
>> --- include/asm-x86/wrappers_64.h	(revision 3719)
>> +++ include/asm-x86/wrappers_64.h	(revision 3720)
>> @@ -31,8 +31,8 @@
>>  #define rthal_irq_descp(irq)		(irq_desc + irq)
>>  #define rthal_irq_desc_status(irq)	(rthal_irq_descp(irq)->status)
>>
>> -#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
>>> enable(irq); 0; })
>> -#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
>>> disable(irq); 0; })
>> +#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
>>> unmask(irq); 0; })
>> +#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
>>> mask(irq); 0; })
>>  #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)-
>>> ipipe_end(irq, rthal_irq_descp(irq));
>> 0; })
>>
>>  typedef irq_handler_t rthal_irq_host_handler_t;
> 
> We are using the current version from the SVN repository and those
> changes are already in there.
> 

Please send the output back:

--- ksrc/arch/x86/hal-common.c	(revision 3734)
+++ ksrc/arch/x86/hal-common.c	(working copy)
@@ -347,8 +347,20 @@
 	if (irq >= NR_IRQS)
 		return -EINVAL;

+	if (rthal_irq_descp(irq)->chip == NULL) {
+		printk(KERN_ERR "Xenomai: %s: no chip descriptor for irq %u\n", __FUNCTION__, irq);
+		return 0;
+	}
+
 	rthal_irq_desc_status(irq) &= ~IRQ_DISABLED;

+	if (rthal_irq_descp(irq)->chip->unmask == NULL) {
+		printk(KERN_ERR "Xenomai: NULL unmask handler for irq %u, chip %s (->enable=%p)\n",
+		       irq, rthal_irq_descp(irq)->chip->name,
+		       rthal_irq_descp(irq)->chip->enable);
+		return 0;
+	}
+
 	return rthal_irq_chip_enable(irq);
 }

@@ -358,8 +370,20 @@
 	if (irq >= NR_IRQS)
 		return -EINVAL;

+	if (rthal_irq_descp(irq)->chip == NULL) {
+		printk(KERN_ERR "Xenomai: %s: no chip descriptor for irq %u\n", __FUNCTION__, irq);
+		return 0;
+	}
+
 	rthal_irq_desc_status(irq) |= IRQ_DISABLED;

+	if (rthal_irq_descp(irq)->chip->mask == NULL) {
+		printk(KERN_ERR "Xenomai: NULL mask handler for irq %u, chip %s (->disable=%p)\n",
+		       irq, rthal_irq_descp(irq)->chip->name,
+		       rthal_irq_descp(irq)->chip->disable);
+		return 0;
+	}
+
 	return rthal_irq_chip_disable(irq);
 }

-- 
Philippe.

