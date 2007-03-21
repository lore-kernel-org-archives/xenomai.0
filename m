Message-ID: <460167F8.50703@domain.hid>
Date: Wed, 21 Mar 2007 18:14:32 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46002EE0.9040406@domain.hid>
In-Reply-To: <46002EE0.9040406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
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
Cc: socketcan-core@domain.hid, xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> on the Xenomai mailing list the topic "bus error flooding" popped up 
> again. Various users reported trouble due to high bus error rates and 
> bad impact on latencies. Some discussion is going on on how to avoid 
> such flooding. I have already implemented "on-demand" bus error 
> interrupts. Bus error interrupts are then only enabled when at least one 
> socket is listening on bus errors. But flooding can still occur and we 
> are thinking about a better way of downscaling or temporarily disabling 
> them. Socket-CAN currently restarts the controller after 200 bus errors.
> My preferred solution for RT-Socket-CAN currently is to stop the CAN 
> controller after a kernel configurable amount of successive bus errors. 
> More clever ideas and comments are welcome?

What do you think about the following method?

   config XENO_DRIVERS_CAN_SJA1000_BUS_ERR_LIMIT
	depends on XENO_DRIVERS_CAN_SJA1000
	int "Maximum number of successive bus errors"
	range 0 255
	default 20
	help

	CAN bus errors are very useful for analyzing electrical problems
         but they can come at a very high rate resulting in interrupt
         flooding with bad impact on system performance and real-time
         behavior. This option, if greater than 0, will limit the amount
         of successive bus error interrupts. If the limit is reached, an
         error message with "can_id = CAN_ERR_BUSERR_FLOOD" is sent. The
         bus error counter gets reset on restart of the device and on any
         successful message transmission or reception. Be aware that bus
         error interrupts are only enabled if at least one socket is
         listening on bus errors.

I think it should make Sebastian and Jan happy, at least ;-).

> 
> To have some input, I have measured the bus error rate with the PEAK 
> PCAN PCI card on my Icecube MPC5200 eval-board doing rtcansend without 
> cable connected. Here are the results for the various baud-rates:
> 
>     125 KB/s  1926 BEI/s
>     250 KB/s  3925 BEI/s
>     500 KB/s  7856 BEI/s
>    1000 KB/s 15700 BEI/s
> 
> The latency measured with "latency" from the testsuite reported an 
> increase of the latency with load from 67 to 95us almost independently 
> of the baud-rate. Sending messages with 8 byte payload from MSCAN to 
> SJA1000 on the same node as fast as possible increased the latency up to 
> 103us. This measurement did not include delivery of messages to sockets 
> (actually no socket was listening).
> 
> Wolfgang.

Wolfgang.

