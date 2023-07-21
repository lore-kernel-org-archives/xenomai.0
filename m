Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436429AB
	for <xenomai@lists.linux.dev>; Fri, 21 Jul 2023 12:43:09 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230721124301b8debbb930d7c2b692
        for <xenomai@lists.linux.dev>;
        Fri, 21 Jul 2023 14:43:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=2W+N3jpxEVDawW/7pJQSmt7TA7oyrI8HD2AQvYDBHps=;
 b=lzygyp9AeaBHkMpatiVCpKMmQI/wP91r95pmSKGMykpzv8scABcZ+cC+IeIOBnYmf+HoSM
 0FQxptsS65I60hCWBmvY5VOelE6+Eaf5dYSU1Kq+zb8VFuJmx9hF84LerzeicJ5kZipxA6I9
 /c9bn83Qb7O9LT3XuNrRitjpq829U=;
Message-ID: <0e0aa54e62d8723d447682efe4c4d1caa3b278c3.camel@siemens.com>
Subject: Re: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct
 sched_param_ex to time64_t
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 21 Jul 2023 14:43:00 +0200
In-Reply-To: <f0114278-3dc2-7faf-9b2f-fec6dcfbb4a8@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
	 <f0114278-3dc2-7faf-9b2f-fec6dcfbb4a8@siemens.com>
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

On Thu, 2023-07-20 at 18:36 +0200, Jan Kiszka wrote:
> On 17.07.23 11:10, Florian Bezdeka wrote:
> > Instead of implementing time64_t based cobalt services for the
> > following services we simply break the ABI and make it time64_t aware.
> >=20
> > Affected cobalt services:
> >   - cobalt_thread_create
> >   - cobalt_thread_setschedparam_ex
> >   - cobalt_thread_getschedparam_ex
> >   - cobalt_sched_setconfig_np
> >   - cobalt_sched_getconfig_np
> >   - cobalt_sched_setscheduler_ex
> >   - cobalt_sched_getscheduler_ex
> >=20
> > XENOMAI_ABI_REV is incremented on all supported plattforms to express
> > the ABI breakage.
> >=20
> > The memory alignment of some data structures is changed by adding
> > some anonymous paddings. This allows us to remove some compat specific
> > services afterwards. The memory layout is identical on all platforms
> > now.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/uapi/kernel/types.h                       |  5 +++++
> >  include/cobalt/uapi/sched.h                              | 14 ++++++++=
+-----
> >  .../cobalt/arch/arm/include/asm/xenomai/uapi/features.h  |  2 +-
> >  .../arch/arm64/include/asm/xenomai/uapi/features.h       |  2 +-
> >  .../cobalt/arch/x86/include/asm/xenomai/uapi/features.h  |  2 +-
> >  kernel/cobalt/posix/clock.h                              | 16 ++++++++=
++------
> >  kernel/cobalt/posix/sched.c                              | 16 ++++++++=
--------
> >  kernel/cobalt/posix/thread.c                             |  8 ++++----
> >  8 files changed, 39 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/k=
ernel/types.h
> > index 2c931c29c..495c94506 100644
> > --- a/include/cobalt/uapi/kernel/types.h
> > +++ b/include/cobalt/uapi/kernel/types.h
> > @@ -57,6 +57,11 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t =
handle)
> >  	return handle & ~XN_HANDLE_TRANSIENT_MASK;
> >  }
> > =20
> > +struct xn_ts64 {
> > +	__u64 tv_sec;
> > +	__u64 tv_nsec;
> > +};
> > +
> >  /*
> >   * Our representation of time specs at the kernel<->user interface
> >   * boundary at the moment, until we have fully transitioned to a
> > diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
> > index 14095870f..6b1639feb 100644
> > --- a/include/cobalt/uapi/sched.h
> > +++ b/include/cobalt/uapi/sched.h
> > @@ -33,15 +33,17 @@
> > =20
> >  struct __sched_ss_param {
> >  	int __sched_low_priority;
> > -	struct __user_old_timespec __sched_repl_period;
> > -	struct __user_old_timespec __sched_init_budget;
> > +	int: 32;
> > +	struct xn_ts64 __sched_repl_period;
> > +	struct xn_ts64 __sched_init_budget;
> >  	int __sched_max_repl;
> > +	int: 32;
> >  };
> > =20
> >  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
> > =20
> >  struct __sched_rr_param {
> > -	struct __user_old_timespec __sched_rr_quantum;
> > +	struct xn_ts64 __sched_rr_quantum;
> >  };
> > =20
> >  #ifndef SCHED_TP
> > @@ -54,9 +56,10 @@ struct __sched_tp_param {
> >  };
> > =20
> >  struct sched_tp_window {
> > -	struct __user_old_timespec offset;
> > -	struct __user_old_timespec duration;
> > +	struct xn_ts64 offset;
> > +	struct xn_ts64 duration;
> >  	int ptid;
> > +	int: 32;
> >  };
> > =20
> >  enum {
> > @@ -122,6 +125,7 @@ struct __sched_config_quota {
> > =20
> >  struct sched_param_ex {
> >  	int sched_priority;
> > +	int: 32;
>=20
> Having these two lines back-to-back looks strange: Why do we specify 32
> bits explicitly for the padding, why don't we have to specify that for
> the sched_priority, and why don't we use the __u32/__s32 types here?
> Same applies to the other structs touched.

AFAICT there is no difference in the data type used for the padding. We
could switch to __u32/__32 as long as the produced memory layout is the
same on all architectures. As this "member" does not have a name
(=3Danonymous) it really shouldn't make any difference.

I'm not sure if I get the part about "why don't we have to specify that
for the sched_priority" right. After the padding in sched_param_ex two
64 bit values (__u64 as part of struct xn_ts64) will follow.=20

64 bit values are 8 byte aligned on 64 bit systems but 4 byte aligned
on 32 bit systems. To get the same memory layout (for being able to
handle compat syscalls with the same data types) I added the "anonymous
padding". The padding has an impact on 32 bit systems only.

The other structs touched have the same reasoning behind.
__sched_ss_param and sched_tp_window will be extended to the next 8
byte boundary on 64 bit systems automatically, so we have to "fill them
up" with a trailing padding.

Does that answer your questions? Any follow up necessary?

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

