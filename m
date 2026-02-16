Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850171EDA2B
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234069; cv=none; b=FulruqXyeWa8K8ejaxfGu0GFAIIu0EI5ksQrF2KMiSxCPMe8ukvbKmiL/NT98QI5IrHa8VkVu3Cd/fZ6dYex9X00RPGXquc6FzM6g5urmUjojC5Wo9qOQ8RNcl99RsNy9ZmDteEfcVNg6Ew8bLu1Bu2hxnpihqd17YRI/ytACXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234069; c=relaxed/simple;
	bh=RbvslvHuNBya37VSUbza3K/QPcGe0kYrZgq/O+z0TVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhEDmkWVcDUfqVgUhZKFRRu1RNYmFi3/jFAMM452iqOdvdlXKc2sUuw+Xce1lPMz9YiNIHbCSQeU+NmE6haUomTiLdSyZLdl8yfxBibaSG8wZSxLCPtAxe+kKusIzXn4yKBl7d+xeeoiQf4szU9AuxFy0vaE6mpmKvfRfItugn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PV2HdHHL; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PV2HdHHL"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026021609274137c0829ce90002073e
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 10:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fMUvufr2NlaLyQUkHwX/2ymzCMlqdlANjmMpkeJhlGk=;
 b=PV2HdHHLBtNPmt0a12s15R8ZnZeK0Cs2hJ+WaKzCOYSF7OS39MeGWnAHvhFoRHNv0/NvbH
 xjnGUTJqU9/Y2mnMcTeKDSNofZB+3Z/Y4FGYPDjsstFLcxXXfmCMXyWvfYBi1tG4c5dWimrm
 JBlV56rqDiogtS1iGRlf59z1ZePTGnakd7w6lMfSPqQDDrxYaVq/Cy4as+thr2ML2JUrbBqT
 6yz25Fj0bv8dWur6xCtuBW6IYkqZKWrOgyeRXmXYijBJOye4YzX4AMGhx56vvHFVoSCtXabE
 zSUoKqriP/OMpIxTTlROVmUvh0E0mDFwx4aHVveF4cbCk5Lz1Y7O2ajA==;
Message-ID: <9596bb75fa20f8f470dbef5cd03d944e7df50c1c.camel@siemens.com>
Subject: Re: [PATCH dovetail] irq_pipeline: synchronize inband IRQ log in
 exit_to_user_mode_prepare()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
Date: Mon, 16 Feb 2026 10:27:41 +0100
In-Reply-To: <5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com>
References: <20260214113941.91453-1-tobias.schaffner@siemens.com>
	 <5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com>
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

On Sun, 2026-02-15 at 00:25 +0100, Florian Bezdeka wrote:
> On 2/14/26 12:39, Tobias Schaffner wrote:
> > Architectures using the generic handle_irq_pipelined() path do not
>=20
> arm64 and x86 are not using that, so the only arch left is arm.
> See below...
>=20
> > synchronize the inband IRQ log in handle_irq_pipelined_finish()
> > because inband is still stalled from irqentry_enter() when it gets
> > called.
>=20
> I think the real issue / correct wording is:
>=20
> _TIF_WORK is left pending on IRQ exit.
>=20
> >=20
> > As a result, deferred inband IRQs may not be played before the kernel
> > checks for pending work in exit_to_user_mode_loop(), causing
> > those IRQs to be missed on the return path to userspace.
> >=20
> > Flush the inband IRQ log in exit_to_user_mode_prepare() before
> > entering the work loop.
> >=20
> > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > ---
> >  include/linux/irq-entry-common.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry=
-common.h
> > index b21fb5893a67..e5815511a80a 100644
> > --- a/include/linux/irq-entry-common.h
> > +++ b/include/linux/irq-entry-common.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/tick.h>
> >  #include <linux/kmsan.h>
> >  #include <linux/unwind_deferred.h>
> > +#include <linux/irq_pipeline.h>
> > =20
> >  #include <asm/entry-common.h>
> > =20
> > @@ -237,6 +238,11 @@ static __always_inline void exit_to_user_mode_prep=
are(struct pt_regs *regs)
> >  	/* Flush pending rcuog wakeup before the last need_resched() check */
> >  	tick_nohz_user_enter_prepare();
> > =20
> > +	/* Synchronize the in-band log before the work loop so that any defer=
red
> > +	 * IRQs are played before we check for pending work. */
> > +	if (running_inband())
> > +		sync_inband_irqs();
> > +
>=20
> I think there is more behind it. Seems your architecture (most likely
> risc-v) is missing one corner case in the low level IRQ entry code:
>=20
> Potential stage demotion of the preempted task which originally entered
> on the oob stage, then left it for the in-band stage as a result of IRQ
> handling. This should happen in handle_irq_pipeline_finish() - if require=
d.
>=20
> So on IRQ entry you are OOB, after the call to
> handle_irq_pipeline_finish() you might be inband.
>=20
> In that case you most likely want to call irqentry_exit_to_user_mode()
> with the inband stage stalled:
>=20
> Taken from arm64/x86:
> if (unlikely(running_oob() || irqs_disabled())) {
> 	...
> 	handle_irq_pipelined_finish(prevd, regs);
> 	if (running_inband() && user_mode(regs)) {
> 		stall_inband_nocheck();
> 		irqentry_exit_to_user_mode(regs);
> 	}
> 	...
> }
>=20
> >  again:
> >  	ti_work =3D read_thread_flags();
> >  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>=20
> That said, we should double check that this corner case is handled right
> on arm. If arm suffers from the same problem, this corner case is
> missing in handle_irq_pipelined().

ARM is doing the right thing on assembly level already by calling into
do_work_pending() on the way back.

>=20
> I hope all of this makes sense at the end. It's late...
>=20
> Best regards,
> Florian
