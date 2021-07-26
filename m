Subject: Re: [PATCH v2] Enable retrieving of RTNET network packet timestamp
 OOB using recvmsg()
References: <1202-60a23b00-e9-1ab27320@266121145>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b70b84f9-fd99-78ed-53d5-ae38faf86891@siemens.com>
Date: Mon, 26 Jul 2021 14:01:33 +0200
MIME-Version: 1.0
In-Reply-To: <1202-60a23b00-e9-1ab27320@266121145>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 17.05.21 11:44, François Legal via Xenomai wrote:
> This patch enables retrieving, in realtime application, of RTNET enabled adapters packet timestamps.
> It uses the linux semantic SO_TIMESTAMPNS, and the linux code to put the timestamp in the control_msg structure.
> 
> I tested this patch with af_packet sockets only. UDP  & TCP might be a little bit trickier as many fragment/segments get reassembled in a single recvmsg. I believe the linux code I used to put the timestamps in the control structure should be OK though.

One of my question on v1 is still open: How does Linux handle stamping
the context of fragmented UDP and TCP packets? And given that you enable
it for those protocols as well, we should likely test that too.

> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
>  kernel/drivers/net/stack/Kconfig              |  8 +++
>  .../drivers/net/stack/include/rtnet_socket.h  |  7 +++
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  8 +++
>  kernel/drivers/net/stack/ipv4/udp/udp.c       |  7 +++
>  kernel/drivers/net/stack/packet/af_packet.c   |  7 +++
>  kernel/drivers/net/stack/socket.c             | 59 +++++++++++++++++++
>  6 files changed, 96 insertions(+)
> 
> diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/stack/Kconfig
> index 830cec5ad..f8ee0f1ad 100644
> --- a/kernel/drivers/net/stack/Kconfig
> +++ b/kernel/drivers/net/stack/Kconfig
> @@ -12,6 +12,14 @@ config XENO_DRIVERS_NET_RX_FIFO_SIZE
>      of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
>      be usable.
>  
> +config XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +    bool "Enable packet timestamping (SO_TIMESTAMPNS)"
> +    depends on XENO_DRIVERS_NET
> +    ---help---
> +    Enable userland access to low level packet timestamps using SO_TIMESTAMPNS
> +    ioctl on socket. Timestamp are then returned in recvmsg calls in msg_control
> +    structure inside msghdr structure.
> +

Why do we need a config option? All it adds in the off-case is a single
bit test.

>  config XENO_DRIVERS_NET_ETH_P_ALL
>      depends on XENO_DRIVERS_NET
>      bool "Support for ETH_P_ALL"
> diff --git a/kernel/drivers/net/stack/include/rtnet_socket.h b/kernel/drivers/net/stack/include/rtnet_socket.h
> index d2caab649..dc488a58a 100644
> --- a/kernel/drivers/net/stack/include/rtnet_socket.h
> +++ b/kernel/drivers/net/stack/include/rtnet_socket.h
> @@ -29,6 +29,7 @@
>  
>  #include <asm/atomic.h>
>  #include <linux/list.h>
> +#include <net/sock.h>
>  
>  #include <rtdev.h>
>  #include <rtdm/net.h>
> @@ -77,6 +78,12 @@ struct rtsocket {
>  	} prot;
>  };
>  
> +#ifdef CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +#define SOCKET_FLAG_TIMESTAMP   SOCK_RCVTSTAMPNS
> +int rtnet_put_cmsg(struct rtdm_fd *fd, struct user_msghdr *msg, int level,
> +					int type, int len, void *data);
> +#endif
> +
>  static inline struct rtdm_fd *rt_socket_fd(struct rtsocket *sock)
>  {
>  	return rtdm_private_to_fd(sock);
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> index d8c189c88..c8b21c521 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> @@ -2027,6 +2027,14 @@ static ssize_t rt_tcp_read(struct rtdm_fd *fd, void *buf, size_t nbyte)
>  			kfree_rtskb(first_skb); /* or store the data? */
>  			return -EFAULT;
>  		}
> +
> +#ifdef CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +		if (test_bit(SOCKET_FLAG_TIMESTAMP, &sock->flags))
> +			rtnet_put_cmsg(fd, msg, SOL_SOCKET, SCM_TIMESTAMPNS,
> +					sizeof(nanosecs_abs_t),
> +					(void *) &skb->time_stamp);
> +#endif /* CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP */
> +
>  		rtdm_lock_get_irqsave(&ts->socket_lock, context);
>  		if (ts->sync.window) {
>  			ts->sync.window += block_size;
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index 546b35855..ac6448027 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -463,6 +463,13 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
>  	do {
>  		rtskb_trim(skb, data_len);
>  
> +#ifdef CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +		if (test_bit(SOCKET_FLAG_TIMESTAMP, &sock->flags))
> +			rtnet_put_cmsg(fd, msg, SOL_SOCKET, SCM_TIMESTAMPNS,
> +					sizeof(nanosecs_abs_t),
> +					(void *) &skb->time_stamp);
> +#endif /* CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP */
> +
>  		block_size = skb->len;
>  		copied += block_size;
>  		data_len -= block_size;
> diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
> index cc7487303..10e8113fe 100644
> --- a/kernel/drivers/net/stack/packet/af_packet.c
> +++ b/kernel/drivers/net/stack/packet/af_packet.c
> @@ -364,6 +364,13 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
>  	if (rtdm_fd_to_context(fd)->device->driver->socket_type != SOCK_DGRAM)
>  		rtskb_push(rtskb, rtskb->data - rtskb->mac.raw);
>  
> +#ifdef CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +		if (test_bit(SOCKET_FLAG_TIMESTAMP, &sock->flags))
> +			rtnet_put_cmsg(fd, msg, SOL_SOCKET, SCM_TIMESTAMPNS,
> +					sizeof(nanosecs_abs_t),
> +					(void *) &rtskb->time_stamp);
> +#endif /* CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP */
> +
>  	/* The data must not be longer than the available buffer size */
>  	copy_len = rtskb->len;
>  	len = rtdm_get_iov_flatlen(iov, msg->msg_iovlen);
> diff --git a/kernel/drivers/net/stack/socket.c b/kernel/drivers/net/stack/socket.c
> index f030663be..5a9702975 100644
> --- a/kernel/drivers/net/stack/socket.c
> +++ b/kernel/drivers/net/stack/socket.c
> @@ -273,6 +273,15 @@ int rt_socket_if_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
>  		return rtnet_put_arg(fd, &u_ifc->ifc_len, &size, sizeof(size));
>  	}
>  
> +#ifdef CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +	if (request == SO_TIMESTAMPNS) {
> +		struct rtsocket *sock = rtdm_fd_to_private(fd);
> +
> +		set_bit(SOCKET_FLAG_TIMESTAMP, &sock->flags);
> +		return 0;
> +	}
> +#endif
> +
>  	u_ifr = arg;
>  	ifr = rtnet_get_arg(fd, &_ifr, u_ifr, sizeof(_ifr));
>  	if (IS_ERR(ifr))
> @@ -393,3 +402,53 @@ int rtnet_put_arg(struct rtdm_fd *fd, void *dst, const void *src, size_t len)
>  	return rtdm_copy_to_user(fd, dst, src, len);
>  }
>  EXPORT_SYMBOL_GPL(rtnet_put_arg);
> +
> +#ifdef CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP
> +int rtnet_put_cmsg(struct rtdm_fd *fd, struct user_msghdr *msg, int level,
> +					int type, int len, void *data)
> +{
> +	struct cmsghdr __user *cm = msg->msg_control;
> +	struct cmsghdr cmhdr;
> +	int cmlen = CMSG_LEN(len);
> +	int err;
> +
> +	if (MSG_CMSG_COMPAT & msg->msg_flags)
> +		return 0; /* XXX: return error? check spec. */
> +
> +	if ((cm == NULL) || (msg->msg_controllen < sizeof(*cm))) {
> +		msg->msg_flags |= MSG_CTRUNC;
> +		return 0; /* XXX: return error? check spec. */

Please resolve the "XXX" cases. The first one indicates that this does
not work with 32-bit compat apps.

> +	}
> +	if (msg->msg_controllen < cmlen) {
> +		msg->msg_flags |= MSG_CTRUNC;
> +		cmlen = msg->msg_controllen;
> +	}
> +	cmhdr.cmsg_level = level;
> +	cmhdr.cmsg_type = type;
> +	cmhdr.cmsg_len = cmlen;
> +
> +	err = -EFAULT;
> +
> +	if (!rtdm_fd_is_user(fd)) {
> +		memcpy(cm, &cmhdr, sizeof(struct cmsghdr));
> +		memcpy(CMSG_DATA(cm), data, cmlen - sizeof(struct cmsghdr));
> +		err = 0;

This path does not update msg like below.

> +	} else {
> +		if (rtdm_copy_to_user(fd, cm, &cmhdr, sizeof(struct cmsghdr)))
> +			goto out;
> +		if (rtdm_copy_to_user(fd, CMSG_DATA(cm), data,
> +					cmlen - sizeof(struct cmsghdr)))
> +			goto out;

Could also be folded into a "if (... || ...)".

> +		cmlen = CMSG_SPACE(len);
> +		if (msg->msg_controllen < cmlen)
> +			cmlen = msg->msg_controllen;
> +		msg->msg_control += cmlen;
> +		msg->msg_controllen -= cmlen;
> +		err = 0;
> +	}
> +out:
> +	return err;
> +}
> +EXPORT_SYMBOL(rtdm_put_cmsg);
> +
> +#endif /* CONFIG_XENO_DRIVERS_NET_PACKET_TIMESTAMP */
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

