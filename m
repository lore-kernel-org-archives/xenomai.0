References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
 <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
 <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3275c582-ede3-dd17-d6d1-46be97984b95@xenomai.org>
Date: Tue, 20 Mar 2018 12:37:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgMJ_cvEsXJd+oF+g0ftMudT4Ztkb_yy=AXBMRDWuGqBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Simple application for invoking rtdm driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/20/2018 12:31 PM, Pintu Kumar wrote:
> On Tue, Mar 20, 2018 at 3:02 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/20/2018 08:26 AM, Pintu Kumar wrote:
>>> On Tue, Mar 20, 2018 at 10:57 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>> On Tue, Mar 20, 2018 at 9:03 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>> If you want to use open, read, write you need to specify in the
>>>>> makefile to use the posix skin.  You need something like these in your
>>>>> Makefile:
>>>>>
>>>>> XENO_CONFIG := /usr/xenomai/bin/xeno-config
>>>>> CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
>>>>> LDFLAGS := $(shell  $(XENO_CONFIG) --posix --ldflags)
>>>>>
>>>>
>>>> Oh yes I forgot to mention with posix skin it is working.
>>>>
>>>> But I wanted to use native API only, so I removed posix skin from Makefile.
>>>>
>>>> For, native API, I am using: rt_dev_{open, read, write}. Is this the
>>>> valid API for Xenomai 3.0 ?
>>>> Or there is something else?
>>>> Is there any reference ?
>>>>
>>>
>>> Dear Greg,
>>>
>>> In my sample, I am just copying some string from user <--> kernel and
>>> printing them.
>>> For normal driver, I get read/write latency like this:
>>> write latency: 2.247 us
>>> read latency: 2.202 us
>>>
>>> For Xenomai 3.0 rtdm driver, using : rt_dev_{open, read, write}
>>> I get the latency like this:
>>> write latency: 7.668 us
>>> read latency: 5.558 us
>>>
>>> My concern is, why the latency is higher in case of RTDM ?
>>> This is on x86-64 machine.
>>>
>>
>> Did you stress your machine while your test was running? If not, you
>> were not measuring worst-case latency, you were measuring execution time
>> in this case, which is different. If you want to actually measure
>> latency for real-time usage, you need to run your tests under
>> significant stress load. Under such load, the RTDM version should
>> perform reliably below a reasonable latency limit, the "normal" version
>> will experience jittery above that limit.
>>
>> A trivial stress load may be as simple as running a dd loop copying
>> 128Mb blocks from /dev/zero to /dev/null in the background, you may also
>> add a kernel compilation keeping all CPUs busy.
>>
> 
> OK, I tried both the option. But still normal driver latency is much lower.
> In fact, with kernel build in another terminal, rtdm latency shoots much higher.
> Normal Kernel
> --------------------
> write latency: 3.084 us
> read latency: 3.186 us
> 
> RTDM Kernel (native)
> ---------------------------------
> write latency: 12.676 us
> read latency: 9.858 us
> 
> RTDM Kernel (posix)
> ---------------------------------
> write latency: 12.907 us
> read latency: 8.699 us
> 
> During the beginning of kernel build I even observed, RTDM (native)
> goes as high as:
> write latency: 4061.266 us
> read latency: 3947.836 us

Just to make sure, we are actually discussing a test case on real
hardware, not VM stuff, right?

-- 
Philippe.

