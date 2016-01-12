References: <D9EDB4F689BF9F4EA6F2158A073942732E7C9E64@de08ex3008.global.ds.honeywell.com>
 <5693C218.5070701@xenomai.org>
 <D9EDB4F689BF9F4EA6F2158A073942732E7C9FEA@de08ex3008.global.ds.honeywell.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <569528D3.2050008@xenomai.org>
Date: Tue, 12 Jan 2016 17:24:51 +0100
MIME-Version: 1.0
In-Reply-To: <D9EDB4F689BF9F4EA6F2158A073942732E7C9FEA@de08ex3008.global.ds.honeywell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Test program not accessing RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/12/2016 04:43 PM, Heinick, J Michael wrote:
>
>
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Monday, January 11, 2016 9:54 AM
> To: Heinick, J Michael; xenomai@xenomai.org
> Subject: Re: [Xenomai] Test program not accessing RTDM driver
>
> On 01/11/2016 03:33 PM, Heinick, J Michael wrote:
>>
>> .........1.........2.........3.........4.........5.........6.........7
>> ....|
>>
>> Currently, I have a RTDM driver that installs with insmod, creates the
>> node in /dev/rtdm, uninstalls with rmmod, and removes the node from
>> /dev/rtdm.  At this early stage this RTDM driver is only a skeleton
>> that should log a message with rtdm_printk whenever the open, close,
>> read, write, and ioctl handlers are called. So far I have been unable
>> to get any indication that any of the handlers I have written for the
>> driver are interacting with the small test program even though the
>> program appears to run without errors.
>>
>> The ioctl call in the test program generates the following message in
>> the dmesg file:
>>
>> [12503.672657] [Xenomai] tcgrtdmtest[3595] called regular ioctl() on
>> /dev/rtdm/tcgrtdm
>>
>> The example at
>> http://git.xenomai.org/xenomai-jro.git/tree/demo/posix/cobalt/gpiopwm.
>> c?h=410c recently suggested by Jorge Ramirez Ortiz has been somewhat
>> helpful, but I still do not know what I am missing.  Are my
>> rtdm_device and rtdm_driver structures correct enough to get the
>> handlers called, or is the problem elsewhere?
>>
>> Thanks for any help that you can provide.
>> Mike H.
>
> The issue is with the link stage of your user-space program: the posix I/O calls used in your code such as open/ioctl and friends should be provided by libcobalt.so, but they are not. When the substitution takes place, RTDM handles the calls, otherwise the calls are routed via the glibc/uclibc to the regular kernel, which ends up reaching a dummy placeholder driver, which eventually issues the warning message in the kernel log (foo[pid] called regular <func> on /dev/rtdm/device).
>
> The substitution happens when the proper application build flags are used, based on the linker's --wrap switch. So the fix is likely to be applied to your application Makefile. Even if slightly outdated wrt Xenomai 3.x, the doc below gives some hints (you should assume libcobalt.so when reading libpthread_rt.so):
>
> http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Compilation_for_the_Xenomai_POSIX_skin
>
> --
> Philippe.
>
> ---------------------------------------------------------------------------------------------
>
> Thank you, Philippe.
>
> The makefile now looks like this:
>
> XENO_CONFIG := /usr/xenomai/bin/xeno-config
> CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
> LDLAGS := $(shell $(XENO_CONFIG) --posix --ldflags)
> CC := $(shell $(XENO_CONFIG) --cc)
>
> default:
> 	$(CC) -c -o tcgrtdmtest.o tcgrtdmtest.C $(CFLAGS) $(LDFLAGS)
> 	/usr/xenomai/bin/wrap-link.sh -v $(CC) -o tcgrtdmtest tcgrtdmtest.o -Wl,@/usr/xenomai/lib/cobalt.wrappers -L/usr/xenomai/lib -lcobalt -lpthread -lrt
>
> Then I found out that I had to set LD_LIBRARY_PATH=/usr/xenomai/lib.
> Now when the test program runs I no longer get the message in the
> dmesg file that the regular ioctl is being called.
>
> But now the open statement is generating an "Operation not permitted"
> message in its ouput, and still not logging any messages in the
> dmesg file.  It does this even when I run as superuser.
>
> So, referring to the link:
>    http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/
> I ran id to get my gid which turned out to be 1000, and then, as superuser,
> entered  echo 1000 > sys/module/xenomai/parameters/allowed_group
> There is no /dev/rtpipe.  I still get the same "Operation not permitted"
> message, even as superuser.  What else should I check and do?
>

The link-wrap line should read:

/usr/xenomai/bin/wrap-link.sh -v $(CC) -o tcgrtdmtest tcgrtdmtest.o 
$(LFDLAGS)

The comment in wrap-link.sh may be misleading.

-- 
Philippe.

