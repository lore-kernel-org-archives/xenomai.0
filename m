MIME-Version: 1.0
In-Reply-To: <4FFBEA93.5070202@xenomai.org>
References: <CAKSrRNzt7tRjShU79EFYv71SbYwhjmagP11KCAk7-LUCTqXdzA@mail.gmail.com>
	<4FFBEA93.5070202@xenomai.org>
Date: Tue, 10 Jul 2012 05:03:17 -0400
Message-ID: <CAKSrRNxNEU5f3eY93tgL1WQjtPP5500z1pbYFjLnYOf2P4T2Zg@mail.gmail.com>
From: Sunetra Sashi <snmgmt19@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] XDDP and inter-driver API.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Jul 10, 2012 at 4:40 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 07/10/2012 04:30 AM, Sunetra Sashi wrote:
>
>> Hi,
>>
>> I am trying to use the XDDP module in order to achieve linux-xenomai
>> domain
>> cross communication. However, when I install my module which creates a
>> socket and binds its to the XDDP port, via the *rtdm_socket(AF_RTIPC,
>> SOCK_DGRAM, IPCPROTO_XDDP)* call, it fails. Also, when I try to open the
>> device on the linux side, via an *rtdm_open("/dev/rtp0", O_RDWR)*, it also
>> fails.
>>
>
> Please report issues with all details, typically error codes and return
> values. "call fails" is not enough.
>

rtdm_socket call fails with error code 97. The rtdm_open fails with error
code 19.

>
> Although using rtdm_open() for /dev/rtp0 may work, this pseudo-device file
> should be opened using a plain open(2) call, since we want to open the
> regular linux-side endpoint for the communication.


I am making these calls from within the kernel, not from user space. Hence
I ended up using rtdm calls instead

>
>
>> Do I need to install any specific xenomai modules for this to work?
>>
>
> Obviously, yes. Check IPC drivers in the "Drivers" sub-menu of the Xenomai
> configuration. You need to have CONFIG_XENO_DRIVERS_RTIPC_XDDP enabled.
>

I already checked this in the configuration, It is enabled. Should this
also be set to y? CONFIG_XENO_DRIVERS_RTIPC. In my configuration it is set
to m.
Should I see any modules loaded in /proc/xenomai/rtdm/protocol_devices?

>
>
>> Thanks
>> Shweta
>> ______________________________**_________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>>
>>
>
> --
> Philippe.
>
>
>
