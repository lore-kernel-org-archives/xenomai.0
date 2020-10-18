Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
References: <20201014132459.GB24671@linux.intel.com>
 <8e59bc35-84ae-78be-8296-4f2367e8e844@siemens.com>
 <20201016033638.GB5581@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ba45dfa-4755-c627-e1fd-9f2c32ea8b8a@siemens.com>
Date: Sun, 18 Oct 2020 23:41:14 +0200
MIME-Version: 1.0
In-Reply-To: <20201016033638.GB5581@linux.intel.com>
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

On 16.10.20 05:36, Fino Meng wrote:
> On Thu, Oct 15, 2020 at 04:20:11PM +0200, Jan Kiszka wrote:
>> On 14.10.20 15:25, Fino Meng wrote:
>>> hi team,
>>>
>>> I just updated the scripts to build the WIP version xenomai porting to
>>> kernel 5.4, just follow the steps:
>>>
>>> git clone https://github.com/finomeng/xenomai-mirror.git /tmp/xenomai-mirror.next-5.4
>>> cd /tmp/xenomai-mirror.next-5.4
>>> git checkout -t origin/wip/next-5.4-porting
>>>
>>> git clone https://github.com/intel/linux-stable-xenomai /tmp/kernel
>>> cd /tmp/kernel
>>> git checkout -t review/5.4.59/stable/ipipe-x86
>>>
>>> ./patching-xenomai2kernel.sh
>>>
>>> cp config_xenomai.kernel_debug .config
>>> make olddefconfig
>>> ./build-debpkg.sh
>>>
>>>
>>> I didn't put it togethter with ISAR/Debian yet. I test it with a PC with Debian 10 installed.
>>>
>>> if no error, linux-image-*.deb and linux-headers-*.deb should generated outside kernel folder,
>>> copy them to your target test device with already installed a Debian/Ubuntu,
>>> install the deb with "dpkg -i", update-grub should be called during install linux-image-*.deb
>>> reboot and select to boot the new kernel in grub's menu
>>>
>>> the build steps also written in patching-xenomai2kernel.sh and build-debpkg.sh
>>>
>>> switchtest will fail in current version, for example: "./switchtest rtk_fp_ufpp0"
>>> will print:
>>>
>>> r0: 2147483648 != 1000
>>> r1: 2147483648 != 1000
>>> r2: 2147483648 != 1000
>>> r3: 2147483648 != 1000
>>> r4: 2147483648 != 1000
>>> r5: 2147483648 != 1000
>>> r6: 2147483648 != 1000
>>> r7: 2147483648 != 1000
>>> ymm0: 2676586395008836901/0 != 1000/1000
>>> ymm1: 71776119061217280/0 != 1000/1000
>>> ymm2: 0/0 != 1000/1000
>>> ymm3: 1000/0 != 1000/1000
>>> ymm4: 1000/0 != 1000/1000
>>> ymm5: 1000/0 != 1000/1000
>>> ymm6: 1000/0 != 1000/1000
>>> ymm7: 1000/0 != 1000/1000
>>> Error after context switch from task 1(rtk_fp_ufpp0-1) to task 0(sleeper_ufps0-0),
>>> FPU registers were set to 0 (maybe task sleeper_ufps0-0)
>>>
>>> if meet more questions just write to me, thanks!
>>>
>>> BR fino
>>>
>>
>> I can reproduce in KVM and poked around a bit, though without finding
>> the needle yet. Likely, there are multiple aspects. The change in
>> upstream to FPU switching on user-return is a hot lead, but it takes a
>> bit to fully grasp that and map it on our scenarios with Xenomai.
>>
>> Jan
> 
> it seems that, switch_fpu_prepare() and switch_fpu_finish() are
> for kernel thread context switch (in __switch_to() )and switch_fpu_return() is needed
> before return to userspace( in prepare_exit_to_usermode()).
> 

Yes, we need explicit switch_fpu_return() (likely open-coded, to skip
the PF_KTHREAD check) at the end of xnarch_switch_to, at least as long
as we do not add that to all fast (primary-mode) return-to-user paths.

But it's more complex. The removal of fpu_initialized changed the
condition under which __switch_to() does FPU saving and restoring: All
kernel threads, also ours, are excluded. That needs to be compensated.

But I'm still facing corruptions - continuing to debug.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

