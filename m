References: <CAOuPNLiL2jQ3wcYsxMAO2kqOvCvyPVPnZNakiLX_nhQVtVJk7A@mail.gmail.com>
 <CALLqZ8R77Pv+TRCrXiGkfzrcOdMMY+WfWzpO-qVE6-oFAgpU0g@mail.gmail.com>
 <CAOuPNLhcNcOdveFRLJUvFTLDDfQY4YOYUPRjWiPjK1o0zdTjJg@mail.gmail.com>
 <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <854aec2d-861e-f17e-e57c-d86e9f5e7a90@xenomai.org>
Date: Tue, 20 Mar 2018 10:32:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgJOsYcT51SHS56mG5KDsS9pOBYPdWY9aWDvv7rfvBTUg@mail.gmail.com>
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
To: Pintu Kumar <pintu.ping@gmail.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/20/2018 08:26 AM, Pintu Kumar wrote:
> On Tue, Mar 20, 2018 at 10:57 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>> On Tue, Mar 20, 2018 at 9:03 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>> If you want to use open, read, write you need to specify in the
>>> makefile to use the posix skin.  You need something like these in your
>>> Makefile:
>>>
>>> XENO_CONFIG := /usr/xenomai/bin/xeno-config
>>> CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
>>> LDFLAGS := $(shell  $(XENO_CONFIG) --posix --ldflags)
>>>
>>
>> Oh yes I forgot to mention with posix skin it is working.
>>
>> But I wanted to use native API only, so I removed posix skin from Makefile.
>>
>> For, native API, I am using: rt_dev_{open, read, write}. Is this the
>> valid API for Xenomai 3.0 ?
>> Or there is something else?
>> Is there any reference ?
>>
> 
> Dear Greg,
> 
> In my sample, I am just copying some string from user <--> kernel and
> printing them.
> For normal driver, I get read/write latency like this:
> write latency: 2.247 us
> read latency: 2.202 us
> 
> For Xenomai 3.0 rtdm driver, using : rt_dev_{open, read, write}
> I get the latency like this:
> write latency: 7.668 us
> read latency: 5.558 us
> 
> My concern is, why the latency is higher in case of RTDM ?
> This is on x86-64 machine.
>

Did you stress your machine while your test was running? If not, you
were not measuring worst-case latency, you were measuring execution time
in this case, which is different. If you want to actually measure
latency for real-time usage, you need to run your tests under
significant stress load. Under such load, the RTDM version should
perform reliably below a reasonable latency limit, the "normal" version
will experience jittery above that limit.

A trivial stress load may be as simple as running a dd loop copying
128Mb blocks from /dev/zero to /dev/null in the background, you may also
add a kernel compilation keeping all CPUs busy.

Besides, you need to make sure to disable I-pipe and Cobalt debug
options, particularly CONFIG_IPIPE_TRACE and
CONFIG_XENO_OPT_DEBUG_LOCKING when running the RTDM case.

>
> Latency is little better, when using only posix skin:
> write latency: 3.587 us
> read latency: 3.392 us
>

This does not make much sense, see the excerpt from
include/trank/rtdm/rtdm.h, which simply wraps the inline rt_dev_write()
call to Cobalt's POSIX call [__wrap_]write() from lib/cobalt/rtdm.c:

#define rt_dev_call(__call, __args...)	\
({					\
	int __ret;			\
	__ret = __RT(__call(__args));	\
	__ret < 0 ? -errno : __ret;	\
})

static inline ssize_t rt_dev_write(int fd, const void *buf, size_t len)
{
	return rt_dev_call(write, fd, buf, len);
}

The way you measure the elapsed time may affect the measurement:
libalchemy's rt_timer_read() is definitely slower than libcobalt's
clock_gettime().

The POSIX skin is generally faster than the alchemy API, because it
implements wrappers to the corresponding Cobalt system calls (i.e.
libcobalt is Xenomai's libc equivalent). Alchemy has to traverse
libcopperplate before actual syscalls may be issued by libcobalt it is
depending on, because libalchemy needs the copperplate interface layer
for shielding itself from Cobalt/Mercury differences.

-- 
Philippe.

