MIME-Version: 1.0
Date: Tue, 13 Oct 2015 18:07:03 -0700
Message-ID: <CAMcKmiFz6o_45dsSJfsvdfq25-s3Fzuzr5jyui7ty93SD3ErJQ@mail.gmail.com>
From: George Broz <brozgeo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] undefined reference to __cobalt_rt_dev_ioctl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 13 October 2015 at 06:37, Philippe Gerum <rpm@xenomai.org> wrote:
> On 10/12/2015 09:12 PM, George Broz wrote:
>> Hi,
>>
>> I'm trying to build a 3rd party application (IgH EtherCAT Master)
>> for Xenomai 3.0 for an Altera ARM (socfpga) board. Linux and Xenomai,
>> built with tools on the target, are working normally.
>>
>> The IgH ECM uses autotools and makes use of xeno-config to set
>> CFLAGS and LDFLAGS. It builds a user-space shared library that
>> makes use of rt_dev_open(), rt_dev_close(), and rt_dev_iodev().
>> Applications using the IgH ECM then link against this library.
>>
>> For Xenomai 2.6.4, it was sufficient to use:
>> xeno-config --rtdm --cflags/--ldflags to build this shared library.
>>
>> For Xenomai 3.0 this results in:
>> .libs/libethercat_rtdm.so: undefined reference to `rt_dev_ioctl'
>> .libs/libethercat_rtdm.so: undefined reference to `rt_dev_open'
>> .libs/libethercat_rtdm.so: undefined reference to `rt_dev_close'
>>
>> Using:
>> xeno-config --rtdm --compat --cflags/--ldflags
>>
>> Eliminates those undefined references but results in a new one:
>> .libs/libethercat_rtdm.so: undefined reference to `__cobalt_rt_dev_ioctl'
>>
>> I could not find __cobalt_rt_dev_ioctl anywhere...
>>
>> What is the best way to migrate an application making use of these calls
>> to Xenomai 3.0? Is --compat supposed to make this work? If so, where
>> could I find __cobalt_rt_dev_ioctl?
>>
>
> Yes, --compat is the proper way if you need to use the deprecated
> rt_dev_*() interface from userland.
>
> The only possible explanation I can think of for this issue would be a
> bad expansion of the rt_dev_call() macro in include/trank/rtdm/rtdm.h,
> like the following call would produce: rt_dev_call(rt_dev_ioctl),
> instead of rt_dev_call(ioctl). However, I can't find such macro
> invocation in the current (3.0) code base.
>
> Bottom line is that rt_dev_ioctl() should resolve as __cobalt_ioctl(),
> which is available from lib/cobalt/rtdm.c.
>
> Could you pinpoint the call that expands to __cobalt_rt_dev_ioctl() in
> the ethercat library source code?

Thanks for the information. I found the offending code in master/ioctl.h:

#ifdef USE_RTDM
    :
    #define ioctl rt_dev_ioctl
    :
#else
    :
    #define ioctl ioctl
    :
#endif

One too many substitutions! For now, just changed the first to look
like the second and that resolved this issue.


>
> PS: 3.0 final has been released, you should definitely upgrade from -rc6
> to the latest code.
>

I upgraded to 3.0 stable.

Thanks!
--George

> --
> Philippe.

