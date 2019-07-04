Subject: Re: [PATCH 1/2] drivers/net: drop socket-specific module refcounting
References: <20190620172934.31393-1-rpm@xenomai.org>
 <20190620172934.31393-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <436668c5-9f87-4da8-601a-64cef5f96ee6@siemens.com>
Date: Thu, 4 Jul 2019 11:04:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190620172934.31393-2-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 20.06.19 19:29, Philippe Gerum via Xenomai wrote:
> RTDM already refcounts rtdm_fd descriptors to prevent unsafe module
> unloading while connections are still active. We can remove the legacy
> module refcounting done by the generic socket code, since every socket
> is covered by an RTDM file descriptor.
> ---
>   .../drivers/net/stack/include/rtnet_socket.h  | 15 +++--------
>   kernel/drivers/net/stack/ipv4/icmp.c          |  4 +--
>   kernel/drivers/net/stack/socket.c             | 27 ++++++-------------
>   3 files changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/include/rtnet_socket.h b/kernel/drivers/net/stack/include/rtnet_socket.h
> index 351e62c77..0d8850c7f 100644
> --- a/kernel/drivers/net/stack/include/rtnet_socket.h
> +++ b/kernel/drivers/net/stack/include/rtnet_socket.h
> @@ -76,8 +76,6 @@ struct rtsocket {
>   	    int                  ifindex;
>   	} packet;
>       } prot;
> -
> -    struct module *owner;
>   };
>   
>   
> @@ -97,10 +95,7 @@ int rtnet_put_arg(struct rtdm_fd *fd, void *dst,
>   #define rt_socket_dereference(sock) \
>       rtdm_fd_unlock(rt_socket_fd(sock))
>   
> -int __rt_socket_init(struct rtdm_fd *fd, unsigned short protocol,
> -		struct module *module);
> -#define rt_socket_init(fd, proto) \
> -    __rt_socket_init(fd, proto, THIS_MODULE)
> +int rt_socket_init(struct rtdm_fd *fd, unsigned short protocol);
>   
>   void rt_socket_cleanup(struct rtdm_fd *fd);
>   int rt_socket_common_ioctl(struct rtdm_fd *fd, int request, void __user *arg);
> @@ -110,16 +105,12 @@ int rt_socket_select_bind(struct rtdm_fd *fd,
>   			  enum rtdm_selecttype type,
>   			  unsigned fd_index);
>   
> -int __rt_bare_socket_init(struct rtdm_fd *fd, unsigned short protocol,
> -			unsigned int priority, unsigned int pool_size,
> -			struct module *module);
> -#define rt_bare_socket_init(fd, proto, prio, pool_sz) \
> -    __rt_bare_socket_init(fd, proto, prio, pool_sz, THIS_MODULE)
> +int rt_bare_socket_init(struct rtdm_fd *fd, unsigned short protocol,
> +			unsigned int priority, unsigned int pool_size);
>   
>   static inline void rt_bare_socket_cleanup(struct rtsocket *sock)
>   {
>       rtskb_pool_release(&sock->skb_pool);
> -    module_put(sock->owner);
>   }
>   
>   #endif  /* __RTNET_SOCKET_H_ */
> diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
> index 58d97cd7f..a944ef6b7 100644
> --- a/kernel/drivers/net/stack/ipv4/icmp.c
> +++ b/kernel/drivers/net/stack/ipv4/icmp.c
> @@ -526,8 +526,8 @@ void __init rt_icmp_init(void)
>   {
>       int skbs;
>   
> -    skbs = __rt_bare_socket_init(icmp_fd, IPPROTO_ICMP, RT_ICMP_PRIO,
> -			    ICMP_REPLY_POOL_SIZE, NULL);
> +    skbs = rt_bare_socket_init(icmp_fd, IPPROTO_ICMP, RT_ICMP_PRIO,
> +			    ICMP_REPLY_POOL_SIZE);
>       BUG_ON(skbs < 0);
>       if (skbs < ICMP_REPLY_POOL_SIZE)
>   	printk("RTnet: allocated only %d icmp rtskbs\n", skbs);
> diff --git a/kernel/drivers/net/stack/socket.c b/kernel/drivers/net/stack/socket.c
> index ce4e4cb46..747db052f 100644
> --- a/kernel/drivers/net/stack/socket.c
> +++ b/kernel/drivers/net/stack/socket.c
> @@ -50,36 +50,27 @@ MODULE_PARM_DESC(socket_rtskbs, "Default number of realtime socket buffers in so
>    *  internal socket functions                                           *
>    ************************************************************************/
>   
> -int __rt_bare_socket_init(struct rtdm_fd *fd, unsigned short protocol,
> -			unsigned int priority, unsigned int pool_size,
> -			struct module *module)
> +int rt_bare_socket_init(struct rtdm_fd *fd, unsigned short protocol,
> +			unsigned int priority, unsigned int pool_size)
>   {
>       struct rtsocket *sock = rtdm_fd_to_private(fd);
>       int err;
>   
> -    err = try_module_get(module);
> -    if (!err)
> -	return -EAFNOSUPPORT;
> -
>       err = rtskb_pool_init(&sock->skb_pool, pool_size, NULL, fd);
> -    if (err < 0) {
> -	module_put(module);
> +    if (err < 0)
>   	return err;
> -    }
>   
>       sock->protocol = protocol;
>       sock->priority = priority;
> -    sock->owner = module;
>   
>       return err;
>   }
> -EXPORT_SYMBOL_GPL(__rt_bare_socket_init);
> +EXPORT_SYMBOL_GPL(rt_bare_socket_init);
>   
>   /***
>    *  rt_socket_init - initialises a new socket structure
>    */
> -int __rt_socket_init(struct rtdm_fd *fd, unsigned short protocol,
> -		struct module *module)
> +int rt_socket_init(struct rtdm_fd *fd, unsigned short protocol)
>   {
>       struct rtsocket *sock = rtdm_fd_to_private(fd);
>       unsigned int    pool_size;
> @@ -94,10 +85,10 @@ int __rt_socket_init(struct rtdm_fd *fd, unsigned short protocol,
>       rtdm_lock_init(&sock->param_lock);
>       rtdm_sem_init(&sock->pending_sem, 0);
>   
> -    pool_size = __rt_bare_socket_init(fd, protocol,
> +    pool_size = rt_bare_socket_init(fd, protocol,
>   				    RTSKB_PRIO_VALUE(SOCK_DEF_PRIO,
>   						    RTSKB_DEF_RT_CHANNEL),
> -				    socket_rtskbs, module);
> +				    socket_rtskbs);
>       sock->pool_size = pool_size;
>       mutex_init(&sock->pool_nrt_lock);
>   
> @@ -112,7 +103,7 @@ int __rt_socket_init(struct rtdm_fd *fd, unsigned short protocol,
>   
>       return 0;
>   }
> -EXPORT_SYMBOL_GPL(__rt_socket_init);
> +EXPORT_SYMBOL_GPL(rt_socket_init);
>   
>   
>   /***
> @@ -133,8 +124,6 @@ void rt_socket_cleanup(struct rtdm_fd *fd)
>   	rtskb_pool_release(&sock->skb_pool);
>   
>       mutex_unlock(&sock->pool_nrt_lock);
> -
> -    module_put(sock->owner);
>   }
>   EXPORT_SYMBOL_GPL(rt_socket_cleanup);
>   
> 

Looks reasonable. Maybe you can additionally clarify in the commit log that 
rtdm_dev_unregister will now prevent unloading under open sockets.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

