Message-ID: <435FE442.2090800@domain.hid>
Date: Wed, 26 Oct 2005 22:17:06 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid>
	<435F2DDA.1030702@domain.hid>	<435FB6CB.9030307@domain.hid>
	<435FBDB1.2010109@domain.hid>	<435FC965.8040400@domain.hid>
	<435FCAA7.8090003@domain.hid> <435FE178.1040100@domain.hid>
In-Reply-To: <435FE178.1040100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hannes Mayer wrote:
[...]
> Just one further thing:
> I've modified rt_serial_uprog.c and I just open rtser0 for reading and 
> writing.
> That works, I can write to it and read data back from it, but:
> 
> In read_task_proc:
>     ret = rt_dev_ioctl(my_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
> rt_dev_ioctl always returns -1 - it doesn't block.
[...]
> How can I get rt_dev_ioctl to block ?

AHA! Found it! :-)

There is
             if (!rtdm_in_rt_context())
                 return -EPERM;
in rt_16550_ioctl(...)

Silly me put a printf into it:
	ret = rt_task_set_mode(0, T_PRIMARY, NULL);
	[...]
	printf(RTASK_PREFIX "waiting for event\n");
	ret = rt_dev_ioctl(write_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
so the whole thing was not in RT anymore.

Thanks again and best regards,
Hannes.

