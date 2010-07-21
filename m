Message-ID: <4C468040.3030509@domain.hid>
Date: Tue, 20 Jul 2010 22:06:08 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
In-Reply-To: <4C46141F.50103@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------050206060301020104050303"
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
--------------050206060301020104050303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Xenomai booted with the 2.6.33 kernel on BeagleBoard!
I built the below 2.6.33 kernels...

    * No Angstrom patches, no Adeos patch - - it booted, I noticed that
      /proc/interrupts showed no interrupts occurred on IRQs 7 or 378
      (SD card Detect). The 2.6.31 kernel showed 2 on each IRQ just
      after boot.
    * No Angstrom patches, Adeos patch, but Xenomai disabled - - it
      booted. Still no interrupts on IRQs 7 or 378.
    * No Angstrom patches, Adeos patch, and Xenomai enabled - - it
      booted! :-)   Still no interrupts on IRQs 7 or 378.

Something obviously changed in the kernel between 2.6.31 and 2.6.33 to 
suppress the IRQ 378 interrupts that occurred at boot time. This change 
*may* be the reason that Xenomai works on the Beagleboard at 2.6.33, but 
not at 2.6.31.

I suspect that the Adeos patch may have trouble handling Level 2 
interrupts coming through a twl4030 device. I know that it is an OMAP 
design practice to route the SD/MMC Card Detect interrupt through this 
device. The device also controls several voltage regulators supplying 
power to the board and OMAP chip. Overvoltage/undervoltage/thermal 
alerts may also be originated by this device.

The easiest way to test the twl4030 interrupt handling may be to use the 
SD Card for a removable file system (not root). If the file system 
automounts when the SD Card is plugged in, that would indicate that the 
twl4030 interrupts are being handled correctly. From the available 
documentation, the micro-SD card slot on the IGEPv2 should be able to be 
used for this testing.

My current dilemma is to figure out how to move the pieces of Angstrom 
that I want from the 2.6.32 kernel system to the 2.6.33 kernel ahead of 
the Angstrom train. :-(

Many thanks for you help Gilles.

Now that I can see Xenomai running, is there any documentation that 
describes useful things I can poke to obtain Xenomai state, status and 
statistics? (for example the meanings of the data in the /proc/Xemomai 
directory)

Regards,
Bob Feretich

On 7/20/2010 2:24 PM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    I have downloaded the 2.6.33 omap kernel and I 'm starting to work
>> with it. I'll write again when I have a clean boot of the vanilla kernel
>> and tried to boot again with the Adeos patch.
>>
>> I think that I figured out how to tell OpenEmbedded to build it.
>>
>> When you display /proc/interrupts on the IGEPv2, do you see interrupts
>> occuring at IRQs greater or equal to IRQ 384?
>> Do you see the same number reflected in IRQ 7?
> I see this:
>             CPU0
>    7:     104068        INTC  TWL4030-PIH
>   12:          4        INTC  DMA
>   37:       1408        INTC  gp timer
>   56:     313486        INTC  i2c_omap
>   61:          0        INTC  i2c_omap
>   74:         42        INTC  serial
>   77:         93        INTC  ehci_hcd:usb2
>   83:         66        INTC  mmc0
>   86:         12        INTC  mmc1
>   92:          1        INTC  musb_hdrc
> 336:        809        GPIO  eth0
> 378:          0     twl4030  twl4030_usb
> 384:          0     twl4030  mmc0
>
> I believe the interrupts tagged "twl4030" are chained interrupts. Having
> looked at the code, these interrupts are not chained the usual way
> because they require i2c communication, which in turn requires a context
> allowed to sleep, so they are dispatched by a kernel thread.
>
>

--------------050206060301020104050303
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Xenomai booted with the 2.6.33 kernel on BeagleBoard!<br>
    I built the below 2.6.33 kernels...<br>
    <ul>
      <li>No Angstrom patches, no Adeos patch - - it booted, I noticed
        that /proc/interrupts showed no interrupts occurred on IRQs 7 or
        378 (SD card Detect). The 2.6.31 kernel showed 2 on each IRQ
        just after boot.</li>
      <li>No Angstrom patches, Adeos patch, but Xenomai disabled - - it
        booted. Still no interrupts on IRQs 7 or 378.</li>
      <li>No Angstrom patches, Adeos patch, and Xenomai enabled - - it
        booted! <span class="moz-smiley-s1"><span> :-) </span></span> 
        Still no interrupts on IRQs 7 or 378.</li>
    </ul>
    Something obviously changed in the kernel between 2.6.31 and 2.6.33
    to suppress the IRQ 378 interrupts that occurred at boot time. This
    change *may* be the reason that Xenomai works on the Beagleboard at
    2.6.33, but not at 2.6.31.<br>
    <br>
    I suspect that the Adeos patch may have trouble handling Level 2
    interrupts coming through a twl4030 device. I know that it is an
    OMAP design practice to route the SD/MMC Card Detect interrupt
    through this device. The device also controls several voltage
    regulators supplying power to the board and OMAP chip.
    Overvoltage/undervoltage/thermal alerts may also be originated by
    this device.<br>
    <br>
    The easiest way to test the twl4030 interrupt handling may be to use
    the SD Card for a removable file system (not root). If the file
    system automounts when the SD Card is plugged in, that would
    indicate that the twl4030 interrupts are being handled correctly.
    From the available documentation, the micro-SD card slot on the
    IGEPv2 should be able to be used for this testing.<br>
    <br>
    My current dilemma is to figure out how to move the pieces of
    Angstrom that I want from the 2.6.32 kernel system to the 2.6.33
    kernel ahead of the Angstrom train. <span class="moz-smiley-s2"><span>
        :-( </span></span><br>
    <br>
    Many thanks for you help Gilles.<br>
    <br>
    Now that I can see Xenomai running, is there any documentation that
    describes useful things I can poke to obtain Xenomai state, status
    and statistics? (for example the meanings of the data in the
    /proc/Xemomai directory)<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 7/20/2010 2:24 PM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C46141F.50103@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">  I have downloaded the 2.6.33 omap kernel and I 'm starting to work 
with it. I'll write again when I have a clean boot of the vanilla kernel 
and tried to boot again with the Adeos patch.

I think that I figured out how to tell OpenEmbedded to build it.

When you display /proc/interrupts on the IGEPv2, do you see interrupts 
occuring at IRQs greater or equal to IRQ 384?
Do you see the same number reflected in IRQ 7?
</pre>
      </blockquote>
      <pre wrap="">
I see this:
           CPU0
  7:     104068        INTC  TWL4030-PIH
 12:          4        INTC  DMA
 37:       1408        INTC  gp timer
 56:     313486        INTC  i2c_omap
 61:          0        INTC  i2c_omap
 74:         42        INTC  serial
 77:         93        INTC  ehci_hcd:usb2
 83:         66        INTC  mmc0
 86:         12        INTC  mmc1
 92:          1        INTC  musb_hdrc
336:        809        GPIO  eth0
378:          0     twl4030  twl4030_usb
384:          0     twl4030  mmc0

I believe the interrupts tagged "twl4030" are chained interrupts. Having
looked at the code, these interrupts are not chained the usual way
because they require i2c communication, which in turn requires a context
allowed to sleep, so they are dispatched by a kernel thread.


</pre>
    </blockquote>
  </body>
</html>

--------------050206060301020104050303--

