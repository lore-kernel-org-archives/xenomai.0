Message-ID: <4D279BE9.2090409@domain.hid>
Date: Sat, 08 Jan 2011 00:04:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D23435B.70603@domain.hid> <201101052303.46018.kisda@domain.hid>
	<4D26CEBE.6070308@domain.hid> <201101072321.43680.kisda@domain.hid>
In-Reply-To: <201101072321.43680.kisda@domain.hid>
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Stefan Kisdaroczi wrote:
> Am Freitag 07 Januar 2011, 09:28:46 schrieb Jan Kiszka:
>> Am 05.01.2011 23:03, Stefan Kisdaroczi wrote:
>>> Am Mittwoch 05 Januar 2011, 20:55:29 schrieb Jan Kiszka:
>>>> Am 05.01.2011 20:40, Stefan Kisdaroczi wrote:
>>>>> Am Dienstag 04 Januar 2011, 20:49:59 schrieben Sie:
>>>>>> Stefan Kisdaroczi wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> the attached patch adds pci support to the 16550A serial driver. I
>>>>>>> have a Moxa CP-132 board and the first tests are looking good. If
>>>>>>> there is a chance to get the patch applied I kindly request you to
>>>>>>> review it. I'll add support for more Moxa boards if there is a
>>>>>>> interest to apply the patch.
>>>>>>>
>>>>>>> thanks
>>>>>>> Stefan
>>>>>> Looks fine to me, however, nit-picking a bit, could we do this 
> differently:
>>>>> new patches attached.
>>>> Looks good to me as well except for a minor white space damage:
>>>>> +static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,
>>>>>
>>>>                                            ^^^^^^^
>>>>
>>>> I have one further suggestion which can be done on top: The RTDM_IRQTYPE
>>>> flags should be customized as well. So far we assume edge-type devices,
>>>> but PCI is level-triggered. Requesting edge works, but is suboptimal.
>>>>
>>>> Jan
>>> thanks for the input. updated patches attached with customizable irqtype.
>>> better? (not compiled and not tested -> tomorrow)
>> Fine with me (unless an even smarter solution shows up, but I don't see
>> it ATM). One simplification:
>>
>> static unsigned long irqtype[MAX_DEVICES] = {
>> 	[0 ... MAX_DEVICES-1] = RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE;
>> };
>>
>> Jan
> 
> fixed and tested patches attached.

Merged. Launching the build-test to see if it compiles fine in all cases.

-- 
                                                                Gilles.

