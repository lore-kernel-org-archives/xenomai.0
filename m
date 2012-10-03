Message-ID: <506BF4C0.10207@xenomai.org>
Date: Wed, 03 Oct 2012 10:18:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5060AFD1.30303@gmail.com>	<506373F6.80406@xenomai.org>	<5063E8DE.8010303@gmail.com>	<50640444.8010703@xenomai.org>
	<50647502.9020204@gmail.com>	<50649906.7080605@xenomai.org>
	<506BE88A.9020303@gmail.com>
In-Reply-To: <506BE88A.9020303@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel 2.6.37.6 + Xenomai 2.5.6 is ok,
 but with Xenomai 2.6.1 it won't boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jari Lietzen <jari.lietzen@gmail.com>
Cc: xenomai@xenomai.org

On 10/03/2012 09:26 AM, Jari Lietzen wrote:
> 27.09.2012 21:20, Gilles Chanteperdrix kirjoitti:
>> On 09/27/2012 05:47 PM, Jari Lietzen wrote:
>>
>>> 27.09.2012 10:46, Gilles Chanteperdrix kirjoitti:
>>>> On 09/27/2012 07:49 AM, Jari Lietzen wrote:
>>>>
>>>>> 27.09.2012 00:30, Gilles Chanteperdrix kirjoitti:
>>>>>> On 09/24/2012 09:09 PM, Jari Lietzen wrote:
>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> Kernel 2.6.37.6 and Xenomai 2.5.6 boots ok, though displaying the error
>>>>>>> message: "MP-BIOS bug: 8254 timer not connected to IO-APIC".
>>>>>>>
>>>>>>> If I try to use Xenomai 2.6.1 the error message displayed is the same
>>>>>>> and system just hangs after that. No other messages, keyboard doesn't
>>>>>>> work, nothing. I started with the same kernel configuration, but I have
>>>>>>> disabled a few options more (e.g. syscall auditing, shared interrupt
>>>>>>> support).
>>>>>>>
>>>>>>> I'm using Intel Core 2 Duo processor with Asus P5LD2-VM motherboard.
>>>>>>> Obviously I'm missing something, but I can't figure that out. Here is
>>>>>>> the kernel config file:
>>>>>>
>>>>>>
>>>>>> If you use one of the I-pipe patches whih ship with Xenomai 2.6.1, such
>>>>>> as the patch for linux 3.2, do you also have the issue?
>>>>>>
>>>>>
>>>>> Hi!
>>>>>
>>>>> Yes, I have patched the kernel with this:
>>>>> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64
>>>>> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37.6-x86-2.9-02.patch
>>>>> --linux=/usr/src/linux
>>>>>
>>>>> xenomai being a link to xenomai-2.6.1 -directory. When I switch between
>>>>> Xenomai 2.5.6 and 2.6.1 I remove the whole linux directory and extract
>>>>> it from the source again and change the xenomai link accordingly. With
>>>>> Xenomai 2.5.6 the patching was done with this:
>>>>> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64
>>>>> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37-x86-2.9-00.patch
>>>>>     --linux=/usr/src/linux
>>>>
>>>>
>>>> So, could you try Xenoami 2.5.6 with the 2.9-02 patch, or 2.6.1 with the
>>>> 2.9-00 patch, or with the patch for linux 3.2 ?
>>>>
>>>
>>> I booted 2.6.37.6 kernel patched with 2.9-00 patch and compiled Xenomai
>>> 2.6.1 with the following commands:
>>
>>
>> I mean Xenomai 2.6.1 kernel with the 2.9-00 patch or Xenomai 2.5.6
>> kernel with 2.9-00 patch. Since the kernel is not booting, we do not
>> care about the user-space at this point.
>>
> 
> I tested again the following combinations. Always starting with a fresh 
> kernel tree and patching it:
> 
> 		2.9-00 patch	2.9-02 patch
> ----------------------------------------------
> Xenomai 2.5.6	OK		OK
> 
> Xenomai 2.6.1	boot fails	boot fails
> 
> 
> Here is a boot log from 2.9-02 patch used with Xenomai 2.6.1 and the 
> corresponding kernel .config. I used the same config file for all four 
> tests and prepared and compiled the kernel with:
> 
> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64 
> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37.6-x86-2.9-02.patch 
> --linux=/usr/src/linux

Ok, this does not match what you originally said, you originally said
the kernel was locking up after the "MP-BIOS bug: 8254 timer not
connected to IO-APIC", something changed between the tests?

What about my suggestion to try the patch for Linux 3.2 which ships with
Xenomai 2.6.1?

> 
> copy saved configuration to /usr/src/linux/.config
> make xconfig (no changes, but save .config anyway)
> make -j 2
> make modules_install
> make install
> 
> I also tested this with Atom D2500 based board, and Xenomai 2.6.1 with 
> 2.9-02 patch fails the same way with that too. Changed the processor 
> type of course.

Ok, there are a few things in your configuration I would change:
- enable ACPI, except for ACPI_PROCESSOR
- disable AUDIT_SYSCALL, KPROBES, PERF_EVENTS, OPROFILE, HPET_TIMER
But since the same configuration works with 2.5.6, it should work with
2.6.1.

The things I would try to debug this issue:
- add some printks along the xenomai initialization to see what function
exactly is causing the issue (the usual suspect would be rthal_start_timer)
- try and enable the APIC or I/OAPIC nmi watchdog, so that it can tell
you where the lockup happens
- try 2.6.0 (which likely does not work either)
- if 2.6.0 does not work, try a "git bisect" between 2.5.6 and 2.6.0
- if 2.6.0 works, try a "git bisect" between 2.6.0 and 2.6.1

On my side, I will try and use your kernel configuration on my atom, to
see if I reproduce the issue.

Regards.

-- 
					    Gilles.

