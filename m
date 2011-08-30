MIME-Version: 1.0
Date: Tue, 30 Aug 2011 16:40:12 +0800
Message-ID: <CAMk6uB=6aJmndwmU14zu3S9QBH=tFy0xrub7kznUyZBqsTTdiQ@mail.gmail.com>
From: realmz6 <realmz6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] gpio irq always set to level sensitive with Xenomai
	on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, uclinux-dist-devel@domain.hid, adeos-main@gna.org

Hi Guys,

in adeos patch bfin_set_irq_handler(), this will set irq handle to
handle_level_irq even it is a edge gpio irq, is it true?

 #ifdef CONFIG_IPIPE
-       _set_irq_handler(irq, handle_level_irq);
-#else
-       struct irq_desc *desc = irq_desc + irq;
+       handle = __fixup_irq_handler(desc, handle_level_irq, 0);
+#endif

should it like the follows, it just fixup original handle and will not
always set it to handle_level_irq.

#ifdef CONFIG_IPIPE
-       _set_irq_handler(irq, handle_level_irq);
-#else
-       struct irq_desc *desc = irq_desc + irq;
+       handle = __fixup_irq_handler(desc, handle, 0);
+#endif

-steven

