Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893B3A641E
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948942; cv=none; b=hmFIlw17Zs2N0JrQLFUcoVk50MZEEVphqn6rR+pSx1v+iO/iPhTiXQXtS0klgwNAIJ2qW3LMgCdaWMWjtuy0HAq0H0SAmTI7xfB4KU/w77f/+33msQxUe2oM2LJM1sQ55zQPzjKfmaW19a3YgK3bdO49U5CEBx8jAcFDrCbmIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948942; c=relaxed/simple;
	bh=FcDETi7RpLpGzQ3HM4qEpJzo+Z82GXjh0YDF9s/+fHQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3M5osDKb1suFw24UNOPFgWmTNp2cIGhJztOIRJDTEANqdtPBJ2GGP3Alv12Z/lXbrpTDX7looEJM1KvIyKj+npaSEAG6aDlp7QO8vnDtQibTRD40tEkM6fIza0GAxCRBwelogyDKezU38Ho6qLLPuxCL1QwR5UjVFIeyDpBlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bL0pZqeZ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bL0pZqeZ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202602241602090e6f8732b9000207a4
        for <xenomai@lists.linux.dev>;
        Tue, 24 Feb 2026 17:02:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=90KtibBTQdHlt0NltlvRbtc8YVuba32mzKoQ6l5G4VQ=;
 b=bL0pZqeZGE+S7m/4FBQnqnUyDzCevBoTv2omO0gr8yKvsaKOG44DpEspDcPxTBg1BpvDGJ
 n6nfrSc3V8RA4duMdqO2xDbiPhZ9gzvOWdOPVxdvFvgsuBsO2KP+TtKM/NdpmTglgxy7ub4D
 07et5bCMo4n/gVzZIFwhsMrtITvVGBGHJA0qBmPKfkl7Pw6EfoyPkGAOJkD6eJBwyo8lzZUg
 aXQB6xwNqPLho4axRCIXJhMwiElBKE9FY+dcWLDNPaUdAF6Fp5tF6HpBHLcene6vqjw8UU9d
 ghC3TfQN9tFSzCFOxNb6WCzOsNIu5LOpGJAkVEEZHpQcVSoj1F+bUCQQ==;
Message-ID: <4e89f7e28939cf5b8c699633a87c82012c43593d.camel@siemens.com>
Subject: Re: [PATCH v2 2/3] cobalt/rtdm: Prepare for new signature of
 mm_get_unmapped_area() in 6.19
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Tue, 24 Feb 2026 17:02:09 +0100
In-Reply-To: <918f3284-3b30-40a5-9db5-19222ab74f8c@siemens.com>
References: 
	<20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
	 <20260220-wip-flo-prepare-for-6-19-v2-2-222effb01976@siemens.com>
	 <918f3284-3b30-40a5-9db5-19222ab74f8c@siemens.com>
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

On Fri, 2026-02-20 at 16:25 +0100, Jan Kiszka wrote:
> On 20.02.26 12:27, Florian Bezdeka wrote:
> > Since 6.19 the signature of mm_get_unmapped_area() has one parameter
> > less. The (previously) first struct mm_struct *mm parameter has been
> > removed.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  kernel/cobalt/rtdm/drvlib.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> > index 86788743fe47b228662ef16831b4281ddefd04ff..0258100db5bbcc04880ddc7=
1632b7992e50168dc 100644
> > --- a/kernel/cobalt/rtdm/drvlib.c
> > +++ b/kernel/cobalt/rtdm/drvlib.c
> > @@ -1907,8 +1907,12 @@ driver_get_unmapped_area(struct file *filp,
> > =20
> >  #ifdef CONFIG_MMU
> >  	/* Run default handler. */
> > -	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff,
> > -				    flags);
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
> > +	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flag=
s);
> > +#else
> > +	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
> > +#endif
>=20
> -> wrappers.h, extending the existing logic there, using the latest
> pattern here.
>=20

Just realized that=C2=A0this function has more history in wrapping:

#if LINUX_VERSION_CODE < KERNEL_VERSION(6,10,0)
#define mm_get_unmapped_area(__mm, __filp, __addr, __len, __pgoff, __flags)=
 \
	(__mm)->get_unmapped_area(__filp, __addr, __len, __pgoff, __flags)
#endif

Kernel versions < 6.19 will need 6 parameters, >=3D 6.19 will need 5. The
callers of the wrapper macro must agree in the number of parameters.

As we cannot touch other callers (Linux code), we have to align the
caller to the kernel version. I'm running out of ideas here...

