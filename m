Message-ID: <455A14C3.60701@domain.hid>
Date: Tue, 14 Nov 2006 20:10:59 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, TX loopback and further
	improvements
References: <4559D38C.2080001@domain.hid>
	<4559DA0E.7060406@domain.hid> <455A02AD.9000403@domain.hid>
In-Reply-To: <455A02AD.9000403@domain.hid>
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
> Hi Wolfgang,
> 
> some hint in advance for future patches (not only concerning yours):
> 
> Annotated patches are easier to read. I hacked my configuration into the
> wiki on how to generate those via svn diff. Please have a look at
> 
> http://www.xenomai.org/index.php/Teaching_-p_to_svn_diff
> (Referenced by http://www.xenomai.org/index.php/Contributing_Patches)

Done.

> Wolfgang Grandegger wrote:
>> Attached is the missing patch!
>>
>> Wolfgang Grandegger wrote:
>>> Hi Jan,
>>>
>>> attached is a patch implementing the TX loopback, apart from some
>>> other fixes and improvements. The TX loopback to foreign local sockets
>>> allows to have a net-alike behavior of the CAN bus. Local sockets
>>> listening to a device can receive TX messages as well. As discussed,
>>> the TX lookback is performed when TX is done (TX done interrupt). As I
>>> still think that it will not be used very often, I made it a
>>> configurable kernel option. When it's selected, it's _on_ by default
>>> and it can be switched off or on again with setsockopt() (to make the
>>> Linux Socket-CAN people happy). As long as it's not enabled, it adds
>>> little overhead to the driver. If you have no objections I will check
>>> it in.
> 
> I'm still not happy with the whole situation but I guess this way is the
> best compromise that can be found without diverging too much from their
> path. Do you have any news on how the LLCF group now implements this?

No. For the time being I want to offer this option to the users mainly 
to get feedback and gain experience. The API is defined and the user 
should therefore not suffer from future internal re-implementations.

> ...
>> Index: src/utils/can/rtcansend.c
>> ===================================================================
>> --- src/utils/can/rtcansend.c	(revision 1834)
>> +++ src/utils/can/rtcansend.c	(working copy)
>> @@ -26,7 +26,9 @@
>>  	    " -l  --loop=COUNT      send message COUNT times\n"
>>  	    " -c, --count           message count in data[0-3]\n"
>>  	    " -d, --delay=MS        delay in ms (default = 1ms)\n"
>> +	    " -s, --send            use send instead of sendto\n"
>>  	    " -t, --timeout=MS      timeout in ms\n"
>> +	    " -T, --tx-loopback=0|1 switch TX loopback off or on\n"
>>  	    " -v, --verbose         be verbose\n"
>>  	    " -p, --print=MODULO    print every MODULO message\n"
>>  	    " -h, --help            this help\n",
>> @@ -37,9 +39,10 @@
>>  RT_TASK rt_task_desc;
>>  
>>  static int s=-1, dlc=0, rtr=0, extended=0, verbose=0, loops=1, delay=1000000;
>> -static int count=0, print=1;
>> +static int count=0, print=1, use_send=0, tx_loopback=-1;
>>  static nanosecs_rel_t timeout = 0;
>>  static struct can_frame frame;
>> +static struct sockaddr_can to_addr;
>>  
>>  
>>  void cleanup(void)
>> @@ -77,16 +80,21 @@
>>          rt_task_sleep(delay);
>>  	if (count)
>>  	    memcpy(&frame.data[0], &i, sizeof(i));
>> -        ret = rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0);
>> +	/* Note: sendto avoids the definiton of a receive filter list */ 
>> +	if (use_send)
>> +	    ret = rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0);
>> +	else
>> +	    ret = rt_dev_sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
>> +				(struct sockaddr *)&to_addr, sizeof(to_addr));
> 
> Hmm, I haven't checked the code, but isn't it possible to register a
> filter list of zero elements? Wouldn't this have the same effect (/wrt
> the RX path) than not binding at all? Or what do you avoid this way?

If you call bind, one filter entry accepting all messages is added to 
the filter list of the device. This has been discussed on the 
Socket-CAN-ML in the thread 
https://lists.berlios.de/pipermail/socketcan-core/2006-July/000272.html
and the result was, that rt_dev_sendto could be used to avoid the bind. 
I don't know if a zero elements list is legal. I will ask.

>>  	if (ret < 0) {
>>  	    switch (ret) {
>>  	    case -ETIMEDOUT:
>>  		if (verbose)
>> -		    printf("rt_dev_send: timed out");
>> +		    printf("rt_dev_send(to): timed out");
>>  		break;
>>  	    case -EBADF:
>>  		if (verbose)
>> -		    printf("rt_dev_send: aborted because socket was closed");
>> +		    printf("rt_dev_send(to): aborted because socket was closed");
>>  		break;
>>  	    default:
>>  		fprintf(stderr, "rt_dev_send: %s\n", strerror(-ret));
>> @@ -111,7 +119,6 @@
>>  
>>  int main(int argc, char **argv)
>>  {
>> -    struct sockaddr_can addr;
>>      int i, opt, ret;
>>      struct ifreq ifr;
>>      char name[32];
>> @@ -126,7 +133,9 @@
>>  	{ "print", required_argument, 0, 'p'},
>>  	{ "loop", required_argument, 0, 'l'},
>>  	{ "delay", required_argument, 0, 'd'},
>> +	{ "send", no_argument, 0, 's'},
>>  	{ "timeout", required_argument, 0, 't'},
>> +	{ "tx-loopbcak", required_argument, 0, 'T'},
> 
> Typo.
> 
>> Index: ksrc/drivers/can/Kconfig
>> ===================================================================
>> --- ksrc/drivers/can/Kconfig	(revision 1834)
>> +++ ksrc/drivers/can/Kconfig	(working copy)
>> @@ -1,35 +1,62 @@
>>  menu "CAN drivers"
>>  
>>  config XENO_DRIVERS_RTCAN
>> -       depends on XENO_SKIN_RTDM
>> -       tristate "RT-Socket-CAN, CAN raw socket interface"
>> -       help
>> -       RT-Socket-CAN is a real-time socket interface for CAN controllers.
>> +	depends on XENO_SKIN_RTDM
>> +	tristate "RT-Socket-CAN, CAN raw socket interface"
>> +	help
>> +	RT-Socket-CAN is a real-time socket interface for CAN controllers.
>>  
>>  config XENO_DRIVERS_RTCAN_DEBUG
>> -       depends on XENO_DRIVERS_RTCAN
>> -       bool "Enable debug output"
>> -       default y
>> +	depends on XENO_DRIVERS_RTCAN
>> +	bool "Enable debug output"
>> +	default y
>> +	help
>>  
>> +	This option activates debugging checks and enhanced output for the
>> +	RT-Socket-CAN driver. It also allows to list the hardware registers
>> +	of the registered CAN controllers. It is a recommended option for
>> +	getting started and analysing potential problems. For production
>> +	purposes, it should be switched off (for the sake of latency).
>> +
>> +config XENO_DRIVERS_RTCAN_TX_LOOPBACK
>> +	depends on XENO_DRIVERS_RTCAN
>> +	bool "Enable TX loopback to local sockets"
>> +	default n
> 
> Default is "n", so this line is redundant.
> 
>> Index: ksrc/drivers/can/rtcan_raw.c
>> ===================================================================
>> --- ksrc/drivers/can/rtcan_raw.c	(revision 1834)
>> +++ ksrc/drivers/can/rtcan_raw.c	(working copy)
>> @@ -68,7 +68,7 @@
>>  }
>>  
>>  
>> -static inline void rtcan_rcv_deliver(struct rtcan_recv *recv_listener, 
>> +static void rtcan_rcv_deliver(struct rtcan_recv *recv_listener, 
>>  				     struct rtcan_skb *skb)
>>  {
>>      int size_free;
>> @@ -152,7 +152,50 @@
>>      }
>>  }
>>  
>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>>  
>> +static void rtcan_tx_push(struct rtcan_device *dev, struct rtcan_socket *sock,
>> +			  can_frame_t *frame)
>> +{
>> +    struct rtcan_rb_frame *rb_frame = &dev->tx_skb.rb_frame;
>> +
>> +    RTCAN_ASSERT(dev->tx_socket == 0,
>> +		 rtdm_printk("(%d) TX skb still in use", dev->ifindex););
>> +
>> +    rb_frame->can_id = frame->can_id;
>> +    rb_frame->can_dlc = frame->can_dlc;
>> +    dev->tx_skb.rb_frame_size = EMPTY_RB_FRAME_SIZE;
>> +    if (frame->can_dlc && !(frame->can_id & CAN_RTR_FLAG)) {
>> +	memcpy(rb_frame->data, frame->data, frame->can_dlc);
> 
> I bet blindly copying always 8 bytes will be even more efficient than
> the two lines above... :)

Be aware that rb_frame->data is not aligned on 4 bytes. But likely you 
are right.

>> +	dev->tx_skb.rb_frame_size += frame->can_dlc;
>> +    }
>> +    rb_frame->can_ifindex = dev->ifindex;
>> +    dev->tx_socket = sock;
>> +}
>> +
>> +void rtcan_tx_loopback(struct rtcan_device *dev)
>> +{
>> +    /* Entry in reception list, begin with head */
>> +    struct rtcan_recv *recv_listener = dev->recv_list;
>> +    struct rtcan_rb_frame *frame = &dev->tx_skb.rb_frame;
>> +
>> +    while (recv_listener != NULL) {
>> +	dev->rx_count++;
>> +	if ((dev->tx_socket != recv_listener->sock) &&
>> +	    rtcan_accept_msg(frame->can_id, &recv_listener->can_filter)) {
>> +	    recv_listener->match_count++;
>> +	    rtcan_rcv_deliver(recv_listener, &dev->tx_skb);
>> +	}
>> +	recv_listener = recv_listener->next;
>> +    }
>> +    dev->tx_socket = NULL;
>> +}
>> +
>> +EXPORT_SYMBOL(rtcan_tx_loopback);
> 
> EXPORT_SYMBOL_GPL, please.

OK, forgot that.

> 
> So this loopback model builds (for now?) on the assumptions that no
> driver will ever queue more than one outgoing frame per device in
> hardware, right?

Yes! But do we really want to queue more than one message in hardware? 
It will break real-time to some extend. Furthermore I have done some 
test with MSCAN-MPC5200 filling up 3 buffers and I did not realized any 
significant improvement of the throughput, also at 1 MB/sec. Support of 
more than one buffer requires some device dependent re-implementation, 
not only for the TX loopback. But that's feasible as well.

> 
>> @@ -894,6 +937,12 @@
>>      /* We got access */
>>  
>>  
>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>> +    /* Push message onto stack for loopback when TX done */
>> +    if (sock->tx_loopback)
>> +	rtcan_tx_push(dev, sock, frame);
>> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
> 
> Hmm, I would prefer to define something like
> 
> if (rtcan_tx_loopback_enabled(sock))
>     rtcan_tx_push(dev, sock, frame);
> 
> with rtcan_tx_loopback_enabled resolving to 0 in the configured-out
> case. Thus some #ifdefs could be moved from the code to central places
> in header files.

OK, here I can avoid the #ifdef's ...

>> Index: ksrc/drivers/can/mscan/rtcan_mscan.c
>> ===================================================================
>> --- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1834)
>> +++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
>> @@ -251,6 +251,21 @@
>>  	regs->cantier = 0;
>>  	/* Wake up a sender */
>>  	rtdm_sem_up(&dev->tx_sem);
>> +
>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>> +	if (dev->tx_socket) {
> 
> Same here. A macro like rtcan_tx_loopback_pending(dev) would avoid the
> #ifdef.

...but not here. Or does the optimizer remove the if block?

>> Index: ksrc/drivers/can/rtcan_raw.h
>> ===================================================================
>> --- ksrc/drivers/can/rtcan_raw.h	(revision 1834)
>> +++ ksrc/drivers/can/rtcan_raw.h	(working copy)
>> @@ -32,6 +32,10 @@
>>  
>>  void rtcan_rcv(struct rtcan_device *rtcandev, struct rtcan_skb *skb);
>>  
>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>> +void rtcan_tx_loopback(struct rtcan_device *rtcandev);
> 
> Prototypes don't need the #ifdef (same applies to the CONFIG_PROC_FS
> below, BTW).

OK.

>> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
>> +
>>  #ifdef CONFIG_PROC_FS
>>  int __init rtcan_raw_proto_register(void);
>>  void __exit rtcan_raw_proto_unregister(void);
> 
> ...
> 
>> Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
>> ===================================================================
>> --- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 1834)
>> +++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
>> @@ -312,11 +312,27 @@
>>  	}
>>  
>>          /* Transmit Interrupt? */
>> -        if (irq_source & SJA_IR_TI)
>> +        if (irq_source & SJA_IR_TI) {
>>              /* Wake up a sender */
>>              rtdm_sem_up(&dev->tx_sem);
>>  
>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
>> +	    if (dev->tx_socket) {
>> +		/* Copy timestamp to skb */
>> +		memcpy((void *)&dev->tx_skb.rb_frame + dev->tx_skb.rb_frame_size,
>> +		       &timestamp, TIMESTAMP_SIZE);
>>  
>> +	    if (recv_lock_free) {
>> +		recv_lock_free = 0;
>> +		rtdm_lock_get(&rtcan_recv_list_lock);
>> +		rtdm_lock_get(&rtcan_socket_lock);
>> +	    }
>> +
>> +	    rtcan_tx_loopback(dev);
> 
> [I just noticed the redundancy with the MSCAN code]
> 
> I think the timestamp should rather be passed to rtcan_tc_loopback and
> set there. Or, if passing that value increases the code size needlessly,
> rtcan_tx_loopback should be defined like
> 
> static inline void
> rtcan_tx_loopback(struct rtcan_device *dev, nanosecs_abs_t timestamp)
> {
>     <set timestamp>
>     __rtcan_tx_loopback(dev);
> }
> 
> where __rtcan_tx_loopback is the uninlined code. That makes the driver
> code leaner. Locking will hopefully change anyway, so nothing to do on
> this part for now.

Or do it directly in rtcan_tx_loopback() and rtcan_recv(). Would it be 
OK to read the time in these functions as well or should it be done, as 
is, at the beginning of the ISR? I have already planned some similar 
rewrite when Xenomai 2.3. is out, hopefully together with the new locking.

>> +	    }
>> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
>> +	}
>> +
>>          /* Receive Interrupt? */
>>          if (irq_source & SJA_IR_RI) {
>>  
> 
> 
> Last remark: For the sake of completeness, tx-loopback should also be
> implemented in the virtual CAN driver.

Ah, I missed that.

Thanks for feedback.

Wolfgang.


