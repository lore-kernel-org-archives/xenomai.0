Subject: Re: [PATCH 2/2] cobalt: switch hand over status to -ENODEV for
 non-RTDM fd
References: <20190620172934.31393-1-rpm@xenomai.org>
 <20190620172934.31393-3-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <79f76c99-54e1-af26-250f-45623057c598@siemens.com>
Date: Thu, 4 Jul 2019 11:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190620172934.31393-3-rpm@xenomai.org>
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
> Having the RTDM core return -EBADF to indicate that it does not manage
> a file descriptor is a problem, as several drivers also raise this
> error to notify userland about an aborted wait due to a connection
> being dismantled (e.g. RTnet). In this case, libcobalt ends up
> forwarding the aborted request to the glibc, which is wrong.
> 
> Switch from -EBADF to -ENODEV to notify userland that RTDM does not
> manage a file descriptor, which cannot conflict with any sensible
> return from active I/O operations. This is also consistent with the
> status RTDM currently returns to notify that it cannot handle a device
> open request.
> ---
>   kernel/cobalt/rtdm/fd.c |  7 ++++---
>   lib/cobalt/rtdm.c       | 46 ++++++++++++++++++++---------------------
>   2 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
> index f3b6444c3..75c4acf28 100644
> --- a/kernel/cobalt/rtdm/fd.c
> +++ b/kernel/cobalt/rtdm/fd.c
> @@ -204,8 +204,9 @@ int rtdm_fd_register(struct rtdm_fd *fd, int ufd)
>    * @param[in] ufd User-side file descriptor
>    * @param[in] magic Magic word for lookup validation
>    *
> - * @return Pointer to the RTDM file descriptor matching @a ufd, or
> - * ERR_PTR(-EBADF).
> + * @return Pointer to the RTDM file descriptor matching @a
> + * ufd. Otherwise ERR_PTR(-ENODEV) is returned if the use-space handle
> + * is either invalid or not managed by RTDM.
>    *
>    * @note The file descriptor returned must be later released by a call
>    * to rtdm_fd_put().
> @@ -221,7 +222,7 @@ struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic)
>   	xnlock_get_irqsave(&fdtree_lock, s);
>   	fd = fetch_fd(p, ufd);
>   	if (fd == NULL || (magic != 0 && fd->magic != magic)) {
> -		fd = ERR_PTR(-EBADF);
> +		fd = ERR_PTR(-ENODEV);
>   		goto out;
>   	}
>   
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 176210ddc..506302d26 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -123,7 +123,7 @@ COBALT_IMPL(int, close, (int fd))
>   
>   	pthread_setcanceltype(oldtype, NULL);
>   
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(close(fd));
> @@ -154,7 +154,7 @@ COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
>   
>   	ret = XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, arg);
>   
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(fcntl(fd, cmd, arg));
> @@ -171,7 +171,7 @@ COBALT_IMPL(int, ioctl, (int fd, unsigned int request, ...))
>   	va_end(ap);
>   
>   	ret = do_ioctl(fd, request, arg);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(ioctl(fd, request, arg));
> @@ -187,7 +187,7 @@ COBALT_IMPL(ssize_t, read, (int fd, void *buf, size_t nbyte))
>   
>   	pthread_setcanceltype(oldtype, NULL);
>   
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(read(fd, buf, nbyte));
> @@ -203,7 +203,7 @@ COBALT_IMPL(ssize_t, write, (int fd, const void *buf, size_t nbyte))
>   
>   	pthread_setcanceltype(oldtype, NULL);
>   
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(write(fd, buf, nbyte));
> @@ -227,7 +227,7 @@ COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
>   	int ret;
>   
>   	ret = do_recvmsg(fd, msg, flags);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(recvmsg(fd, msg, flags));
> @@ -244,7 +244,7 @@ COBALT_IMPL(int, recvmmsg, (int fd, struct mmsghdr *msgvec, unsigned int vlen,
>   
>   	pthread_setcanceltype(oldtype, NULL);
>   
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(recvmmsg(fd, msgvec, vlen, flags, timeout));
> @@ -268,7 +268,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
>   	int ret;
>   
>   	ret = do_sendmsg(fd, msg, flags);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(sendmsg(fd, msg, flags));
> @@ -285,7 +285,7 @@ COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
>   
>   	pthread_setcanceltype(oldtype, NULL);
>   
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(sendmmsg(fd, msgvec, vlen, flags));
> @@ -309,7 +309,7 @@ COBALT_IMPL(ssize_t, recvfrom, (int fd, void *buf, size_t len, int flags,
>   	int ret;
>   
>   	ret = do_recvmsg(fd, &msg, flags);
> -	if (ret != -EBADF && ret != -ENOSYS) {
> +	if (ret != -ENODEV && ret != -ENOSYS) {
>   		if (ret < 0)
>   			return set_errno(ret);
>   
> @@ -340,7 +340,7 @@ COBALT_IMPL(ssize_t, sendto, (int fd, const void *buf, size_t len, int flags,
>   	int ret;
>   
>   	ret = do_sendmsg(fd, &msg, flags);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(sendto(fd, buf, len, flags, to, tolen));
> @@ -363,7 +363,7 @@ COBALT_IMPL(ssize_t, recv, (int fd, void *buf, size_t len, int flags))
>   	int ret;
>   
>   	ret = do_recvmsg(fd, &msg, flags);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(recv(fd, buf, len, flags));
> @@ -386,7 +386,7 @@ COBALT_IMPL(ssize_t, send, (int fd, const void *buf, size_t len, int flags))
>   	int ret;
>   
>   	ret = do_sendmsg(fd, &msg, flags);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(send(fd, buf, len, flags));
> @@ -399,7 +399,7 @@ COBALT_IMPL(int, getsockopt, (int fd, int level, int optname, void *optval,
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_GETSOCKOPT, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(getsockopt(fd, level, optname, optval, optlen));
> @@ -414,7 +414,7 @@ COBALT_IMPL(int, setsockopt, (int fd, int level, int optname, const void *optval
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_SETSOCKOPT, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(setsockopt(fd, level, optname, optval, optlen));
> @@ -426,7 +426,7 @@ COBALT_IMPL(int, bind, (int fd, const struct sockaddr *my_addr, socklen_t addrle
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_BIND, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(bind(fd, my_addr, addrlen));
> @@ -438,7 +438,7 @@ COBALT_IMPL(int, connect, (int fd, const struct sockaddr *serv_addr, socklen_t a
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_CONNECT, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(connect(fd, serv_addr, addrlen));
> @@ -449,7 +449,7 @@ COBALT_IMPL(int, listen, (int fd, int backlog))
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_LISTEN, (void *)(long)backlog);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(listen(fd, backlog));
> @@ -461,7 +461,7 @@ COBALT_IMPL(int, accept, (int fd, struct sockaddr *addr, socklen_t *addrlen))
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_ACCEPT, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(accept(fd, addr, addrlen));
> @@ -473,7 +473,7 @@ COBALT_IMPL(int, getsockname, (int fd, struct sockaddr *name, socklen_t *namelen
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_GETSOCKNAME, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(getsockname(fd, name, namelen));
> @@ -485,7 +485,7 @@ COBALT_IMPL(int, getpeername, (int fd, struct sockaddr *name, socklen_t *namelen
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_GETPEERNAME, &args);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(getpeername(fd, name, namelen));
> @@ -496,7 +496,7 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
>   	int ret;
>   
>   	ret = do_ioctl(fd, _RTIOC_SHUTDOWN, (void *)(long)how);
> -	if (ret != -EBADF && ret != -ENOSYS)
> +	if (ret != -ENODEV && ret != -ENOSYS)
>   		return set_errno(ret);
>   
>   	return __STD(shutdown(fd, how));
> @@ -518,7 +518,7 @@ COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
>   	rma.flags = flags;
>   
>   	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
> -	if (ret != -EBADF && ret != -ENOSYS) {
> +	if (ret != -ENODEV && ret != -ENOSYS) {
>   		ret = set_errno(ret);
>   		if (ret)
>   			return MAP_FAILED;
> 

Looks reasonable, just wondering if we didn't run into other cases where ENODEV 
is returned by the driver already. I would suggest using some uncommon error 
code instead.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

