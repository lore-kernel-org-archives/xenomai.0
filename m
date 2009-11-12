Message-ID: <60cff48e311e722386962d4ab26b3829.squirrel@domain.hid>
Date: Thu, 12 Nov 2009 14:34:04 -0000
From: =?iso-8859-1?Q?Gwenha=EBl_Goavec-Merou?= <gwen@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai on ARMadeus
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

Sorry for the late
> gwenhael.goavec wrote:
>> On Mon, 02 Nov 2009 23:29:31 +0100
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> wrote:
>>
>>> gwenhael.goavec wrote:
>>>> On Mon, 02 Nov 2009 19:38:51 +0100
>>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>> wrote:
>>>>
>>>>> By the way, did you make any change to the I-pipe patch to get it
running on this board?
>>>> The only change realized, is made because Armadeus and
>>>> I-pipe does the same change on
>>>> mach-imx/include/mach/imxfb.h :
>>>>
>>>> --- a/arch/arm/mach-imx/include/mach/imxfb.h
>>>> +++ b/arch/arm/mach-imx/include/mach/imxfb.h
>>>> @@ -14,7 +14,6 @@
>>>>  #define PCR_BPIX_8 (3 << 25)
>>>>  #define PCR_BPIX_12    (4 << 25)
>>>>  #define PCR_BPIX_16    (4 << 25)
>>>> +#define PCR_BPIX_MASK   (7 << 25)
>>>>  #define PCR_PIXPOL (1 << 24)
>>>>  #define PCR_FLMPOL (1 << 23)
>>>>  #define PCR_LPPOL  (1 << 22)
>>>>
>>>> I take this opportunity to ask a question:
>>>> on APF27 with imx27, I found that the system freeze
>>>> when an interrupt handler is in place and an
>>>> interruption happens.
>>>> if interrupt handler is in place without interruption no
>>>> problems and if interruption happens without interrupt
>>>> handler it's ok too.
>>>>
>>>> If someone could help or advise me.
>>>> thank you very much
>
> The reason I knew for this problem was if handle_edge_irq was used for
some interrupts. But problems of this kind for IMX GPIOs are fixed in
1.3-03.
>
> Do you have this problem with in-kernel or out-of-tree drivers? With
real-time or non real-time interrupts? Could you show us
> /proc/interrupts before the system freezes?
>
I use an RTDM real-time driver for testing
GPIO interrupt don't appears in /proc/interrupts

~ # cat /proc/interrupts
           CPU0
 20:         69           -  IMX-uart
 26:       1664           -  i.MX Timer Tick
 29:      84439           -  mxc_nd
 50:         75           -  fec
 53:          0           -  VPU_CODEC_IRQ
Err:          0

Gwenhael

Signed-off-by: gwenhael.goavec-merou@domain.hid





