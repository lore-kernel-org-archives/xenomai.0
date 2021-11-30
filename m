Subject: Re: [PATCH v2 1/6] drivers/can: add multi message support to sendmsg
References: <20211129220750.10362-1-dariobin@libero.it>
 <20211129230612.v2.1.Ib16491ef1950ca5ad44805af98a594a9e0622729@changeid>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <254dca53-ff41-9542-868a-c800fc27efe6@siemens.com>
Date: Tue, 30 Nov 2021 09:33:01 +0100
MIME-Version: 1.0
In-Reply-To: <20211129230612.v2.1.Ib16491ef1950ca5ad44805af98a594a9e0622729@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, Michael Trimarchi <michael@amarulasolutions.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>

On 29.11.21 23:07, Dario Binacchi wrote:
> The `user_msghdr' structure is designed to send multiple messages as
> well, so rtcan_raw_sendmsg() can also send multiple messages. This
> avoids having to add the sendmmsg system call which requires more
> extensive Xenomai changes.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---
> 
> (no changes since v1)
> 

I asked for testing the changes also smokey (via rtcan_virt). How about
that?

Jan

>  kernel/drivers/can/rtcan_raw.c | 239 ++++++++++++++++++---------------
>  1 file changed, 128 insertions(+), 111 deletions(-)
> 
> diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
> index 693b927fe..b17c1709d 100644
> --- a/kernel/drivers/can/rtcan_raw.c
> +++ b/kernel/drivers/can/rtcan_raw.c
> @@ -762,113 +762,13 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
>  }
>  
>  
> -ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
> -			  const struct user_msghdr *msg, int flags)
> +static ssize_t __rtcan_raw_sendmsg(struct rtcan_device *dev, struct rtcan_socket *sock,
> +				   can_frame_t *frame, nanosecs_rel_t timeout)
>  {
> -    struct rtcan_socket *sock = rtdm_fd_to_private(fd);
> -    struct sockaddr_can *scan = (struct sockaddr_can *)msg->msg_name;
> -    struct sockaddr_can scan_buf;
> -    struct iovec *iov = (struct iovec *)msg->msg_iov;
> -    struct iovec iov_buf;
> -    can_frame_t *frame;
> -    can_frame_t frame_buf;
> -    rtdm_lockctx_t lock_ctx;
> -    nanosecs_rel_t timeout = 0;
>      struct tx_wait_queue tx_wait;
> -    struct rtcan_device *dev;
> -    int ifindex = 0;
> -    int ret  = 0;
> +    rtdm_lockctx_t lock_ctx;
>      spl_t s;
> -
> -
> -    if (flags & MSG_OOB)   /* Mirror BSD error message compatibility */
> -	return -EOPNOTSUPP;
> -
> -    /* Only MSG_DONTWAIT is a valid flag. */
> -    if (flags & ~MSG_DONTWAIT)
> -	return -EINVAL;
> -
> -    /* Check msg_iovlen, only one buffer allowed */
> -    if (msg->msg_iovlen != 1)
> -	return -EMSGSIZE;
> -
> -    if (scan == NULL) {
> -	/* No socket address. Will use bound interface for sending */
> -
> -	if (msg->msg_namelen != 0)
> -	    return -EINVAL;
> -
> -
> -	/* We only want a consistent value here, a spin lock would be
> -	 * overkill. Nevertheless, the binding could change till we have
> -	 * the chance to send. Blame the user, though. */
> -	ifindex = atomic_read(&sock->ifindex);
> -
> -	if (!ifindex)
> -	    /* Socket isn't bound or bound to all interfaces. Go out. */
> -	    return -ENXIO;
> -    } else {
> -	/* Socket address given */
> -	if (msg->msg_namelen < sizeof(struct sockaddr_can))
> -	    return -EINVAL;
> -
> -	if (rtdm_fd_is_user(fd)) {
> -	    /* Copy socket address from userspace */
> -	    if (!rtdm_read_user_ok(fd, msg->msg_name,
> -				   sizeof(struct sockaddr_can)) ||
> -		rtdm_copy_from_user(fd, &scan_buf, msg->msg_name,
> -				    sizeof(struct sockaddr_can)))
> -		return -EFAULT;
> -
> -	    scan = &scan_buf;
> -	}
> -
> -	/* Check address family */
> -	if (scan->can_family != AF_CAN)
> -	    return -EINVAL;
> -
> -	ifindex = scan->can_ifindex;
> -    }
> -
> -    if (rtdm_fd_is_user(fd)) {
> -	/* Copy IO vector from userspace */
> -	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
> -			     sizeof(struct iovec)) ||
> -	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
> -				sizeof(struct iovec)))
> -	    return -EFAULT;
> -
> -	iov = &iov_buf;
> -    }
> -
> -    /* Check size of buffer */
> -    if (iov->iov_len != sizeof(can_frame_t))
> -	return -EMSGSIZE;
> -
> -    frame = (can_frame_t *)iov->iov_base;
> -
> -    if (rtdm_fd_is_user(fd)) {
> -	/* Copy CAN frame from userspace */
> -	if (!rtdm_read_user_ok(fd, iov->iov_base,
> -			       sizeof(can_frame_t)) ||
> -	    rtdm_copy_from_user(fd, &frame_buf, iov->iov_base,
> -				sizeof(can_frame_t)))
> -	    return -EFAULT;
> -
> -	frame = &frame_buf;
> -    }
> -
> -    /* Adjust iovec in the common way */
> -    iov->iov_base += sizeof(can_frame_t);
> -    iov->iov_len -= sizeof(can_frame_t);
> -    /* ... and copy it back to userspace if necessary */
> -    if (rtdm_fd_is_user(fd)) {
> -	if (rtdm_copy_to_user(fd, msg->msg_iov, iov,
> -			      sizeof(struct iovec)))
> -	    return -EFAULT;
> -    }
> -
> -    /* At last, we've got the frame ... */
> +    int ret = 0;
>  
>      /* Check if DLC between 0 and 15 */
>      if (frame->can_dlc > 15)
> @@ -881,11 +781,6 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>  	    return -EINVAL;
>      }
>  
> -    if ((dev = rtcan_dev_get_by_index(ifindex)) == NULL)
> -	return -ENXIO;
> -
> -    timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->tx_timeout;
> -
>      tx_wait.rt_task = rtdm_task_current();
>  
>      /* Register the task at the socket's TX wait queue and decrement
> @@ -931,7 +826,6 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>  
>      /* We got access */
>  
> -
>      /* Push message onto stack for loopback when TX done */
>      if (rtcan_loopback_enabled(sock))
>  	rtcan_tx_push(dev, sock, frame);
> @@ -960,10 +854,133 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>   send_out2:
>      rtdm_lock_put_irqrestore(&dev->device_lock, lock_ctx);
>   send_out1:
> -    rtcan_dev_dereference(dev);
>      return ret;
>  }
>  
> +ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
> +			  const struct user_msghdr *msg, int flags)
> +{
> +    struct rtcan_socket *sock = rtdm_fd_to_private(fd);
> +    struct sockaddr_can *scan = (struct sockaddr_can *)msg->msg_name;
> +    struct sockaddr_can scan_buf;
> +    struct iovec *iov = (struct iovec *)msg->msg_iov;
> +    struct iovec iov_buf;
> +    can_frame_t *frame;
> +    can_frame_t frame_buf;
> +    nanosecs_rel_t timeout;
> +    struct rtcan_device *dev;
> +    int ret = 0, ifindex = 0, i = 0, n, sent = 0;
> +
> +    if (flags & MSG_OOB)   /* Mirror BSD error message compatibility */
> +	return -EOPNOTSUPP;
> +
> +    /* Only MSG_DONTWAIT is a valid flag. */
> +    if (flags & ~MSG_DONTWAIT)
> +	return -EINVAL;
> +
> +    timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->tx_timeout;
> +
> +    if (scan == NULL) {
> +	/* No socket address. Will use bound interface for sending */
> +	if (msg->msg_namelen != 0)
> +	    return -EINVAL;
> +
> +
> +	/* We only want a consistent value here, a spin lock would be
> +	 * overkill. Nevertheless, the binding could change till we have
> +	 * the chance to send. Blame the user, though. */
> +	ifindex = atomic_read(&sock->ifindex);
> +	if (!ifindex)
> +	    /* Socket isn't bound or bound to all interfaces. Go out. */
> +	    return -ENXIO;
> +    } else {
> +	/* Socket address given */
> +	if (msg->msg_namelen < sizeof(struct sockaddr_can))
> +	    return -EINVAL;
> +
> +	if (rtdm_fd_is_user(fd)) {
> +	    /* Copy socket address from userspace */
> +	    if (!rtdm_read_user_ok(fd, msg->msg_name,
> +				   sizeof(struct sockaddr_can)) ||
> +		rtdm_copy_from_user(fd, &scan_buf, msg->msg_name,
> +				    sizeof(struct sockaddr_can)))
> +		return -EFAULT;
> +
> +	    scan = &scan_buf;
> +	}
> +
> +	/* Check address family */
> +	if (scan->can_family != AF_CAN)
> +	    return -EINVAL;
> +
> +	ifindex = scan->can_ifindex;
> +    }
> +
> +    dev = rtcan_dev_get_by_index(ifindex);
> +    if (!dev)
> +	return -ENXIO;
> +
> +    if (rtdm_fd_is_user(fd)) {
> +
> +	/* Copy IO vector from userspace */
> +	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
> +			     sizeof(struct iovec)) ||
> +	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
> +				sizeof(struct iovec))) {
> +	    ret = -EFAULT;
> +	    goto finally;
> +	}
> +
> +	iov = &iov_buf;
> +    }
> +
> +    n = msg->msg_iovlen;
> +    while (i < n) {
> +	if (iov->iov_len < sizeof(can_frame_t)) {
> +	    ret = -EMSGSIZE;
> +	    goto finally;
> +	}
> +
> +	frame = (can_frame_t *)iov->iov_base;
> +
> +	if (rtdm_fd_is_user(fd)) {
> +	    /* Copy CAN frame from userspace */
> +	    if (!rtdm_read_user_ok(fd, iov->iov_base, sizeof(can_frame_t)) ||
> +		rtdm_copy_from_user(fd, &frame_buf, iov->iov_base,
> +				    sizeof(can_frame_t))) {
> +	        ret = -EFAULT;
> +	        goto finally;
> +	    }
> +
> +	    frame = &frame_buf;
> +	}
> +
> +	iov->iov_base += sizeof(can_frame_t);
> +	iov->iov_len -= sizeof(can_frame_t);
> +
> +	ret = __rtcan_raw_sendmsg(dev, sock, frame, timeout);
> +	if (ret < 0)
> +	    goto finally;
> +
> +	sent += ret;
> +    }
> +
> +    /* copy it back to userspace if necessary */
> +    if (rtdm_fd_is_user(fd)) {
> +	if (rtdm_copy_to_user(fd, msg->msg_iov, iov, sizeof(struct iovec))) {
> +	    ret = -EFAULT;
> +	    goto finally;
> +	}
> +    }
> +
> +finally:
> +    rtcan_dev_dereference(dev);
> +
> +    if (sent > 0)
> +	    return sent;
> +
> +    return ret;
> +}
>  
>  static struct rtdm_driver rtcan_driver = {
>  	.profile_info		= RTDM_PROFILE_INFO(rtcan,
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

