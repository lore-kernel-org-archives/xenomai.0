MIME-Version: 1.0
In-Reply-To: <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
 <14040d9b-3b4b-9677-05d0-24773e309310@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 20 Mar 2018 17:30:03 +0530
Message-ID: <CAOuPNLjP+6CPOf-4uYHZCLEfAzGjQOXy32r+5TBwMrVFFH9fOw@mail.gmail.com>
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

On Tue, Mar 20, 2018 at 5:15 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/20/2018 12:31 PM, Pintu Kumar wrote:
>> On Tue, Mar 20, 2018 at 3:02 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 03/20/2018 08:26 AM, Pintu Kumar wrote:
>>>> On Tue, Mar 20, 2018 at 10:57 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>>> On Tue, Mar 20, 2018 at 9:03 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>> If you want to use open, read, write you need to specify in the
>>>>>> makefile to use the posix skin.  You need something like these in your
>>>>>> Makefile:
>>>>>>
>>>>>> XENO_CONFIG := /usr/xenomai/bin/xeno-config
>>>>>> CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
>>>>>> LDFLAGS := $(shell  $(XENO_CONFIG) --posix --ldflags)
>>>>>>
>>>>>
>>>>> Oh yes I forgot to mention with posix skin it is working.
>>>>>
>>>>> But I wanted to use native API only, so I removed posix skin from Makefile.
>>>>>
>>>>> For, native API, I am using: rt_dev_{open, read, write}. Is this the
>>>>> valid API for Xenomai 3.0 ?
>>>>> Or there is something else?
>>>>> Is there any reference ?
>>>>>
>>>>
>>>> Dear Greg,
>>>>
>>>> In my sample, I am just copying some string from user <--> kernel and
>>>> printing them.
>>>> For normal driver, I get read/write latency like this:
>>>> write latency: 2.247 us
>>>> read latency: 2.202 us
>>>>
>>>> For Xenomai 3.0 rtdm driver, using : rt_dev_{open, read, write}
>>>> I get the latency like this:
>>>> write latency: 7.668 us
>>>> read latency: 5.558 us
>>>>
>>>> My concern is, why the latency is higher in case of RTDM ?
>>>> This is on x86-64 machine.
>>>>
>>>
>>> Did you stress your machine while your test was running? If not, you
>>> were not measuring worst-case latency, you were measuring execution time
>>> in this case, which is different. If you want to actually measure
>>> latency for real-time usage, you need to run your tests under
>>> significant stress load. Under such load, the RTDM version should
>>> perform reliably below a reasonable latency limit, the "normal" version
>>> will experience jittery above that limit.
>>>
>>> A trivial stress load may be as simple as running a dd loop copying
>>> 128Mb blocks from /dev/zero to /dev/null in the background, you may also
>>> add a kernel compilation keeping all CPUs busy.
>>>
>>
>> OK, I tried both the option. But still normal driver latency is much lower.
>> In fact, with kernel build in another terminal, rtdm latency shoots much higher.
>> Normal Kernel
>> --------------------
>> write latency: 3.084 us
>> read latency: 3.186 us
>>
>> RTDM Kernel (native)
>> ---------------------------------
>> write latency: 12.676 us
>> read latency: 9.858 us
>>
>> RTDM Kernel (posix)
>> ---------------------------------
>> write latency: 12.907 us
>> read latency: 8.699 us
>>
>> During the beginning of kernel build I even observed, RTDM (native)
>> goes as high as:
>> write latency: 4061.266 us
>> read latency: 3947.836 us
>>
>> ---------------------------------
>> As a quick reference, this is the snippet for the rtdm write method.
>>
>> --------------------------------
>> static ssize_t rtdm_write(..)
>> {
>>         struct dummy_context *context;
>>
>>         context = rtdm_fd_to_private(fd);
>>
>>         memset(context->buffer, 0, 4096);
>>         rtdm_safe_copy_from_user(fd, context->buffer, buff, len);
>>         rtdm_printk("write done\n");
>>
>>         return len;
>> }
>>
>> The normal driver write is also almost same.
>>
>> In the application side, I just invoke using:
>>         t1 = rt_timer_read();
>>         ret = rt_dev_write(fd, msg, len);
>>         t2 = rt_timer_read();
>>
>> Is there any thing wrong on the rtdm side ?
>> --------------------------------
>>
>>> Besides, you need to make sure to disable I-pipe and Cobalt debug
>>> options, particularly CONFIG_IPIPE_TRACE and
>>> CONFIG_XENO_OPT_DEBUG_LOCKING when running the RTDM case.
>>>
>>
>> Yes this debug options are already disabled.
>>
>>>>
>>>> Latency is little better, when using only posix skin:
>>>> write latency: 3.587 us
>>>> read latency: 3.392 us
>>>>
>>>
>>> This does not make much sense, see the excerpt from
>>> include/trank/rtdm/rtdm.h, which simply wraps the inline rt_dev_write()
>>> call to Cobalt's POSIX call [__wrap_]write() from lib/cobalt/rtdm.c:
>>>
>>
>> OK sorry, there was a mistake in posix latency value.
>> I forgot to switch to rtdm driver, instead of normal driver.
>> With posix skin and using the exactly same as normal driver application.
>> The latency figure was almost same as native skin.
>> write latency: 7.044 us
>> read latency: 6.786 us
>>
>>
>>> #define rt_dev_call(__call, __args...)  \
>>> ({                                      \
>>>         int __ret;                      \
>>>         __ret = __RT(__call(__args));   \
>>>         __ret < 0 ? -errno : __ret;     \
>>> })
>>>
>>> static inline ssize_t rt_dev_write(int fd, const void *buf, size_t len)
>>> {
>>>         return rt_dev_call(write, fd, buf, len);
>>> }
>>>
>>> The way you measure the elapsed time may affect the measurement:
>>> libalchemy's rt_timer_read() is definitely slower than libcobalt's
>>> clock_gettime().
>>
>> For normal kernel driver (and rtdm with posix skin) application, I am
>> using clock_gettime().
>> For Xenomai rtdm driver with native skin application, I am using rt_timer_read()
>>
>>
>>>
>>> The POSIX skin is generally faster than the alchemy API, because it
>>> implements wrappers to the corresponding Cobalt system calls (i.e.
>>> libcobalt is Xenomai's libc equivalent). Alchemy has to traverse
>>> libcopperplate before actual syscalls may be issued by libcobalt it is
>>> depending on, because libalchemy needs the copperplate interface layer
>>> for shielding itself from Cobalt/Mercury differences.
>>>
>>
>> Actually, as per the previous experience for simple thread
>> application, rt_timer_read() with native
>> skin gave better latency, when compared to using posix skin with clock API.
>>
>
> This behavior makes not much sense, simply looking at the library code:
> rt_timer_read() may be considered as a superset of libcobalt's
> clock_gettime.
>
> This could be a hint that you might not be testing with Cobalt's POSIX
> API. You may want to check running "nm" on your executable, verifying
> that __wrap_* calls are listed (e.g. __wrap_clock_gettime instead of
> clock_gettime).
>

Yes, wrap calls are listed in symbol table.

posix# nm -a my_app | grep clock
                 U __wrap_clock_gettime


> --
> Philippe.

