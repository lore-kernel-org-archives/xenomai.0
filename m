Subject: Re: [Patch 1/3] Problem with upstream SPECTRE mitigation found in
 sendmsg/recvmsg syscalls
References: <1176-5fd9c780-16b-12dbaa60@116805552>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <edd84af6-13ea-579b-069d-2ee3a0b1bcd2@siemens.com>
Date: Wed, 16 Dec 2020 11:41:46 +0100
MIME-Version: 1.0
In-Reply-To: <1176-5fd9c780-16b-12dbaa60@116805552>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>, xenomai@xenomai.org

On 16.12.20 09:38, François Legal via Xenomai wrote:
> From: François LEGAL <devel@thom.fr.eu.org>
> 
> The RTNET sendmsg/recvmsg protocol handlers used to call copy_to/from_user on the struct user_msghdr argument. The syscall entry code already does this copy, so calling again the copy_to/from_user in handlers triggers SPECTRE mitigation protection. This patch removes the calls in the handlers
> 
> This patch has been tested with 4.4.x kernel
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
>  kernel/drivers/net/stack/packet/af_packet.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
> index b8de8a0..cc74873 100644
> --- a/kernel/drivers/net/stack/packet/af_packet.c
> +++ b/kernel/drivers/net/stack/packet/af_packet.c
> @@ -294,7 +294,7 @@ static int rt_packet_ioctl(struct rtdm_fd *fd, unsigned int request,
>  /***
>   *  rt_packet_recvmsg
>   */
> -static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *u_msg,
> +static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
>  				 int msg_flags)
>  {
>  	struct rtsocket *sock = rtdm_fd_to_private(fd);
> @@ -304,14 +304,9 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *u_msg,
>  	struct sockaddr_ll sll;
>  	int ret, flags;
>  	nanosecs_rel_t timeout = sock->timeout;
> -	struct user_msghdr _msg, *msg;
>  	socklen_t namelen;
>  	struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
>  
> -	msg = rtnet_get_arg(fd, &_msg, u_msg, sizeof(_msg));
> -	if (IS_ERR(msg))
> -		return PTR_ERR(msg);
> -
>  	if (msg->msg_iovlen < 0)
>  		return -EINVAL;
>  
> @@ -359,7 +354,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *u_msg,
>  			goto fail;
>  
>  		namelen = sizeof(sll);
> -		ret = rtnet_put_arg(fd, &u_msg->msg_namelen, &namelen,
> +		ret = rtnet_put_arg(fd, &msg->msg_namelen, &namelen,
>  				    sizeof(namelen));
>  		if (ret)
>  			goto fail;
> @@ -380,7 +375,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *u_msg,
>  	if (copy_len > len) {
>  		copy_len = len;
>  		flags = msg->msg_flags | MSG_TRUNC;
> -		ret = rtnet_put_arg(fd, &u_msg->msg_flags, &flags,
> +		ret = rtnet_put_arg(fd, &msg->msg_flags, &flags,
>  				    sizeof(flags));
>  		if (ret)
>  			goto fail;
> @@ -419,7 +414,6 @@ static ssize_t rt_packet_sendmsg(struct rtdm_fd *fd,
>  	unsigned char *addr;
>  	int ifindex;
>  	ssize_t ret;
> -	struct user_msghdr _msg;
>  	struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;
>  
>  	if (msg_flags & MSG_OOB) /* Mirror BSD error message compatibility */
> @@ -427,10 +421,6 @@ static ssize_t rt_packet_sendmsg(struct rtdm_fd *fd,
>  	if (msg_flags & ~MSG_DONTWAIT)
>  		return -EINVAL;
>  
> -	msg = rtnet_get_arg(fd, &_msg, msg, sizeof(*msg));
> -	if (IS_ERR(msg))
> -		return PTR_ERR(msg);
> -
>  	if (msg->msg_iovlen < 0)
>  		return -EINVAL;
> 
> 

Changes look good to me, and generally splitting up is also nice -
provided there are specific commit messages as well. The subject should
be something like "<subsystem>: Drop duplicate copy_to/from_user", and
then the commit log should explain why (like it does already).

Please also version your patch series ("[PATCH v2 1/3]") to make it
easier finding out what is latest.

I'm fixing this up in this case while merging.

Thanks for debugging and solving this!
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

