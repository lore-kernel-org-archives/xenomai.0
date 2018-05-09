From: Edouard Tisserant <edouard.tisserant@gmail.com>
References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
 <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
 <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
 <e937a73f-ef0f-5394-bdae-400fcfe30ddb@gmail.com>
 <2e75fd33-8998-4cfb-6fa6-bef20f37f2dc@gmail.com>
 <e398a8e0-65f2-cd46-b502-0e81f5e6fee6@xenomai.org>
 <9c2a8966-09c2-cc32-9a7b-fe16339d9c80@gmail.com>
Message-ID: <bd252434-25b7-e0c1-5a55-7e9321c48d8f@gmail.com>
Date: Wed, 9 May 2018 10:57:53 +0200
MIME-Version: 1.0
In-Reply-To: <9c2a8966-09c2-cc32-9a7b-fe16339d9c80@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

> [Xenomai] bad syscall <0xf0002>

It appears that 0xf0002 is a private ARM SWI, as declared in linux'
/arch/arm/include/uapi/asm/unistd.h :

/*
 * The following SWIs are ARM private.
 */
#define __ARM_NR_BASE           (__NR_SYSCALL_BASE+0x0f0000)
#define __ARM_NR_breakpoint     (__ARM_NR_BASE+1)
#define __ARM_NR_cacheflush     (__ARM_NR_BASE+2)
...

Code in Xenomai's /kernel/cobalt/posix/syscall.c must be wrong :

linux_syscall:
    code = __xn_get_syscall_nr(regs);
    if (code >= NR_syscalls)
        goto bad_syscall;

NR_syscalls is defined in kernel as 400, so private ARM SWIs are always
rejected.

What should we do ? Can we safely ignore that cacheflush syscall is not
being executed ?

Otherwise, what should be the logic to determine good or bad syscalls ?


On 09/05/2018 09:45, Edouard Tisserant wrote:
> I detected this in my dmesg :
>
> [Xenomai] bad syscall <0xf0002>
>
> The message isn't associated to any crash. It doesn't seem to break
> anything, but it doesn't smell good... does it ?
>
> It happens each time I dlopen a cobalt-wrapped shared object (also
> happens if just using alchemy, without any other special linker
> instuctions).
>
> I was looking at kernel/cobalt/posix/syscall*,  but still I couldn't
> figure out what is emitting that wrong syscall when dlopening. In case
> it matters, OABI compatibility is not enabled in my build, and target is
> an imx28.
>
> I'm a bit lost. Where should I search ?
>
>
>
>
> On 27/04/2018 17:43, Philippe Gerum wrote:
>> On 04/27/2018 04:43 PM, Edouard Tisserant wrote:
>>>> Now let see if dlopen/dlclose some code using alchemy segfaults or not...
>>> Well, it didn't work as-is, but I finally got it working !
>>>
>>> If I was dlopening anything relying on copperplate after that python
>>> code, then it was making an assert :  __register_setup_call: Assertion
>>> `!main_init_done' failed.
>>>
>>> The reason is that all xenomai libraries we plan to use have to be
>>> loaded _before_ call to xenomai_init, so that their setup call is
>>> registered.
>>>
>>> Hereafter is updated (and simplified) python code :
>>>
>>> from ctypes import *
>>> for name in ["cobalt", "modechk", "copperplate", "alchemy"]:
>>>     globals()[name] = CDLL("lib"+name+".so", mode=RTLD_GLOBAL)
>>> cobalt.xenomai_init(pointer(c_int(0)),
>>> pointer((POINTER(c_char)*2)(create_string_buffer("python"), None)))
>>>
>>> Note : Order of dlopen matters. Argument passed to
>>> xenomai_init(&argc,&argv) are here only to prevent de-referencing NULL.
>>>
>>> After this being executed, you can load and unload many shared object
>>> that use alchemy and posix (they should not be linked to boostrap_pic.o)
>>>
>> Looks good. The key point is that xenomai_init() is the call from the
>> API which controls the whole Xenomai init process, after which Xenomai
>> libs are fully functional. This explains why any library which wants to
>> be part of that process needs its setup descriptor to be known and
>> registered prior to issuing this call.
>>
>> The bootstrap module is just a helper that calls xenomai_init()
>> automatically before the main() routine is entered (bootstrap.o) when
>> glued to a final executable, or right after a DSO is loaded
>> (bootstrap-pic.o) when glued to a shared library. If the application
>> wants a fine-grained control over the init sequence instead, it just
>> needs not to include the bootstrap module in the executable/DSO, calling
>> xenomai_init() manually when it sees fit.
>>


