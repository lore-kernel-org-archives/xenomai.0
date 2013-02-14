Message-ID: <511CD673.2030400@xenomai.org>
Date: Thu, 14 Feb 2013 13:20:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>
	<511CD5C2.50701@arcor.de>
In-Reply-To: <511CD5C2.50701@arcor.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel configuration problems with ACPI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christopher Hahn <hahnchristopher@arcor.de>
Cc: xenomai@xenomai.org

On 02/14/2013 01:17 PM, Christopher Hahn wrote:

> Am 14.02.2013 13:12, schrieb hahnchristopher@arcor.de:
>> Hey guys,
>>
>> I'm running the new Xenomai 2.6.2.1 with 3.5.7 Kernel on a x86 machine.
>> I tried several kernel configurations, but I haven't found the right one yet.
>>
>> The PC (ADLD25PC) uses a PEAK-Systems PCIE/104 CAN interface and two serialport devices.
>>
>> I have selected the CAN driver and 16550A driver as kernel modules.
>>
>>
>> With kernel configuration "-xenomai4"  the serial and can devices works, but there are only 2 CPUs detected - so the hyperthreading cores arn't detected.
>> And I get a message during bootup "BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)."
>> This is my "best" solution so far - CONFIG_ACPI is completely disabled.
>>
>>
>> In "-xenomai5" configuration is ACPI enabled as you can see in the attached kernel configs.
>> The mptable message disappears, 4 cores are detected, but serial and can device IRQs get disabled.
>> The can interface and a usb hub get IRQ 19 - thats solvable for me, but the serialport on IRQ 4 gets disabled and I don't know why. (lspci -v log is also attached)
>>
>>
>> Could you point me in a direction how to combine the advantages of the two configurations?
>>
>>
>> Thank you,
>>
>> Christopher
> 
> 
> Attachments now as txt files


It would be interesting to have the kernel boot logs too.

-- 
                                                                Gilles.

