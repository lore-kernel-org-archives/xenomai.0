Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A379DC
	for <xenomai@lists.linux.dev>; Mon, 10 Jul 2023 07:29:22 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023071007291596a683e9a92644577d
        for <xenomai@lists.linux.dev>;
        Mon, 10 Jul 2023 09:29:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=r02e6rfWCYH4Kk1bK4TgTfIk3ntlbQAnVsKUPz3lHx0=;
 b=jmchGN2JenHZ0NvRIUObteE6Oe/vDeFPfKpp/ZZlwNFsKw+GSartiyncV/UHxyl+YcqrHX
 KWDWLmfcQUOPJ9BCOpg24BRQp4oAWZSnsretJ7/gD1qdVbPVmGG2dhqnPkWykgKVsfSzR1HU
 xVSXZdN2XuqU6k/G+I3MXrR4CL/S4=;
Message-ID: <ebc41a2996d8f6092f74610ec730194130153efb.camel@siemens.com>
Subject: Re: [PATCH 06/12] y2038: cobalt/uapi: Align memory layout for
 time64 related types
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 10 Jul 2023 09:29:14 +0200
In-Reply-To: <6a248eae-34f3-cf4c-eba3-4829ed05c759@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v1-6-604a089542c2@siemens.com>
	 <68fd52af-9c3a-059a-d4f7-1c798c3ae17b@siemens.com>
	 <aaa0e6b0eb40c2b8015bbed1e14d8a188acf44a0.camel@siemens.com>
	 <6a248eae-34f3-cf4c-eba3-4829ed05c759@siemens.com>
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

On Fri, 2023-07-07 at 13:37 +0200, Jan Kiszka wrote:
> On 06.07.23 09:50, Florian Bezdeka wrote:
> > On Thu, 2023-07-06 at 09:23 +0200, Jan Kiszka wrote:
> > > On 05.07.23 08:38, Florian Bezdeka wrote:
> > > > When turning on time64 support the memory layout of
> > > > struct sched_param_ex (used by userspace in any case) and the "shad=
ow
> > > > type" (struct sched_param_ex64, used by time64 related entry points=
)
> > > > have to match.
> > > >=20
> > > > Simplified example for different memory layout (offsets) of
> > > > struct sched_param_ex:
> > > >=20
> > > >                                            offset 32 bit   offset 6=
4 bit
> > > > struct sched_param_ex {
> > > > 	int               sched_prio;           0                0
> > > > 	struct timespec   __sched_ss_param;     4                8
> > > > 	...
> > > > };
> > > >=20
> > > > With padding we get
> > > >=20
> > > > struct sched_param_ex {
> > > > 	int               sched_prio;           0                0
> > > > 	struct timespec   __sched_ss_param;     8                8
> > > > 	...
> > > > };
> > > >=20
> > > > This is a backward compatibility breaking change. Incrementing the
> > > > Xenomai ABI revision on all supported architectures to express that=
.
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >  include/cobalt/kernel/compat.h                               | 4 +=
+++
> > > >  include/cobalt/uapi/sched.h                                  | 4 +=
+++
> > > >  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h   | 2 +=
-
> > > >  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +=
-
> > > >  kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h   | 2 +=
-
> > > >  kernel/cobalt/posix/thread.h                                 | 3 +=
++
> > > >  6 files changed, 14 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel=
/compat.h
> > > > index f2dce74b4..71010e3a9 100644
> > > > --- a/include/cobalt/kernel/compat.h
> > > > +++ b/include/cobalt/kernel/compat.h
> > > > @@ -30,9 +30,11 @@ struct sched_param_ex64;
> > > > =20
> > > >  struct __compat_sched_ss_param {
> > > >  	int __sched_low_priority;
> > > > +	int: 32;
> > > >  	struct old_timespec32 __sched_repl_period;
> > > >  	struct old_timespec32 __sched_init_budget;
> > > >  	int __sched_max_repl;
> > > > +	int: 32;
> > >=20
> > > Why not u32? And why not using that type for the other int fields as
> > > well? Same below.
> >=20
> > I just followed the glibc way of defining such paddings. Is there any
> > significant difference?
> >=20
>=20
> OK, if they do it this way...
>=20
> But I was also wondering, as we are breaking ABIs here, if we shouldn't
> use types of static width for all the touched structures.

I was asking me the same... That would have saved a lot of compat
specific handling right from the beginning. My feeling was that for
some reason struct timespec was preferred / chosen to be the way to go.

Is there a POSIX like API that we tried to follow as close as possible?

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Competence Center Embedded Linux

