Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAB15A1
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:48:14 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202307060748067de6f9d6c9f96fa310
        for <xenomai@lists.linux.dev>;
        Thu, 06 Jul 2023 09:48:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=PqtiNJtDfXxjECARfPDg/V0taylPJbOgwyoeGWqs90g=;
 b=ifJ3rZnW9aGHKvPaUx0McdhXkhIwBQ+H8R4TiKVEbvx4AWHCvIcLsrckctPRQMlJ1ge3RW
 9TOtZ7AIZhx2ksMkTXoRX6ghNjB1WSJjqymVWvu4M8amNih3k2ZVqXZN57G3CIjFjNOcP4+V
 EsxI3G76RXTjRjMiuxbIKJnLXrWqE=;
Message-ID: <3388855bfe193a322ff87b8116773bf4c2cfb500.camel@siemens.com>
Subject: Re: [PATCH 01/12] y2038: cobalt: Introduce sched_param_ex64 and use
 it internally
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 06 Jul 2023 09:48:05 +0200
In-Reply-To: <99f6eab7-bb4b-020a-0a0c-49e653a4a243@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
	 <99f6eab7-bb4b-020a-0a0c-49e653a4a243@siemens.com>
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

On Thu, 2023-07-06 at 09:13 +0200, Jan Kiszka wrote:
> On 05.07.23 08:38, Florian Bezdeka wrote:
> > Introducing a new type sched_param_ex64. All members are (always) based
> > on time64_t. All internal APIs have been migrated now. Existing compat
> > and native system call entry points will do the necessary translation.
> >=20
> > This is a preparation step for introducing time64_t based cobalt thread
> > cobalt services.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/kernel/compat.h     |   5 +-
> >  kernel/cobalt/posix/clock.h        |  38 +++++++++--
> >  kernel/cobalt/posix/compat.c       |   5 +-
> >  kernel/cobalt/posix/sched.c        |  39 +++++++-----
> >  kernel/cobalt/posix/sched.h        |   8 +--
> >  kernel/cobalt/posix/syscall32.c    |  12 ++--
> >  kernel/cobalt/posix/thread.c       | 126 +++++++++++++++++++++++++++++=
+-------
> >  kernel/cobalt/posix/thread.h       |  39 ++++++++++--
> >  kernel/cobalt/trace/cobalt-posix.h |  20 +++---
> >  9 files changed, 219 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/com=
pat.h
> > index 275735df5..f2dce74b4 100644
> > --- a/include/cobalt/kernel/compat.h
> > +++ b/include/cobalt/kernel/compat.h
> > @@ -26,6 +26,7 @@
> >  #include <cobalt/uapi/sched.h>
> > =20
> >  struct mq_attr;
> > +struct sched_param_ex64;
> > =20
> >  struct __compat_sched_ss_param {
> >  	int __sched_low_priority;
> > @@ -117,12 +118,12 @@ int sys32_put_fdset(compat_fd_set __user *cfds, c=
onst fd_set *fds,
> >  		    size_t fdsize);
> > =20
> >  int sys32_get_param_ex(int policy,
> > -		       struct sched_param_ex *p,
> > +		       struct sched_param_ex64 *p,
> >  		       const struct compat_sched_param_ex __user *u_cp);
> > =20
> >  int sys32_put_param_ex(int policy,
> >  		       struct compat_sched_param_ex __user *u_cp,
> > -		       const struct sched_param_ex *p);
> > +		       const struct sched_param_ex64 *p);
> > =20
> >  int sys32_get_mqattr(struct mq_attr *ap,
> >  		     const struct compat_mq_attr __user *u_cap);
> > diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
> > index 38b59e24f..b0fc84396 100644
> > --- a/kernel/cobalt/posix/clock.h
> > +++ b/kernel/cobalt/posix/clock.h
> > @@ -18,6 +18,7 @@
> >  #ifndef _COBALT_POSIX_CLOCK_H
> >  #define _COBALT_POSIX_CLOCK_H
> > =20
> > +#include <linux/compat.h>
> >  #include <linux/types.h>
> >  #include <linux/time.h>
> >  #include <linux/cpumask.h>
> > @@ -38,6 +39,14 @@ static inline void u_ns2ts(struct __user_old_timespe=
c *ts, xnticks_t nsecs)
> >  	ts->tv_sec =3D xnclock_divrem_billion(nsecs, &ts->tv_nsec);
> >  }
> > =20
> > +static inline void ns2kts(struct __kernel_timespec *kts, xnticks_t tic=
ks)
> > +{
> > +	unsigned long nsecs;
> > +
> > +	kts->tv_sec =3D xnclock_divrem_billion(ticks, &nsecs);
> > +	kts->tv_nsec =3D (long long)nsecs;
> > +}
> > +
> >  static inline xnticks_t ts2ns(const struct timespec64 *ts)
> >  {
> >  	xnticks_t nsecs =3D ts->tv_nsec;
> > @@ -48,6 +57,23 @@ static inline xnticks_t ts2ns(const struct timespec6=
4 *ts)
> >  	return nsecs;
> >  }
> > =20
> > +static inline xnticks_t kts2ns(const struct __kernel_timespec *ts)
> > +{
> > +	xnticks_t nsecs =3D ts->tv_nsec;
> > +
> > +	/* zero out padding in compat mode */
> > +	if (in_compat_syscall())
> > +		nsecs &=3D 0xFFFFFFFFUL;
> > +
> > +	/* In 32-bit mode, this drops the padding */
> > +	nsecs =3D (long)nsecs;
>=20
> These two look strange: nsecs > 1,000,000,000 (which already fits into
> 32-bits) is a bug, if ts came from userspace, an userspace bug. Why
> don't we need to catch that? When could the higher bits be undefined,
> and why don't we initialize them properly at the point ts is filled?

Here is the struct timespec definition from libc, so the userspace part
used by applications:

struct timespec
{
#ifdef __USE_TIME_BITS64
  __time64_t tv_sec;		/* Seconds.  */
#endif
#if __WORDSIZE =3D=3D 64 \
  || (defined __SYSCALL_WORDSIZE && __SYSCALL_WORDSIZE =3D=3D 64) \
  || (__TIMESIZE =3D=3D 32 && !defined __USE_TIME_BITS64)
  __syscall_slong_t tv_nsec;	/* Nanoseconds.  */
#else
# if __BYTE_ORDER =3D=3D __BIG_ENDIAN
  int: 32;           /* Padding.  */
  long int tv_nsec;  /* Nanoseconds.  */
# else
  long int tv_nsec;  /* Nanoseconds.  */
  int: 32;           /* Padding.  */
# endif
#endif
};

The tv_nsec field of compat applications (and native 32bit
applications) is still 32 bit and some padding is used to fill it up to
64 bit - in order to match struct __kernel_timespec on kernel side.

IOW: For compat (or native 32 bit applications) the upper bits will be
undefined.

An other option of doing this "auto correction" is converting to struct
timespec64, which we do on some other places as well. But that would
require us to read each struct __kernel_timespec on it's own. So no
single cobalt_copy_from_user() but several cobalt_get_timespec64()
calls instead. I considered that to be more efficient.

Does that make sense now? Any leftovers?

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Competence Center Embedded Linux

