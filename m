Message-ID: <4A7BDA38.2060405@domain.hid>
Date: Fri, 07 Aug 2009 09:39:36 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
References: <4A72BFBA.8040209@domain.hid> <4A7AF4C4.30001@domain.hid>
In-Reply-To: <4A7AF4C4.30001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] high latencies with Intel P45 ICH10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Theo Veenker wrote:
>> Hi,
>>
>> I'm replacing a number of old machines in our lab by new ones with an
>> MSI P45 Neo3 mobo. On the new hardware I'm seeing high latencies with
>> Xenomai 2.4.8 on kernel 2.6.29.5. The latency thingy reports many
>> overruns:
>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
>> RTD|       4.083|       9.100|       9.807|       0|       4.083|       9.807
>> RTD|       4.137|       9.280|    1804.493|      18|       4.083|    1804.493
>> RTD|       3.451|       9.099|      14.337|      18|       3.451|    1804.493
>> RTD|       3.864|       9.281|    1820.762|      36|       3.451|    1820.762
>> RTD|       4.017|       9.102|       9.917|      36|       3.451|    1820.762
>> RTD|       4.121|       9.273|    1742.710|      53|       3.451|    1820.762
>>
>> I've tried UP/SMP both with and without disabling SMI. No CONFIG_ACPI_PROCESSOR
>> etc. PCI_MSI is disabled too. I do not see the "Xenomai: SMI-enabled chipset
>> found..." message in the messages log file. Is that correct or is this hardware
>> too new for this version of Xenomai?
> 
> Probably, the table of supported PCI ids is in arch/x86/smi.c
> 

Boy, am I glad this list is rolling again. I had no idea where to look.
I have added the ID of the LPC Interface Controller. Is that the expected
thing to do? (Maybe you can add a comment about it in smi.c).

And guess what; It works! Well I need to perform a lengthy test, but the
overruns are gone now.

This is the line I've added in smi.c:
	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},

Thanks Gilles.

Theo


