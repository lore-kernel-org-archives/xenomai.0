Message-ID: <4D24CF69.8040809@domain.hid>
Date: Wed, 05 Jan 2011 21:07:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D23435B.70603@domain.hid> <4D2379E7.6050307@domain.hid>
	<201101052040.24049.kisda@domain.hid> <4D24CCB1.30305@domain.hid>
In-Reply-To: <4D24CCB1.30305@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RFC: 16550A pci serial board support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Am 05.01.2011 20:40, Stefan Kisdaroczi wrote:
>> Am Dienstag 04 Januar 2011, 20:49:59 schrieben Sie:
>>> Stefan Kisdaroczi wrote:
>>>> Hi,
>>>>
>>>> the attached patch adds pci support to the 16550A serial driver. I have
>>>> a Moxa CP-132 board and the first tests are looking good. If there is a
>>>> chance to get the patch applied I kindly request you to review it. I'll
>>>> add support for more Moxa boards if there is a interest to apply the
>>>> patch.
>>>>
>>>> thanks
>>>> Stefan
>>> Looks fine to me, however, nit-picking a bit, could we do this differently:
>> new patches attached.
>>
> 
> Looks good to me as well except for a minor white space damage:
> 
>> +static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,
>                                            ^^^^^^^
> 
> I have one further suggestion which can be done on top: The RTDM_IRQTYPE
> flags should be customized as well. So far we assume edge-type devices,
> but PCI is level-triggered. Requesting edge works, but is suboptimal.

Well, on vanilla linux, the edge handler does not mask the interrupt
line before invoking the handler, so, using the edge handler for level
interrupts should not work and lock-up (except if IRQF_DISABLED is
passed, which should now be the default, OK).

Anyway, is a driver the right place to pass these flags? Since the
interrupt controller pins to which the PCI interrupts are wired really
depends on the board more than on the device driver.

-- 
					    Gilles.

