Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13B36D4FA
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155315; cv=none; b=QxSDo4Ii4azhaCFIPKbfc5HgUcZ6S8tSevrwgqD/6fnxJLpvkRvi5CKv5HPwzaKC/ahPu9PrRPfPggCNVGkjbV5KmUsPh1NBYZXbG9niivLII9Zsp68GpKRBTM+We4Na+Tsw1WsvXICG0l+ASkt6c7VVkmHZW/dImPtDw4nBi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155315; c=relaxed/simple;
	bh=0IkMupAzWgHyzrnFWh1VaHsfaUyGEu+q4XLoydQ3yKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIJ0H8wbw8wH6RnRJgCBl3ViIhXJaH6M3RSLt3wPTw0h0rEFg/ZAvzwhxBUXQkgiGab7+3t9y4IsBrsXVYiSS7BfffzQQbEp/q//yUnw7BCwMgYoruUrD5Z1+daUyVCfpfy0v5CCoZNshuM5OPZrPgl5GmzHLyCNVJzhTglZYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XkQRkjqO; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XkQRkjqO"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202602032148284b549e6989000207f9
        for <xenomai@lists.linux.dev>;
        Tue, 03 Feb 2026 22:48:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s3vD3XRZJN7C8/JwtxR91Vp9pfFcizU5X54Y7MLEL7k=;
 b=XkQRkjqOuNJn36MqBdoGd//9qo1+ozFH6YTYwUJ8Q65GhM3Yps1YDv1DEIBJVxVMkDLry0
 RyVJwpMSegUY/sgghuDK5mkLLY1/Jr9esXDlLXU21QkGx+kwlV4dD+BrBlk6bvHto1LFFlaN
 Bnr6VTlPjfcm5AtJHOLJyPHMQpVB+5pHJG3ClWkr7Fj9mPISsMevYfGiLefAqDXDHRSmJk0A
 sykk8wIJGn6K/yxJ6k81aloMP501iyveUpHxDm6yN4hVlMtlffBcFk8eeOMfLqLDQ7vugdBy
 b2mDNbpuTGs03iGiDEIMWAa+cNYRmWv2MflwWZ8UQmmwZBzyoWy30YHA==;
Message-ID: <198ace7718b548735ec0cb3e29b5c4f8129fbe9d.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 03 Feb 2026 22:48:26 +0100
In-Reply-To: <87qzr1ivxz.fsf@xenomai.org>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
		<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
		<87o6m6vutd.fsf@xenomai.org>
		<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
	 <87qzr1ivxz.fsf@xenomai.org>
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

On Tue, 2026-02-03 at 18:22 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
> > > -static inline void map_oob_ipis(int cpu)
> > > +static inline void map_oob_ipis(int cpu, int offset)
> > >  {
> > >  	int ipi;
> > > =20
> > >  	for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi=
++)
> > > -		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + ipi);
> > > +		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + cpu * offset=
 + ipi);
> > >  }
> >=20
> > I'm still quite sure that the loop is wrong and should be=20
> >=20
> > +static inline void map_oob_ipis(int cpu, int offset)
> >  {
> >         int ipi;
> > =20
> > -       for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET;=
 ipi++)
> > -               get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + i=
pi);
> > +       offset =3D ipi_irq_base + (cpu * offset);
> > +
> > +       for (ipi =3D OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
> > +               get_ipi_desc(cpu, ipi) =3D irq_to_desc(offset + ipi);
> >  }
> >=20
>=20
> For ipi=3DSGI-0-7, the upstream implementation of ipi_setup_lpi() does:
>=20
>                 irq =3D ipi_irq_base + (cpu * nr_ipi) + ipi;
> 		get_ipi_desc(cpu, ipi) =3D irq_to_desc(irq);
>=20
> In pipelined mode, we need to do that for ipi=3DSGI0 for in-band IPIs,
> then for ipi=3DSGI1-3 for oob ones (see below). All members of
> ipi_msg_type become _logical_ IPIs multiplexed over SGI0. That is the
> whole point of your fix regarding CPU_BACKTRACE and KGDB_ROUNDUP.
>=20
>=20
> > instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)
>=20
> The code above would map the original IPI range from SGI0-7, which we
> don't have to in pipelined mode, we only use SGI0-3 here.
>=20
> >=20
> > Example:
> >=20
> > static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
> > {
> > 	unsigned int cpu;
> >=20
> > 	if (!percpu_ipi_descs)
> > 		__ipi_send_mask(get_ipi_desc(0, nr), mask);
> >=20
> > How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located behind
> > the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would return
> > NULL as we skipped the mapping in map_oob_ipis().
> >=20
>=20
> Any IPI from IPI_RESCHEDULE to IPI_IRQ_WORK are multiplexed over SGI0 by
> smp_cross_call().=C2=A0
>=20

Here we go. I missed that smp_cross_call() calls __smp_cross_call() with
ipinr set to 0, unconditionally, not forwarding ipinr. I simply
overlooked that. That allows us to only map the oob IPIs as the "wrong"
mapping in arm64_send_ipi() can not happen anymore. Sorry for the
confusion.

I will send out v2 tomorrow after some more testing.

> IPI_CPU_BACKTRACE and IPI_KGDB_ROUNDUP should be as
> well, but unfortunately bypassed that routine to call into
> arm64_send_ipi() directly, which is invalid. So, if all call sites which
> want to send an in-band IPI do this remapping so that arm64_send_ipi()
> is always called with ipi=3DSGI0 for them, we are ok.
>=20
> IOW, arm64_send_ipi() can only be called for SGI0-3, i.e. one in-band
> channel over which all upstream IPIs are multiplexed, three oob IPIs the
> real-time core may use as it sees fit.
>=20
> I should have an Hikey Lemaker somewhere in my drawers to be excavated
> that I can reconnect to my lab. Is it the hardware which shows the issue
> in lpi mode, or is it a 960?

I can only test the SGI mode here. Everything else came up while
inspecting the code.
