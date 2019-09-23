Subject: Re: [PATCH v5 1/1] cobalt/rtdm: allow for device teardown
References: <20190920165930.6732-1-rpm@xenomai.org>
 <20190920165930.6732-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f9d8f3be-be6e-2fe0-edfd-269a4821f68d@siemens.com>
Date: Mon, 23 Sep 2019 14:30:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190920165930.6732-2-rpm@xenomai.org>
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

On 20.09.19 18:59, Philippe Gerum wrote:
> Currently, rtdm_dev_unregister() will hang soft until all references
> on the dismantled device have been dropped, which in turn cannot
> happen until all rtdm_fds on the device have been closed, which cannot
> happen until all references on those fds have been dropped eventually.
> Unfortunately, applications have no indication that such teardown has
> been requested, and keep sleeping on I/O channels managed by the
> dismantled device, which prevents rtdm_dev_unregister() from
> completing.
> 
> Allow for orderly device teardown by tracking all file descriptors
> representing connections active on a device, forcing each of them down
> by calling the driver's close() handler from rtdm_dev_unregister().
> Since a close() handler should abort any ongoing I/O operation on the
> channel being dismantled, any blocking I/O call on such channel should
> return on error with no additional change to the existing drivers. The
> common error code indicating an aborted I/O operation in this case is
> EBADF.
> 
> Upon receiving the error, the application is expected to close the
> stale file descriptor and/or exit, which would drop the corresponding
> file reference.
> 
> Stale file descriptors lingering in applications will still prevent
> driver modules serving them from unloading until they are eventually
> closed. Subsequent operations on a file descriptor connected to a
> device which is being torn now down lead to the EBADF error.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> [Jan: dropped unneeded change to list_get_entry]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   include/cobalt/kernel/list.h        |  8 +++++
>   include/cobalt/kernel/rtdm/driver.h |  1 +
>   include/cobalt/kernel/rtdm/fd.h     |  8 +++++
>   kernel/cobalt/rtdm/core.c           | 10 +++---
>   kernel/cobalt/rtdm/device.c         |  9 +++--
>   kernel/cobalt/rtdm/fd.c             | 56 +++++++++++++++++++++++++++--
>   kernel/cobalt/rtdm/internal.h       |  6 ++++
>   kernel/drivers/testing/rtdmtest.c   |  2 ++
>   8 files changed, 89 insertions(+), 11 deletions(-)
> 
> diff --git a/include/cobalt/kernel/list.h b/include/cobalt/kernel/list.h
> index 989d934b8..ec029ef09 100644
> --- a/include/cobalt/kernel/list.h
> +++ b/include/cobalt/kernel/list.h
> @@ -49,6 +49,14 @@ do {										\
>   	  __item;						\
>     })
>   
> +#define list_get_entry_init(__head, __type, __member)		\
> +  ({								\
> +	  __type *__item;					\
> +	  __item = list_first_entry(__head, __type, __member);	\
> +	  list_del_init(&__item->__member);			\
> +	  __item;						\
> +  })
> +
>   #ifndef list_next_entry
>   #define list_next_entry(__item, __member)			\
>   	list_entry((__item)->__member.next, typeof(*(__item)), __member)
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 88bd7048f..d3d5d6b27 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -385,6 +385,7 @@ struct rtdm_device {
>   		atomic_t refcount;
>   		struct rtdm_fd_ops ops;
>   		wait_queue_head_t putwq;
> +		struct list_head openfd_list;
>   	};
>   };
>   
> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
> index 572b17e29..289065082 100644
> --- a/include/cobalt/kernel/rtdm/fd.h
> +++ b/include/cobalt/kernel/rtdm/fd.h
> @@ -31,6 +31,7 @@ struct rtdm_fd;
>   struct _rtdm_mmap_request;
>   struct xnselector;
>   struct cobalt_ppd;
> +struct rtdm_device;
>   
>   /**
>    * @file
> @@ -304,7 +305,9 @@ struct rtdm_fd {
>   #ifdef CONFIG_XENO_ARCH_SYS3264
>   	int compat;
>   #endif
> +	bool stale;
>   	struct list_head cleanup;
> +	struct list_head next;	/* in dev->openfd_list */
>   };
>   
>   #define RTDM_FD_MAGIC 0x52544446
> @@ -395,6 +398,11 @@ int rtdm_fd_valid_p(int ufd);
>   int rtdm_fd_select(int ufd, struct xnselector *selector,
>   		   unsigned int type);
>   
> +int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
> +		struct rtdm_device *dev);
> +
> +void rtdm_device_flush_fds(struct rtdm_device *dev);
> +
>   void rtdm_fd_cleanup(struct cobalt_ppd *p);
>   
>   void rtdm_fd_init(void);
> diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
> index 28db7adb7..843193a2b 100644
> --- a/kernel/cobalt/rtdm/core.c
> +++ b/kernel/cobalt/rtdm/core.c
> @@ -54,7 +54,7 @@ void __rtdm_dev_close(struct rtdm_fd *fd)
>   	struct rtdm_device *dev = context->device;
>   	struct rtdm_driver *drv = dev->driver;
>   
> -	if (drv->ops.close)
> +	if (!fd->stale && drv->ops.close)
>   		drv->ops.close(fd);
>   
>   	cleanup_instance(dev, context);
> @@ -174,7 +174,7 @@ int __rtdm_dev_open(const char *path, int oflag)
>   
>   	context->fd.minor = dev->minor;
>   	context->fd.oflags = oflag;
> -	
> +
>   	trace_cobalt_fd_open(current, &context->fd, ufd, oflag);
>   
>   	if (dev->ops.open) {
> @@ -185,8 +185,7 @@ int __rtdm_dev_open(const char *path, int oflag)
>   			goto fail_open;
>   	}
>   
> -	trace_cobalt_fd_created(&context->fd, ufd);
> -	ret = rtdm_fd_register(&context->fd, ufd);
> +	ret = rtdm_device_new_fd(&context->fd, ufd, context->device);
>   	if (ret < 0)
>   		goto fail_open;
>   
> @@ -240,8 +239,7 @@ int __rtdm_dev_socket(int protocol_family, int socket_type,
>   			goto fail_socket;
>   	}
>   
> -	trace_cobalt_fd_created(&context->fd, ufd);
> -	ret = rtdm_fd_register(&context->fd, ufd);
> +	ret = rtdm_device_new_fd(&context->fd, ufd, context->device);
>   	if (ret < 0)
>   		goto fail_socket;
>   
> diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
> index 8fe0ed735..7d76d2cc5 100644
> --- a/kernel/cobalt/rtdm/device.c
> +++ b/kernel/cobalt/rtdm/device.c
> @@ -417,6 +417,7 @@ int rtdm_dev_register(struct rtdm_device *dev)
>   	else
>   		dev->ops.open = (typeof(dev->ops.open))enosys;
>   
> +	INIT_LIST_HEAD(&dev->openfd_list);
>   	init_waitqueue_head(&dev->putwq);
>   	dev->ops.close = __rtdm_dev_close; /* Interpose on driver's handler. */
>   	atomic_set(&dev->refcount, 0);
> @@ -524,8 +525,9 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
>   /**
>    * @brief Unregister a RTDM device
>    *
> - * Removes the device from the RTDM namespace. This routine waits until
> - * all connections to @a device have been closed prior to unregistering.
> + * Removes the device from the RTDM namespace. This routine first
> + * attempts to teardown all active connections to the @a device prior
> + * to unregistering.
>    *
>    * @param[in] dev Device descriptor.
>    *
> @@ -542,6 +544,9 @@ void rtdm_dev_unregister(struct rtdm_device *dev)
>   	/* Lock out any further connection. */
>   	dev->magic = ~RTDM_DEVICE_MAGIC;
>   
> +	/* Flush all fds from this device. */
> +	rtdm_device_flush_fds(dev);
> +
>   	/* Then wait for the ongoing connections to finish. */
>   	wait_event(dev->putwq,
>   		   atomic_read(&dev->refcount) == 0);
> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
> index d8a62376e..0a1c6e44e 100644
> --- a/kernel/cobalt/rtdm/fd.c
> +++ b/kernel/cobalt/rtdm/fd.c
> @@ -160,7 +160,9 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
>   	fd->owner = ppd;
>   	fd->ufd = ufd;
>   	fd->refs = 1;
> +	fd->stale = false;
>   	set_compat_bit(fd);
> +	INIT_LIST_HEAD(&fd->next);
>   
>   	return 0;
>   }
> @@ -190,6 +192,24 @@ int rtdm_fd_register(struct rtdm_fd *fd, int ufd)
>   	return ret;
>   }
>   
> +int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
> +			struct rtdm_device *device)
> +{
> +	spl_t s;
> +	int ret;
> +
> +	ret = rtdm_fd_register(fd, ufd);
> +	if (ret < 0)
> +		return ret;
> +
> +	trace_cobalt_fd_created(fd, ufd);
> +	xnlock_get_irqsave(&fdtree_lock, s);
> +	list_add(&fd->next, &device->openfd_list);
> +	xnlock_put_irqrestore(&fdtree_lock, s);
> +
> +	return 0;
> +}
> +
>   /**
>    * @brief Retrieve and lock a RTDM file descriptor
>    *
> @@ -223,6 +243,11 @@ struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic)
>   		goto out;
>   	}
>   
> +	if (fd->stale) {
> +		fd = ERR_PTR(-EBADF);
> +		goto out;
> +	}
> +
>   	++fd->refs;
>   out:
>   	xnlock_put_irqrestore(&fdtree_lock, s);
> @@ -269,9 +294,13 @@ static void lostage_trigger_close(struct ipipe_work_header *work)
>   
>   static void __put_fd(struct rtdm_fd *fd, spl_t s)
>   {
> -	int destroy;
> +	bool destroy;
>   
> +	XENO_WARN_ON(COBALT, fd->refs <= 0);
>   	destroy = --fd->refs == 0;
> +	if (destroy && !list_empty(&fd->next))
> +		list_del_init(&fd->next);
> +
>   	xnlock_put_irqrestore(&fdtree_lock, s);
>   
>   	if (!destroy)
> @@ -295,6 +324,29 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
>   	}
>   }
>   
> +void rtdm_device_flush_fds(struct rtdm_device *dev)
> +{
> +	struct rtdm_driver *drv = dev->driver;
> +	struct rtdm_fd *fd;
> +	spl_t s;
> +
> +	xnlock_get_irqsave(&fdtree_lock, s);
> +
> +	while (!list_empty(&dev->openfd_list)) {
> +		fd = list_get_entry_init(&dev->openfd_list, struct rtdm_fd, next);
> +		fd->stale = true;
> +		if (drv->ops.close) {
> +			rtdm_fd_get_light(fd);
> +			xnlock_put_irqrestore(&fdtree_lock, s);
> +			drv->ops.close(fd);
> +			rtdm_fd_put(fd);
> +			xnlock_get_irqsave(&fdtree_lock, s);
> +		}
> +	}
> +
> +	xnlock_put_irqrestore(&fdtree_lock, s);
> +}
> +
>   /**
>    * @brief Release a RTDM file descriptor obtained via rtdm_fd_get()
>    *
> @@ -359,8 +411,6 @@ void rtdm_fd_unlock(struct rtdm_fd *fd)
>   	spl_t s;
>   
>   	xnlock_get_irqsave(&fdtree_lock, s);
> -	/* Warn if fd was unreferenced. */
> -	XENO_WARN_ON(COBALT, fd->refs <= 0);
>   	__put_fd(fd, s);
>   }
>   EXPORT_SYMBOL_GPL(rtdm_fd_unlock);
> diff --git a/kernel/cobalt/rtdm/internal.h b/kernel/cobalt/rtdm/internal.h
> index b634bd997..99488e058 100644
> --- a/kernel/cobalt/rtdm/internal.h
> +++ b/kernel/cobalt/rtdm/internal.h
> @@ -49,6 +49,12 @@ int __rtdm_dev_ioctl_core(struct rtdm_fd *fd,
>   int __rtdm_mmap_from_fdop(struct rtdm_fd *fd, size_t len, off_t offset,
>   			  int prot, int flags, void **pptr);
>   
> +/* nklock held, irqs off. */
> +static inline void rtdm_fd_get_light(struct rtdm_fd *fd)
> +{
> +	++fd->refs;
> +}
> +
>   int rtdm_init(void);
>   
>   void rtdm_cleanup(void);
> diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/rtdmtest.c
> index 6abf76b56..87aef8ee6 100644
> --- a/kernel/drivers/testing/rtdmtest.c
> +++ b/kernel/drivers/testing/rtdmtest.c
> @@ -51,6 +51,7 @@ static void close_timer_proc(rtdm_timer_t *timer)
>   		       "rtdmtest: %s: close_counter is %lu, should be 1!\n",
>   		       __FUNCTION__, ctx->close_counter);
>   
> +	ctx->close_deferral = RTTST_RTDM_NORMAL_CLOSE;
>   	rtdm_fd_unlock(rtdm_private_to_fd(ctx));
>   }
>   
> @@ -81,6 +82,7 @@ static void rtdm_basic_close(struct rtdm_fd *fd)
>   			       __FUNCTION__, ctx->close_counter);
>   			return;
>   		}
> +		rtdm_fd_unlock(fd);
>   		break;
>   	}
>   
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

