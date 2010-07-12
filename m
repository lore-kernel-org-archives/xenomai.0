Message-ID: <4C3B1149.90309@domain.hid>
Date: Mon, 12 Jul 2010 14:57:45 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
References: <4C3B07A2.4020606@domain.hid> <4C3B0CEB.7040906@domain.hid>
In-Reply-To: <4C3B0CEB.7040906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PCI id missing from arch/x86/smi.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Theo Veenker wrote:
>> Hi,
>>
>> About a year ago when installing Xenomai on a new box it appeared this
>> particular system required an addition to the PDI IDs table in arch/x86/smi.c.
>> See this thread: https://mail.gna.org/public/xenomai-help/2009-08/msg00031.html
>> Gilles said he would make the change to smi.c. That was with 2.4.8.
>>
>> Now I'm trying 2.5.3 but again the same PCI ID is missing. Is there a
>> particular reason not to include this ID? On this system the SMI detection
>> stuff doesn't work without it.
>>
>> It requires adding this line to rthal_smi_pci_tbl[]:
>> {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},
> 
> Does the SMI disabling actually work, ie. do you _measure_ any
> difference? I'm asking as I think to remember that recent (but older
> than ICH10) Intel chipset no longer provide the required interface or at
> least changed it in an incompatible way.

Yes it does. First I got high latencies (~1800us). Then I remembered that I had to
disable SMI on this platform, so I recompiled with SMI disabled, to find out it
didn't make a difference. In the messages log I saw it didn't say anything about
SMI so I looked into it and found out the PCI ID I had in before was gone. I added
it and now the SMI workaround works and the high latencies are gone.

Theo

