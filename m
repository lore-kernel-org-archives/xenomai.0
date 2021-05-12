Subject: Re: latency test crashing
References: <ed8df10e-9353-6181-78df-535d4ccced59@akamina.com>
 <13f1c51c-c831-12e1-67bb-f701fd39f211@siemens.com>
From: Peter Laurich <Peter.Laurich@akamina.com>
Message-ID: <5b805394-acaf-77be-ad23-eae32fa179a5@akamina.com>
Date: Wed, 12 May 2021 18:46:44 -0400
MIME-Version: 1.0
In-Reply-To: <13f1c51c-c831-12e1-67bb-f701fd39f211@siemens.com>
Content-Language: en-CA
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Thanks Jan.

I experimented with a few of the Linux 4.9 kernels with 32-bit but all 
with the same result. It is time for me to abandon x86_32 development. 
Unfortunately, the BIOS will not allow me to put a 64-bit kernel onto 
the hardware so that hardware is now obsolete. I'll have to think about 
my options.

Peter

On 5/12/2021 3:00 AM, Jan Kiszka wrote:
> On 12.05.21 00:04, Peter Laurich via Xenomai wrote:
>> Hi,
>>
>> I am hoping that someone can help me to solve a problem that I am having
>> with the Xenomai latency test.
>>
>> Here is my set up:
>>
>> * 4.9.146 kernel with ipipe patch (this is the last kernel version
>>    that supports 32-bit x86 and has a Xenomai patch file)
> Honestly, it may only compile by chance. 32-bit is dead for ages, no one
> tested that anymore. But your CPU supports 64-bit. So, turn that on in
> the kernel while you can still run userspace in 32-bit.
>
> Jan
>
>> * kernel config options set as defined in Xenomai wiki
>>    Configuring_For_X86_Based_Dual_Kernels
>> * kernel configured for NFS mounting the root fs
>> * using Buildroot 2021.02 set up for i386 build with GCC 9.3.0 and
>>    Xenomai 3.1
>> * processor set to Atom
>> * target processor is D2550 Atom
>>
>> When I attempting to run the latency program it crashes immediately
>> after the first few lines of preamble are output. The last few lines of
>> the call trace include entries such as:
>>
>>    xnintr_core_clock_handler
>>    dispatch_irq_head
>>    __ipipe_dispatch_irq
>>    __ipipe_handle_irq
>>    apic_timer_interrupt
>>    ? gdb_serial_stub
>>    ? __ipipe_halt_root
>>    mwait_idle
>>    arch_cpu_idle
>>    default_idle_call
>>    cpu_startup_entry
>>    rest_init
>>    start_kernel
>>    i386_start_kernel
>>    ...
>>
>> I have tried this on two different Atom targets with the same results -
>> the latency program crashes immediately after the preamble is printed.
>>
>> Any suggestions as to what the root cause might be would be appreciated.
>>
>> Thanks
>>
>> Peter
>>
>
