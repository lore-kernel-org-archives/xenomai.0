Message-ID: <4C454D18.1030207@domain.hid>
Date: Tue, 20 Jul 2010 00:15:36 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid> <4C43D265.9080609@domain.hid>
	<4C43FC4F.3010006@domain.hid> <4C440D6F.1060204@domain.hid>
In-Reply-To: <4C440D6F.1060204@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------000808080904040201030900"
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000808080904040201030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  On the BeagleBoard...

    * The SD card/MMC is attached to the OMAP3530 chip MMC1 hardware
      Port. (The chip has 3 SD/MMC ports, numbered 1, 2, and 3.) The
      BeagleBoard connects the MMC2 port to an expansion connector and
      its not used in my application. The BeagleBoard does not use MMC3
      (not connected to anything).
    * The MMC1 hardware port is the first mmc port and is referred to in
      the kernel mmc0.
    * The OMAP controller for this port interrupts on IRQ 83.
    * The OMAP controller also uses SDMA channels 60 and 61 which
      results in other IRQs from the DMA controller.
    * The Card Detect signal from the SD card/MMC interface is wired to
      a TPS65950 chip
    * This TPS65950 chip presents the Card Detect interrupt to the
      OMAP3530 via sys_nirq[0]. This signal is mapped to IRQ 7. The
      TPS65950 can funnel up to 18 interrupts into sys_nirq[0].
    * The Level 2 interrupt handler maps the Card Detect interrupt to
      IRQ 384.  IRQ 384 is the first IRQ of the TWL4030 GPIO IRQ space.
      Apparently the the TWL4030 interrupt mapping is used for the TPS65950.
    * My SD card has two partitions. The first is a FAT partition
      containing the u-boot and kernel boot image. The second is a ext3
      partition containing the root file system.

It's possible that the kernel is expecting a Card Detect interrupt to 
proceed with the mounting of the root file system. I noticed that the 
/proc/interrupts listing that I mailed you showed 2 interrupts each on 
IRQ 384 and on IRQ 7.
Does Xenomai support TWL4030 style Level 2 interrupts?
Could pending interrupts have gotten lost when when Adeos initializes?

Regards,
Bob Feretich

On 7/19/2010 5:15 PM, Bob Feretich wrote:
> The debounce clock is not the source of the problem.
> On the 2430 chip, the debounce clock is under software control. For 
> the OMAP3 chips, its been placed under hardware control. So the 2.6.31 
> kernel classifies the  this message as a warning...
... snipped ...


--------------000808080904040201030900
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    On the BeagleBoard...<br>
    <ul>
      <li>The SD card/MMC is attached to the OMAP3530 chip MMC1 hardware
        Port. (The chip has 3 SD/MMC ports, numbered 1, 2, and 3.) The
        BeagleBoard connects the MMC2 port to an expansion connector and
        its not used in my application. The BeagleBoard does not use
        MMC3 (not connected to anything).</li>
      <li>The MMC1 hardware port is the first mmc port and is referred
        to in the kernel mmc0. <br>
      </li>
      <li>The OMAP controller for this port interrupts on IRQ 83.</li>
      <li>The OMAP controller also uses SDMA channels 60 and 61 which
        results in other IRQs from the DMA controller.</li>
      <li>The Card Detect signal from the SD card/MMC interface is wired
        to a TPS65950 chip <br>
      </li>
      <li>This TPS65950 chip presents the Card Detect interrupt to the
        OMAP3530 via sys_nirq[0]. This signal is mapped to IRQ 7. The
        TPS65950 can funnel up to 18 interrupts into sys_nirq[0].</li>
      <li>The Level 2 interrupt handler maps the Card Detect interrupt
        to IRQ 384.&nbsp; IRQ 384 is the first IRQ of the TWL4030 GPIO IRQ
        space. Apparently the the TWL4030 interrupt mapping is used for
        the TPS65950.</li>
      <li>My SD card has two partitions. The first is a FAT partition
        containing the u-boot and kernel boot image. The second is a
        ext3 partition containing the root file system.<br>
      </li>
    </ul>
    It's possible that the kernel is expecting a Card Detect interrupt
    to proceed with the mounting of the root file system. I noticed that
    the /proc/interrupts listing that I mailed you showed 2 interrupts
    each on IRQ 384 and on IRQ 7. <br>
    Does Xenomai support TWL4030 style Level 2 interrupts?<br>
    Could pending interrupts have gotten lost when when Adeos
    initializes?<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 7/19/2010 5:15 PM, Bob Feretich wrote: <br>
    <blockquote type="cite">The debounce clock is not the source of the
      problem.<br>
      On the 2430 chip, the debounce clock is under software control.
      For the OMAP3 chips, its been placed under hardware control. So
      the 2.6.31 kernel classifies the&nbsp; this message as a warning...</blockquote>
    ... snipped ...<br>
    <br>
  </body>
</html>

--------------000808080904040201030900--

