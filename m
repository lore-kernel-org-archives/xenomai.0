Message-ID: <4DFBAFA9.4070909@domain.hid>
Date: Fri, 17 Jun 2011 20:48:57 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>
	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
	<4DFBA463.3090902@domain.hid>
In-Reply-To: <4DFBA463.3090902@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On 17/06/2011 20:00, Gilles Chanteperdrix wrote:
> On 06/17/2011 04:05 PM, Jakub Nowacki wrote:
>>>
>>>
>>> I've added my ID to the table in smi.c file as:
>>
>> {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>> PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN+0xa)}
>>
>> Everything complies OK but during the startup I get message:
>>
>> [    2.137733] Xenomai: SMI-enabled chipset found
>> [    2.137744] Xenomai: SMI workaround failed!
>>
>> Should I do something extra apart from adding it to the table?
>
> There are two reasons why it may not work:
> - the way to globally disable SMIs has changed with the chipset version
> you are using;
> - the BIOS of your PC locks the SMI disabling bit.
>
> So, the next step is to check the chipset datasheet.
>
Following the datasheet available at:

http://www.intel.com/Assets/PDF/datasheet/322169.pdf

SMI_EN—SMI Control and Enable Register has address: PMBASE + 30 (see p. 
531), which seems to be the same as in 'smi.c' (PMBASE is 0x40-0x43; see 
p. 460). Structure seems to be the same, namely, GBL_SMI_EN_BIT is the 
first bit. However, SMI enable can be locked using SMI_LOC bit in 
GEN_PMCON_1—General PM Configuration 1 Register
(PM—D31:F0) with Offset Address: A0h; see p. 513. Hence, this one can 
potentially stop 'smi.c' from applying the workaround. Sorry for 
slightly descriptive approach but I don't know 'smi.c' code that well to 
fiddle with it.

Hope it helps slightly.

Best wishes,

Jakub

