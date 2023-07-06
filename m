Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE115A1
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:50:42 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230706075039e916cd931609792824
        for <xenomai@lists.linux.dev>;
        Thu, 06 Jul 2023 09:50:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1MbubymajDIaXUJdy5j1/2P5a5kxP1oSvUVae0ZV82k=;
 b=YIwV/lHD1kW9riZDEgBkpCxDTkyL9ni13IqNzhFkrx2Hf+QMGJPxZOFWDeUPBIDVWhtky0
 s3t3KnPXDLza/Q6nkDO01ef2RtdrxbMJfe87QyBh43DLIOkTeSG8fVvvI4SKCZuSpPDpJCeB
 YSQZFoTlU79xXPk2mtVFi3L+4esdc=;
Message-ID: <aaa0e6b0eb40c2b8015bbed1e14d8a188acf44a0.camel@siemens.com>
Subject: Re: [PATCH 06/12] y2038: cobalt/uapi: Align memory layout for
 time64 related types
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 06 Jul 2023 09:50:39 +0200
In-Reply-To: <68fd52af-9c3a-059a-d4f7-1c798c3ae17b@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v1-6-604a089542c2@siemens.com>
	 <68fd52af-9c3a-059a-d4f7-1c798c3ae17b@siemens.com>
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

On Thu, 2023-07-06 at 09:23 +0200, Jan Kiszka wrote:
> On 05.07.23 08:38, Florian Bezdeka wrote:
> > When turning on time64 support the memory layout of
> > struct sched_param_ex (used by userspace in any case) and the "shadow
> > type" (struct sched_param_ex64, used by time64 related entry points)
> > have to match.
> >=20
> > Simplified example for different memory layout (offsets) of
> > struct sched_param_ex:
> >=20
> >                                            offset 32 bit   offset 64 bi=
t
> > struct sched_param_ex {
> > 	int               sched_prio;           0                0
> > 	struct timespec   __sched_ss_param;     4                8
> > 	...
> > };
> >=20
> > With padding we get
> >=20
> > struct sched_param_ex {
> > 	int               sched_prio;           0                0
> > 	struct timespec   __sched_ss_param;     8                8
> > 	...
> > };
> >=20
> > This is a backward compatibility breaking change. Incrementing the
> > Xenomai ABI revision on all supported architectures to express that.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/kernel/compat.h                               | 4 ++++
> >  include/cobalt/uapi/sched.h                                  | 4 ++++
> >  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h   | 2 +-
> >  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
> >  kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h   | 2 +-
> >  kernel/cobalt/posix/thread.h                                 | 3 +++
> >  6 files changed, 14 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/com=
pat.h
> > index f2dce74b4..71010e3a9 100644
> > --- a/include/cobalt/kernel/compat.h
> > +++ b/include/cobalt/kernel/compat.h
> > @@ -30,9 +30,11 @@ struct sched_param_ex64;
> > =20
> >  struct __compat_sched_ss_param {
> >  	int __sched_low_priority;
> > +	int: 32;
> >  	struct old_timespec32 __sched_repl_period;
> >  	struct old_timespec32 __sched_init_budget;
> >  	int __sched_max_repl;
> > +	int: 32;
>=20
> Why not u32? And why not using that type for the other int fields as
> well? Same below.

I just followed the glibc way of defining such paddings. Is there any
significant difference?

>=20
> Jan
>=20
> >  };
> > =20
> >  struct __compat_sched_rr_param {
> > @@ -41,6 +43,7 @@ struct __compat_sched_rr_param {
> > =20
> >  struct compat_sched_param_ex {
> >  	int sched_priority;
> > +	int: 32;
> >  	union {
> >  		struct __compat_sched_ss_param ss;
> >  		struct __compat_sched_rr_param rr;
> > @@ -60,6 +63,7 @@ struct compat_sched_tp_window {
> >  	struct old_timespec32 offset;
> >  	struct old_timespec32 duration;
> >  	int ptid;
> > +	int: 32;
> >  };
> > =20
> >  struct __compat_sched_config_tp {
> > diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
> > index 730456d89..4081fbc0e 100644
> > --- a/include/cobalt/uapi/sched.h
> > +++ b/include/cobalt/uapi/sched.h
> > @@ -39,9 +39,11 @@
> > =20
> >  struct __sched_ss_param {
> >  	int __sched_low_priority;
> > +	int: 32;
> >  	struct xntimespec __sched_repl_period;
> >  	struct xntimespec __sched_init_budget;
> >  	int __sched_max_repl;
> > +	int: 32;
> >  };
> > =20
> >  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
> > @@ -63,6 +65,7 @@ struct sched_tp_window {
> >  	struct xntimespec offset;
> >  	struct xntimespec duration;
> >  	int ptid;
> > +	int: 32;
> >  };
> > =20
> >  enum {
> > @@ -128,6 +131,7 @@ struct __sched_config_quota {
> > =20
> >  struct sched_param_ex {
> >  	int sched_priority;
> > +	int: 32;
> >  	union {
> >  		struct __sched_ss_param ss;
> >  		struct __sched_rr_param rr;
> > diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h=
 b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> > index 43b7afb10..fdd5c0e32 100644
> > --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> > +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> > @@ -22,7 +22,7 @@
> >  #define _COBALT_ARM_ASM_UAPI_FEATURES_H
> > =20
> >  /* The ABI revision level we use on this arch. */
> > -#define XENOMAI_ABI_REV   18UL
> > +#define XENOMAI_ABI_REV   19UL
> > =20
> >  #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
> > =20
> > diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features=
.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> > index b98a96392..301797748 100644
> > --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> > +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> > @@ -22,7 +22,7 @@
> >  #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
> > =20
> >  /* The ABI revision level we use on this arch. */
> > -#define XENOMAI_ABI_REV   2UL
> > +#define XENOMAI_ABI_REV   3UL
> > =20
> >  #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
> > =20
> > diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h=
 b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> > index 65f8164a0..045adf0c1 100644
> > --- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> > +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> > @@ -19,7 +19,7 @@
> >  #define _COBALT_X86_ASM_UAPI_FEATURES_H
> > =20
> >  /* The ABI revision level we use on this arch. */
> > -#define XENOMAI_ABI_REV   18UL
> > +#define XENOMAI_ABI_REV   19UL
> > =20
> >  #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
> > =20
> > diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.=
h
> > index fb4306351..f663acde7 100644
> > --- a/kernel/cobalt/posix/thread.h
> > +++ b/kernel/cobalt/posix/thread.h
> > @@ -114,9 +114,11 @@ struct cobalt_sigwait_context {
> > =20
> >  struct __sched_ss_param64 {
> >  	int __sched_low_priority;
> > +	int: 32;
> >  	struct __kernel_timespec __sched_repl_period;
> >  	struct __kernel_timespec __sched_init_budget;
> >  	int __sched_max_repl;
> > +	int: 32;
> >  };
> > =20
> >  struct __sched_rr_param64 {
> > @@ -125,6 +127,7 @@ struct __sched_rr_param64 {
> > =20
> >  struct sched_param_ex64 {
> >  	int sched_priority;
> > +	int: 32;
> >  	union {
> >  		struct __sched_ss_param64 ss;
> >  		struct __sched_rr_param64 rr;
> >=20
>=20
> --=20
> Siemens AG, Technology
> Competence Center Embedded Linux

