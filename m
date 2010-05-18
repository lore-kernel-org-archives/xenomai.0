Message-ID: <4BF285FD.3060705@domain.hid>
Date: Tue, 18 May 2010 19:20:13 +0700
From: "P.B.Cheblakov" <P.B.Cheblakov@domain.hid>
MIME-Version: 1.0
References: <1274182125-12750-1-git-send-email-P.B.Cheblakov@domain.hid>	<201005181342.57816.smolorz@domain.hid>
	<4BF27FB4.6090301@domain.hid>
In-Reply-To: <4BF27FB4.6090301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Wolfgang Grandegger wrote:
> Hi Sebastian,
>
> On 05/18/2010 01:42 PM, Sebastian Smolorz wrote:
>   
>> Pavel Cheblakov wrote:
>>     
>>> This is a general driver for cards based on PLX90xx PCI-bridges.
>>> It supports following cards:
>>>  - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
>>>  - Adlink PCI-7841/cPCI-7841 SE card
>>>  - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
>>>  - esd CAN-PCI/PMC/266
>>>  - esd CAN-PCIe/2000
>>>  - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
>>>  - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
>>>       
>> The esd cards mentioned above are supported by the RTCAN driver 
>> xeno_can_esd_pci. Why do you propose a new driver instead of extending the 
>> existing one?
>>     
>
> For Socket-CAN, this driver is supposed to support all PLX PCI based
> boards including the esd CAN PCI cards and also the IXXAT PCI board (not
> yet done, though). The RTCAN driver xeno_can_esd_pci is a *dedicated*
> driver for that card without generic support for the PLX PCI chips.
> Extending it makes little sense. The question is if we want to drop
> xeno_can_esd_pci and xeno_can_ixxat_pci.
>
> Wolfgang.
>   
I subscribe to Wolfgang.
Moreover, during an adaptation of Socket-CAN plx_pci driver to Xenomai, 
I remarked that these drivers are too similar. In general, the 
differences consist only of slightly changed API (early version of 
Socket-CAN internal API) and different prefixes for some names.

