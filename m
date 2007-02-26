Message-ID: <45E2FEB1.1070008@domain.hid>
Date: Mon, 26 Feb 2007 09:37:21 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-core=5D_?=
	=?ISO-8859-1?Q?rtdm=2C_rtc_and_printk_driver=2E?=
References: <s5e1d71e.043@domain.hid> <45E1D317.5040305@domain.hid>
In-Reply-To: <45E1D317.5040305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:

> The long-term question for me is if there is a need to synchronise the
> system clock (or some skin timebase in future Xenomai versions) on an
> external sources like the RTC here. Not that I'm desperately locking for
> work, it's just good to know user requirements whenever further design
> decisions [on the time subsystem] have to be made.

Our real-time simulation requires synchronization with an external time base.  The external timing source generates a one-pulse-per-second signal that is connected to an interrupt line on the real-time PC.  We use this  one-PPS interrupt to calibrate the task execution period and remove any accumulated clock skew to keep our simulation outputs in-sync with other parts of the simulation.

I am satisfied with the current implementation, but thought I would respond, since you were asking for input.  I hadn't thought about the possibility of some sort of built-in timebase synchronization functionality, but I imagine this sort of thing is fairly common, and it may prove useful to include it in Xenomai.

-Jeff


