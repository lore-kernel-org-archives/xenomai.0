MIME-Version: 1.0
In-Reply-To: <20bffd5c-9f11-3bb2-236a-11764a129059@xenomai.org>
References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
 <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
 <CAOuPNLjP+6CPOf-4uYHZCLEfAzGjQOXy32r+5TBwMrVFFH9fOw@mail.gmail.com>
 <20bffd5c-9f11-3bb2-236a-11764a129059@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 23 Mar 2018 18:10:41 +0530
Message-ID: <CAOuPNLi28DcSYvuk__P6_o=xZ=O=Wv-k8iXqiUez87PKCKeXfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Philippe,

Thank you so much for your detailed explanation.

First to cross-check, I also tried on ARM BeagleBone (White) with
256MB RAM, Single core
These are the values I got.
===========================
NORMAL KERNEL Driver Build (with xenomai present)
---------------------------------------------------------------------------
write latency: 8235.083 us
read latency: 13636.875 us
-------------------------------------
write latency: 8192.542 us
read latency: 12859.833 us
--------------------------------------
write latency: 8182.833 us
read latency: 11003.333 us

===========================
XENOMAI RTDM Driver (native skin only)
--------------------------------------------------------
write latency: 8118.208 us
read latency: 12464.459 us
------------------------------------
write latency: 8162.083 us
read latency: 12885.000 us
------------------------------------
write latency: 8353.792 us
read latency: 11065.666 us

===========================
XENOMAI RTDM Driver (using posix skin only)
write latency: 8459.958 us
read latency: 12597.875 us
-------------------------------------
write latency: 8386.042 us
read latency: 11579.958 us
-------------------------------------
write latency: 8283.958 us
read latency: 13078.167 us
==============================================

So, looks like random behavior.
Sometimes normal driver is better, sometime RTDM-native is better,
sometimes RTDM-posix is better
I even tried by firing dd commands in background. In this case also
normal kernel driver is better.



About previous SkyLake machine, please find the information below:
# Architecture:          x86_64
# CPU op-mode(s):        32-bit, 64-bit
# CPU(s):                8
# Core:                    i7-6700K CPU @ 4.00GHz
# Virtualization:        VT-x
# Linux Kernel:         4.9.51
# cat /proc/cmdline
initrd=0:\initrd.img-4.9.51-amd-x86-64-rtdm
root=/dev/disk/by-partlabel/system ro ip=off processor.max_cstate=1
idle=poll i915.enable_rc6=0 i915.enable_dc=0 i915.powersave=0 nosmap
maxcpus=8 xenomai.smi=disabled
# /usr/xenomai/sbin/version
Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
# cat /proc/ipipe/version
4
# cat /proc/xenomai/latency
896


This is the latest latency value on SkyLake machine
==================================================
NORMAL KERNEL DRIVER:
write latency: 2.053 us
read latency: 2.285 us
-------------------------
XENOMAI RTDM DRIVER (native skin)
write latency: 6.248 us
read latency: 5.024 us
-------------------------
XENOMAI RTDM DRIVER (posix skin)
write latency: 6.320 us
read latency: 5.524 us
-------------------------

==================================================
This is the code snippet for RTDM write function:
(Note: error checking is removed to make it easy.
--------------------------------------------------------------------
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/string.h>
#include <rtdm/driver.h>

static ssize_t my_write(struct rtdm_fd *fd, const void __user *buff,
                                size_t len)
{
        struct my_context *context;

        context = rtdm_fd_to_private(fd);

        memset(context->buffer, 0, PAGE_SIZE);
        rtdm_safe_copy_from_user(fd, context->buffer, buff, len);
        rtdm_printk(": %s: done\n", __func__);

        return len;
}

static struct rtdm_driver my_driver = {
        .profile_info           =       RTDM_PROFILE_INFO(name,
                                                          RTDM_CLASS_MISC,
                                                          0,
                                                          0),
        .device_flags           =       RTDM_NAMED_DEVICE|RTDM_EXCLUSIVE,
        .device_count           =       1,
        .context_size           =       sizeof(struct my_context),
        .ops = {
                .open           =       my_open,
                .read_rt        =       my_read,
                .write_rt       =      my_write,
                .close          =       my_close,
        },
};

Makefile:
Same as normal linux module makefile, without any XENO_FLAGS.
-------------------------------------------------------------------
Application:
char msg[] = "something";
        len = strlen(msg);
        prev = rt_timer_read();
        ret = rt_dev_write(fd, msg, len);
        now = rt_timer_read();
        diff = (now - prev) / 1000.0;
        rt_printf("write latency: %5.3f us\n", diff);
--------------------------------------------------------------------
Hope this implementation is fine. If there is any mistake here, please
let me know.
==================================================

At the RTDM driver side, I even tried removing memset, printk, and
kept just copy_from_user, but it just reduces to 1 micro-seconds.
Also I tried replacing the rtdm_safe_copy_from_user, with just
rtdm_copy_from_user, nothing much changed.
So, it seems 2 things to me:
- rtdm_copy_from_user - takes more thing compare to normal kernel copy_from_user
- rt_dev_write - takes more time compare to normal write call, in normal kernel.

OR, is there too many primary<-->secondary switching happening in case
of my RTDM driver.

Is there any other way to check this issue and improve latency with
rtdm driver ?

If you have any other pointers/suggestions, please let me know.


Thanks,
Pintu

On Tue, Mar 20, 2018 at 6:39 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/20/2018 01:00 PM, Pintu Kumar wrote:
>> On Tue, Mar 20, 2018 at 5:15 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 03/20/2018 12:31 PM, Pintu Kumar wrote:
>>>> On Tue, Mar 20, 2018 at 3:02 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>>> On 03/20/2018 08:26 AM, Pintu Kumar wrote:
>>>>>> On Tue, Mar 20, 2018 at 10:57 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>>>>> On Tue, Mar 20, 2018 at 9:03 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>> If you want to use open, read, write you need to specify in the
>>>>>>>> makefile to use the posix skin.  You need something like these in your
>>>>>>>> Makefile:
>>>>>>>>
>>>>>>>> XENO_CONFIG := /usr/xenomai/bin/xeno-config
>>>>>>>> CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
>>>>>>>> LDFLAGS := $(shell  $(XENO_CONFIG) --posix --ldflags)
>>>>>>>>
>>>>>>>
>>>>>>> Oh yes I forgot to mention with posix skin it is working.
>>>>>>>
>>>>>>> But I wanted to use native API only, so I removed posix skin from Makefile.
>>>>>>>
>>>>>>> For, native API, I am using: rt_dev_{open, read, write}. Is this the
>>>>>>> valid API for Xenomai 3.0 ?
>>>>>>> Or there is something else?
>>>>>>> Is there any reference ?
>>>>>>>
>>>>>>
>>>>>> Dear Greg,
>>>>>>
>>>>>> In my sample, I am just copying some string from user <--> kernel and
>>>>>> printing them.
>>>>>> For normal driver, I get read/write latency like this:
>>>>>> write latency: 2.247 us
>>>>>> read latency: 2.202 us
>>>>>>
>>>>>> For Xenomai 3.0 rtdm driver, using : rt_dev_{open, read, write}
>>>>>> I get the latency like this:
>>>>>> write latency: 7.668 us
>>>>>> read latency: 5.558 us
>>>>>>
>>>>>> My concern is, why the latency is higher in case of RTDM ?
>>>>>> This is on x86-64 machine.
>>>>>>
>>>>>
>>>>> Did you stress your machine while your test was running? If not, you
>>>>> were not measuring worst-case latency, you were measuring execution time
>>>>> in this case, which is different. If you want to actually measure
>>>>> latency for real-time usage, you need to run your tests under
>>>>> significant stress load. Under such load, the RTDM version should
>>>>> perform reliably below a reasonable latency limit, the "normal" version
>>>>> will experience jittery above that limit.
>>>>>
>>>>> A trivial stress load may be as simple as running a dd loop copying
>>>>> 128Mb blocks from /dev/zero to /dev/null in the background, you may also
>>>>> add a kernel compilation keeping all CPUs busy.
>>>>>
>>>>
>>>> OK, I tried both the option. But still normal driver latency is much lower.
>>>> In fact, with kernel build in another terminal, rtdm latency shoots much higher.
>>>> Normal Kernel
>>>> --------------------
>>>> write latency: 3.084 us
>>>> read latency: 3.186 us
>>>>
>>>> RTDM Kernel (native)
>>>> ---------------------------------
>>>> write latency: 12.676 us
>>>> read latency: 9.858 us
>>>>
>>>> RTDM Kernel (posix)
>>>> ---------------------------------
>>>> write latency: 12.907 us
>>>> read latency: 8.699 us
>>>>
>>>> During the beginning of kernel build I even observed, RTDM (native)
>>>> goes as high as:
>>>> write latency: 4061.266 us
>>>> read latency: 3947.836 us
>>>>
>>>> ---------------------------------
>>>> As a quick reference, this is the snippet for the rtdm write method.
>>>>
>>>> --------------------------------
>>>> static ssize_t rtdm_write(..)
>>>> {
>>>>         struct dummy_context *context;
>>>>
>>>>         context = rtdm_fd_to_private(fd);
>>>>
>>>>         memset(context->buffer, 0, 4096);
>>>>         rtdm_safe_copy_from_user(fd, context->buffer, buff, len);
>>>>         rtdm_printk("write done\n");
>>>>
>>>>         return len;
>>>> }
>>>>
>>>> The normal driver write is also almost same.
>>>>
>>>> In the application side, I just invoke using:
>>>>         t1 = rt_timer_read();
>>>>         ret = rt_dev_write(fd, msg, len);
>>>>         t2 = rt_timer_read();
>>>>
>>>> Is there any thing wrong on the rtdm side ?
>>>> --------------------------------
>>>>
>>>>> Besides, you need to make sure to disable I-pipe and Cobalt debug
>>>>> options, particularly CONFIG_IPIPE_TRACE and
>>>>> CONFIG_XENO_OPT_DEBUG_LOCKING when running the RTDM case.
>>>>>
>>>>
>>>> Yes this debug options are already disabled.
>>>>
>>>>>>
>>>>>> Latency is little better, when using only posix skin:
>>>>>> write latency: 3.587 us
>>>>>> read latency: 3.392 us
>>>>>>
>>>>>
>>>>> This does not make much sense, see the excerpt from
>>>>> include/trank/rtdm/rtdm.h, which simply wraps the inline rt_dev_write()
>>>>> call to Cobalt's POSIX call [__wrap_]write() from lib/cobalt/rtdm.c:
>>>>>
>>>>
>>>> OK sorry, there was a mistake in posix latency value.
>>>> I forgot to switch to rtdm driver, instead of normal driver.
>>>> With posix skin and using the exactly same as normal driver application.
>>>> The latency figure was almost same as native skin.
>>>> write latency: 7.044 us
>>>> read latency: 6.786 us
>>>>
>>>>
>>>>> #define rt_dev_call(__call, __args...)  \
>>>>> ({                                      \
>>>>>         int __ret;                      \
>>>>>         __ret = __RT(__call(__args));   \
>>>>>         __ret < 0 ? -errno : __ret;     \
>>>>> })
>>>>>
>>>>> static inline ssize_t rt_dev_write(int fd, const void *buf, size_t len)
>>>>> {
>>>>>         return rt_dev_call(write, fd, buf, len);
>>>>> }
>>>>>
>>>>> The way you measure the elapsed time may affect the measurement:
>>>>> libalchemy's rt_timer_read() is definitely slower than libcobalt's
>>>>> clock_gettime().
>>>>
>>>> For normal kernel driver (and rtdm with posix skin) application, I am
>>>> using clock_gettime().
>>>> For Xenomai rtdm driver with native skin application, I am using rt_timer_read()
>>>>
>>>>
>>>>>
>>>>> The POSIX skin is generally faster than the alchemy API, because it
>>>>> implements wrappers to the corresponding Cobalt system calls (i.e.
>>>>> libcobalt is Xenomai's libc equivalent). Alchemy has to traverse
>>>>> libcopperplate before actual syscalls may be issued by libcobalt it is
>>>>> depending on, because libalchemy needs the copperplate interface layer
>>>>> for shielding itself from Cobalt/Mercury differences.
>>>>>
>>>>
>>>> Actually, as per the previous experience for simple thread
>>>> application, rt_timer_read() with native
>>>> skin gave better latency, when compared to using posix skin with clock API.
>>>>
>>>
>>> This behavior makes not much sense, simply looking at the library code:
>>> rt_timer_read() may be considered as a superset of libcobalt's
>>> clock_gettime.
>>>
>>> This could be a hint that you might not be testing with Cobalt's POSIX
>>> API. You may want to check running "nm" on your executable, verifying
>>> that __wrap_* calls are listed (e.g. __wrap_clock_gettime instead of
>>> clock_gettime).
>>>
>>
>> Yes, wrap calls are listed in symbol table.
>>
>> posix# nm -a my_app | grep clock
>>                  U __wrap_clock_gettime
>>
>>
>
> Then you may suspect a SMI problem, less likely an hyperthreading issue
> given the magnitude of the latency figures. You may want to have a look
> at this thread [1].
>
> If this is a SMI issue, you should be able to see it on a regular kernel
> as well, provided the protocol for testing is right and actually
> exercises the same thing for an equivalent period of time on both ends
> (Xenomai / native).
>
> We generally don't know which configuration is under test on your end:
> which I-pipe patch you have been using, which kernel release, which
> Xenomai release (assuming you are not using the obsolete 3.0.0 original
> release). Actually, we don't know much about your hw either (the Intel
> micro-architecture is not defining when it comes to latency issues, the
> SoC may be, the BIOS usually is).
>
> AFAIU, the symptoms you are referring to are either SMI-related, or
> might be related to some GPU driver doing issuing costly instructions
> badly affecting the latency (e.g. wbinvd, although a 4 ms latency spike
> is completely insane and does not fit the typical footprint of those
> insns), or might denote a massive I-pipe/Xenomai bug.
>
> The latter is always possible, but not the most likely at the moment, as
> this kind of bug tends to be noticed by many people, and nobody did so
> far with the stable Xenomai release and an official I-pipe patch for
> x86, or any other architecture.
>
> First I would recommend reading [2], providing the missing information
> afterwards.
>
> Then, I would make 100% sure that your SoC is SMI-free, and HT is
> disabled in the BIOS, running a vanilla kernel: no I-pipe, no Xenomai,
> just plain regular kernel.
>
> [1] http://xenomai.org/pipermail/xenomai/2018-February/038393.html
> [2] http://xenomai.org/asking-for-help/
>
> --
> Philippe.

