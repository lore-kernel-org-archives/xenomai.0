Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B6A92A
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 09:33:50 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202305150933423a6bc106510ac8bd30
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 11:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hS5ll5DugU5mcqB6cUSpk3+ZFFm71BDiBmp7gyCHtYo=;
 b=VOL5yOLkVSulEBQC8XKRMWHBgBOOCvZVv92WLzEcGc1hIx3Oe+1M//zTMq3w7aOxmhPYeH
 3mqB81RjdVsuu/GNFS/MSbuDBu2k6Bvi79jJPYWj0JQvl2piJFQhbaZgzGywLYxb2zvGB2PQ
 z9pjw0zhX+x8xU4vDu1oWjs5NVJlM=;
Message-ID: <40a686c6f9e03427093c14fa4850572cd91dc138.camel@siemens.com>
Subject: Re: [PATCH 02/13] y2038: cobalt/posix/timer: Adding timer_settime64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 15 May 2023 11:33:42 +0200
In-Reply-To: <a38c9123-f06e-f17c-ea83-0ca96cde7555@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
	 <20230508-florian-y2038-part-two-v1-2-a417812fba85@siemens.com>
	 <a38c9123-f06e-f17c-ea83-0ca96cde7555@siemens.com>
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

On Fri, 2023-05-12 at 18:02 +0200, Jan Kiszka wrote:
> On 08.05.23 10:13, Florian Bezdeka wrote:
> > Add a syscall specific for timer_settime with 64bit time_t.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/uapi/syscall.h      |  1 +
> >  kernel/cobalt/posix/timer.c        | 32 +++++++++++++++++++++++++++++-=
--
> >  kernel/cobalt/posix/timer.h        |  5 +++++
> >  kernel/cobalt/trace/cobalt-posix.h |  3 ++-
> >  4 files changed, 37 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscal=
l.h
> > index 9646a0d97..77184bd22 100644
> > --- a/include/cobalt/uapi/syscall.h
> > +++ b/include/cobalt/uapi/syscall.h
> > @@ -136,6 +136,7 @@
> >  #define sc_cobalt_event_wait64			113
> >  #define sc_cobalt_recvmmsg64			114
> >  #define sc_cobalt_cond_wait_prologue64		115
> > +#define sc_cobalt_timer_settime64		116
> > =20
> >  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
> > =20
> > diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
> > index a115ded53..3c7579def 100644
> > --- a/kernel/cobalt/posix/timer.c
> > +++ b/kernel/cobalt/posix/timer.c
> > @@ -16,6 +16,7 @@
> >   * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
> >   */
> > =20
> > +#include <cobalt/kernel/time.h>
> >  #include <linux/module.h>
> >  #include <linux/cred.h>
> >  #include <linux/err.h>
> > @@ -295,9 +296,8 @@ int __cobalt_timer_setval(struct xntimer *__restric=
t__ timer, int clock_flag,
> >  		return 0;
> >  	}
> > =20
> > -	if ((unsigned long)value->it_value.tv_nsec >=3D ONE_BILLION ||
> > -	    ((unsigned long)value->it_interval.tv_nsec >=3D ONE_BILLION &&
> > -	     (value->it_value.tv_sec !=3D 0 || value->it_value.tv_nsec !=3D 0=
)))
> > +	if (!timespec64_valid(&value->it_interval) ||
> > +	    !timespec64_valid(&value->it_value))
>=20
> Is that directly related to this patch? Or rather some cleanup?

I should move that into a separate patch... Expect v2 soon. It's a
valid cleanup but not directly related.

>=20
> >  		return -EINVAL;
> > =20
> >  	start =3D ts2ns(&value->it_value) + 1;
> > @@ -495,6 +495,32 @@ COBALT_SYSCALL(timer_settime, primary,
> >  	return 0;
> >  }
> > =20
> > +COBALT_SYSCALL(timer_settime64, primary,
> > +	       (timer_t tm, int flags,
> > +		const struct __kernel_itimerspec __user *u_newval,
> > +		struct __kernel_itimerspec __user *u_oldval))
> > +{
> > +	struct itimerspec64 newv, oldv, *oldvp =3D &oldv;
> > +	int ret;
> > +
> > +	if (u_oldval =3D=3D NULL)
> > +		oldvp =3D NULL;
> > +
> > +	if (cobalt_get_itimerspec64(&newv, u_newval))
> > +		return -EFAULT;
> > +
> > +	ret =3D __cobalt_timer_settime(tm, flags, &newv, oldvp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (oldvp && cobalt_put_itimerspec64(u_oldval, oldvp)) {
> > +		__cobalt_timer_settime(tm, flags, oldvp, NULL);
> > +		return -EFAULT;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  COBALT_SYSCALL(timer_gettime, current,
> >  	       (timer_t tm, struct __user_old_itimerspec __user *u_val))
> >  {
> > diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
> > index 3b580d470..16d3a572a 100644
> > --- a/kernel/cobalt/posix/timer.h
> > +++ b/kernel/cobalt/posix/timer.h
> > @@ -78,6 +78,11 @@ COBALT_SYSCALL_DECL(timer_settime,
> >  		     const struct __user_old_itimerspec __user *u_newval,
> >  		     struct __user_old_itimerspec __user *u_oldval));
> > =20
> > +COBALT_SYSCALL_DECL(timer_settime64,
> > +		    (timer_t tm, int flags,
> > +		     const struct __kernel_itimerspec __user *u_newval,
> > +		     struct __kernel_itimerspec __user *u_oldval));
> > +
> >  COBALT_SYSCALL_DECL(timer_gettime,
> >  		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
> > =20
> > diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/c=
obalt-posix.h
> > index c7eef7fba..5f99b1162 100644
> > --- a/kernel/cobalt/trace/cobalt-posix.h
> > +++ b/kernel/cobalt/trace/cobalt-posix.h
> > @@ -168,7 +168,8 @@
> >  		__cobalt_symbolic_syscall(monitor_wait64),		\
> >  		__cobalt_symbolic_syscall(event_wait64),		\
> >  		__cobalt_symbolic_syscall(recvmmsg64),			\
> > -		__cobalt_symbolic_syscall(cond_wait_prologue64))
> > +		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
> > +		__cobalt_symbolic_syscall(timer_settime64))
> > =20
> >  DECLARE_EVENT_CLASS(cobalt_syscall_entry,
> >  	TP_PROTO(unsigned int nr),
> >=20
>=20
> Jan
>=20

