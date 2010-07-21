Message-ID: <4C469173.1020703@domain.hid>
Date: Tue, 20 Jul 2010 23:19:31 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
In-Reply-To: <4C468485.5060408@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------060105070606060403050009"
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
--------------060105070606060403050009
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Comments inline...

On 7/20/2010 10:24 PM, Gilles Chanteperdrix wrote:
> ... snipped ...
> However, I had trouble with this code on 2.6.33 generating spurious i2c
> interrupts, which lead me to the following patch:
> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cdc72520c88b329fa785b0e1f45392cdfff10ec6;hp=e52fee515be7c5b914c201c19604cd700afbc44f
>
> which I backported to 2.6.31 without testing it. Could you try and
> revert it?
Sure. I'll start tomorrow.
>> The easiest way to test the twl4030 interrupt handling may be to use the
>> SD Card for a removable file system (not root). If the file system
>> automounts when the SD Card is plugged in, that would indicate that the
>> twl4030 interrupts are being handled correctly. From the available
>> documentation, the micro-SD card slot on the IGEPv2 should be able to be
>> used for this testing.
> I tested reads and writes on the sd card on IGEPv2, it works, generating
> interrupts.
>
Reading and writing is all done via IRQ 83 (for MMC1) and IRQ 86 (for 
MMC2).  It would not exercise IRQ 384.

The /proc/interrupts that you posted showed...
  83:         66        INTC  mmc0
  86:         12        INTC  mmc1
  92:          1        INTC  musb_hdrc
336:        809        GPIO  eth0
378:          0     twl4030  twl4030_usb
384:          0     twl4030  mmc0

IRQ 378 is a USB power system interrupt of some sort. The twl4030 family 
power interrupts for OMAP3 are in the range of IRQ 376 
(TWL4030_PWR_IRQ_BASE) to IRQ 383 (TWL4030_PWR_IRQ_END).

IRQ 384 is the first GPIO pin on the twl4030. On the BeagleBoard, it's 
connected to the SD Card Detect circuit. I believe that is also true for 
the IGEPv2. The Level 2 GPIO interrupts (from the twl4030 family chip, 
not OMAP chip GPIO pins) are in the range of IRQ 384 
(TWL4030_GPIO_IRQ_BASE) to IRQ 383 (TWL4030_GPIO_IRQ_END).

Note that the above ranges apply to all boards that use an OMAP3 chip. 
Of course future changes to the kernel's interrupt handlers can reassign 
any IRQ above 95. (OMAP3 chip hardware IRQs stop at 95. The rest are 
software assigned.)
>> My current dilemma is to figure out how to move the pieces of Angstrom
>> that I want from the 2.6.32 kernel system to the 2.6.33 kernel ahead of
>> the Angstrom train. :-(
> We probably can get 2.6.31 to work, we just have to figure out what is
> wrong.
Thanks for your willingness to help.

Regards,
Bob Feretich

--------------060105070606060403050009
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Comments inline...<br>
    <br>
    On 7/20/2010 10:24 PM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C468485.5060408@domain.hid" type="cite">...
      snipped ...<br>
      <pre wrap="">However, I had trouble with this code on 2.6.33 generating spurious i2c
interrupts, which lead me to the following patch:
<a class="moz-txt-link-freetext" href="http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cdc72520c88b329fa785b0e1f45392cdfff10ec6;hp=e52fee515be7c5b914c201c19604cd700afbc44f">http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cdc72520c88b329fa785b0e1f45392cdfff10ec6;hp=e52fee515be7c5b914c201c19604cd700afbc44f</a>

which I backported to 2.6.31 without testing it. Could you try and
revert it?
</pre>
    </blockquote>
    Sure. I'll start tomorrow.<br>
    <blockquote cite="mid:4C468485.5060408@domain.hid" type="cite">
      <blockquote type="cite">
        <pre wrap="">The easiest way to test the twl4030 interrupt handling may be to use the 
SD Card for a removable file system (not root). If the file system 
automounts when the SD Card is plugged in, that would indicate that the 
twl4030 interrupts are being handled correctly. From the available 
documentation, the micro-SD card slot on the IGEPv2 should be able to be 
used for this testing.
</pre>
      </blockquote>
      <pre wrap="">
I tested reads and writes on the sd card on IGEPv2, it works, generating
interrupts.

</pre>
    </blockquote>
    Reading and writing is all done via IRQ 83 (for MMC1) and IRQ 86
    (for MMC2).  It would not exercise IRQ 384.<br>
    <br>
    The /proc/interrupts that you posted showed...<br>
    <tt> 83:         66        INTC  mmc0<br>
       86:         12        INTC  mmc1<br>
       92:          1        INTC  musb_hdrc<br>
      336:        809        GPIO  eth0<br>
      378:          0     twl4030  twl4030_usb<br>
      384:          0     twl4030  mmc0</tt><br>
    <br>
    IRQ 378 is a USB power system interrupt of some sort. The twl4030
    family power interrupts for OMAP3 are in the range of IRQ 376 <small>(TWL4030_PWR_IRQ_BASE)</small>
    to IRQ 383<small> (TWL4030_PWR_IRQ_END)</small>.<br>
    <br>
    IRQ 384 is the first GPIO pin on the twl4030. On the BeagleBoard,
    it's connected to the SD Card Detect circuit. I believe that is also
    true for the IGEPv2. The Level 2 GPIO interrupts (from the twl4030
    family chip, not OMAP chip GPIO pins) are in the range of IRQ 384 <small>(TWL4030_GPIO_IRQ_BASE)</small>
    to IRQ 383<small> (TWL4030_GPIO_IRQ_END)</small>.<br>
    <br>
    Note that the above ranges apply to all boards that use an OMAP3
    chip. Of course future changes to the kernel's interrupt handlers
    can reassign any IRQ above 95. (OMAP3 chip hardware IRQs stop at 95.
    The rest are software assigned.)<br>
    <blockquote cite="mid:4C468485.5060408@domain.hid" type="cite">
      <blockquote type="cite">
        <pre wrap="">My current dilemma is to figure out how to move the pieces of Angstrom 
that I want from the 2.6.32 kernel system to the 2.6.33 kernel ahead of 
the Angstrom train. :-(
</pre>
      </blockquote>
      <pre wrap="">We probably can get 2.6.31 to work, we just have to figure out what is
wrong.
</pre>
    </blockquote>
    Thanks for your willingness to help.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
  </body>
</html>

--------------060105070606060403050009--

