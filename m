From: Dirk Roloff <roloff@domain.hid>
Date: Mon, 23 Feb 2004 21:11:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402232111.55260.roloff@domain.hid>
Subject: [Adeos-main] Priority of interrupts
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi List,

i read something about priority in PIC
0,1,2(cascade),8,9,10,11,12,13,14,15,3,4,5,6,7

? Is this used in linux or is the rotating mode enabled ?

* IRQ 0 has high priority 7 very low.
* if IRQ 7 is running it will be interrupted by all other irqs.
* In linux a incomming IRQ 8 will be acked by sending EOI
* IRQ 8 will be masked in IMR

? Will this running isr now interrupted by IRQ 7 with much lower prio (of cause in sti mode) ? 
? will the pic deliver the IRQ 7 just befor we leave the isr with iret ?

? How dose this work on APIC IO-APIC on SMP / UP

Thanks for helping me to understand this basics.

Dirk



