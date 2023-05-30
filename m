Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9913AC8
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 09:19:58 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023053009195669ef968f5a5545274d
        for <xenomai@lists.linux.dev>;
        Tue, 30 May 2023 11:19:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tkKkfgIUFZxLTLcNqr/SpEoaH4cgwrHLC9SXw7JwhPo=;
 b=actCrrQ48BlDaKM3dKUuSoH1DD5gOOsfrxMQA2Ins6B5AtWT0+WgtIgTz6Z6IqEEyUgMfu
 BcSZDuG62r+zMLczJGIkAT1jD+NNEx1eBkpOPiQbVLrXCsE/Sh9ow/0Q0XUTlX7pAk8UErFo
 rwn8IROuNuSyYSNp6ZE3n8/JMj/VE=;
Message-ID: <a7499de6f30946b8b87cc3f3a65070ecef81a15c.camel@siemens.com>
Subject: Re: [PATCH v2 1/4] y2038: cobalt/posix/select: Refactor
 __cobalt_select()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 30 May 2023 11:19:54 +0200
In-Reply-To: <61004f9c-6d5c-6cf9-1b94-d6053f90d9c8@siemens.com>
References: 
	<20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
	 <20230516-florian-y2038-part-three-v2-1-3fc689b21a32@siemens.com>
	 <6d7f05db-4158-9b1d-cc70-7a7681ad9aa0@siemens.com>
	 <beb2687da573bcc25e0f42d45c7ac23a55e17553.camel@siemens.com>
	 <61004f9c-6d5c-6cf9-1b94-d6053f90d9c8@siemens.com>
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

On Tue, 2023-05-30 at 11:16 +0200, Jan Kiszka wrote:
> On 30.05.23 11:01, Florian Bezdeka wrote:
> > On Mon, 2023-05-29 at 13:11 +0200, Jan Kiszka wrote:
> > > On 26.05.23 07:35, Florian Bezdeka wrote:
> > > > There is no y2038 safe select() syscall provided by Linuy. If y2038
> > > > safety is required the application should not use select() and move=
 on
> > > > to something like pselect().
> > > >=20
> > > > As we still want to support select() for keeping backward compatibi=
lity
> > > > - even if y2038 safety is requested - an additional pselect() based
> > > > entry will be introduced soon which will re-use __cobalt_select().
> > > >=20
> > > > This patch moves all the timeout related userspace copy operations =
out
> > > > of __cobalt_select() and migrates __cobalt_select() to
> > > > struct timespec64. That will allow pselect64() to be based on
> > > > __cobalt_select() as well.
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 ++++++++
> > > >  kernel/cobalt/posix/clock.h                        |  6 +--
> > > >  kernel/cobalt/posix/io.c                           | 60 ++++++++++=
------------
> > > >  kernel/cobalt/posix/syscall32.c                    | 22 +++++++-
> > > >  4 files changed, 74 insertions(+), 36 deletions(-)
> > > >=20
> > > > diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/=
kernel/cobalt/include/asm-generic/xenomai/syscall.h
> > > > index 70b3e68f9..d61b985fb 100644
> > > > --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> > > > +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> > > > @@ -138,6 +138,28 @@ static inline int cobalt_put_u_itimerspec(
> > > >  	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
> > > >  }
> > > > =20
> > > > +static inline struct timespec64
> > > > +cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *sr=
c)
> > > > +{
> > > > +	struct timespec64 ts;
> > > > +
> > > > +	ts.tv_sec =3D src->tv_sec + (src->tv_usec / USEC_PER_SEC);
> > > > +	ts.tv_nsec =3D (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
> > > > +
> > > > +	return ts;
> > > > +}
> > > > +
> > > > +static inline struct __kernel_old_timeval
> > > > +cobalt_timespec64_to_timeval(const struct timespec64 *src)
> > > > +{
> > > > +	struct __kernel_old_timeval tv;
> > > > +
> > > > +	tv.tv_sec =3D src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
> > > > +	tv.tv_usec =3D (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
> > > > +
> > > > +	return tv;
> > > > +}
> > > > +
> > > >  /* 32bit syscall emulation */
> > > >  #define __COBALT_COMPAT_BIT	0x1
> > > >  /* 32bit syscall emulation - extended form */
> > > > diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/cloc=
k.h
> > > > index dbaabbc5d..38b59e24f 100644
> > > > --- a/kernel/cobalt/posix/clock.h
> > > > +++ b/kernel/cobalt/posix/clock.h
> > > > @@ -68,12 +68,12 @@ static inline xnticks_t tv2ns(const struct __ke=
rnel_old_timeval *tv)
> > > >  	return nsecs;
> > > >  }
> > > > =20
> > > > -static inline void ticks2tv(struct __kernel_old_timeval *tv, xntic=
ks_t ticks)
> > > > +static inline void ticks2ts64(struct timespec64 *ts, xnticks_t tic=
ks)
> > > >  {
> > > >  	unsigned long nsecs;
> > > > =20
> > > > -	tv->tv_sec =3D xnclock_divrem_billion(ticks, &nsecs);
> > > > -	tv->tv_usec =3D nsecs / 1000;
> > > > +	ts->tv_sec =3D xnclock_divrem_billion(ticks, &nsecs);
> > > > +	ts->tv_nsec =3D nsecs;
> > > >  }
> > > > =20
> > > >  static inline xnticks_t clock_get_ticks(clockid_t clock_id)
> > > > diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> > > > index 45ec09fae..8d408cc90 100644
> > > > --- a/kernel/cobalt/posix/io.c
> > > > +++ b/kernel/cobalt/posix/io.c
> > > > @@ -221,7 +221,7 @@ static int __cobalt_select_bind_all(struct xnse=
lector *selector,
> > > >  }
> > > > =20
> > > >  int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_=
wfds,
> > > > -		    void __user *u_xfds, void __user *u_tv, bool compat)
> > > > +		    void __user *u_xfds, struct timespec64 *to, bool compat)
> > > >  {
> > > >  	void __user *ufd_sets[XNSELECT_MAX_TYPES] =3D {
> > > >  		[XNSELECT_READ] =3D u_rfds,
> > > > @@ -237,13 +237,12 @@ int __cobalt_select(int nfds, void __user *u_=
rfds, void __user *u_wfds,
> > > >  	xntmode_t mode =3D XN_RELATIVE;
> > > >  	struct xnselector *selector;
> > > >  	struct xnthread *curr;
> > > > -	struct __kernel_old_timeval tv;
> > > >  	size_t fds_size;
> > > >  	int i, err;
> > > > =20
> > > >  	curr =3D xnthread_current();
> > > > =20
> > > > -	if (u_tv) {
> > > > +	if (to) {
> > > >  		if (xnthread_test_localinfo(curr, XNSYSRST)) {
> > > >  			xnthread_clear_localinfo(curr, XNSYSRST);
> > > > =20
> > > > @@ -255,23 +254,11 @@ int __cobalt_select(int nfds, void __user *u_=
rfds, void __user *u_wfds,
> > > >  				goto out;
> > > >  			}
> > > >  		} else {
> > > > -#ifdef CONFIG_XENO_ARCH_SYS3264
> > > > -			if (compat) {
> > > > -				if (sys32_get_timeval(&tv, u_tv))
> > > > -					return -EFAULT;
> > > > -			} else
> > > > -#endif
> > > > -			{
> > > > -				if (!access_ok(u_tv, sizeof(tv))
> > > > -				    || cobalt_copy_from_user(&tv, u_tv,
> > > > -							     sizeof(tv)))
> > > > -					return -EFAULT;
> > > > -			}
> > > > =20
> > > > -			if (tv.tv_usec >=3D 1000000)
> > > > +			if (!timespec64_valid(to))
> > > >  				return -EINVAL;
> > > > =20
> > > > -			timeout =3D clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
> > > > +			timeout =3D clock_get_ticks(CLOCK_MONOTONIC) + ts2ns(to);
> > > >  		}
> > > > =20
> > > >  		mode =3D XN_ABSOLUTE;
> > > > @@ -343,23 +330,12 @@ int __cobalt_select(int nfds, void __user *u_=
rfds, void __user *u_wfds,
> > > >  	}
> > > > =20
> > > >  out:
> > > > -	if (u_tv && (err > 0 || err =3D=3D -EINTR)) {
> > > > +	if (to && (err > 0 || err =3D=3D -EINTR)) {
> > > >  		xnsticks_t diff =3D timeout - clock_get_ticks(CLOCK_MONOTONIC);
> > > >  		if (diff > 0)
> > > > -			ticks2tv(&tv, diff);
> > > > +			ticks2ts64(to, diff);
> > > >  		else
> > > > -			tv.tv_sec =3D tv.tv_usec =3D 0;
> > > > -
> > > > -#ifdef CONFIG_XENO_ARCH_SYS3264
> > > > -		if (compat) {
> > > > -			if (sys32_put_timeval(u_tv, &tv))
> > > > -				return -EFAULT;
> > > > -		} else
> > > > -#endif
> > > > -		{
> > > > -			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
> > > > -				return -EFAULT;
> > > > -		}
> > > > +			to->tv_sec =3D to->tv_nsec =3D 0;
> > > >  	}
> > > > =20
> > > >  	if (err >=3D 0)
> > > > @@ -390,5 +366,25 @@ COBALT_SYSCALL(select, primary,
> > > >  		fd_set __user *u_xfds,
> > > >  		struct __kernel_old_timeval __user *u_tv))
> > > >  {
> > > > -	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false)=
;
> > > > +	struct timespec64 ts64, *to =3D NULL;
> > > > +	struct __kernel_old_timeval tv;
> > > > +	int ret;
> > > > +
> > > > +	if (u_tv && (!access_ok(u_tv, sizeof(tv)) ||
> > > > +		     cobalt_copy_from_user(&tv, u_tv, sizeof(tv))))
> > > > +		return -EFAULT;
> > > > +
> > > > +	if (u_tv) {
> > > > +		ts64 =3D cobalt_timeval_to_timespec64(&tv);
> > > > +		to =3D &ts64;
> > > > +	}
> > > > +
> > > > +	ret =3D __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
> > > > +
> > > > +	if (u_tv) {
> > > > +		tv =3D cobalt_timespec64_to_timeval(to);
> > > > +		cobalt_copy_to_user(u_tv, &tv, sizeof(tv)); // errors ignored
> > >=20
> > > This helps in case ret was already non-zero. But if it wasn't, we are
> > > now missing an error.
> >=20
> > ret > 0 is the success case (number of file descriptors changed), ret <
> > 0 the error case, ret =3D=3D 0 the "timeout occured" case. Error handli=
ng
>=20
> I should have written ret < 0 here, right.
>=20
> > is exactly the same compared to Linux. cobalt_copy_to_user() should
> > succeed anyway, that is already covered by the access_ok() check above.
> >=20
>=20
> access_ok was run and probably also a read access, but writing here may
> still fail.

We should have a helper for checking rw access... Let me check that.
Might be an additional improvement.

>=20
> Jan
>=20

