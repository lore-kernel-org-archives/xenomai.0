Message-ID: <40A399BC.9080001@domain.hid>
Date: Thu, 13 May 2004 17:52:28 +0200
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] ADEOS for ARM: irq vectors ?
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hi there,

I am looking at the file

http://download.gna.org/adeos/patches/v2.4/arm/adeos-linux-2.4.19-arm-rmk7-pxa2-r12.patch

and find the code:

#elif defined(CONFIG_ARCH_SA1100)

                 .macro  disable_fiq
                 .endm

                 .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
                 mov     r4, #0xfa000000                 @ ICIP = 0xfa050000
                 add     r4, r4, #0x00050000
                 ldr     \irqstat, [r4]                  @ get irqs
                 ldr     \irqnr, [r4, #4]                @ ICMR = 0xfa050004
                 ands    \irqstat, \irqstat, \irqnr
                 mov     \irqnr, #0
                 beq     1001f
#ifdef CONFIG_ADEOS_CORE
                 tst     \irqstat, #0x04000000   @ check OSMR0 first
                 movne   \irqnr, #26
                 bne     1001f
#endif /* CONFIG_ADEOS_CORE */
                 tst     \irqstat, #0xff
                 moveq   \irqstat, \irqstat, lsr #8
                 addeq   \irqnr, \irqnr, #8
...

What's the point here?

Does it mean that if an interrupt occured and it was a timer interrupt

     tst     \irqstat, #0x04000000   @ check OSMR0 first

then irqnr (=R0) is loaded with the value "26" ...

So ADEOS replace the interrupt "vector 26" with its own code that gets 
called instead of the normal timer interrupt? Is that correct? Where is it done?

Thanks!

Steven


