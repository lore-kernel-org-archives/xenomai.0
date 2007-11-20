From: Dennis Nguyen <dennisnguy@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 14:42:08 -0800
Message-Id: <1195598528.25407.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled. Disable IRQ
	line.
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

Hello,

I'm using linux kernel 2.6.22.12, xenomai 2.4-rc6, and rtnet trunk 1140
date 11/15/2007. There are 2 8139 RealTek nics in the system 

I got the disable IRQ messages when loading RTnet modules:
Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disable IRQ line.
Xenomai: xnintr_shirq_handler: IRQ10 not handled. Disable IRQ line.

one nic using IRQ 11 and the other using IRQ 10
These cause the rteth0 and rteth1 not receive any packages.

How can I enable the interrupts? or control so that the
xnintr_shirq_handler not disable the interrupts?

Thanks in advance.
Dennis  



