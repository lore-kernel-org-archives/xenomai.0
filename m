Message-ID: <4FFBEA93.5070202@xenomai.org>
Date: Tue, 10 Jul 2012 10:40:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKSrRNzt7tRjShU79EFYv71SbYwhjmagP11KCAk7-LUCTqXdzA@mail.gmail.com>
In-Reply-To: <CAKSrRNzt7tRjShU79EFYv71SbYwhjmagP11KCAk7-LUCTqXdzA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XDDP and inter-driver API.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sunetra Sashi <snmgmt19@gmail.com>
Cc: xenomai@xenomai.org

On 07/10/2012 04:30 AM, Sunetra Sashi wrote:
> Hi,
>
> I am trying to use the XDDP module in order to achieve linux-xenomai domain
> cross communication. However, when I install my module which creates a
> socket and binds its to the XDDP port, via the *rtdm_socket(AF_RTIPC,
> SOCK_DGRAM, IPCPROTO_XDDP)* call, it fails. Also, when I try to open the
> device on the linux side, via an *rtdm_open("/dev/rtp0", O_RDWR)*, it also
> fails.

Please report issues with all details, typically error codes and return 
values. "call fails" is not enough.

Although using rtdm_open() for /dev/rtp0 may work, this pseudo-device 
file should be opened using a plain open(2) call, since we want to open 
the regular linux-side endpoint for the communication.

>
> Do I need to install any specific xenomai modules for this to work?

Obviously, yes. Check IPC drivers in the "Drivers" sub-menu of the 
Xenomai configuration. You need to have CONFIG_XENO_DRIVERS_RTIPC_XDDP 
enabled.

>
> Thanks
> Shweta
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.



