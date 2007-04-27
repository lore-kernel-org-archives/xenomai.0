From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1646519.1177684097169.JavaMail.ngmail@domain.hid>
References: <1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 16:56:01 +0200
Message-Id: <1177685762.5010.104.camel@domain.hid>
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

On Fri, 2007-04-27 at 16:28 +0200, M. Koehrer wrote:
> Hello Philippe,
> 
> here it is: (I have no idea what BUGON does...)
> 

This patch will print out the irq/vector mappings. I'm interested in
reading this output.

--- arch/i386/kernel/io_apic.c~	2007-02-26 10:31:39.000000000 +0100
+++ arch/i386/kernel/io_apic.c	2007-04-27 16:51:51.000000000 +0200
@@ -1259,6 +1259,7 @@
 	current_vector = vector;
 	current_offset = offset;
 	irq_vector[irq] = vector;
+	printk("IRQ %d vectored at #%2x\n", irq, vector);
 
 	return vector;
 }

-- 
Philippe.



