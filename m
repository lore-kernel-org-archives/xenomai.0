References: <20220406155648.1592472-1-rpm@xenomai.org>
 <20220406155648.1592472-5-rpm@xenomai.org>
 <38bbcf6b-ca46-0f3d-ee17-88dd2880a821@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 5/5] drivers: ipc: enable non-blocking write from
 regular threads
Date: Thu, 07 Apr 2022 13:37:39 +0200
In-reply-to: <38bbcf6b-ca46-0f3d-ee17-88dd2880a821@siemens.com>
Message-ID: <87h775f7h1.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 06.04.22 17:56, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Regular threads should be allowed to write to RTIPC sockets provided
>> MSG_DONTWAIT is implicitly set for such a request. This would match
>> the existing behavior with other synchronization objects, such as
>> semaphores and events, avoiding unnecessary restrictions on usage.
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  kernel/drivers/ipc/bufp.c  | 8 ++++++--
>>  kernel/drivers/ipc/iddp.c  | 8 ++++++--
>>  kernel/drivers/ipc/rtipc.c | 4 ++--
>>  kernel/drivers/ipc/xddp.c  | 6 +++++-
>>  4 files changed, 19 insertions(+), 7 deletions(-)
>> 
>> diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
>> index fd533dba27..565409dd6f 100644
>> --- a/kernel/drivers/ipc/bufp.c
>> +++ b/kernel/drivers/ipc/bufp.c
>> @@ -655,11 +655,15 @@ static ssize_t bufp_write(struct rtdm_fd *fd,
>>  	struct rtipc_private *priv = rtdm_fd_to_private(fd);
>>  	struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
>>  	struct bufp_socket *sk = priv->state;
>> +	int flags = 0;
>>  
>>  	if (sk->peer.sipc_port < 0)
>>  		return -EDESTADDRREQ;
>>  
>> -	return __bufp_sendmsg(fd, &iov, 1, 0, &sk->peer);
>> +	if (is_secondary_domain())
>> +		flags = MSG_DONTWAIT;
>> +
>> +	return __bufp_sendmsg(fd, &iov, 1, flags, &sk->peer);
>>  }
>>  
>>  static int __bufp_bind_socket(struct rtipc_private *priv,
>> @@ -682,7 +686,7 @@ static int __bufp_bind_socket(struct rtipc_private *priv,
>>  	    __test_and_set_bit(_BUFP_BINDING, &sk->status))
>>  		ret = -EADDRINUSE;
>>  	cobalt_atomic_leave(s);
>> -	
>> +
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
>> index a553902326..05d0193394 100644
>> --- a/kernel/drivers/ipc/iddp.c
>> +++ b/kernel/drivers/ipc/iddp.c
>> @@ -255,7 +255,7 @@ static ssize_t __iddp_recvmsg(struct rtdm_fd *fd,
>>  	}
>>  
>>  	/* We want to pick one buffer from the queue. */
>> -	
>> +
>>  	for (;;) {
>>  		ret = rtdm_sem_timeddown(&sk->insem, timeout, toseq);
>>  		if (unlikely(ret)) {
>> @@ -522,11 +522,15 @@ static ssize_t iddp_write(struct rtdm_fd *fd,
>>  	struct rtipc_private *priv = rtdm_fd_to_private(fd);
>>  	struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
>>  	struct iddp_socket *sk = priv->state;
>> +	int flags = 0;
>>  
>>  	if (sk->peer.sipc_port < 0)
>>  		return -EDESTADDRREQ;
>>  
>> -	return __iddp_sendmsg(fd, &iov, 1, 0, &sk->peer);
>> +	if (is_secondary_domain())
>> +		flags = MSG_DONTWAIT;
>> +
>> +	return __iddp_sendmsg(fd, &iov, 1, flags, &sk->peer);
>>  }
>>  
>>  static int __iddp_bind_socket(struct rtdm_fd *fd,
>> diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
>> index 859bdab2f2..211b496ec5 100644
>> --- a/kernel/drivers/ipc/rtipc.c
>> +++ b/kernel/drivers/ipc/rtipc.c
>> @@ -428,7 +428,7 @@ static int rtipc_select(struct rtdm_fd *fd, struct xnselector *selector,
>>  	struct xnselect *block;
>>  	spl_t s;
>>  	int ret;
>> -	
>> +
>>  	if (type != XNSELECT_READ && type != XNSELECT_WRITE)
>>  		return -EINVAL;
>>  
>> @@ -480,7 +480,7 @@ static struct rtdm_driver rtipc_driver = {
>>  		.read_rt	=	rtipc_read,
>>  		.read_nrt	=	NULL,
>>  		.write_rt	=	rtipc_write,
>> -		.write_nrt	=	NULL,
>> +		.write_nrt	=	rtipc_write, /* MSG_DONTWAIT. */
>>  		.select		=	rtipc_select,
>>  	},
>>  };
>> diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
>> index ae5b720c0c..2ca0da5fd4 100644
>> --- a/kernel/drivers/ipc/xddp.c
>> +++ b/kernel/drivers/ipc/xddp.c
>> @@ -657,11 +657,15 @@ static ssize_t xddp_write(struct rtdm_fd *fd,
>>  	struct rtipc_private *priv = rtdm_fd_to_private(fd);
>>  	struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
>>  	struct xddp_socket *sk = priv->state;
>> +	int flags = 0;
>>  
>>  	if (sk->peer.sipc_port < 0)
>>  		return -EDESTADDRREQ;
>>  
>> -	return __xddp_sendmsg(fd, &iov, 1, 0, &sk->peer);
>> +	if (is_secondary_domain())
>> +		flags = MSG_DONTWAIT;
>> +
>> +	return __xddp_sendmsg(fd, &iov, 1, flags, &sk->peer);
>>  }
>>  
>>  static int __xddp_bind_socket(struct rtipc_private *priv,
>
> Does this patch have any dependency on 1-4, or was it just bundled with
> them by chance?
>

Not related. I'm upstreaming my patch queue indistinctly with stuff
which have been in use for a few months here.

-- 
Philippe.

