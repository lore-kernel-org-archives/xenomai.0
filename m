References: <CAMcKmiHxu63HkbO9niHD07mpkvzo+7n1AW1xrSGc8_-GJ54OJw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <561D0904.3020901@xenomai.org>
Date: Tue, 13 Oct 2015 15:37:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAMcKmiHxu63HkbO9niHD07mpkvzo+7n1AW1xrSGc8_-GJ54OJw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] undefined reference to __cobalt_rt_dev_ioctl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>, xenomai@xenomai.org

On 10/12/2015 09:12 PM, George Broz wrote:
> Hi,
> 
> I'm trying to build a 3rd party application (IgH EtherCAT Master)
> for Xenomai 3.0 for an Altera ARM (socfpga) board. Linux and Xenomai,
> built with tools on the target, are working normally.
> 
> The IgH ECM uses autotools and makes use of xeno-config to set
> CFLAGS and LDFLAGS. It builds a user-space shared library that
> makes use of rt_dev_open(), rt_dev_close(), and rt_dev_iodev().
> Applications using the IgH ECM then link against this library.
> 
> For Xenomai 2.6.4, it was sufficient to use:
> xeno-config --rtdm --cflags/--ldflags to build this shared library.
> 
> For Xenomai 3.0 this results in:
> .libs/libethercat_rtdm.so: undefined reference to `rt_dev_ioctl'
> .libs/libethercat_rtdm.so: undefined reference to `rt_dev_open'
> .libs/libethercat_rtdm.so: undefined reference to `rt_dev_close'
> 
> Using:
> xeno-config --rtdm --compat --cflags/--ldflags
> 
> Eliminates those undefined references but results in a new one:
> .libs/libethercat_rtdm.so: undefined reference to `__cobalt_rt_dev_ioctl'
> 
> I could not find __cobalt_rt_dev_ioctl anywhere...
> 
> What is the best way to migrate an application making use of these calls
> to Xenomai 3.0? Is --compat supposed to make this work? If so, where
> could I find __cobalt_rt_dev_ioctl?
>

Yes, --compat is the proper way if you need to use the deprecated
rt_dev_*() interface from userland.

The only possible explanation I can think of for this issue would be a
bad expansion of the rt_dev_call() macro in include/trank/rtdm/rtdm.h,
like the following call would produce: rt_dev_call(rt_dev_ioctl),
instead of rt_dev_call(ioctl). However, I can't find such macro
invocation in the current (3.0) code base.

Bottom line is that rt_dev_ioctl() should resolve as __cobalt_ioctl(),
which is available from lib/cobalt/rtdm.c.

Could you pinpoint the call that expands to __cobalt_rt_dev_ioctl() in
the ethercat library source code?

PS: 3.0 final has been released, you should definitely upgrade from -rc6
to the latest code.

-- 
Philippe.

