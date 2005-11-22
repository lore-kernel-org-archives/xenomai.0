Message-ID: <43836DA2.90705@domain.hid>
Date: Tue, 22 Nov 2005 20:12:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] define your own pipe heap
References: <4382201C.8040503@domain.hid>	<43825E4C.4030002@domain.hid>
	<4382F115.5010007@domain.hid>
	<4382F81D.8020303@domain.hid>
	<43830785.6010402@domain.hid>
In-Reply-To: <43830785.6010402@domain.hid>
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Jan Kiszka wrote:
>>>
>>>
>>>>...
>>>>A patch says more than thousand words. ;)
>>>>
>>>>As a first approach, I picked the second variant and implemented a new
>>>>function called rt_pipe_setpool. I also had to extend rt_pipe_alloc and
>>>>rt_pipe_free so that the right pool is used by them.
>>>>
>>>
>>>
>>>I thought about this variant again, and it seems to me rather unsafe in
>>>case some buffer allocation takes place between rt_pipe_create and
>>>rt_pipe_setpool. So, here is a patch which extends rt_pipe_create with a
>>>new argument poolsize instead.
>>>
>>
>>Yep, looks safer to me too.
>>
> 
> 
> Ok, I addressed most your comments, and here is round 2 of variant 2.
> The only question for me is if we should rt_pipe_create in kernel space
> from RT context with poolsize=0 if this is prevented effectively for
> userspace task?

This is not prevented for user-space, since there is an automatic switch 
to secondary mode caused by the lostage exec bit.

  So far, I deny any non-RT invocation.
> 

You likely mean, any non-Linux invocation.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: skins/native/pipe.h
> ===================================================================
> --- skins/native/pipe.h	(revision 165)
> +++ skins/native/pipe.h	(working copy)
> @@ -37,6 +37,8 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <nucleus/heap.h>
> +
>  #define XENO_PIPE_MAGIC 0x55550202
>  
>  typedef xnpipe_mh_t RT_PIPE_MSG;
> @@ -57,6 +59,10 @@
>  
>      RT_PIPE_MSG *buffer;	/* !< Buffer used in byte stream mode. */
>  
> +    xnheap_t *bufpool;		/* !< Current buffer pool. */
> +
> +    xnheap_t privpool;		/* !< Private buffer pool. */
> +
>      size_t fillsz;		/* !< Bytes written to the buffer.  */
>  
>      u_long flushable;		/* !< Flush request flag. */
> @@ -85,7 +91,8 @@
>  
>  int rt_pipe_create(RT_PIPE *pipe,
>  		   const char *name,
> -		   int minor);
> +		   int minor,
> +		   size_t poolsize);
>  
>  int rt_pipe_delete(RT_PIPE *pipe);
>  
> @@ -113,9 +120,11 @@
>  		     size_t size,
>  		     int mode);
>  
> -RT_PIPE_MSG *rt_pipe_alloc(size_t size);
> +RT_PIPE_MSG *rt_pipe_alloc(RT_PIPE *pipe,
> +                           size_t size);
>  
> -int rt_pipe_free(RT_PIPE_MSG *msg);
> +int rt_pipe_free(RT_PIPE *pipe,
> +                 RT_PIPE_MSG *msg);
>  
>  ssize_t rt_pipe_flush(RT_PIPE *pipe);
>  
> Index: skins/native/syscall.c
> ===================================================================
> --- skins/native/syscall.c	(revision 165)
> +++ skins/native/syscall.c	(working copy)
> @@ -3194,6 +3194,7 @@
>      char name[XNOBJECT_NAME_LEN];
>      RT_PIPE_PLACEHOLDER ph;
>      int err, minor;
> +    size_t poolsize;
>      RT_PIPE *pipe;
>  
>      if (!__xn_access_ok(curr,VERIFY_WRITE,__xn_reg_arg1(regs),sizeof(ph)))
> @@ -3213,12 +3214,15 @@
>      /* Device minor. */
>      minor = (int)__xn_reg_arg3(regs);
>  
> +    /* Buffer pool size. */
> +    poolsize = (size_t)__xn_reg_arg4(regs);
> +
>      pipe = (RT_PIPE *)xnmalloc(sizeof(*pipe));
>  
>      if (!pipe)
>  	return -ENOMEM;
>  
> -    err = rt_pipe_create(pipe,name,minor);
> +    err = rt_pipe_create(pipe,name,minor,poolsize);
>  
>      if (err == 0)
>  	{
> @@ -3332,7 +3336,7 @@
>      /* Zero-sized messages are allowed, so we still need to free the
>         message buffer even if no data copy took place. */
>  
> -    rt_pipe_free(msg);
> +    rt_pipe_free(pipe,msg);
>  
>      return err;
>  }
> @@ -3374,7 +3378,7 @@
>      if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),size))
>  	return -EFAULT;
>  
> -    msg = rt_pipe_alloc(size);
> +    msg = rt_pipe_alloc(pipe,size);
>  	
>      if (!msg)
>  	return -ENOMEM;
> @@ -3386,7 +3390,7 @@
>      if (err != size)
>  	/* If the operation failed, we need to free the message buffer
>  	   by ourselves. */
> -	rt_pipe_free(msg);
> +	rt_pipe_free(pipe,msg);
>  
>      return err;
>  }
> @@ -3436,7 +3440,7 @@
>  	}
>      else
>  	{
> -	msg = rt_pipe_alloc(size);
> +	msg = rt_pipe_alloc(pipe,size);
>  	
>  	if (!msg)
>  	    return -ENOMEM;
> @@ -3449,7 +3453,7 @@
>      err = rt_pipe_stream(pipe,buf,size);
>  
>      if (msg)
> -	rt_pipe_free(msg);
> +	rt_pipe_free(pipe,msg);
>  
>      return err;
>  }
> @@ -3595,7 +3599,7 @@
>      [__xeno_intr_enable ] = { &__rt_intr_enable, __xn_exec_any },
>      [__xeno_intr_disable ] = { &__rt_intr_disable, __xn_exec_any },
>      [__xeno_intr_inquire ] = { &__rt_intr_inquire, __xn_exec_any },
> -    [__xeno_pipe_create ] = { &__rt_pipe_create, __xn_exec_any },
> +    [__xeno_pipe_create ] = { &__rt_pipe_create, __xn_exec_lostage },
>      [__xeno_pipe_bind ] = { &__rt_pipe_bind, __xn_exec_conforming },
>      [__xeno_pipe_delete ] = { &__rt_pipe_delete, __xn_exec_any },
>      [__xeno_pipe_read ] = { &__rt_pipe_read, __xn_exec_primary },
> Index: skins/native/lib/pipe.c
> ===================================================================
> --- skins/native/lib/pipe.c	(revision 165)
> +++ skins/native/lib/pipe.c	(working copy)
> @@ -23,13 +23,15 @@
>  
>  int rt_pipe_create (RT_PIPE *pipe,
>  		    const char *name,
> -		    int minor)
> +		    int minor,
> +		    size_t poolsize)
>  {
> -    return XENOMAI_SKINCALL3(__xeno_muxid,
> +    return XENOMAI_SKINCALL4(__xeno_muxid,
>  			     __xeno_pipe_create,
>  			     pipe,
>  			     name,
> -			     minor);
> +			     minor,
> +			     poolsize);
>  }
>  
>  int rt_pipe_bind (RT_PIPE *pipe,
> Index: skins/native/pipe.c
> ===================================================================
> --- skins/native/pipe.c	(revision 165)
> +++ skins/native/pipe.c	(working copy)
> @@ -50,8 +50,6 @@
>  #include <native/registry.h>
>  #include <native/pipe.h>
>  
> -static xnheap_t *__pipe_heap = &kheap;
> -
>  static int __pipe_flush_apc;
>  
>  static DECLARE_XNQUEUE(__pipe_flush_q);
> @@ -83,6 +81,14 @@
>  
>  #endif /* CONFIG_XENO_NATIVE_EXPORT_REGISTRY */
>  
> +static void __pipe_flush_pool (xnheap_t *heap,
> +                               void *poolmem,
> +                               u_long poolsize,
> +                               void *cookie)
> +{
> +    xnarch_sysfree(poolmem,poolsize);
> +}
> +
>  static inline ssize_t __pipe_flush (RT_PIPE *pipe)
>  
>  {
> @@ -122,8 +128,10 @@
>  				   size_t size,
>  				   void *cookie)
>  {
> +    RT_PIPE *pipe = (RT_PIPE *)cookie;
> +
>      /* Allocate memory for the incoming message. */
> -    return xnheap_alloc(__pipe_heap,size);
> +    return xnheap_alloc(pipe->bufpool,size);
>  }
>  
>  static int __pipe_output_handler (int bminor,
> @@ -131,8 +139,10 @@
>  				  int retval,
>  				  void *cookie)
>  {
> +    RT_PIPE *pipe = (RT_PIPE *)cookie;
> +
>      /* Free memory from output/discarded message. */
> -    xnheap_free(__pipe_heap,mh);
> +    xnheap_free(pipe->bufpool,mh);
>      return retval;
>  }
>  
> @@ -154,7 +164,7 @@
>  }
>  
>  /**
> - * @fn int rt_pipe_create(RT_PIPE *pipe,const char *name,int minor)
> + * @fn int rt_pipe_create(RT_PIPE *pipe,const char *name,int minor, size_t poolsize)
>   * @brief Create a message pipe.
>   *
>   * This service opens a bi-directional communication channel allowing
> @@ -201,6 +211,10 @@
>   * /proc/xenomai/registry/pipes/@a name to the allocated pipe device
>   * entry (i.e. /dev/rtp*).
>   *
> + * @param poolsize Specifies the size of a dedicated buffer pool for the
> + * pipe. Passing 0 means that all message allocations for this pipe are
> + * performed on the system heap.
> + *
>   * @return 0 is returned upon success. Otherwise:
>   *
>   * - -ENOMEM is returned if the system fails to get enough dynamic
> @@ -232,20 +246,55 @@
>  
>  int rt_pipe_create (RT_PIPE *pipe,
>  		    const char *name,
> -		    int minor)
> +		    int minor,
> +		    size_t poolsize)
>  {
>      int err = 0;
> +    void *poolmem;
>  
> -    if (xnpod_asynch_p())
> +    if (!xnpod_root_p())
>  	return -EPERM;
>  
>      pipe->buffer = NULL;
> +    pipe->bufpool = &kheap;
>      pipe->fillsz = 0;
>      pipe->flushable = 0;
>      pipe->handle = 0;    /* i.e. (still) unregistered pipe. */
>      pipe->magic = XENO_PIPE_MAGIC;
>      xnobject_copy_name(pipe->name,name);
>  
> +    if (poolsize > 0)
> +	{
> +	/* Make sure we won't hit trivial argument errors when calling
> +	   xnheap_init(). */
> +
> +	if (poolsize < 2 * PAGE_SIZE)
> +	    poolsize = 2 * PAGE_SIZE;
> +
> +	/* Account for the overhead so that the actual free space is large
> +	   enough to match the requested size. */
> +
> +	poolsize += xnheap_overhead(poolsize,PAGE_SIZE);
> +	poolsize = PAGE_ALIGN(poolsize);
> +
> +	poolmem = xnarch_sysalloc(poolsize);
> +
> +	if (!poolmem)
> +	    return -ENOMEM;
> +
> +	err = xnheap_init(&pipe->privpool,
> +	                  poolmem,
> +	                  poolsize,
> +	                  PAGE_SIZE); /* Use natural page size */
> +	if (err)
> +	    {
> +	    xnarch_sysfree(poolmem,poolsize);
> +	    return err;
> +	    }
> +
> +	pipe->bufpool = &pipe->privpool;
> +	}
> +
>      minor = xnpipe_connect(minor,
>  			 &__pipe_output_handler,
>  			 NULL,
> @@ -253,7 +302,12 @@
>  			 pipe);
>  
>      if (minor < 0)
> +	{
> +	if (pipe->bufpool == &pipe->privpool)
> +	    xnheap_destroy(&pipe->privpool,__pipe_flush_pool,NULL);
> +
>  	return minor;
> +	}
>  
>      pipe->minor = minor;
>  
> @@ -337,14 +391,15 @@
>      if (!pipe)
>  	{
>  	err = xeno_handle_error(pipe,XENO_PIPE_MAGIC,RT_PIPE);
> -	goto unlock_and_exit;
> +	xnlock_put_irqrestore(&nklock,s);
> +	return err;
>  	}
>  
>      if (__test_and_clear_bit(0,&pipe->flushable))
>  	{
>  	/* Purge data waiting for flush. */
>  	removeq(&__pipe_flush_q,&pipe->link);
> -	rt_pipe_free(pipe->buffer);
> +	rt_pipe_free(pipe,pipe->buffer);
>  	}
>  
>      err = xnpipe_disconnect(pipe->minor);
> @@ -356,10 +411,11 @@
>  
>      xeno_mark_deleted(pipe);
>  
> - unlock_and_exit:
> -
>      xnlock_put_irqrestore(&nklock,s);
>  
> +    if (pipe->bufpool == &pipe->privpool)
> +	xnheap_destroy(&pipe->privpool,__pipe_flush_pool,NULL);
> +
>      return err;
>  }
>  
> @@ -572,7 +628,7 @@
>      /* Zero-sized messages are allowed, so we still need to free the
>         message buffer even if no data copy took place. */
>  
> -    rt_pipe_free(msg);
> +    rt_pipe_free(pipe,msg);
>  
>      return nbytes;
>  }
> @@ -767,7 +823,7 @@
>  	/* Try flushing the streaming buffer in any case. */
>  	return rt_pipe_send(pipe,NULL,0,mode);
>  
> -    msg = rt_pipe_alloc(size);
> +    msg = rt_pipe_alloc(pipe,size);
>  	
>      if (!msg)
>  	return -ENOMEM;
> @@ -779,7 +835,7 @@
>      if (nbytes != size)
>  	/* If the operation failed, we need to free the message buffer
>  	   by ourselves. */
> -	rt_pipe_free(msg);
> +	rt_pipe_free(pipe,msg);
>  
>      return nbytes;
>  }
> @@ -886,7 +942,7 @@
>  
>  	if (pipe->buffer == NULL)
>  	    {
> -	    pipe->buffer = rt_pipe_alloc(CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ);
> +	    pipe->buffer = rt_pipe_alloc(pipe,CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ);
>  
>  	    if (pipe->buffer == NULL)
>  		{
> @@ -984,15 +1040,17 @@
>  }
>  
>  /**
> - * @fn RT_PIPE_MSG *rt_pipe_alloc(size_t size)
> + * @fn RT_PIPE_MSG *rt_pipe_alloc(RT_PIPE *pipe,size_t size)
>   *
>   * @brief Allocate a message pipe buffer.
>   *
> - * This service allocates a message buffer from the system heap which
> + * This service allocates a message buffer from the pipe's heap which
>   * can be subsequently filled by the caller then passed to
>   * rt_pipe_send() for sending. The beginning of the available data
>   * area of @a size contiguous bytes is accessible from P_MSGPTR(msg).
>   *
> + * @param pipe The descriptor address of the affected pipe.
> + *
>   * @param size The requested size in bytes of the buffer. This value
>   * should represent the size of the payload data.
>   *
> @@ -1010,10 +1068,11 @@
>   * Rescheduling: never.
>   */
>  
> -RT_PIPE_MSG *rt_pipe_alloc (size_t size)
> +RT_PIPE_MSG *rt_pipe_alloc (RT_PIPE *pipe,
> +                            size_t size)
>  
>  {
> -    RT_PIPE_MSG *msg = (RT_PIPE_MSG *)xnheap_alloc(__pipe_heap,size + sizeof(RT_PIPE_MSG));
> +    RT_PIPE_MSG *msg = (RT_PIPE_MSG *)xnheap_alloc(pipe->bufpool,size + sizeof(RT_PIPE_MSG));
>  
>      if (msg)
>  	{
> @@ -1025,13 +1084,15 @@
>  }
>  
>  /**
> - * @fn int rt_pipe_free(RT_PIPE_MSG *msg)
> + * @fn int rt_pipe_free(RT_PIPE *pipe,RT_PIPE_MSG *msg)
>   *
>   * @brief Free a message pipe buffer.
>   *
>   * This service releases a message buffer returned by
> - * rt_pipe_receive() to the system heap.
> + * rt_pipe_receive() to the pipe's heap.
>   *
> + * @param pipe The descriptor address of the affected pipe.
> + *
>   * @param msg The address of the message buffer to free.
>   *
>   * @return 0 is returned upon success, or -EINVAL if @a msg is not a
> @@ -1049,9 +1110,9 @@
>   * Rescheduling: never.
>   */
>  
> -int rt_pipe_free (RT_PIPE_MSG *msg)
> +int rt_pipe_free (RT_PIPE *pipe,RT_PIPE_MSG *msg)
>  {
> -    return xnheap_free(__pipe_heap,msg);
> +    return xnheap_free(pipe->bufpool,msg);
>  }
>  
>  /*@}*/
> Index: testsuite/klatency/latency-module.c
> ===================================================================
> --- testsuite/klatency/latency-module.c	(revision 165)
> +++ testsuite/klatency/latency-module.c	(working copy)
> @@ -83,7 +83,7 @@
>  	maxjitter = maxj;
>  	avgjitter = sumj / sample_count;
>  
> -	msg = rt_pipe_alloc(sizeof(struct latency_stat));
> +	msg = rt_pipe_alloc(&pipe,sizeof(struct latency_stat));
>  
>  	if (!msg)
>  	    {
> @@ -103,7 +103,7 @@
>  	   ourselves. */
>  
>  	if (rt_pipe_send(&pipe,msg,sizeof(*s),0) != sizeof(*s))
> -	    rt_pipe_free(msg);
> +	    rt_pipe_free(&pipe,msg);
>  	}
>  }
>  
> @@ -128,7 +128,7 @@
>  	return 2;
>  	}
>  
> -    err = rt_pipe_create(&pipe,"klatency",0);
> +    err = rt_pipe_create(&pipe,"klatency",0,0);
>  
>      if (err)
>  	{


-- 

Philippe.

