Message-ID: <4AFC22E9.8020107@domain.hid>
Date: Thu, 12 Nov 2009 15:59:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20091020113724.9069.23594.stgit@domain.hid>
	<20091020113725.9069.28060.stgit@domain.hid>
	<1256404942.2862.498.camel@domain.hid>
	<1257177854.2065.616.camel@domain.hid>
	<4AEF0BCC.2020208@domain.hid>
	<1257180716.2065.618.camel@domain.hid>
	<4AEF0F7F.2060603@domain.hid> <4AEF1E91.6030407@domain.hid>
	<4AEF22C3.4070303@domain.hid> <4AEF273B.3090402@domain.hid>
	<20091102201924.5f392e15@domain.hid> <4AEF5D4B.2090106@domain.hid>
	<20091103082204.248eed59@domain.hid> <4AF17E50.1000707@domain.hid>
	<fbc4f538a6f4d84cfe514aba0985a525.squirrel@domain.hid>
In-Reply-To: <fbc4f538a6f4d84cfe514aba0985a525.squirrel@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: =?ISO-8859-1?Q?Gwenha=EBl_Goavec-Merou?= <gwen@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gwenha=EBl Goavec-Merou wrote:
> Sorry for the late
>> gwenhael.goavec wrote:
>>> On Mon, 02 Nov 2009 23:29:31 +0100
>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>> wrote:
>>>
>>>> gwenhael.goavec wrote:
>>>>> On Mon, 02 Nov 2009 19:38:51 +0100
>>>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>> wrote:
>>>>>
>>>>>> By the way, did you make any change to the I-pipe patch to get it
>>>>>> running on this board?
>>>>> The only change realized, is made because Armadeus and
>>>>> I-pipe does the same change on
>>>>> mach-imx/include/mach/imxfb.h :
>>>>>
>>>>> --- a/arch/arm/mach-imx/include/mach/imxfb.h
>>>>> +++ b/arch/arm/mach-imx/include/mach/imxfb.h
>>>>> @@ -14,7 +14,6 @@
>>>>>  #define PCR_BPIX_8 (3 << 25)
>>>>>  #define PCR_BPIX_12    (4 << 25)
>>>>>  #define PCR_BPIX_16    (4 << 25)
>>>>> +#define PCR_BPIX_MASK   (7 << 25)
>>>>>  #define PCR_PIXPOL (1 << 24)
>>>>>  #define PCR_FLMPOL (1 << 23)
>>>>>  #define PCR_LPPOL  (1 << 22)
>>>>>
>>>>> I take this opportunity to ask a question:
>>>>> on APF27 with imx27, I found that the system freeze
>>>>> when an interrupt handler is in place and an
>>>>> interruption happens.
>>>>> if interrupt handler is in place without interruption no
>>>>> problems and if interruption happens without interrupt
>>>>> handler it's ok too.
>>>>>
>>>>> If someone could help or advise me.
>>>>> thank you very much
>> The reason I knew for this problem was if handle_edge_irq was used for
>> some interrupts. But problems of this kind for IMX GPIOs are fixed in
>> 1.3-03.
>>
>> Do you have this problem with in-kernel or out-of-tree drivers? With
>> real-time or non real-time interrupts? Could you show us
>> /proc/interrupts before the system freezes?
>>
> I use an RTDM real-time driver for testing
> GPIO interrupt don't appears in /proc/interrupts
>=20
> ~ # cat /proc/interrupts
>            CPU0
>  20:         69           -  IMX-uart
>  26:       1664           -  i.MX Timer Tick
>  29:      84439           -  mxc_nd
>  50:         75           -  fec
>  53:          0           -  VPU_CODEC_IRQ
> Err:          0

Appear in /proc/interrupts only the Linux domain interrupts.
Xenomai domain interrupts appear in /proc/xenomai/irq.

Now, if you are sure to use the latest I-pipe patch, you should try and
follow the course of the interrupts masking, acking, calling the handler
and unmasking, to understand what happens. The most likely problem is
that your interrupt handler gets called in an infinite loop, for some
reason. The reason may be that the interrupt controller is configured
for the wrong type (edge/level) of irq, or simply that your interrupt
handler is bogus, or something else.

We could help you if you showed us the driver code, and told us what
kind of interrupt (edge, level) the hardware is using.

You could also try to implement the driver as a plain linux driver and
run it over the xenomai patched kernel and a plain linux kernel, to see
if the problem is in the interrupt handling code, I-pipe irq handling
code, or something else.

--=20
                                          Gilles


