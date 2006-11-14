Message-ID: <455A02AD.9000403@domain.hid>
Date: Tue, 14 Nov 2006 18:53:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, TX loopback and further
	improvements
References: <4559D38C.2080001@domain.hid> <4559DA0E.7060406@domain.hid>
In-Reply-To: <4559DA0E.7060406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig970B40181B1CFABEDC77BC14"
Sender: jan.kiszka@domain.hid
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig970B40181B1CFABEDC77BC14
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

some hint in advance for future patches (not only concerning yours):

Annotated patches are easier to read. I hacked my configuration into the
wiki on how to generate those via svn diff. Please have a look at

http://www.xenomai.org/index.php/Teaching_-p_to_svn_diff
(Referenced by http://www.xenomai.org/index.php/Contributing_Patches)

Wolfgang Grandegger wrote:
> Attached is the missing patch!
>=20
> Wolfgang Grandegger wrote:
>> Hi Jan,
>>
>> attached is a patch implementing the TX loopback, apart from some
>> other fixes and improvements. The TX loopback to foreign local sockets=

>> allows to have a net-alike behavior of the CAN bus. Local sockets
>> listening to a device can receive TX messages as well. As discussed,
>> the TX lookback is performed when TX is done (TX done interrupt). As I=

>> still think that it will not be used very often, I made it a
>> configurable kernel option. When it's selected, it's _on_ by default
>> and it can be switched off or on again with setsockopt() (to make the
>> Linux Socket-CAN people happy). As long as it's not enabled, it adds
>> little overhead to the driver. If you have no objections I will check
>> it in.

I'm still not happy with the whole situation but I guess this way is the
best compromise that can be found without diverging too much from their
path. Do you have any news on how the LLCF group now implements this?

=2E..
> Index: src/utils/can/rtcansend.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/utils/can/rtcansend.c	(revision 1834)
> +++ src/utils/can/rtcansend.c	(working copy)
> @@ -26,7 +26,9 @@
>  	    " -l  --loop=3DCOUNT      send message COUNT times\n"
>  	    " -c, --count           message count in data[0-3]\n"
>  	    " -d, --delay=3DMS        delay in ms (default =3D 1ms)\n"
> +	    " -s, --send            use send instead of sendto\n"
>  	    " -t, --timeout=3DMS      timeout in ms\n"
> +	    " -T, --tx-loopback=3D0|1 switch TX loopback off or on\n"
>  	    " -v, --verbose         be verbose\n"
>  	    " -p, --print=3DMODULO    print every MODULO message\n"
>  	    " -h, --help            this help\n",
> @@ -37,9 +39,10 @@
>  RT_TASK rt_task_desc;
> =20
>  static int s=3D-1, dlc=3D0, rtr=3D0, extended=3D0, verbose=3D0, loops=3D=
1, delay=3D1000000;
> -static int count=3D0, print=3D1;
> +static int count=3D0, print=3D1, use_send=3D0, tx_loopback=3D-1;
>  static nanosecs_rel_t timeout =3D 0;
>  static struct can_frame frame;
> +static struct sockaddr_can to_addr;
> =20
> =20
>  void cleanup(void)
> @@ -77,16 +80,21 @@
>          rt_task_sleep(delay);
>  	if (count)
>  	    memcpy(&frame.data[0], &i, sizeof(i));
> -        ret =3D rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0)=
;
> +	/* Note: sendto avoids the definiton of a receive filter list */=20
> +	if (use_send)
> +	    ret =3D rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0);
> +	else
> +	    ret =3D rt_dev_sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
> +				(struct sockaddr *)&to_addr, sizeof(to_addr));

Hmm, I haven't checked the code, but isn't it possible to register a
filter list of zero elements? Wouldn't this have the same effect (/wrt
the RX path) than not binding at all? Or what do you avoid this way?

>  	if (ret < 0) {
>  	    switch (ret) {
>  	    case -ETIMEDOUT:
>  		if (verbose)
> -		    printf("rt_dev_send: timed out");
> +		    printf("rt_dev_send(to): timed out");
>  		break;
>  	    case -EBADF:
>  		if (verbose)
> -		    printf("rt_dev_send: aborted because socket was closed");
> +		    printf("rt_dev_send(to): aborted because socket was closed");
>  		break;
>  	    default:
>  		fprintf(stderr, "rt_dev_send: %s\n", strerror(-ret));
> @@ -111,7 +119,6 @@
> =20
>  int main(int argc, char **argv)
>  {
> -    struct sockaddr_can addr;
>      int i, opt, ret;
>      struct ifreq ifr;
>      char name[32];
> @@ -126,7 +133,9 @@
>  	{ "print", required_argument, 0, 'p'},
>  	{ "loop", required_argument, 0, 'l'},
>  	{ "delay", required_argument, 0, 'd'},
> +	{ "send", no_argument, 0, 's'},
>  	{ "timeout", required_argument, 0, 't'},
> +	{ "tx-loopbcak", required_argument, 0, 'T'},

Typo.

> Index: ksrc/drivers/can/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/Kconfig	(revision 1834)
> +++ ksrc/drivers/can/Kconfig	(working copy)
> @@ -1,35 +1,62 @@
>  menu "CAN drivers"
> =20
>  config XENO_DRIVERS_RTCAN
> -       depends on XENO_SKIN_RTDM
> -       tristate "RT-Socket-CAN, CAN raw socket interface"
> -       help
> -       RT-Socket-CAN is a real-time socket interface for CAN controlle=
rs.
> +	depends on XENO_SKIN_RTDM
> +	tristate "RT-Socket-CAN, CAN raw socket interface"
> +	help
> +	RT-Socket-CAN is a real-time socket interface for CAN controllers.
> =20
>  config XENO_DRIVERS_RTCAN_DEBUG
> -       depends on XENO_DRIVERS_RTCAN
> -       bool "Enable debug output"
> -       default y
> +	depends on XENO_DRIVERS_RTCAN
> +	bool "Enable debug output"
> +	default y
> +	help
> =20
> +	This option activates debugging checks and enhanced output for the
> +	RT-Socket-CAN driver. It also allows to list the hardware registers
> +	of the registered CAN controllers. It is a recommended option for
> +	getting started and analysing potential problems. For production
> +	purposes, it should be switched off (for the sake of latency).
> +
> +config XENO_DRIVERS_RTCAN_TX_LOOPBACK
> +	depends on XENO_DRIVERS_RTCAN
> +	bool "Enable TX loopback to local sockets"
> +	default n

Default is "n", so this line is redundant.

> Index: ksrc/drivers/can/rtcan_raw.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_raw.c	(revision 1834)
> +++ ksrc/drivers/can/rtcan_raw.c	(working copy)
> @@ -68,7 +68,7 @@
>  }
> =20
> =20
> -static inline void rtcan_rcv_deliver(struct rtcan_recv *recv_listener,=
=20
> +static void rtcan_rcv_deliver(struct rtcan_recv *recv_listener,=20
>  				     struct rtcan_skb *skb)
>  {
>      int size_free;
> @@ -152,7 +152,50 @@
>      }
>  }
> =20
> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
> =20
> +static void rtcan_tx_push(struct rtcan_device *dev, struct rtcan_socke=
t *sock,
> +			  can_frame_t *frame)
> +{
> +    struct rtcan_rb_frame *rb_frame =3D &dev->tx_skb.rb_frame;
> +
> +    RTCAN_ASSERT(dev->tx_socket =3D=3D 0,
> +		 rtdm_printk("(%d) TX skb still in use", dev->ifindex););
> +
> +    rb_frame->can_id =3D frame->can_id;
> +    rb_frame->can_dlc =3D frame->can_dlc;
> +    dev->tx_skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE;
> +    if (frame->can_dlc && !(frame->can_id & CAN_RTR_FLAG)) {
> +	memcpy(rb_frame->data, frame->data, frame->can_dlc);

I bet blindly copying always 8 bytes will be even more efficient than
the two lines above... :)

> +	dev->tx_skb.rb_frame_size +=3D frame->can_dlc;
> +    }
> +    rb_frame->can_ifindex =3D dev->ifindex;
> +    dev->tx_socket =3D sock;
> +}
> +
> +void rtcan_tx_loopback(struct rtcan_device *dev)
> +{
> +    /* Entry in reception list, begin with head */
> +    struct rtcan_recv *recv_listener =3D dev->recv_list;
> +    struct rtcan_rb_frame *frame =3D &dev->tx_skb.rb_frame;
> +
> +    while (recv_listener !=3D NULL) {
> +	dev->rx_count++;
> +	if ((dev->tx_socket !=3D recv_listener->sock) &&
> +	    rtcan_accept_msg(frame->can_id, &recv_listener->can_filter)) {
> +	    recv_listener->match_count++;
> +	    rtcan_rcv_deliver(recv_listener, &dev->tx_skb);
> +	}
> +	recv_listener =3D recv_listener->next;
> +    }
> +    dev->tx_socket =3D NULL;
> +}
> +
> +EXPORT_SYMBOL(rtcan_tx_loopback);

EXPORT_SYMBOL_GPL, please.


So this loopback model builds (for now?) on the assumptions that no
driver will ever queue more than one outgoing frame per device in
hardware, right?


> @@ -894,6 +937,12 @@
>      /* We got access */
> =20
> =20
> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
> +    /* Push message onto stack for loopback when TX done */
> +    if (sock->tx_loopback)
> +	rtcan_tx_push(dev, sock, frame);
> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */

Hmm, I would prefer to define something like

if (rtcan_tx_loopback_enabled(sock))
    rtcan_tx_push(dev, sock, frame);

with rtcan_tx_loopback_enabled resolving to 0 in the configured-out
case. Thus some #ifdefs could be moved from the code to central places
in header files.

> Index: ksrc/drivers/can/mscan/rtcan_mscan.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1834)
> +++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
> @@ -251,6 +251,21 @@
>  	regs->cantier =3D 0;
>  	/* Wake up a sender */
>  	rtdm_sem_up(&dev->tx_sem);
> +
> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
> +	if (dev->tx_socket) {

Same here. A macro like rtcan_tx_loopback_pending(dev) would avoid the
#ifdef.

> Index: ksrc/drivers/can/rtcan_raw.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_raw.h	(revision 1834)
> +++ ksrc/drivers/can/rtcan_raw.h	(working copy)
> @@ -32,6 +32,10 @@
> =20
>  void rtcan_rcv(struct rtcan_device *rtcandev, struct rtcan_skb *skb);
> =20
> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
> +void rtcan_tx_loopback(struct rtcan_device *rtcandev);

Prototypes don't need the #ifdef (same applies to the CONFIG_PROC_FS
below, BTW).

> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
> +
>  #ifdef CONFIG_PROC_FS
>  int __init rtcan_raw_proto_register(void);
>  void __exit rtcan_raw_proto_unregister(void);

=2E..

> Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 1834)
> +++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
> @@ -312,11 +312,27 @@
>  	}
> =20
>          /* Transmit Interrupt? */
> -        if (irq_source & SJA_IR_TI)
> +        if (irq_source & SJA_IR_TI) {
>              /* Wake up a sender */
>              rtdm_sem_up(&dev->tx_sem);
> =20
> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
> +	    if (dev->tx_socket) {
> +		/* Copy timestamp to skb */
> +		memcpy((void *)&dev->tx_skb.rb_frame + dev->tx_skb.rb_frame_size,
> +		       &timestamp, TIMESTAMP_SIZE);
> =20
> +	    if (recv_lock_free) {
> +		recv_lock_free =3D 0;
> +		rtdm_lock_get(&rtcan_recv_list_lock);
> +		rtdm_lock_get(&rtcan_socket_lock);
> +	    }
> +
> +	    rtcan_tx_loopback(dev);

[I just noticed the redundancy with the MSCAN code]

I think the timestamp should rather be passed to rtcan_tc_loopback and
set there. Or, if passing that value increases the code size needlessly,
rtcan_tx_loopback should be defined like

static inline void
rtcan_tx_loopback(struct rtcan_device *dev, nanosecs_abs_t timestamp)
{
    <set timestamp>
    __rtcan_tx_loopback(dev);
}

where __rtcan_tx_loopback is the uninlined code. That makes the driver
code leaner. Locking will hopefully change anyway, so nothing to do on
this part for now.

> +	    }
> +#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
> +	}
> +
>          /* Receive Interrupt? */
>          if (irq_source & SJA_IR_RI) {
> =20


Last remark: For the sake of completeness, tx-loopback should also be
implemented in the virtual CAN driver.

Jan


--------------enig970B40181B1CFABEDC77BC14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFWgKtniDOoMHTA+kRAudhAJ9U/NUzkYYdUrIXjIjk6Wv8LFe+NQCfZm+c
cwY5tss7RMkmC5dipGintwE=
=EEtU
-----END PGP SIGNATURE-----

--------------enig970B40181B1CFABEDC77BC14--

