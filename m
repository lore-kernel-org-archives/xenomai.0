Date: Wed, 5 Mar 2008 14:40:48 +0100 (CET)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <47CE9A92.10206@domain.hid>
Message-ID: <Pine.LNX.4.64.0803051410580.394@domain.hid>
References: <Pine.LNX.4.64.0803041734290.26008@domain.hid>
	<47CE8544.9070800@domain.hid>
	<Pine.LNX.4.64.0803051337420.394@domain.hid>
	<47CE9A92.10206@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Shared IRQ issue with Xeno Peak PCI CAN driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 5 Mar 2008, Wolfgang Grandegger wrote:
> Klaas Gadeyne wrote:
>> On Wed, 5 Mar 2008, Wolfgang Grandegger wrote:
>>> Klaas Gadeyne wrote:
>>>> Hi,
>>>>
>>>> we're having a problem finding a non-shared IRQ for a PEAK systems can
>>>> board in a particular industrial SBC with PCI backplane [*].
>>>> Loading the xeno_can_peak_pci driver fails due to a "so-called" IRQ
>>>> conflict. (see below)
>>>>
>>>> However, it seems the IRQ (12) is not assigned, so this shouldn't be a
>>>> problem [**]?
>>
>> [...]
>>>> Any hints on how to debug this?  We've already tried everything
>>>> described in the FAQ (I guess), but we don't understand there's a
>>>> conflict even if nothing is listed in /proc/interrupts?
>>>
>>> There are two CAN controllers on the card, right? Therefore you need
>>> support for shared interrupts. Actually, requesting the IRQ 12 for the
>>> second CAN controller fails because it's already used by the first one.
>>
>> Thx! (we've just found out ourselves that the difference in behaviour
>> between the 2 pc's was indeed due to different xenomai versions
>> (<http://svn.gna.org/viewcvs/xenomai?rev=3291&view=rev>).
>
> Well, yes. Since commit 3291
>
> http://svn.gna.org/viewcvs/xenomai?rev=3291&view=rev
>
> the driver does not tolerate that failure any more. Do you prefer the
> old behavior (ignoring the failure and using just the first channel)?

Well, it took us quite some time to figure out what was wrong.  But
partly (hold tight, now comes the whole story :-) this was due to the
fact that 
- we ordered a new card recently and were not sure if the problem
   had something to do with the card.
- we already had problems on the SBC using shared interrupts with
   other boards before

So, when we read the error message

<quote>
"busy, check shared interrupt support"
</quote>

we did not think about problems originating to the 2 channels on the board,
and falsely concluded there was a problem sharing a RT and non-RT
interrupt.  Also, we did not install xenomai from source, but from a
package.  Hence, we did not review the kernel config options.

That said, 
1/ I just reviewed the Kconfig file and I think the
documentation is lacking behind

config XENO_DRIVERS_CAN_SJA1000_PEAK_PCI
         depends on XENO_DRIVERS_CAN_SJA1000
         tristate "PEAK PCI Card"
         help

         This driver is for the PCAN PCI, the PC-PCI CAN plug-in card
         (1 or 2 channel) from PEAK Systems (http://www.peak-system.com). To
         get the second channel working, Xenomai's shared interrupt support
         must be enabled.

2/ Maybe the error message could be somewhat more explicit?

Hence something like:

[kgad@domain.hid ~/SVN/xenomai-v2.4.x/ksrc/drivers/can/sja1000]$
  svn diff
Index: Kconfig
===================================================================
--- Kconfig     (revision 3533)
+++ Kconfig     (working copy)
@@ -27,9 +27,9 @@
         help

         This driver is for the PCAN PCI, the PC-PCI CAN plug-in card (1 or 
-       2 channel) from PEAK Systems (http://www.peak-system.com). To
-       get the second channel working, Xenomai's shared interrupt support
-       must be enabled.
+       2 channel) from PEAK Systems (http://www.peak-system.com). If
+       you have a card with 2 channels, Xenomai's shared interrupt
+       support must be enabled or the driver will refuse to load!

  config XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI
         depends on XENO_DRIVERS_CAN_SJA1000
Index: rtcan_sja1000.c
===================================================================
--- rtcan_sja1000.c     (revision 3533)
+++ rtcan_sja1000.c     (working copy)
@@ -765,7 +765,7 @@
      if (ret) {
         printk(KERN_ERR "ERROR %d: IRQ %d is %s!\n",
                ret, chip->irq_num, ret == -EBUSY ?
-              "busy, check shared interrupt support" : "invalid");
+              "busy. If you have a card with > 1 channel, check if CONFIG_XENO_OPT_SHIRQ* is set" : "invalid");
         return ret;
      }

Not kernel coding style, I know :-)

regards,

Klaas




