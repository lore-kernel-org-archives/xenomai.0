MIME-Version: 1.0
In-Reply-To: <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 20 Mar 2018 12:56:02 +0530
Message-ID: <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Mar 20, 2018 at 10:57 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> On Tue, Mar 20, 2018 at 9:03 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> If you want to use open, read, write you need to specify in the
>> makefile to use the posix skin.  You need something like these in your
>> Makefile:
>>
>> XENO_CONFIG := /usr/xenomai/bin/xeno-config
>> CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
>> LDFLAGS := $(shell  $(XENO_CONFIG) --posix --ldflags)
>>
>
> Oh yes I forgot to mention with posix skin it is working.
>
> But I wanted to use native API only, so I removed posix skin from Makefile.
>
> For, native API, I am using: rt_dev_{open, read, write}. Is this the
> valid API for Xenomai 3.0 ?
> Or there is something else?
> Is there any reference ?
>

Dear Greg,

In my sample, I am just copying some string from user <--> kernel and
printing them.
For normal driver, I get read/write latency like this:
write latency: 2.247 us
read latency: 2.202 us

For Xenomai 3.0 rtdm driver, using : rt_dev_{open, read, write}
I get the latency like this:
write latency: 7.668 us
read latency: 5.558 us

My concern is, why the latency is higher in case of RTDM ?
This is on x86-64 machine.

Latency is little better, when using only posix skin:
write latency: 3.587 us
read latency: 3.392 us


Do you have any inputs for this behavior ?


Thanks,
Pintu


>
> Thanks,
> Pintu
>
>
>>
>> -Greg
>>
>>
>>
>> On Mon, Mar 19, 2018 at 9:42 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>> Hi,
>>>
>>> I have developed a simple rtdm driver using: open, read_rt, write_rt, close.
>>> Now I wanted to test it using a Xenomai native application, using native skin.
>>>
>>> Here are my observation.
>>>
>>> 1) If I use normal open, read, write system call, then Xenomai reports
>>> that normal read/write method is used for rtdm.
>>> So, it does not work like that.
>>>
>>> 2) If I use, rt_dev_open, rt_dev_read, rt_dev_write, then it works fine.
>>> But latency is very high for write/read, compared to normal.
>>> Also, the migration document says these are legacy API and should be
>>> replaced with rtdm_open, etc. for Xenomai 3.0.
>>> However, if I use rtdm_open, rtdm_write, etc, it could not compile successfully.
>>> I have included rtdm/rtdm.h header file.
>>>
>>> So, please guide me which are the right APIs to use to invoke the rtdm driver.
>>> I could to find the right example in test suite.
>>>
>>>
>>> Thanks,
>>> Pintu
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai

