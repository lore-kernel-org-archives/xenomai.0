Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17129AB
	for <xenomai@lists.linux.dev>; Fri, 21 Jul 2023 12:52:02 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230721125154cef28f9ab640511d9f
        for <xenomai@lists.linux.dev>;
        Fri, 21 Jul 2023 14:51:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IhiP8RmMxUGGHeUcydsGt1cYcjsXXolVij1M18OIXnM=;
 b=ayImYDsscDi35rs8HbPf/FfyEBcyGFz0LQSL9/njShhasW5i0Mu7EorWmfAHaXMVSMa700
 gV2rvvyAiJhn5BYk3ctr/uZ7yMPSye8V2Zb4cRyRKFN+3qgNy0OLxr8mQFv3e+qlAYsP6Nbe
 7QZqmbIJAB4sgjteFbzxDtzYOOR+s=;
Message-ID: <3405c588f25b0bb07be8a427c43414a0fa86e6c1.camel@siemens.com>
Subject: Re: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct
 sched_param_ex to time64_t
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 21 Jul 2023 14:51:54 +0200
In-Reply-To: <c6dcd8aa-f50e-633b-8b6d-7755cce2b98a@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
	 <c6dcd8aa-f50e-633b-8b6d-7755cce2b98a@siemens.com>
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

On Thu, 2023-07-20 at 18:47 +0200, Jan Kiszka wrote:
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
>=20
> While the cleanups are enormous, I think we need to make sure that we
> are not causing subtle issues to applications.
>=20
> I first thought we are only breaking the ABI for internal communication
> kernel<->libcobalt. But some structs you touch here are used by
> applications as well, aren't they? And then we are now exposing 64-bit
> time types to them. Will they be fine with that? Recompilation is
> needed, that is clear, but will applications not supporting 64-bit time
> types yet nevertheless be able to use the 64-bit extended structures
> without major code changes?

Recompiling is necessary, no question. That should be OK as this is
targeting the next/master branch exclusively.

We never had any time_t in this API. We used our own data type (struct
__user_old_timespec) in the past. This is why this "auto-conversion"
with glibc support does not work here. If we would like to have that we
would have to use struct timespec and we are back to v1 of this series.

Userspace code should use struct sched_param_ex and friends which will
now hold struct xn_ts64 instead of our previously used struct with
identical member names, so no problem expected. The testsuite stayed as
is right now, that's a good sign.

struct sched_param_ex is part of the uapi, and hopefully only used
there. Even if an application decided to use it internally as well that
should work. Different memory layout but everything else should be
backward compatible - only a recompile away.

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

