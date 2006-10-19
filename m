Message-ID: <39447.127.0.0.1.1161276534.squirrel@domain.hid>
In-Reply-To: <1160942865.4962.22.camel@domain.hid>
References: <47746.127.0.0.1.1160160976.squirrel@domain.hid>
	<1160942865.4962.22.camel@domain.hid>
Date: Thu, 19 Oct 2006 16:48:54 -0000 (UTC)
Subject: Re: [Xenomai-core] kernel panic
From: "Wael BACHTA" <wael@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,

Thank you for your hints.

I patched my kernel the new adeos patch
(adeos-ipipe-2.6.17-i386-1.5-00.patch). and I did this tests :

- SMP on and PCI_MSI on : my PC boots. I installed xenomai 2.2.0. I can see
my 2 virtual processors with "cat /proc/cpuinfo" BUT, I don't have
interrupts.

- SMP on and PCI_MSI off : The PC boots and I see my 2 virtual processors.

- SMP off and PCI_MSI on : The PC boots, I have my interrupts.

It seems to me that the new patch disables the PCI_MSI when the SMP is on.
The new patch doesn't seem to fix my problem.

Thanks for your help.

Wael.



> On Fri, 2006-10-06 at 18:56 +0000, Wael BACHTA wrote:
>> Hi,
>>
>> I use an Intel Pentium 4 processor which can be used as 2 virtual
>> processors when setting the SMP option during the kernel compiling (I
>> can
>> see 2 processors with "cat /proc/cpuinfo").
>>
>> I patched the kernel with adeos in order to install xenomai. I
>> discovered
>> that :
>> - when completely disabling the ACPI and setting the SMP, my system
>> boots
>> but I have only one processor when I look into /proc/cpuinfo
>> - Everything goes well when I don't disable completely the ACPI.
>>
>> I also use a PCI framegrabber. its driver is a real time one developed
>> under xenomai. I noticed that this driver works fine only if the PCI_MSI
>> is set. Otherwise, I don't have any interrupts.
>>
>> I must use my real time driver and the 2 virtual processors.
>> But, when I enable the ACPI, the SMP and the PCI_MSI, I have a kernel
>> panic. My PC boots when I disable the ACPI but I loose 1 processor.
>>
>> I don't see what's wrong.
>>
>
> Try this patch:
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.17-i386-1.5-00.patch
>
>
>> Thanks for your help,
>>
>> Wael.
>>
>> -------------------------------------
>> Wael BACHTA
>> Strasbourg I University
>> LSIIT Laboratory, AVR group
>> Bd S. Brant
>> BP 10413, 67412 ILLKIRCH cedex, FRANCE
>> Tel : +33 (0)3 90 24 44 78
>> Fax : +33 (0)3 90 24 44 80
>> http://eavr.u-strasbg.fr
>>
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> --
> Philippe.
>
>
-------------------------------------
Wael BACHTA
Strasbourg I University
LSIIT Laboratory, AVR group
Bd S. Brant
BP 10413, 67412 ILLKIRCH cedex, FRANCE
Tel : +33 (0)3 90 24 44 78
Fax : +33 (0)3 90 24 44 80
http://eavr.u-strasbg.fr


