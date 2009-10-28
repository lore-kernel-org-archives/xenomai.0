Message-ID: <4AE879BF.5070308@domain.hid>
Date: Wed, 28 Oct 2009 18:05:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid>
	<4AE82F22.6090203@domain.hid>	<4AE86123.9060602@domain.hid>
	<4AE8789B.2020907@domain.hid>
In-Reply-To: <4AE8789B.2020907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTnet install problem: Xenomai
 configuration	tool not found
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
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> [ Please keep the CCs intact. ]
> 
> Benjamin Biegel wrote:
>> Is this in my /boot/config-2.6.28.9 file? Here i see that CONFIG_PCI_MSI=y.
>>
>> Is this something set up when i compile the patched kernel? Or how do I run without the above setting?
> 
> Reconfigure your kernel (make menuconfig/xconfig/<whatever>config) and
> rebuild it. Without MSI support, interrupts will fall back to IOAPIC
> handling which /may/ cause other problems (shared IRQ conflicts between
> Xenomai and Linux), but let's check this first.

Please be sure to enable ACPI, except ACPI_PROCESSOR. Disabling ACPI may
be the cause of some issues (I have been beaten again by this issue
recently).

-- 
                                          Gilles


