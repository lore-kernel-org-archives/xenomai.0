Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
References: <20201014132459.GB24671@linux.intel.com>
 <8e59bc35-84ae-78be-8296-4f2367e8e844@siemens.com>
 <20201016033638.GB5581@linux.intel.com>
 <0ba45dfa-4755-c627-e1fd-9f2c32ea8b8a@siemens.com>
 <9153481d-6df6-314f-c2c0-f413a34fb815@siemens.com>
 <20201021114329.GA4344@linux.intel.com>
 <88232cd0-0713-4e45-bad2-e22acdeb7632@siemens.com>
 <3a85c6c8-6792-40d1-5ef2-6ee634fc3c91@siemens.com>
 <20201022114938.GA8098@linux.intel.com>
 <39ccbc86-3f64-0941-241b-30e2431468cf@siemens.com>
 <20201022132522.GA9776@linux.intel.com>
 <ae889a3f-40c1-d22e-c97b-807fe2ab7b5f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7a72e153-412e-4206-6794-fc6c60e9e243@siemens.com>
Date: Thu, 22 Oct 2020 18:02:41 +0200
MIME-Version: 1.0
In-Reply-To: <ae889a3f-40c1-d22e-c97b-807fe2ab7b5f@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fino Meng <fino.meng@linux.intel.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 22.10.20 17:22, Jan Kiszka via Xenomai wrote:
> On 22.10.20 15:25, Fino Meng wrote:
>> On Thu, Oct 22, 2020 at 02:15:23PM +0200, Jan Kiszka wrote:
>>> On 22.10.20 13:49, Fino Meng wrote:
>>>> On Thu, Oct 22, 2020 at 09:26:59AM +0200, Jan Kiszka wrote:
>>>>> On 22.10.20 08:27, Jan Kiszka via Xenomai wrote:
>>>>>> On 21.10.20 13:43, Fino Meng wrote:
>>>>>>> On Wed, Oct 21, 2020 at 08:36:04AM +0200, Jan Kiszka wrote:
>>>>>>>> On 18.10.20 23:41, Jan Kiszka via Xenomai wrote:
>>>>>>>>> On 16.10.20 05:36, Fino Meng wrote:
>>>>>>>>>> On Thu, Oct 15, 2020 at 04:20:11PM +0200, Jan Kiszka wrote:
>>>>>>>>>>> On 14.10.20 15:25, Fino Meng wrote:
>>>>>>>>>>>> hi team,
>>>>>>>>>>>>
>>>>>>>>>>>> I just updated the scripts to build the WIP version xenomai porting to
>>>>>>>>>>>> kernel 5.4, just follow the steps:
>>>>>>>>>>>>
>>>>>>>>>>>> git clone https://github.com/finomeng/xenomai-mirror.git /tmp/xenomai-mirror.next-5.4
>>>>>>>>>>>> cd /tmp/xenomai-mirror.next-5.4
>>>>>>>>>>>> git checkout -t origin/wip/next-5.4-porting
>>>>>>>>>>>>
>>>>>>>>>>>> git clone https://github.com/intel/linux-stable-xenomai /tmp/kernel
>>>>>>>>>>>> cd /tmp/kernel
>>>>>>>>>>>> git checkout -t review/5.4.59/stable/ipipe-x86
>>>>>>>>>>>>
>>>>>>>>>>>> ./patching-xenomai2kernel.sh
>>>>>>>>>>>>
>>>>>>>>>>>> cp config_xenomai.kernel_debug .config
>>>>>>>>>>>> make olddefconfig
>>>>>>>>>>>> ./build-debpkg.sh
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I didn't put it togethter with ISAR/Debian yet. I test it with a PC with Debian 10 installed.
>>>>>>>>>>>>
>>>>>>>>>>>> if no error, linux-image-*.deb and linux-headers-*.deb should generated outside kernel folder,
>>>>>>>>>>>> copy them to your target test device with already installed a Debian/Ubuntu,
>>>>>>>>>>>> install the deb with "dpkg -i", update-grub should be called during install linux-image-*.deb
>>>>>>>>>>>> reboot and select to boot the new kernel in grub's menu
>>>>>>>>>>>>
>>>>>>>>>>>> the build steps also written in patching-xenomai2kernel.sh and build-debpkg.sh
>>>>>>>>>>>>
>>>>>>>>>>>> switchtest will fail in current version, for example: "./switchtest rtk_fp_ufpp0"
>>>>>>>>>>>> will print:
>>>>>>>>>>>>
>>>>>>>>>>>> r0: 2147483648 != 1000
>>>>>>>>>>>> r1: 2147483648 != 1000
>>>>>>>>>>>> r2: 2147483648 != 1000
>>>>>>>>>>>> r3: 2147483648 != 1000
>>>>>>>>>>>> r4: 2147483648 != 1000
>>>>>>>>>>>> r5: 2147483648 != 1000
>>>>>>>>>>>> r6: 2147483648 != 1000
>>>>>>>>>>>> r7: 2147483648 != 1000
>>>>>>>>>>>> ymm0: 2676586395008836901/0 != 1000/1000
>>>>>>>>>>>> ymm1: 71776119061217280/0 != 1000/1000
>>>>>>>>>>>> ymm2: 0/0 != 1000/1000
>>>>>>>>>>>> ymm3: 1000/0 != 1000/1000
>>>>>>>>>>>> ymm4: 1000/0 != 1000/1000
>>>>>>>>>>>> ymm5: 1000/0 != 1000/1000
>>>>>>>>>>>> ymm6: 1000/0 != 1000/1000
>>>>>>>>>>>> ymm7: 1000/0 != 1000/1000
>>>>>>>>>>>> Error after context switch from task 1(rtk_fp_ufpp0-1) to task 0(sleeper_ufps0-0),
>>>>>>>>>>>> FPU registers were set to 0 (maybe task sleeper_ufps0-0)
>>>>>>>>>>>>
>>>>>>>>>>>> if meet more questions just write to me, thanks!
>>>>>>>>>>>>
>>>>>>>>>>>> BR fino
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I can reproduce in KVM and poked around a bit, though without finding
>>>>>>>>>>> the needle yet. Likely, there are multiple aspects. The change in
>>>>>>>>>>> upstream to FPU switching on user-return is a hot lead, but it takes a
>>>>>>>>>>> bit to fully grasp that and map it on our scenarios with Xenomai.
>>>>>>>>>>>
>>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>> it seems that, switch_fpu_prepare() and switch_fpu_finish() are
>>>>>>>>>> for kernel thread context switch (in __switch_to() )and switch_fpu_return() is needed
>>>>>>>>>> before return to userspace( in prepare_exit_to_usermode()).
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yes, we need explicit switch_fpu_return() (likely open-coded, to skip
>>>>>>>>> the PF_KTHREAD check) at the end of xnarch_switch_to, at least as long
>>>>>>>>> as we do not add that to all fast (primary-mode) return-to-user paths.
>>>>>>>>>
>>>>>>>>> But it's more complex. The removal of fpu_initialized changed the
>>>>>>>>> condition under which __switch_to() does FPU saving and restoring: All
>>>>>>>>> kernel threads, also ours, are excluded. That needs to be compensated.
>>>>>>>>>
>>>>>>>>> But I'm still facing corruptions - continuing to debug.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Quick update:
>>>>>>>>
>>>>>>>> I made some progress with changes like below, but I'm still facing 
>>>>>>>> issues, not with weird AVX register corruptions. They confuse me because 
>>>>>>>> classic FPU registers are updated and saved/restored the same way, but 
>>>>>>>> they are currently unaffected.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>
>>>>>>> in my current understand, 
>>>>>>> a userspace Xenomai/Cobalt process's context switch always need FPU
>>>>>>> state save/restore; but how about the other case?
>>>>>>>
>>>>>>> in vanilla kernel, I see if a pure kernel thread want to use FPU, need
>>>>>>> manually call kernel_fpu_begin() and kernel_fpu_end(), like a critical
>>>>>>> area.
>>>>>>
>>>>>> Xenomai kernel threads can use the FPU, and that without
>>>>>> kernel_fpu_begin/end. That this works is also tested by switchtest, and
>>>>>> there were several issues, possibly there are still more.
>>>>>>
>>>>>> One step further: My weird avx register corruption is understand. It was
>>>>>> the local instrumentation. xnftrace_printf likely uses xmm regs
>>>>>> internally, and I had such an output after setting up the test pattern.
>>>>>> Fixing that, I still have a corruption, but not a "normal one" again,
>>>>>> ie. of the legacy FPU regs.
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>>> Got it working:
>>>>>
>>>>> diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
>>>>> index aa7b5d19d8..9a014818ef 100644
>>>>> --- a/kernel/cobalt/arch/x86/thread.c
>>>>> +++ b/kernel/cobalt/arch/x86/thread.c
>>>>> @@ -215,6 +215,15 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>>>>>  		 */
>>>>>  		clts();
>>>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
>>>>> +	if (!xnthread_test_state(out, XNROOT | XNUSER) &&
>>>>> +	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>>>>> +		struct fpu *prev_fpu = &prev->thread.fpu;
>>>>> +
>>>>> +		if (!copy_fpregs_to_fpstate(prev_fpu))
>>>>> +			prev_fpu->last_cpu = -1;
>>>>> +		else
>>>>> +			prev_fpu->last_cpu = smp_processor_id();
>>>>> +	}
>>>>>  
>>>>>  	next = in_tcb->core.host_task;
>>>>>  #ifndef IPIPE_X86_FPU_EAGER
>>>>> @@ -260,6 +269,19 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>>>>>  #ifndef IPIPE_X86_FPU_EAGER
>>>>>  	stts();
>>>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
>>>>> +	if (xnthread_current() &&
>>>>> +	    !xnthread_test_state(xnthread_current(), XNROOT) &&
>>>>> +	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
>>>>> +		struct fpu *fpu = &current->thread.fpu;
>>>>> +		int cpu = smp_processor_id();
>>>>> +
>>>>> +		if (!fpregs_state_valid(fpu, cpu)) {
>>>>> +			copy_kernel_to_fpregs(&fpu->state);
>>>>> +			fpregs_activate(fpu);
>>>>> +			fpu->last_cpu = cpu;
>>>>> +		}
>>>>> +		clear_thread_flag(TIF_NEED_FPU_LOAD);
>>>>> +	}
>>>>>  }
>>>>>  
>>>>>  #ifndef IPIPE_X86_FPU_EAGER
>>>>> @@ -488,6 +510,7 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
>>>>>  		return;
>>>>>  
>>>>>  	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>>>>> +	__cpu_invalidate_fpregs_state();
>>>>>  	kernel_fpu_disable();
>>>>>  }
>>>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
>>>>> @@ -541,7 +564,8 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
>>>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
>>>>>  	fpu__activate_fpstate_read(&p->thread.fpu);
>>>>>  #else
>>>>> -	fpu__clear(&p->thread.fpu);
>>>>> +	set_thread_flag(TIF_NEED_FPU_LOAD);
>>>>> +	fpstate_init(&p->thread.fpu.state);
>>>>>  #endif
>>>>>  #endif /* ! IPIPE_X86_FPU_EAGER */
>>>>>  }
>>>>>
>>>>>
>>>>> This still requires proper wrapping for the different kernel versions 
>>>>> and some comments. But maybe you can continue testing from there.
>>>>>
>>>>>
>>>>> BTW, there are more to-dos:
>>>>>
>>>>> [    0.182466] Freeing SMP alternatives memory: 44K
>>>>> [    0.182656] ------------[ cut here ]------------
>>>>> [    0.183038] WARNING: CPU: 0 PID: 0 at ../kernel/ipipe/core.c:1968 __ipipe_spin_unlock_debug+0x14/0x20
>>>>> [    0.183600] Modules linked in:
>>>>> [    0.183600] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.59-xenomai+ #64
>>>>> [    0.183600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>>>> [    0.183600] I-pipe domain: Linux
>>>>> [    0.183600] RIP: 0010:__ipipe_spin_unlock_debug+0x14/0x20
>>>>> [    0.183600] Code: 8b 07 5b e9 0e d5 c7 00 5b c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 e8 bb de a7 00 f7 c7 00 02 00 00 74 09 9c 58 f6 c4 02 75 02 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 e8 9b de a7 00 41 54 55 53 9c
>>>>> [    0.183600] RSP: 0000:ffffffff82403d68 EFLAGS: 00010046
>>>>> [    0.183600] RAX: 0000000000000006 RBX: b74e512d1320154d RCX: ffff88803e6f2cc0
>>>>> [    0.183600] RDX: 0000000000000001 RSI: ffffffff810c1c9e RDI: 0000000000000200
>>>>> [    0.183600] RBP: ffff88803ea3afe4 R08: 0000000000000000 R09: ffff88803dd0e540
>>>>> [    0.183600] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000200
>>>>> [    0.183600] R13: ffff88803dd0da00 R14: ffffffff82403eb0 R15: 0000000000000000
>>>>> [    0.183600] FS:  0000000000000000(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
>>>>> [    0.183600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [    0.183600] CR2: ffff888003201000 CR3: 000000000240a001 CR4: 0000000000360ef0
>>>>> [    0.183600] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> [    0.183600] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> [    0.183600] Call Trace:
>>>>> [    0.183600]  get_random_u64+0x68/0x80
>>>>> [    0.183600]  copy_process+0x37e/0x1ae0
>>>>> [    0.183600]  _do_fork+0x92/0x340
>>>>> [    0.183600]  ? acpi_hw_register_read+0x93/0x123
>>>>> [    0.183600]  kernel_thread+0x55/0x70
>>>>> [    0.183600]  ? rest_init+0xc0/0xc0
>>>>> [    0.183600]  rest_init+0x1e/0xc0
>>>>> [    0.183600]  start_kernel+0x4d4/0x4f9
>>>>> [    0.183600]  secondary_startup_64+0xa4/0xb0
>>>>> [    0.183600] ---[ end trace 9d5e39ac2de18173 ]---
>>>>>
>>>>> This is with I-pipe debugging enabled. Could you have a look?
>>>>>
>>>>
>>>> I cannot reproduce it,
>>>>
>>>> I use this config with IPIPE_DEBUG
>>>> https://github.com/intel/linux-stable-xenomai/blob/review/5.4.59/stable/ipipe-x86/config_xenomai.xeno_debug
>>>>
>>>> test on a real WHL-U board (UP Xtreme), kernel boot OK and swtichtest
>>>> runs continously without error.
>>>>
>>>> another config also have no error:
>>>> https://github.com/intel/linux-stable-xenomai/blob/review/5.4.59/stable/ipipe-x86/config_xenomai.kernel_debug
>>>>
>>>> am I missing something? need to test the image inside QEMU/KVM? and this issue happens
>>>> during boot or after launch the switchtest? 
>>>
>>> This comes once during boot (in QEMU/KVM, but that should not matter -
>>> famous last words). I have this set here:
>>>
>>> CONFIG_IPIPE_DEBUG=y
>>> CONFIG_IPIPE_DEBUG_CONTEXT=y
>>> CONFIG_IPIPE_DEBUG_INTERNAL=y
>>> CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
>>> CONFIG_IPIPE_TRACE=y
>>> # CONFIG_IPIPE_TRACE_ENABLE is not set
>>> CONFIG_IPIPE_TRACE_MCOUNT=y
>>> # CONFIG_IPIPE_TRACE_IRQSOFF is not set
>>> CONFIG_IPIPE_TRACE_SHIFT=14
>>> CONFIG_IPIPE_TRACE_VMALLOC=y
>>> CONFIG_IPIPE_TRACE_PANIC=y
>>>
>>> If you look at the source of the warning, you can see that
>>> CONFIG_IPIPE_DEBUG_INTERNAL=y makes the difference.
>>>
>>> Jan
>>
>> well I still boot OK with IPIPE_DEBUG_INTERNAL. Will check source code
>> tomorrow.
>>
> 
> Found, not yet fixed though:
> 
> fpregs_unlock does not use the flags that fpregs_lock saves. That can
> kill kittens. We likely need to change the signature of that functions
> AND patch all callers. Examining...
> 

That is the very same pattern, in fact, that dovetail uses.

BUT... We should likely not disable hard interrupts across
copy_fpregs_to_sigframe (arch/x86/kernel/fpu/signal.c). Or what was your
reasoning for that, Philippe?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

