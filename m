Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8309227EA8
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336018; cv=none; b=qSxI1EkjR8Kbi3OMRCM6byq5nQxi6GWZqumanzXZZoTkPfroS9QSkosWb9RxpuHsWsYjWWheV2lNWNXmkWIDCcYIt+XDVHhLzu/gkzA81DlOQswa5frWyWlzrC6tTWON2FSA+cmjDV3L/UMb1SU2SifzEBAcYzz+ebdRGXoaSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336018; c=relaxed/simple;
	bh=UV49EfyZ+YLQjNV1slfx/gaNE3RUGdLLim63Y7ASj1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8ru62edsrP3bOeECmz+5QsBSRRwZsgLpnqtiezCgPunqgDlE03awwOlglBrsYvBUmdfLY1DAlrV8W2b+NsmoJo9IdqWoi3MMnVxRYJ+WGZ0Vg/YYLRC4nDtjE0hwk5YDDw+vyEETXZazIzAlEFFAFCAMBfP3wzgv1fVZzpE4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=l35Fe7CG; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="l35Fe7CG"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025090812532974611e1f1f00020716
        for <xenomai@lists.linux.dev>;
        Mon, 08 Sep 2025 14:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=j9bNfVGcVvdQZqU+iuzt+U/zuWE8LG70dC0goaIy5dQ=;
 b=l35Fe7CGNSDfsNs7XVgT8QcYzPyzmCzix8JKfH9nQVEgN7MtVWxgocbN8SURtpTbzjalKT
 7GC4RfpwtKyOzMaMvhQtjcKy+nyLfmGjxrgh2aLa5MnVUZ8goH7OVkvJfocw+YXV13T1LVsv
 P/gpOZRrdvIvsuzrMrxGvOG2i991jxkOxbSIW9A8VNR1//DLDQgwSbWlS9y6JSuNuJojmxTc
 hxvSKKzPOKG8iyd/R1glyTrL6M9E7UBHQKrE1rLs4aRHi+tLAuIUZRv8qGOiA5+V/E/zS406
 AlT51Q6H+RUc+CpBYXnPcpUntZvs5tgv0p4kaKttG2olffCW1HOS72VA==;
Message-ID: <5da04d495818b200d7191b66e578fcc6e1e82d4b.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v3 1/3] x86/fpu: dovetail: Fix FPU
 corruption
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 08 Sep 2025 14:53:29 +0200
In-Reply-To: <87wm6986ih.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
		<20250820-wip-flo-fixes-for-dovetail-6-15-v3-1-ae4a674d8e10@siemens.com>
	 <87wm6986ih.fsf@xenomai.org>
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

On Mon, 2025-09-08 at 14:37 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/=
thread_info.h
> > index 77c4c632cef2..2fc72d622229 100644
> > --- a/arch/x86/include/asm/thread_info.h
> > +++ b/arch/x86/include/asm/thread_info.h
> > @@ -237,10 +237,11 @@ static inline int arch_within_stack_frames(const =
void * const stack,
> >  #define TS_OFFSTAGE		0x0040	/* Thread is in-flight to OOB context */
> >  #define TS_OOBTRAP		0x0080	/* Handling a trap from OOB context */
> > =20
> > -#define _TLF_OOB		TS_OOB
> > -#define _TLF_DOVETAIL		TS_DOVETAIL
> > -#define _TLF_OFFSTAGE		TS_OFFSTAGE
> > -#define _TLF_OOBTRAP		TS_OOBTRAP
> > +#define _TLF_OOB			TS_OOB
> > +#define _TLF_DOVETAIL			TS_DOVETAIL
> > +#define _TLF_OFFSTAGE			TS_OFFSTAGE
> > +#define _TLF_OOBTRAP			TS_OOBTRAP
> > +#define _TLF_KERNEL_FPU_PREEMPTED	0x0100	/* Dovetail: kernel mode FPU =
section preempted by OOB */
> >=20
>=20
> The TS_* enumeration originates from the upstream implementation, so we
> added our thread-synchronous flags there. The _TLF_* aliasing comes from
> the Dovetail implementation, in order to get a common naming scheme
> because not all archs would define TS_* flags. So we should keep it the
> current way which is intended to prevent conflicting upstream addition
> to go unnoticed, i.e. define TS_KERNEL_FPU_PREEMPTED then alias it to
> _TLF_KERNEL_FPU_PREEMPTED.

Got it. Will send out v4 soon. Thanks a lot!

>=20
> The rest looks good to me.
