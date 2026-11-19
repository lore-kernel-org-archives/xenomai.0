Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103921;
	b=IfJK7t7+WEzvgu6rm6xywa2sQM5/jW+LVkURWEU75WdouJtqhIHWNxelfkqeFcRgEnrk
	 cqg13boNVoXbMuLzR55sfEumX+s6e2R+ZjH+uOD1b4qiDfcHYzUGRYqgPz5hAtto0KJJL
	 g37ZqOTDKpz+X6IV76N3tTiCfDGNFjegFTGkZ9GhUBRR8a3dBH5MbDmV93si/+Tmq6hUU
	 IHPP69Iewlr+fLSFcRvM+2nsARKqWvbg5qlr2v0ahrCjPgVHfo2BBSfgGBS0H/tWWsyZH
	 gxDYO9fZJw8DGGmRWDninAhWrIQgwtfLCEUIPDA3CFZ6KOw/2LTkM/p8wOE/Z9aPYgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103921;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=lId9FWAFhQMLyYoOhmffGbeccGLiOYOjrfKj0CJ1f0M=;
	b=J6kiZn2+FqrkNnubnGQLGWIuTuJXmU+gixuxwN9Y/Hm2sVEyaDzs6BQlvAd375wC8ib/
	 e0WqGpdcVqwJnkc5AjZFNdDDcKslXDCac6rAbg6FoNafM8sE0xR1heocZlWO//s5Yo7ai
	 PIbJzW406Lp6xDAiWeBDSGU9LrTBpZUsw74tAfAWco7JvTsqD1DBHXXDAPx9cHBYWNhMX
	 FRZ6zb/1KIlRSOvpqGYal/bJXoJCTyQH+xLTZeVdOvNSvRnwD/WFhq15sz2FlWfnGGPAM
	 IdL+i1PikeoujJjq1yzoL9gx3p9/5NdZnlDaG3FMVqaTUYAN2DLnzCXzRs+HuvjqhPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=p7ifDUVg;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D01606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 15:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D01606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=p7ifDUVg
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026111915583152797f7e5700020799
        for <xenomai@lists.linux.dev>;
        Thu, 19 Nov 2026 16:58:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lId9FWAFhQMLyYoOhmffGbeccGLiOYOjrfKj0CJ1f0M=;
 b=p7ifDUVgrPTPMpFSvvbCocaNEMLF9UWMYdodPJ4J3WFoUP3nh2UsK6CsCdTN4bsj6mbyVL
 bv+8BiYo6fBLicHQglPkRWFmygtLLDk8VErnOceuQRQPdBofcVjG3EqUpPh0o7+ToauefkCb
 oHzy1YNuVHoNLQrufKQFZ0MDysNFTmWrj3gJC9C3Nxc2Vl4Gfxu/CfjwpaWwuCKgdZsZThVy
 lUxcIpsanlEqK0GGPxE7Ygjs807vnRrKFXYX+bSTlik/7TY8/lmOchOppV3q6HjoYYUJlcy0
 0jA/+Uj+9CMsqmI/x7VlaWa1gGLYucoPG0XmCggo7ilonevW2BsVjhzA==;
Message-ID: <e06d42af87e95d790ebb9b41f361385f3f1a0251.camel@siemens.com>
Subject: Re: [dovetail][PATCH] x86: dovetail: preserve in-band stall state
 across handle_bug()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Thu, 19 Nov 2026 16:58:31 +0100
In-Reply-To: <87qzghnf5x.fsf@xenomai.org>
References: <edda3386-02fc-4d36-9e87-ce3f2c4f1916@siemens.com>
	 <87qzghnf5x.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2026-11-19 at 14:07 +0100, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > handle_bug() runs from the raw #UD entry, before irqentry_enter(), and
> > returns straight to the exception site when a WARN() was handled. The
> > trap only cleared the hardware interrupt flag, the in-band stall bit
> > still reflects the state of the exception site.
> >=20
> > When the site ran with hard irqs on, handle_bug() used
> > local_irq_enable_full() and local_irq_disable_full() for the in-band
> > stage, which also unstall then stall the in-band stage. As a result:
> >=20
> > - a WARN() hit with in-band interrupts enabled returned with the
> >   in-band stage stalled, leaking a virtually disabled interrupt state
> >   into the interrupted code, until the next in-band irq enable.
> > - a WARN() hit with in-band interrupts disabled (e.g. under
> >   spin_lock_irqsave()) unstalled the in-band stage while reporting.
> >=20
> > Only restore the hard interrupt state, like upstream does with the
> > (then non-virtualized) interrupt flag, on both stages.
> >=20
> > Assisted-by: opencode:Opus-5.5
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

To simplify the next forward port and the usual history cleanup:

Could you please add / provide the Fixes: tags for all the patches
recently merged? Thanks!


>=20
>=20
> Merged, thanks.
>=20
> --=20
> Philippe.
