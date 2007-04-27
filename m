From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <784082.1177682909759.JavaMail.ngmail@domain.hid>
References: <4631FF09.2000601@domain.hid> <4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 16:19:52 +0200
Message-Id: <1177683592.5010.84.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-04-27 at 16:08 +0200, M. Koehrer wrote:
> Hi Jan, 
> 
> here is the result - I have logged with a serial console (as my kernel freezes).
> There are many printk messages...
> 

--- arch/i386/kernel/ipipe.c~	2007-02-26 10:31:39.000000000 +0100
+++ arch/i386/kernel/ipipe.c	2007-04-27 16:19:06.000000000 +0200
@@ -167,6 +167,7 @@
 static int __ipipe_ack_irq(unsigned irq)
 {
 	irq_desc_t *desc = irq_desc + irq;
+	BUG_ON(!desc->ipipe_ack);
 	desc->ipipe_ack(irq, desc);
 	return 1;
 }

-- 
Philippe.



