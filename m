Message-ID: <5016DF4D.2030708@xenomai.org>
Date: Mon, 30 Jul 2012 21:23:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAvA3H80xn1UcLPASUwu1L3RqEceJiXWQBuGXs=LfAQmDTDq=g@mail.gmail.com>
In-Reply-To: <CAAvA3H80xn1UcLPASUwu1L3RqEceJiXWQBuGXs=LfAQmDTDq=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __rtdm_muxid symbol multipy defined in static libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Weber <jwamsc@gmail.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On 07/30/2012 09:17 PM, Jeff Weber wrote:

> When I attempt to statically link my application, the linker complains the
> symbol
> __rtdm_muxid is multiply defined.:
> 
> c++  -o myapp myobjects  mylibs -static -lsqlite3 -lrtdm -L/usr/xenomai/lib
> -lpthread_rt -lxenomai -lpthread -lrt -ldl
> /usr/xenomai/lib/libpthread_rt.a(libpthread_rt_la-init.o):(.data+0x4):
> multiple definition of `__rtdm_muxid'
> /usr/xenomai/lib/librtdm.a(librtdm_la-init.o):(.data+0x0): first defined
> here
> 
> (I have pre-linked a subset of object files with the posix.wrappers script
> so I can control which application posix calls
> bind to the Xenomai __wrap_ calls.)


You can use the scripts/wrap-link.sh to automate this task
When using it, everything passed on its command line after -lpthread_rt 
is not wrapped.

> 
> Use of "nm" shows what the linker is complaining about:
> 
>  # nm --defined -o /usr/xenomai/lib/*.a | grep __rtdm_muxid
> /usr/xenomai/lib/libpthread_rt.a:libpthread_rt_la-init.o:00000004 D
> __rtdm_muxid
> /usr/xenomai/lib/librtdm.a:librtdm_la-init.o:00000000 D __rtdm_muxid
> 
> I have no link errors when dynamically linking my application.
> 
> Am I statically linking incorrectly, or is this a bug?


It is a bug. Try the following (untested) patch.

diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
index 7a338a0..332081a 100644
--- a/src/skins/posix/init.c
+++ b/src/skins/posix/init.c
@@ -33,8 +33,8 @@
 #include <asm/xenomai/bits/bind.h>
 
 int __pse51_muxid = -1;
-int __rtdm_muxid = -1;
-int __rtdm_fd_start = INT_MAX;
+int __pse51_rtdm_muxid = -1;
+int __pse51_rtdm_fd_start = INT_MAX;
 static int fork_handler_registered;
 
 int __wrap_pthread_setschedparam(pthread_t, int, const struct sched_param *);
@@ -63,8 +63,8 @@ void __init_posix_interface(void)
 	muxid = XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, NULL);
 	if (muxid > 0) {
-		__rtdm_muxid = __xn_mux_shifted_id(muxid);
-		__rtdm_fd_start = FD_SETSIZE - XENOMAI_SKINCALL0(__rtdm_muxid,
+		__pse51_rtdm_muxid = __xn_mux_shifted_id(muxid);
+		__pse51_rtdm_fd_start = FD_SETSIZE - XENOMAI_SKINCALL0(__pse51_rtdm_muxid,
 								 __rtdm_fdcount);
 	}
 
diff --git a/src/skins/posix/rtdm.c b/src/skins/posix/rtdm.c
index d944a03..aa23737 100644
--- a/src/skins/posix/rtdm.c
+++ b/src/skins/posix/rtdm.c
@@ -27,8 +27,8 @@
 #include <rtdm/rtdm.h>
 #include <rtdm/syscall.h>
 
-extern int __rtdm_muxid;
-extern int __rtdm_fd_start;
+extern int __pse51_rtdm_muxid;
+extern int __pse51_rtdm_fd_start;
 
 static inline int set_errno(int ret)
 {
@@ -50,12 +50,12 @@ int __wrap_open(const char *path, int oflag, ...)
 	if (strncmp(path, "/dev/", 5) == 0)
 		rtdm_path += 5;
 
-	ret = XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_open, rtdm_path, oflag);
+	ret = XENOMAI_SKINCALL2(__pse51_rtdm_muxid, __rtdm_open, rtdm_path, oflag);
 
 	pthread_setcanceltype(oldtype, NULL);
 
 	if (ret >= 0)
-		ret += __rtdm_fd_start;
+		ret += __pse51_rtdm_fd_start;
 	else if (ret == -ENODEV || ret == -ENOSYS) {
 		va_list ap;
 
@@ -65,7 +65,7 @@ int __wrap_open(const char *path, int oflag, ...)
 
 		va_end(ap);
 
-		if (ret >= __rtdm_fd_start) {
+		if (ret >= __pse51_rtdm_fd_start) {
 			__real_close(ret);
 			errno = EMFILE;
 			ret = -1;
@@ -82,15 +82,15 @@ int __wrap_socket(int protocol_family, int socket_type, int protocol)
 {
 	int ret;
 
-	ret = XENOMAI_SKINCALL3(__rtdm_muxid,
+	ret = XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 				__rtdm_socket,
 				protocol_family, socket_type, protocol);
 	if (ret >= 0)
-		ret += __rtdm_fd_start;
+		ret += __pse51_rtdm_fd_start;
 	else if (ret == -EAFNOSUPPORT || ret == -ENOSYS) {
 		ret = __real_socket(protocol_family, socket_type, protocol);
 
-		if (ret >= __rtdm_fd_start) {
+		if (ret >= __pse51_rtdm_fd_start) {
 			__real_close(ret);
 			errno = -EMFILE;
 			ret = -1;
@@ -108,14 +108,14 @@ int __wrap_close(int fd)
 	extern int __shm_close(int fd);
 	int ret;
 
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		int oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL1(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL1(__pse51_rtdm_muxid,
 						  __rtdm_close,
-						  fd - __rtdm_fd_start));
+						  fd - __pse51_rtdm_fd_start));
 
 		pthread_setcanceltype(oldtype, NULL);
 
@@ -138,10 +138,10 @@ int __wrap_ioctl(int fd, unsigned long int request, ...)
 	arg = va_arg(ap, void *);
 	va_end(ap);
 
-	if (fd >= __rtdm_fd_start)
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+	if (fd >= __pse51_rtdm_fd_start)
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   request, arg));
 	else
 		return __real_ioctl(fd, request, arg);
@@ -149,14 +149,14 @@ int __wrap_ioctl(int fd, unsigned long int request, ...)
 
 ssize_t __wrap_read(int fd, void *buf, size_t nbyte)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_read,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  buf, nbyte));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -168,14 +168,14 @@ ssize_t __wrap_read(int fd, void *buf, size_t nbyte)
 
 ssize_t __wrap_write(int fd, const void *buf, size_t nbyte)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_write,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  buf, nbyte));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -187,14 +187,14 @@ ssize_t __wrap_write(int fd, const void *buf, size_t nbyte)
 
 ssize_t __wrap_recvmsg(int fd, struct msghdr * msg, int flags)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_recvmsg,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  msg, flags));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -206,14 +206,14 @@ ssize_t __wrap_recvmsg(int fd, struct msghdr * msg, int flags)
 
 ssize_t __wrap_sendmsg(int fd, const struct msghdr * msg, int flags)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_sendmsg,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  msg, flags));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -226,7 +226,7 @@ ssize_t __wrap_sendmsg(int fd, const struct msghdr * msg, int flags)
 ssize_t __wrap_recvfrom(int fd, void *buf, size_t len, int flags,
 			struct sockaddr * from, socklen_t * fromlen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct iovec iov = { buf, len };
 		struct msghdr msg =
 		    { from, (from != NULL) ? *fromlen : 0, &iov, 1, NULL, 0 };
@@ -234,9 +234,9 @@ ssize_t __wrap_recvfrom(int fd, void *buf, size_t len, int flags,
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 					__rtdm_recvmsg,
-					fd - __rtdm_fd_start, &msg, flags);
+					fd - __pse51_rtdm_fd_start, &msg, flags);
 
 		pthread_setcanceltype(oldtype, NULL);
 
@@ -253,7 +253,7 @@ ssize_t __wrap_recvfrom(int fd, void *buf, size_t len, int flags,
 ssize_t __wrap_sendto(int fd, const void *buf, size_t len, int flags,
 		      const struct sockaddr * to, socklen_t tolen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct iovec iov = { (void *)buf, len };
 		struct msghdr msg =
 		    { (struct sockaddr *)to, tolen, &iov, 1, NULL, 0 };
@@ -261,9 +261,9 @@ ssize_t __wrap_sendto(int fd, const void *buf, size_t len, int flags,
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_sendmsg,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  &msg, flags));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -275,16 +275,16 @@ ssize_t __wrap_sendto(int fd, const void *buf, size_t len, int flags,
 
 ssize_t __wrap_recv(int fd, void *buf, size_t len, int flags)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct iovec iov = { buf, len };
 		struct msghdr msg = { NULL, 0, &iov, 1, NULL, 0 };
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_recvmsg,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  &msg, flags));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -296,16 +296,16 @@ ssize_t __wrap_recv(int fd, void *buf, size_t len, int flags)
 
 ssize_t __wrap_send(int fd, const void *buf, size_t len, int flags)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct iovec iov = { (void *)buf, len };
 		struct msghdr msg = { NULL, 0, &iov, 1, NULL, 0 };
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_sendmsg,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  &msg, flags));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -318,13 +318,13 @@ ssize_t __wrap_send(int fd, const void *buf, size_t len, int flags)
 int __wrap_getsockopt(int fd, int level, int optname, void *optval,
 		      socklen_t * optlen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_getsockopt_args args =
 		    { level, optname, optval, optlen };
 
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_GETSOCKOPT, &args));
 	} else
 		return __real_getsockopt(fd, level, optname, optval, optlen);
@@ -333,13 +333,13 @@ int __wrap_getsockopt(int fd, int level, int optname, void *optval,
 int __wrap_setsockopt(int fd, int level, int optname, const void *optval,
 		      socklen_t optlen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_setsockopt_args args =
 		    { level, optname, (void *)optval, optlen };
 
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_SETSOCKOPT, &args));
 	} else
 		return __real_setsockopt(fd, level, optname, optval, optlen);
@@ -347,12 +347,12 @@ int __wrap_setsockopt(int fd, int level, int optname, const void *optval,
 
 int __wrap_bind(int fd, const struct sockaddr *my_addr, socklen_t addrlen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_setsockaddr_args args = { my_addr, addrlen };
 
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_BIND, &args));
 	} else
 		return __real_bind(fd, my_addr, addrlen);
@@ -360,15 +360,15 @@ int __wrap_bind(int fd, const struct sockaddr *my_addr, socklen_t addrlen)
 
 int __wrap_connect(int fd, const struct sockaddr *serv_addr, socklen_t addrlen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_setsockaddr_args args = { serv_addr, addrlen };
 		int ret, oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						  __rtdm_ioctl,
-						  fd - __rtdm_fd_start,
+						  fd - __pse51_rtdm_fd_start,
 						  _RTIOC_CONNECT, &args));
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -380,10 +380,10 @@ int __wrap_connect(int fd, const struct sockaddr *serv_addr, socklen_t addrlen)
 
 int __wrap_listen(int fd, int backlog)
 {
-	if (fd >= __rtdm_fd_start) {
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+	if (fd >= __pse51_rtdm_fd_start) {
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_LISTEN, backlog));
 	} else
 		return __real_listen(fd, backlog);
@@ -391,15 +391,15 @@ int __wrap_listen(int fd, int backlog)
 
 int __wrap_accept(int fd, struct sockaddr *addr, socklen_t * addrlen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_getsockaddr_args args = { addr, addrlen };
 		int oldtype;
 
 		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		fd = XENOMAI_SKINCALL3(__rtdm_muxid,
+		fd = XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 				       __rtdm_ioctl,
-				       fd - __rtdm_fd_start,
+				       fd - __pse51_rtdm_fd_start,
 				       _RTIOC_ACCEPT, &args);
 
 		pthread_setcanceltype(oldtype, NULL);
@@ -407,11 +407,11 @@ int __wrap_accept(int fd, struct sockaddr *addr, socklen_t * addrlen)
 		if (fd < 0)
 			return set_errno(fd);
 
-		return fd + __rtdm_fd_start;
+		return fd + __pse51_rtdm_fd_start;
 	} else {
 		fd = __real_accept(fd, addr, addrlen);
 
-		if (fd >= __rtdm_fd_start) {
+		if (fd >= __pse51_rtdm_fd_start) {
 			__real_close(fd);
 			errno = EMFILE;
 			fd = -1;
@@ -423,12 +423,12 @@ int __wrap_accept(int fd, struct sockaddr *addr, socklen_t * addrlen)
 
 int __wrap_getsockname(int fd, struct sockaddr *name, socklen_t * namelen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_getsockaddr_args args = { name, namelen };
 
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_GETSOCKNAME, &args));
 	} else
 		return __real_getsockname(fd, name, namelen);
@@ -436,12 +436,12 @@ int __wrap_getsockname(int fd, struct sockaddr *name, socklen_t * namelen)
 
 int __wrap_getpeername(int fd, struct sockaddr *name, socklen_t * namelen)
 {
-	if (fd >= __rtdm_fd_start) {
+	if (fd >= __pse51_rtdm_fd_start) {
 		struct _rtdm_getsockaddr_args args = { name, namelen };
 
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_GETPEERNAME, &args));
 	} else
 		return __real_getpeername(fd, name, namelen);
@@ -449,10 +449,10 @@ int __wrap_getpeername(int fd, struct sockaddr *name, socklen_t * namelen)
 
 int __wrap_shutdown(int fd, int how)
 {
-	if (fd >= __rtdm_fd_start) {
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
+	if (fd >= __pse51_rtdm_fd_start) {
+		return set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
 						   __rtdm_ioctl,
-						   fd - __rtdm_fd_start,
+						   fd - __pse51_rtdm_fd_start,
 						   _RTIOC_SHUTDOWN, how));
 	} else
 		return __real_shutdown(fd, how);


-- 
                                                                Gilles.

