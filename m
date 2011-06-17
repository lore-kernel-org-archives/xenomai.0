Message-ID: <4DFBA463.3090902@domain.hid>
Date: Fri, 17 Jun 2011 21:00:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>
	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
In-Reply-To: <BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/17/2011 04:05 PM, Jakub Nowacki wrote:
>>
>>
>> I've added my ID to the table in smi.c file as:
> 
> {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN+0xa)}
> 
> Everything complies OK but during the startup I get message:
> 
> [    2.137733] Xenomai: SMI-enabled chipset found
> [    2.137744] Xenomai: SMI workaround failed!
> 
> Should I do something extra apart from adding it to the table?

There are two reasons why it may not work:
- the way to globally disable SMIs has changed with the chipset version
you are using;
- the BIOS of your PC locks the SMI disabling bit.

So, the next step is to check the chipset datasheet.

-- 
                                                                Gilles.

