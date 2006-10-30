Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN fixes
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4545EA5C.7020105@domain.hid>
References: <4545EA5C.7020105@domain.hid>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 15:20:45 +0100
Message-Id: <1162218046.5188.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2006-10-30 at 13:04 +0100, Wolfgang Grandegger wrote:
> Hallo,
> 
> attached you will find a patch for Xenomai RT-Socket-CAN fixing:
> 
> 2006-10-30  Wolfgang Grandegger  <wg@domain.hid>
> 
>          * src/utils/can/rtcanrecv: Add timestamp support via
>            rt_dev_recvmsg().
> 
>          * ksrc/drivers/can/mscan/rtcan_mscan.c (rtcan_mscan_interrupt),
>          ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Restrict MSCAN TX
>          hardware buffer usage to one for the sake of real-time. Fix bug
>          with TX IRQ handling. Copy timestamp also for error messages.
> 
>          * ksrc/drivers/can/sja1000/rtcan_sja1000.c(rtcan_sja_interrupt):
>          Copy timestamp also for error messages.
> 

Merged, thanks.

> Wolfgang.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



