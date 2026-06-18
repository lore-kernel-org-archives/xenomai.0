Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051E2F8EB8
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765834; cv=none; b=K+Rf3WFeAeEpFyTYCyo+I+aOU/NiTfQO89QNWuUmjua5amXk0q3FKVDPkoU8kRU0H9v4vtOEt8uCQ/xrk4TYWn8qJMm9n/eojvR24obTL/UWlSnjLaKOE6mGGOvM3m0OKowZBcHGzwn70aDi8HDnUAez9kFg0UJ53pB0fKDPSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765834; c=relaxed/simple;
	bh=GeQW4CkD46dApt/gvqF1RrxbPQIkxKf93D9hPs60/+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbjZfqkj6LUYN29KCtSttBEgyJ/0qSWD8yFnmD4oGn4oJYgPNs6lZYfqnSeaDkfjCIfo+ejr/OYZrq4Q3NrUtFdi6uCDoclF66ex1lO81wM5gfPwwYQVidmG4YHqlcfdzQmZ9mUq0qG5OPuAcFdhFyhZ8JZCrtGrYM4F90IfVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=I4iRYFMu; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="I4iRYFMu"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260618065659e37552685d0002071a
        for <xenomai@lists.linux.dev>;
        Thu, 18 Jun 2026 08:56:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iwrsliUUD2f9Xc8LO7a1X8lhYjHEEssFo8fC5LzG6LA=;
 b=I4iRYFMu1g5maFOe0+4yfa+PgtbZvvxYmodLgO6icKUCCymD+ug6k0QQHaqsTHBAOodilG
 WVyyDxkHw/Be3OXspvkY9wd4cR9SC4XWkpP1ipVvbUHzfCBD5jTwxZzB/1LHGsV+4uUhYFG7
 TsccyfnmB/AG/O7SawDP4WZAF7wzf27A+Wyrceul8HGYlA1N2Eu/Xq7ZBkKWX6lePqRla4Gn
 GjecoFHaC4X7+6tQXYTxs57WRNs2V5cqkYoxLmKT1htBqnqmfych3yBtRjkwvb8+j3QlYqLc
 7qF/V9tPmFRuaVdis56RLtLttoUOBcJPRqzDXSkyhw+3QIFwDN8tmZ1A==;
Message-ID: <bf82d836bca573f89532c9fb653d2219eccb616e.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2 2/6] arm: irq_pipeline: Move fault_entry()
 fault_exit() into separate header
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>, Tobias
 Schaffner <tobias.schaffner@siemens.com>
Date: Thu, 18 Jun 2026 08:56:59 +0200
In-Reply-To: <87ik7h7l2g.fsf@xenomai.org>
References: 
	<20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
		<20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-2-62c9c477f8f2@siemens.com>
	 <87ik7h7l2g.fsf@xenomai.org>
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

On Wed, 2026-06-17 at 08:11 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Introducing a new header allows us to keep the implementation as
> > static inline function. Moving them into asm/dovetail.h or
> > asm/irq_pipeline.h would require us to rewrite those helpers as macros.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/arm/include/asm/trap_entry.h | 82 +++++++++++++++++++++++++++++++=
++++++++
> >  arch/arm/mm/fault.c               | 65 +------------------------------
> >  2 files changed, 83 insertions(+), 64 deletions(-)
> >=20
> > diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/t=
rap_entry.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..56cf3352c38d9347e989f9b=
4f6be0b7d649d9b13
> > --- /dev/null
> > +++ b/arch/arm/include/asm/trap_entry.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASMARM_TRAP_ENTRY_H
> > +#define _ASMARM_TRAP_ENTRY_H
> > +
> > +#include <asm/dovetail.h>
> > +#include <asm/trace/exceptions.h>
> > +
> > +#ifdef CONFIG_MMU
> > +#ifdef CONFIG_IRQ_PIPELINE
> > +/*
> > + * We need to synchronize the virtual interrupt state with the hard
> > + * interrupt state we received on entry, then turn hardirqs back on to
> > + * allow code which does not require strict serialization to be
> > + * preempted by an out-of-band activity.
> > + */
> > +static inline unsigned long fault_entry(int exception, struct pt_regs =
*regs)
> > +{
>=20
> We need a prefix to fault_entry() in order not to pollute the namespace.

dovetail_, or any better ideas?
