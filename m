Message-ID: <4BF2989B.4000506@domain.hid>
Date: Tue, 18 May 2010 15:39:39 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1274182125-12750-1-git-send-email-P.B.Cheblakov@domain.hid>
	<201005181429.59169.smolorz@domain.hid>
	<4BF28B0B.1010002@domain.hid>
	<201005181529.40843.smolorz@domain.hid>
In-Reply-To: <201005181529.40843.smolorz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

On 05/18/2010 03:29 PM, Sebastian Smolorz wrote:
> Wolfgang Grandegger wrote:
>> On 05/18/2010 02:29 PM, Sebastian Smolorz wrote:
>>> Hi Wolfgang,
>>>
>>> Wolfgang Grandegger wrote:
>>>> On 05/18/2010 01:42 PM, Sebastian Smolorz wrote:
>>>>> Pavel Cheblakov wrote:
>>>>>> This is a general driver for cards based on PLX90xx PCI-bridges.
>>>>>> It supports following cards:
>>>>>>  - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
>>>>>>  - Adlink PCI-7841/cPCI-7841 SE card
>>>>>>  - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
>>>>>>  - esd CAN-PCI/PMC/266
>>>>>>  - esd CAN-PCIe/2000
>>>>>>  - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
>>>>>>  - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
>>>>>
>>>>> The esd cards mentioned above are supported by the RTCAN driver
>>>>> xeno_can_esd_pci. Why do you propose a new driver instead of
>>>>> extending the existing one?
>>>>
>>>> For Socket-CAN, this driver is supposed to support all PLX PCI based
>>>> boards including the esd CAN PCI cards and also the IXXAT PCI board
>>>> (not yet done, though). The RTCAN driver xeno_can_esd_pci is a
>>>> *dedicated* driver for that card without generic support for the PLX
>>>> PCI chips. Extending it makes little sense. The question is if we want
>>>> to drop xeno_can_esd_pci and xeno_can_ixxat_pci.
>>>
>>> With extending the esd_pci driver I meant to take this driver as a
>>> basis to add support for more cards. Of course this would mean to
>>> rename the driver in order to reflect that. I'm not against a
>>> unification of esd_pci and ixxat_pci but it's unneccessary work to
>>> write a new RTCAN driver if there exists another one which is tried and
>>> tested in the field. So my question was why  Pavel did not take the
>>> esd_pci driver as the starting position.
>>
>> He did *not* write a new RTCAN driver. He ported plx_pci.c from the
>> mainline kernel to rtcan,
> 
> So it is a new RTCAN driver - never mind, just nitpicking. ;-)
> 
> As I said, I'm in favour of a unified driver which supports more cards than 
> esd_pci and ixxat_pci. The question is how we proceed best when we include 
> rt_sja1000_plx_pci. I suggest not to remove esd_pci immediately but rather 
> mark it deprecated with a reference to the new driver, e.g. in the Kconfig 
> help text. That way we would have a fallback driver in case of unforeseen 
> issues with the new driver.

Fine with me. Marking it as deprecated is a good thing, though. Note
that the esd part of the plx_pci driver was contributed by Matthias
Fuchs, including support for the *new* esd pci cards.

Wolfgang.

