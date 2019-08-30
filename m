Subject: Re: [PATCH v4 1/2] cobalt: switch hand over status to -EADV for
 non-RTDM fd
References: <20190830160314.29441-1-rpm@xenomai.org>
 <636b4952-c260-5300-7be8-d57273526cd0@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cc7d2ce7-db9f-a384-b092-bc522e80f661@xenomai.org>
Date: Fri, 30 Aug 2019 19:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <636b4952-c260-5300-7be8-d57273526cd0@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 8/30/19 6:58 PM, Jan Kiszka wrote:
> On 30.08.19 18:03, Philippe Gerum wrote:
>> Having the RTDM core return -EBADF to indicate that it does not manage
>> a file descriptor is a problem, as several drivers also raise this
>> error to notify userland about an aborted wait due to a connection
>> being dismantled (e.g. RTnet). In this case, libcobalt ends up
>> forwarding the aborted request to the glibc, which is wrong.
>>
>> Switch from -EBADF to -EADV to notify userland that RTDM does not
>> manage a file descriptor, which cannot conflict with any sensible
>> error code the Cobalt core or any RTDM driver may return.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>   kernel/cobalt/rtdm/core.c |  4 ++--
>>   kernel/cobalt/rtdm/fd.c   | 36 +++++++++++++++++------------
>>   lib/cobalt/rtdm.c         | 48 +++++++++++++++++++--------------------
>>   3 files changed, 47 insertions(+), 41 deletions(-)
>>
>> diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
>> index c1aedb3d0..28db7adb7 100644
>> --- a/kernel/cobalt/rtdm/core.c
>> +++ b/kernel/cobalt/rtdm/core.c
>> @@ -154,7 +154,7 @@ int __rtdm_dev_open(const char *path, int oflag)
>>   	 */
>>   	dev = __rtdm_get_namedev(path);
>>   	if (dev == NULL)
>> -		return -ENODEV;
>> +		return -EADV;
>>   
>>   	ufd = get_unused_fd_flags(oflag);
>>   	if (ufd < 0) {
>> @@ -266,7 +266,7 @@ int __rtdm_dev_ioctl_core(struct rtdm_fd *fd, unsigned int request,
>>   	struct rtdm_device_info dev_info;
>>   
>>   	if (fd->magic != RTDM_FD_MAGIC || request != RTIOC_DEVICE_INFO)
>> -		return -ENOSYS;
>> +		return -EADV;
>>   
>>   	drv = dev->driver;
>>   	dev_info.device_flags = drv->device_flags;
>> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
>> index f3b6444c3..d965aafef 100644
>> --- a/kernel/cobalt/rtdm/fd.c
>> +++ b/kernel/cobalt/rtdm/fd.c
>> @@ -51,9 +51,9 @@ static int enosys(void)
>>   	return -ENOSYS;
>>   }
>>   
>> -static int enodev(void)
>> +static int eadv(void)
>>   {
>> -	return -ENODEV;
>> +	return -EADV;
>>   }
>>   
>>   static void nop_close(struct rtdm_fd *fd)
>> @@ -81,14 +81,14 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
>>   
>>   #define assign_invalid_handler(__handler)				\
>>   	do								\
>> -		(__handler) = (typeof(__handler))enodev;		\
>> +		(__handler) = (typeof(__handler))eadv;			\
>>   	while (0)
>>   
>> -/* Calling this handler should beget ENODEV if not implemented. */
>> +/* Calling this handler should beget EADV if not implemented. */
>>   #define assign_invalid_default_handler(__handler)			\
>>   	do								\
>>   		if ((__handler) == NULL)				\
>> -			(__handler) = (typeof(__handler))enodev;	\
>> +			(__handler) = (typeof(__handler))eadv;		\
>>   	while (0)
>>   
>>   #define __assign_default_handler(__handler, __placeholder)		\
>> @@ -105,7 +105,7 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
>>   #define __nrt(__handler)	__handler ## _nrt
>>   
>>   /*
>> - * Install a placeholder returning ENODEV if none of the dual handlers
>> + * Install a placeholder returning EADV if none of the dual handlers
>>    * are implemented, ENOSYS otherwise for NULL handlers to trigger the
>>    * adaptive switch.
>>    */
>> @@ -204,8 +204,14 @@ int rtdm_fd_register(struct rtdm_fd *fd, int ufd)
>>    * @param[in] ufd User-side file descriptor
>>    * @param[in] magic Magic word for lookup validation
>>    *
>> - * @return Pointer to the RTDM file descriptor matching @a ufd, or
>> - * ERR_PTR(-EBADF).
>> + * @return Pointer to the RTDM file descriptor matching @a
>> + * ufd. Otherw0ise:
>> + *
>> + * - ERR_PTR(-EADV) if the use-space handle is either invalid, or not
>> + * managed by RTDM.
>> + *
>> + * - ERR_PTR(-EBADF) if the underlying device is being torned down at
>> + * the time of the call.
>>    *
>>    * @note The file descriptor returned must be later released by a call
>>    * to rtdm_fd_put().
>> @@ -221,7 +227,7 @@ struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic)
>>   	xnlock_get_irqsave(&fdtree_lock, s);
>>   	fd = fetch_fd(p, ufd);
>>   	if (fd == NULL || (magic != 0 && fd->magic != magic)) {
>> -		fd = ERR_PTR(-EBADF);
>> +		fd = ERR_PTR(-EADV);
>>   		goto out;
>>   	}
>>   
>> @@ -405,7 +411,7 @@ static struct rtdm_fd *get_fd_fixup_mode(int ufd)
>>   {
>>   	struct xnthread *thread;
>>   	struct rtdm_fd *fd;
>> -	
>> +
>>   	fd = rtdm_fd_get(ufd, 0);
>>   	if (IS_ERR(fd))
>>   		return fd;
>> @@ -470,7 +476,7 @@ int rtdm_fd_ioctl(int ufd, unsigned int request, ...)
>>   
>>   	if (err < 0) {
>>   		ret = __rtdm_dev_ioctl_core(fd, request, arg);
>> -		if (ret != -ENOSYS)
>> +		if (ret != -EADV)
>>   			err = ret;
>>   	}
>>   
>> @@ -814,13 +820,13 @@ int rtdm_fd_close(int ufd, unsigned int magic)
>>   	xnlock_get_irqsave(&fdtree_lock, s);
>>   	idx = fetch_fd_index(ppd, ufd);
>>   	if (idx == NULL)
>> -		goto ebadf;
>> +		goto eadv;
>>   
>>   	fd = idx->fd;
>>   	if (magic != 0 && fd->magic != magic) {
>> -ebadf:
>> +eadv:
>>   		xnlock_put_irqrestore(&fdtree_lock, s);
>> -		return -EBADF;
>> +		return -EADV;
>>   	}
>>   
>>   	set_compat_bit(fd);
>> @@ -860,7 +866,7 @@ int rtdm_fd_mmap(int ufd, struct _rtdm_mmap_request *rma,
>>   	trace_cobalt_fd_mmap(current, fd, ufd, rma);
>>   
>>   	if (rma->flags & (MAP_FIXED|MAP_ANONYMOUS)) {
>> -		ret = -ENODEV;
>> +		ret = -EADV;
>>   		goto unlock;
>>   	}
>>   
>> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
>> index 176210ddc..2d58b38e6 100644
>> --- a/lib/cobalt/rtdm.c
>> +++ b/lib/cobalt/rtdm.c
>> @@ -57,7 +57,7 @@ static int do_open(const char *path, int oflag, mode_t mode)
>>   	fd = XENOMAI_SYSCALL2( sc_cobalt_open, path, oflag);
>>   	pthread_setcanceltype(oldtype, NULL);
>>   	if (fd < 0) {
>> -		if (fd != -ENODEV && fd != -ENOSYS)
>> +		if (fd != -EADV && fd != -ENOSYS)
>>   			return set_errno(fd);
>>   
>>   		fd = __STD(open(path, oflag, mode));
>> @@ -123,7 +123,7 @@ COBALT_IMPL(int, close, (int fd))
>>   
>>   	pthread_setcanceltype(oldtype, NULL);
>>   
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(close(fd));
>> @@ -154,7 +154,7 @@ COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
>>   
>>   	ret = XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, arg);
>>   
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(fcntl(fd, cmd, arg));
>> @@ -171,7 +171,7 @@ COBALT_IMPL(int, ioctl, (int fd, unsigned int request, ...))
>>   	va_end(ap);
>>   
>>   	ret = do_ioctl(fd, request, arg);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(ioctl(fd, request, arg));
>> @@ -187,7 +187,7 @@ COBALT_IMPL(ssize_t, read, (int fd, void *buf, size_t nbyte))
>>   
>>   	pthread_setcanceltype(oldtype, NULL);
>>   
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(read(fd, buf, nbyte));
>> @@ -203,7 +203,7 @@ COBALT_IMPL(ssize_t, write, (int fd, const void *buf, size_t nbyte))
>>   
>>   	pthread_setcanceltype(oldtype, NULL);
>>   
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(write(fd, buf, nbyte));
>> @@ -227,7 +227,7 @@ COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
>>   	int ret;
>>   
>>   	ret = do_recvmsg(fd, msg, flags);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(recvmsg(fd, msg, flags));
>> @@ -244,7 +244,7 @@ COBALT_IMPL(int, recvmmsg, (int fd, struct mmsghdr *msgvec, unsigned int vlen,
>>   
>>   	pthread_setcanceltype(oldtype, NULL);
>>   
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(recvmmsg(fd, msgvec, vlen, flags, timeout));
>> @@ -268,7 +268,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
>>   	int ret;
>>   
>>   	ret = do_sendmsg(fd, msg, flags);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(sendmsg(fd, msg, flags));
>> @@ -285,7 +285,7 @@ COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
>>   
>>   	pthread_setcanceltype(oldtype, NULL);
>>   
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(sendmmsg(fd, msgvec, vlen, flags));
>> @@ -309,7 +309,7 @@ COBALT_IMPL(ssize_t, recvfrom, (int fd, void *buf, size_t len, int flags,
>>   	int ret;
>>   
>>   	ret = do_recvmsg(fd, &msg, flags);
>> -	if (ret != -EBADF && ret != -ENOSYS) {
>> +	if (ret != -EADV && ret != -ENOSYS) {
>>   		if (ret < 0)
>>   			return set_errno(ret);
>>   
>> @@ -340,7 +340,7 @@ COBALT_IMPL(ssize_t, sendto, (int fd, const void *buf, size_t len, int flags,
>>   	int ret;
>>   
>>   	ret = do_sendmsg(fd, &msg, flags);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(sendto(fd, buf, len, flags, to, tolen));
>> @@ -363,7 +363,7 @@ COBALT_IMPL(ssize_t, recv, (int fd, void *buf, size_t len, int flags))
>>   	int ret;
>>   
>>   	ret = do_recvmsg(fd, &msg, flags);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(recv(fd, buf, len, flags));
>> @@ -386,7 +386,7 @@ COBALT_IMPL(ssize_t, send, (int fd, const void *buf, size_t len, int flags))
>>   	int ret;
>>   
>>   	ret = do_sendmsg(fd, &msg, flags);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(send(fd, buf, len, flags));
>> @@ -399,7 +399,7 @@ COBALT_IMPL(int, getsockopt, (int fd, int level, int optname, void *optval,
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_GETSOCKOPT, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(getsockopt(fd, level, optname, optval, optlen));
>> @@ -414,7 +414,7 @@ COBALT_IMPL(int, setsockopt, (int fd, int level, int optname, const void *optval
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_SETSOCKOPT, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(setsockopt(fd, level, optname, optval, optlen));
>> @@ -426,7 +426,7 @@ COBALT_IMPL(int, bind, (int fd, const struct sockaddr *my_addr, socklen_t addrle
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_BIND, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(bind(fd, my_addr, addrlen));
>> @@ -438,7 +438,7 @@ COBALT_IMPL(int, connect, (int fd, const struct sockaddr *serv_addr, socklen_t a
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_CONNECT, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(connect(fd, serv_addr, addrlen));
>> @@ -449,7 +449,7 @@ COBALT_IMPL(int, listen, (int fd, int backlog))
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_LISTEN, (void *)(long)backlog);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(listen(fd, backlog));
>> @@ -461,7 +461,7 @@ COBALT_IMPL(int, accept, (int fd, struct sockaddr *addr, socklen_t *addrlen))
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_ACCEPT, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(accept(fd, addr, addrlen));
>> @@ -473,7 +473,7 @@ COBALT_IMPL(int, getsockname, (int fd, struct sockaddr *name, socklen_t *namelen
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_GETSOCKNAME, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(getsockname(fd, name, namelen));
>> @@ -485,7 +485,7 @@ COBALT_IMPL(int, getpeername, (int fd, struct sockaddr *name, socklen_t *namelen
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_GETPEERNAME, &args);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(getpeername(fd, name, namelen));
>> @@ -496,7 +496,7 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
>>   	int ret;
>>   
>>   	ret = do_ioctl(fd, _RTIOC_SHUTDOWN, (void *)(long)how);
>> -	if (ret != -EBADF && ret != -ENOSYS)
>> +	if (ret != -EADV && ret != -ENOSYS)
>>   		return set_errno(ret);
>>   
>>   	return __STD(shutdown(fd, how));
>> @@ -518,7 +518,7 @@ COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
>>   	rma.flags = flags;
>>   
>>   	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
>> -	if (ret != -EBADF && ret != -ENOSYS) {
>> +	if (ret != -EADV && ret != -ENOSYS) {
>>   		ret = set_errno(ret);
>>   		if (ret)
>>   			return MAP_FAILED;
>>
> 
> I'm seeing a few more suspicious occurrences of EBADF in the core:
> 
> kernel/cobalt/posix/io.c:191:   return -EBADF;
> kernel/cobalt/posix/io.c:289:                   return -EBADF;
> kernel/cobalt/posix/syscall32.c:742:                    return -EBADF;

We still want to receive -EBADF on wrong fildes appearing in select()
descriptors.

> kernel/cobalt/rtdm/fd.c:213: * - ERR_PTR(-EBADF) if the underlying device is being torned down at

Having -EBADF in this case is precisely the point of the whole change
from -EBADF to -ENODEV from the previous commit, so yes we want this
code to be returned by this code.

> kernel/cobalt/rtdm/fd.c:910: * - -EBADF is returned if the file descriptor @a ufd cannot be resolved.
>

Applies to select(), so this is ok.

> Did you check them? Are some/all related to mqueue and timerfd?

yes, and no.

-- 
Philippe.

