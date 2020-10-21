Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
References: <20201014132459.GB24671@linux.intel.com>
 <8e59bc35-84ae-78be-8296-4f2367e8e844@siemens.com>
 <20201016033638.GB5581@linux.intel.com>
 <0ba45dfa-4755-c627-e1fd-9f2c32ea8b8a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9153481d-6df6-314f-c2c0-f413a34fb815@siemens.com>
Date: Wed, 21 Oct 2020 08:36:04 +0200
MIME-Version: 1.0
In-Reply-To: <0ba45dfa-4755-c627-e1fd-9f2c32ea8b8a@siemens.com>
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
To: Fino Meng <fino.meng@linux.intel.com>
Cc: xenomai@xenomai.org

On 18.10.20 23:41, Jan Kiszka via Xenomai wrote:
> On 16.10.20 05:36, Fino Meng wrote:
>> On Thu, Oct 15, 2020 at 04:20:11PM +0200, Jan Kiszka wrote:
>>> On 14.10.20 15:25, Fino Meng wrote:
>>>> hi team,
>>>>
>>>> I just updated the scripts to build the WIP version xenomai porting to
>>>> kernel 5.4, just follow the steps:
>>>>
>>>> git clone https://github.com/finomeng/xenomai-mirror.git /tmp/xenomai-mirror.next-5.4
>>>> cd /tmp/xenomai-mirror.next-5.4
>>>> git checkout -t origin/wip/next-5.4-porting
>>>>
>>>> git clone https://github.com/intel/linux-stable-xenomai /tmp/kernel
>>>> cd /tmp/kernel
>>>> git checkout -t review/5.4.59/stable/ipipe-x86
>>>>
>>>> ./patching-xenomai2kernel.sh
>>>>
>>>> cp config_xenomai.kernel_debug .config
>>>> make olddefconfig
>>>> ./build-debpkg.sh
>>>>
>>>>
>>>> I didn't put it togethter with ISAR/Debian yet. I test it with a PC with Debian 10 installed.
>>>>
>>>> if no error, linux-image-*.deb and linux-headers-*.deb should generated outside kernel folder,
>>>> copy them to your target test device with already installed a Debian/Ubuntu,
>>>> install the deb with "dpkg -i", update-grub should be called during install linux-image-*.deb
>>>> reboot and select to boot the new kernel in grub's menu
>>>>
>>>> the build steps also written in patching-xenomai2kernel.sh and build-debpkg.sh
>>>>
>>>> switchtest will fail in current version, for example: "./switchtest rtk_fp_ufpp0"
>>>> will print:
>>>>
>>>> r0: 2147483648 != 1000
>>>> r1: 2147483648 != 1000
>>>> r2: 2147483648 != 1000
>>>> r3: 2147483648 != 1000
>>>> r4: 2147483648 != 1000
>>>> r5: 2147483648 != 1000
>>>> r6: 2147483648 != 1000
>>>> r7: 2147483648 != 1000
>>>> ymm0: 2676586395008836901/0 != 1000/1000
>>>> ymm1: 71776119061217280/0 != 1000/1000
>>>> ymm2: 0/0 != 1000/1000
>>>> ymm3: 1000/0 != 1000/1000
>>>> ymm4: 1000/0 != 1000/1000
>>>> ymm5: 1000/0 != 1000/1000
>>>> ymm6: 1000/0 != 1000/1000
>>>> ymm7: 1000/0 != 1000/1000
>>>> Error after context switch from task 1(rtk_fp_ufpp0-1) to task 0(sleeper_ufps0-0),
>>>> FPU registers were set to 0 (maybe task sleeper_ufps0-0)
>>>>
>>>> if meet more questions just write to me, thanks!
>>>>
>>>> BR fino
>>>>
>>>
>>> I can reproduce in KVM and poked around a bit, though without finding
>>> the needle yet. Likely, there are multiple aspects. The change in
>>> upstream to FPU switching on user-return is a hot lead, but it takes a
>>> bit to fully grasp that and map it on our scenarios with Xenomai.
>>>
>>> Jan
>>
>> it seems that, switch_fpu_prepare() and switch_fpu_finish() are
>> for kernel thread context switch (in __switch_to() )and switch_fpu_return() is needed
>> before return to userspace( in prepare_exit_to_usermode()).
>>
> 
> Yes, we need explicit switch_fpu_return() (likely open-coded, to skip
> the PF_KTHREAD check) at the end of xnarch_switch_to, at least as long
> as we do not add that to all fast (primary-mode) return-to-user paths.
> 
> But it's more complex. The removal of fpu_initialized changed the
> condition under which __switch_to() does FPU saving and restoring: All
> kernel threads, also ours, are excluded. That needs to be compensated.
> 
> But I'm still facing corruptions - continuing to debug.
> 

Quick update:

I made some progress with changes like below, but I'm still facing 
issues, not with weird AVX register corruptions. They confuse me because 
classic FPU registers are updated and saved/restored the same way, but 
they are currently unaffected.

Jan

diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index aa7b5d19d8..59fcd1995e 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -200,6 +200,8 @@ static inline void do_switch_threads(struct xnarchtcb *out_tcb,
 
 #endif /* LINUX_VERSION_CODE >= 4.8 */
 
+#define tcb_used_kfpu(t) ((t)->root_kfpu)
+
 void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
 	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
@@ -215,6 +217,15 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 		 */
 		clts();
 #endif /* ! IPIPE_X86_FPU_EAGER */
+	if (!xnthread_test_state(out, XNROOT | XNUSER) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		struct fpu *prev_fpu = &prev->thread.fpu;
+
+		if (!copy_fpregs_to_fpstate(prev_fpu))
+			prev_fpu->last_cpu = -1;
+		else
+			prev_fpu->last_cpu = smp_processor_id();
+	}
 
 	next = in_tcb->core.host_task;
 #ifndef IPIPE_X86_FPU_EAGER
@@ -260,6 +271,19 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 #ifndef IPIPE_X86_FPU_EAGER
 	stts();
 #endif /* ! IPIPE_X86_FPU_EAGER */
+	if (xnthread_current() &&
+	    !xnthread_test_state(xnthread_current(), XNROOT) &&
+	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		struct fpu *fpu = &current->thread.fpu;
+		int cpu = smp_processor_id();
+
+		if (!fpregs_state_valid(fpu, cpu)) {
+			copy_kernel_to_fpregs(&fpu->state);
+			fpregs_activate(fpu);
+			fpu->last_cpu = cpu;
+		}
+		clear_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 }
 
 #ifndef IPIPE_X86_FPU_EAGER
@@ -387,8 +413,6 @@ int xnarch_handle_fpu_fault(struct xnthread *from,
 
 #define current_task_used_kfpu() kernel_fpu_disabled()
 
-#define tcb_used_kfpu(t) ((t)->root_kfpu)
-
 #ifndef IPIPE_X86_FPU_EAGER
 void xnarch_leave_root(struct xnthread *root)
 {
@@ -488,6 +509,8 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 		return;
 
 	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
+	__cpu_invalidate_fpregs_state();
+	clear_thread_flag(TIF_NEED_FPU_LOAD);
 	kernel_fpu_disable();
 }
 #endif /* ! IPIPE_X86_FPU_EAGER */
@@ -541,7 +569,8 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
 	fpu__activate_fpstate_read(&p->thread.fpu);
 #else
-	fpu__clear(&p->thread.fpu);
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpstate_init(&p->thread.fpu.state);
 #endif
 #endif /* ! IPIPE_X86_FPU_EAGER */
 }


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

