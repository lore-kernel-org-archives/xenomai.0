Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B099212B39
	for <xenomai@lists.linux.dev>; Fri,  7 Mar 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343547; cv=none; b=HM9OwhHVjpTzlWg9YdMvgFWXcUmpOJSbzwkpJF4ALRFocijFGOMEO4sszJml85zjw/SWMtyZfFsQYSii6ciJ5HNFrTvwibfI5k9VljKgWRrDzTi14KcA8Ny2aKjJ7sjXvaCDjdBkq7IYLrY/ounbFP3+tOkV0h2Sw2PB6P91NXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343547; c=relaxed/simple;
	bh=44OsP4JUsjrwf50hz3s5+hl3owOX8rkPDrNpWfjtxiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwHVThGs3WTfZzCN57IYzMT2UAxdPFxritHeN6HJrvdhgEWKhu7ml2Q4c79ik6NzisMjrTtX3u4BK8DmZrdHr7P1QlCEGFnYZPkdiakFhgKre74D9VUlu58Rio/+815CTxW6TE/40hOBsWqNHo3iCDsZW3RWfc9d3dvUggv/G0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lBCQHu27; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lBCQHu27"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250307102205459891b460f8dcc047
        for <xenomai@lists.linux.dev>;
        Fri, 07 Mar 2025 11:22:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZmxVJEjwaqhGc4dpq7c2FVt+HJJ3zdzCRvyiGd7s12E=;
 b=lBCQHu27gsBp8vOJDbbAue3fZbBJhWjQQlqruE4hcpSI1EZmLW0fI8inBqYjw0EubeUQnk
 nk1ClaQ2GwWgwJkEXKNgBI5KdrmBILSmrZhQ/Y7O8T3GK5jd+30Y9hw8xe7cXi4+V+l8v69S
 QIQDQyTo7inyLUHBPq4rKXxmwm7ItpDQrX8cwolPeAIyFVDYiO2tqUdkboenYpkPgo3OhvTh
 qm2OnkRudhArWuvjlGMcTH/UFNWEMpVEm0zjHY70TuX79HbqHlPwsDjT0HhfFyF3k44S/PHr
 aFSGFDWiAfnxnICv4h4Zm5WlZYwg8ghH2QUD722TOJHc53WwjBllYAvg==;
Message-ID: <3b438093ceac42b69406096b67cedead001a0278.camel@siemens.com>
Subject: Re: [PATCH] kernel/cobalt/posix: Stop supporting timeout parameter
 in recvmmsg
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 07 Mar 2025 11:22:04 +0100
In-Reply-To: <92300bd0-456f-4b11-93ef-5fb76be02edd@siemens.com>
References: <92300bd0-456f-4b11-93ef-5fb76be02edd@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2025-03-04 at 15:33 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> It turned out that trying to put a timer-based timeout on top of the
> loop that calls recvmsg_rt multiple times is broken in an almost
> unfixable way.
>=20
> First of all, timing out by setting XNTIMEO and resuming the waiter
> (=3Dcaller of recvmmsg) races with entering and leaving the blocking
> state inside the respective driver. When the timer fires while the
> thread is not inside xnthread_suspend, the condition is lost, and we may
> even enter infinite blocking later on. This was observed in qemu setups
> with overloaded hosts, but it could also happen in proper deployment if
> the caller of recvmmsg is interrupted before suspending.
>=20
> Second, the driver has no idea about the outer timeout and will
> therefore happily use its own per-socket timeout in addition when set.
> That can lead to unexpected results for the caller. Unfortunately, there
> is no standard way in RTDM to control the socket timeout, not to speak
> of an efficient one.
>=20
> Finally, it would need an interface change in RTDM to collaborate with
> drivers for implementing the out timeout without races and without
> interference by the socket timeout. This appears not worth the effort.
>=20
> Given that the socket timeout can still be used in place of the recvmmsg
> timeout, though not with identical semantics, we avoid complex
> refactoring in favor of discontinuing the timeout feature. Programs that
> continue to pass non-NULL timeout values will receive an error from now
> on.
>=20
> As this obsoletes (and breaks) functional testing of the timeout via
> recvmmsg64, drop the related test case.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> This is for next right now. I still haven't made up my mind how to deal=
=20
> best with stable (3.1..3.3). Removing the feature would break the ABI,=
=20
> but keeping it allows people to run into the race, even if only rarely.=
=20
> An option could be to disable the feature by default in Kconfig,=20
> allowing users to re-enable it while (hopefully) reading the related=20
> warning.
>=20
>  include/cobalt/kernel/rtdm/fd.h        |   3 +-
>  kernel/cobalt/posix/io.c               |   8 +-
>  kernel/cobalt/posix/syscall32.c        |   9 +-
>  kernel/cobalt/rtdm/fd.c                |  66 ++-----------
>  testsuite/smokey/y2038/syscall-tests.c | 129 -------------------------
>  5 files changed, 11 insertions(+), 204 deletions(-)
>=20
> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm=
/fd.h
> index 176c67e223..5226979286 100644
> --- a/include/cobalt/kernel/rtdm/fd.h
> +++ b/include/cobalt/kernel/rtdm/fd.h
> @@ -381,8 +381,7 @@ ssize_t rtdm_fd_recvmsg(int ufd, struct user_msghdr *=
msg, int flags);
>  int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen=
,
>  		       unsigned int flags, void __user *u_timeout,
>  		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
> -		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *m=
msg),
> -		       int (*get_timespec)(struct timespec64 *ts, const void __user *u=
_ts));
> +		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *m=
msg));
> =20
>  int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vl=
en,
>  			 unsigned int flags, void __user *u_timeout,
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index 4e20ca19d6..3a14575ad4 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -95,12 +95,6 @@ COBALT_SYSCALL(recvmsg, handover,
>  	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
>  }
> =20
> -static int get_timespec(struct timespec64 *ts,
> -			const void __user *u_ts)
> -{
> -	return cobalt_get_old_timespec(ts, u_ts);
> -}
> -
>  static int get_mmsg(struct mmsghdr *mmsg, void __user *u_mmsg)
>  {
>  	return cobalt_copy_from_user(mmsg, u_mmsg, sizeof(*mmsg));
> @@ -119,7 +113,7 @@ COBALT_SYSCALL(recvmmsg, primary,
>  		unsigned int flags, struct __kernel_old_timespec __user *u_timeout))
>  {
>  	return __rtdm_fd_recvmmsg(fd, u_msgvec, vlen, flags, u_timeout,
> -				  get_mmsg, put_mmsg, get_timespec);
> +				  get_mmsg, put_mmsg);
>  }
> =20
>  COBALT_SYSCALL(recvmmsg64, primary,
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscal=
l32.c
> index 484f059844..bddc29e7c4 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -552,12 +552,6 @@ COBALT_SYSCALL32emu(recvmsg, handover,
>  	return sys32_put_msghdr(umsg, &m) ?: ret;
>  }
> =20
> -static int get_timespec32(struct timespec64 *ts,
> -			  const void __user *u_ts)
> -{
> -	return sys32_get_timespec(ts, u_ts);
> -}
> -
>  static int get_mmsg32(struct mmsghdr *mmsg, void __user *u_mmsg)
>  {
>  	return sys32_get_mmsghdr(mmsg, u_mmsg);
> @@ -576,8 +570,7 @@ COBALT_SYSCALL32emu(recvmmsg, primary,
>  		unsigned int flags, struct old_timespec32 *u_timeout))
>  {
>  	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
> -				  get_mmsg32, put_mmsg32,
> -				  get_timespec32);
> +				  get_mmsg32, put_mmsg32);
>  }
> =20
>  COBALT_SYSCALL32emu(recvmmsg64, primary,
> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
> index d5813a16c2..5a771cc455 100644
> --- a/kernel/cobalt/rtdm/fd.c
> +++ b/kernel/cobalt/rtdm/fd.c
> @@ -641,36 +641,16 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(rtdm_fd_recvmsg);
> =20
> -struct cobalt_recvmmsg_timer {
> -	struct xntimer timer;
> -	struct xnthread *waiter;
> -};
> -
> -static void recvmmsg_timeout_handler(struct xntimer *timer)
> -{
> -	struct cobalt_recvmmsg_timer *rq;
> -
> -	rq =3D container_of(timer, struct cobalt_recvmmsg_timer, timer);
> -	xnthread_set_info(rq->waiter, XNTIMEO);
> -	xnthread_resume(rq->waiter, XNDELAY);
> -}
> -
>  int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen=
,
>  		       unsigned int flags, void __user *u_timeout,
>  		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
> -		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *m=
msg),
> -		       int (*get_timespec)(struct timespec64 *ts, const void __user *u=
_ts))
> +		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *m=
msg))
>  {
> -	struct cobalt_recvmmsg_timer rq;
> -	xntmode_t tmode =3D XN_RELATIVE;
> -	struct timespec64 ts =3D { 0 };
>  	int ret =3D 0, datagrams =3D 0;
> -	xnticks_t timeout =3D 0;
>  	struct mmsghdr mmsg;
>  	struct rtdm_fd *fd;
>  	void __user *u_p;
>  	ssize_t len;
> -	spl_t s;
> =20
>  	fd =3D rtdm_fd_get(ufd, 0);
>  	if (IS_ERR(fd)) {
> @@ -683,30 +663,12 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgv=
ec, unsigned int vlen,
>  	trace_cobalt_fd_recvmmsg(current, fd, ufd, flags);
> =20
>  	if (u_timeout) {
> -		ret =3D get_timespec(&ts, u_timeout);
> -		if (ret)
> -			goto fail;
> -
> -		if (!timespec64_valid(&ts)) {
> -			ret =3D -EINVAL;
> -			goto fail;
> -		}
> -
> -		tmode =3D XN_ABSOLUTE;
> -		timeout =3D ts2ns(&ts);
> -		if (timeout =3D=3D 0)
> -			flags |=3D MSG_DONTWAIT;
> -		else {
> -			timeout +=3D xnclock_read_monotonic(&nkclock);
> -			rq.waiter =3D xnthread_current();
> -			xntimer_init(&rq.timer, &nkclock,
> -				     recvmmsg_timeout_handler,
> -				     NULL, XNTIMER_IGRAVITY);
> -			xnlock_get_irqsave(&nklock, s);
> -			ret =3D xntimer_start(&rq.timer, timeout,
> -					    XN_INFINITE, tmode);
> -			xnlock_put_irqrestore(&nklock, s);
> -		}
> +		/*
> +		 * The timeout parameter is not supported.
> +		 * Use recvmsg timeouts instead.
> +		 */
> +		ret =3D -EINVAL;
> +		goto fail;
>  	}
> =20
>  	if (fd->oflags & O_NONBLOCK)
> @@ -733,12 +695,6 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgve=
c, unsigned int vlen,
>  			flags |=3D MSG_DONTWAIT;
>  	}
> =20
> -	if (timeout) {
> -		xnlock_get_irqsave(&nklock, s);
> -		xntimer_destroy(&rq.timer);
> -		xnlock_put_irqrestore(&nklock, s);
> -	}
> -
>  fail:
>  	rtdm_fd_put(fd);
> =20
> @@ -751,12 +707,6 @@ out:
>  	return ret;
>  }
> =20
> -static inline int __rtdm_fetch_timeout64(struct timespec64 *ts,
> -					 const void __user *u_ts)
> -{
> -	return u_ts =3D=3D NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
> -}
> -
>  int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vl=
en,
>  			 unsigned int flags, void __user *u_timeout,
>  			 int (*get_mmsg)(struct mmsghdr *mmsg,
> @@ -765,7 +715,7 @@ int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgv=
ec, unsigned int vlen,
>  					 const struct mmsghdr *mmsg))
>  {
>  	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
> -				  get_mmsg, put_mmsg, __rtdm_fetch_timeout64);
> +				  get_mmsg, put_mmsg);
>  }
> =20
> =20
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2=
038/syscall-tests.c
> index b614d3ba07..237549b7aa 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -970,131 +970,6 @@ static int test_sc_cobalt_event_wait64(void)
>  	return 0;
>  }
> =20
> -static int test_sc_cobalt_recvmmsg64(void)
> -{
> -	int sc_nr =3D sc_cobalt_recvmmsg64;
> -	struct rtipc_port_label plabel;
> -	struct xn_timespec64 t1, t2;
> -	struct sockaddr_ipc saddr;
> -	struct timespec ts_nat;
> -	int ret =3D 0;
> -	long data;
> -	int sock;
> -
> -	struct iovec iov =3D {
> -		.iov_base =3D &data,
> -		.iov_len =3D sizeof(data),
> -	};
> -	struct msghdr msg =3D {
> -		.msg_name =3D NULL,
> -		.msg_namelen =3D 0,
> -		.msg_iov =3D &iov,
> -		.msg_iovlen =3D 1,
> -		.msg_control =3D NULL,
> -		.msg_controllen =3D 0,
> -	};
> -
> -	sock =3D smokey_check_errno(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP)=
);
> -	if (sock =3D=3D -EAFNOSUPPORT) {
> -		smokey_note("recvmmsg64: skipped. (no kernel support)");
> -		return 0;
> -	}
> -	if (sock < 0)
> -		return sock;
> -
> -	strcpy(plabel.label, "y2038:recvmmsg64");
> -	ret =3D smokey_check_errno(setsockopt(sock, SOL_XDDP, XDDP_LABEL, &plab=
el,
> -					    sizeof(plabel)));
> -	if (ret)
> -		goto out;
> -
> -	memset(&saddr, 0, sizeof(saddr));
> -	saddr.sipc_family =3D AF_RTIPC;
> -	saddr.sipc_port =3D -1;
> -	ret =3D smokey_check_errno(bind(sock, (struct sockaddr *)&saddr,
> -				      sizeof(saddr)));
> -	if (ret)
> -		goto out;
> -
> -	/* Make sure we don't crash because of NULL pointers */
> -	ret =3D XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
> -	if (ret =3D=3D -ENOSYS) {
> -		smokey_note("recvmmsg64: skipped. (no kernel support)");
> -		goto out; // Not implemented, nothing to test, success
> -	}
> -	if (!smokey_assert(ret =3D=3D -EADV)) {
> -		ret =3D ret ? ret : -EINVAL;
> -		goto out;
> -	}
> -
> -	/* Providing an invalid address has to deliver EFAULT */
> -	ret =3D XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0,
> -			       (void *)0xdeadbeefUL);
> -	if (!smokey_assert(ret =3D=3D -EFAULT)) {
> -		ret =3D ret ? ret : -EINVAL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * providing an invalid timeout has to deliver EINVAL
> -	 */
> -	t1.tv_sec =3D -1;
> -	ret =3D XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
> -	if (!smokey_assert(ret =3D=3D -EINVAL)) {
> -		ret =3D ret ? ret : -EINVAL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * providing a zero timeout,
> -	 * should come back immediately with EWOULDBLOCK
> -	 */
> -	t1.tv_sec =3D 0;
> -	t1.tv_nsec =3D 0;
> -	ret =3D XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
> -	if (!smokey_assert(ret =3D=3D -EWOULDBLOCK)) {
> -		ret =3D ret ? ret : -EINVAL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Providing a valid timeout, waiting for it to time out and check
> -	 * that we didn't come back to early.
> -	 */
> -	ret =3D smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
> -	if (ret)
> -		goto out;
> -
> -	t1.tv_sec =3D 0;
> -	t1.tv_nsec =3D 500000;
> -
> -	ret =3D XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
> -	if (!smokey_assert(ret =3D=3D -ETIMEDOUT)) {
> -		ret =3D ret ? ret : -EINVAL;
> -		goto out;
> -	}
> -
> -	t1.tv_sec =3D ts_nat.tv_sec;
> -	t1.tv_nsec =3D ts_nat.tv_nsec;
> -
> -	ret =3D smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
> -	if (ret)
> -		goto out;
> -
> -	t2.tv_sec =3D ts_nat.tv_sec;
> -	t2.tv_nsec =3D ts_nat.tv_nsec;
> -
> -	if (ts_less(&t2, &t1))
> -		smokey_warning("recvmmsg64 returned to early!\n"
> -			       "Expected wakeup at: %lld sec %lld nsec\n"
> -			       "Back at           : %lld sec %lld nsec\n",
> -			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
> -
> -out:
> -	close(sock);
> -	return ret;
> -}
> -
>  static int test_sc_cobalt_cond_wait_prologue64(void)
>  {
>  	int sc_nr =3D sc_cobalt_cond_wait_prologue64;
> @@ -1724,10 +1599,6 @@ static int run_y2038(struct smokey_test *t, int ar=
gc, char *const argv[])
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D test_sc_cobalt_recvmmsg64();
> -	if (ret)
> -		return ret;
> -

Instead of removing the complete testcase we could change the test to
cover the -EINVAL return value if someone tries to set a timeout.

>  	ret =3D test_sc_cobalt_cond_wait_prologue64();
>  	if (ret)
>  		return ret;
> --=20
> 2.43.0

