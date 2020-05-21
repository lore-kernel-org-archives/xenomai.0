MIME-Version: 1.0
References: <OF7C90913F.87CE5B21-ON0025856F.002B5A49-0025856F.0030C1A6@notes.ce.collabserv.com>
In-Reply-To: <OF7C90913F.87CE5B21-ON0025856F.002B5A49-0025856F.0030C1A6@notes.ce.collabserv.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 21 May 2020 13:41:29 -0400
Message-ID: <CALLqZ8Qghrg49fRsAxxASOqxzGXY2qv55-x6N1n+b-X91OHNsg@mail.gmail.com>
Subject: Re: Porting Xenomai to STM32MP1
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Cesare Masetti <cesare.masetti@marposs.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Thu, May 21, 2020 at 4:53 AM Cesare Masetti via Xenomai
<xenomai@xenomai.org> wrote:
>
>    Hello,
>    I'm trying to port Xenomai to a new arm SOC, here follow my specs:
>
>    - ARMv7 architecture
>    - STM32MP157 SOC, on STM32MP157C-DK2 evaluation board
>    this SOC has a dual Cortex-A7 and a single Cortex-M4, it has an ARM GIC
>    and it should have also an architected timer.
>    - Linux version 4.19.108, patched by ST, retrieved from
>    [1]https://github.com/STMicroelectronics/linux/tree/v4.19-stm32mp-r3.1
>    - ipipe patch ipipe-core-4.19.110-arm-07.patch
>    - xenomai 3.1 stable
>
>    I followed the porting guide step-by-step. At first I had issues at
>    booting with CONFIG_IPIPE enabled, due to some irq chips defined in
>    this SOC, but I managed to solve them. Now it boots correctly,
>    apparently everything works fine.
>    With CONFIG_XENOMAI enabled the booting halts at
>    [Xenomai] scheduling class rt registered.
>    I found that it is stuck in ipipe_critical_enter,
>    precisely at
>    while (!cpumask_equal(&online, &__ipipe_cpu_pass_map))
>
>    I've attached kernel configuration and boot log.
>    After checking it seems to me that core 0 is sending
>    an IPI to core 1 with no response, could I be right?
>    Any help would be really appreciated.
>    Thank you in advance and congratulations for your great work.
>
>    Cesare Masetti
>    R&D Measuring Systems - Hardware Designer
>    cesare.masetti@marposs.com
>
>    ______________________________________________________
>    MARPOSS S.p.A., with a sole shareholder
>    Via Saliceto, 13 - 40010 BENTIVOGLIO (BO) - ITALY
>    Share Capital euro 15,000,000 paid in full - Tax Code and Registration
>    No. at Business Register of Bologna 03354081204
>    Economic and Administrative Index No. 516318 - VAT IT 03354081204
>      [2][USEMAP:cid:_signatureCompleta2.1.jpg_MMAI-BM8GAW]
>    ______________________________________________________
>    The   information  contained  in  this e-mail  and  any  attachments is
>    confidential  and  may  also  be  privileged. If you have received the
>    e-mail and any attachments by mistake, please inform us  immediately,
>    destroy them without storing or copying them on any medium, and do not
>    disclose or use the contents for any purpose.
>    Although our systems implement reasonable precautions against viruses
>    and other threats, we cannot accept responsibility for any loss or
>    damage arising from managing the contents of this e-mail.
>    P  Please consider the environment before printing this e-mail
>
> References
>
>    1. https://github.com/STMicroelectronics/linux/tree/v4.19-stm32mp-r3.1
>    2. LYNXIMGMAP:file://localhost/tmp/tmpJcxPOM.html#image-marposs
>
> [USEMAP]
> file://localhost/tmp/tmpJcxPOM.html#image-marposs
>    1. http://www.marposs.com/
>    2. https://www.facebook.com/Marposs
>    3. http://www.linkedin.com/company/marposs
>    4. https://www.instagram.com/marpossgram
>    5. https://twitter.com/Marposs
>    6. https://www.youtube.com/user/MisterMTech
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: image/jpeg
> Size: 19872 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20200521/a133eb59/attachment.jpe>
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: config.txt
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20200521/a133eb59/attachment.txt>
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: kernel_log.txt
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20200521/a133eb59/attachment-0001.txt>

It's hard to see from just the log what is happening.  To confirm, you
can boot without Xenomai but just the ipipe without issue?  Are you
able to post the patch of the port for us to look at?

Thanks

Greg

